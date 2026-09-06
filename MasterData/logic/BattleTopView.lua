-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleTopView.lua

module("logic.extensions.battle.view.BattleTopView", package.seeall)

local BattleTopView = class("BattleTopView", ViewComponent)
local UnityTime = UnityEngine.Time

function BattleTopView:buildUI()
	self:_buildMyInfo()
	self:_buildOtherInfo()

	self._roundsNum = goutil.findChildTextComponent(self.mainGO, "top/Round/RoundNum")
	self._roundEffectNode = goutil.findChild(self.mainGO, "top/Round/RoundEffect").transform
	self._roundNumTween = self._roundsNum:GetComponent(UnityTweensType.TweenSequence)
end

function BattleTopView:_buildMyInfo()
	self._myName = goutil.findChildTextComponent(self.mainGO, "top/MyName")
	self._myHeadPoint = goutil.findChild(self.mainGO, "top/Myheaicon/con")
	self._myLevel = goutil.findChild(self.mainGO, "top/Myheaicon/level")
	self._txtMyLevel = goutil.findChildTextComponent(self._myLevel, "txtLevel")

	local myBloodBar = Framework.SliderAdapter.GetFrom(self.mainGO, "top/MyBloodBar")
	local myBlood = goutil.findChildTextComponent(self.mainGO, "top/MyBlood")
	local leftEffBlood = goutil.findChild(self.mainGO, "top/MyBloodBar/handleRect/effLeft").transform
	local bloodTail = goutil.findChild(self.mainGO, "top/MyBloodBar/handleRect/MyBloodTail").transform

	self._leftBloodBarEff = BattleCommonBloodBar.New(GameEnum.BattleTeam.Left, leftEffBlood, bloodTail, myBloodBar, myBlood, self)
end

function BattleTopView:_buildOtherInfo()
	self._otherInfo = BattleEnemyHeadIcon.New(self:getGo("top/OtherInfo"), self)
	self._bossBloodBar = BattleBossBloodBar.New(self:getGo("top/BossBloodBar"), self)
	self._otherBloodBarNode = self:getGo("top/OtherBloodBar")

	local otherBloodBar = Framework.SliderAdapter.GetFrom(self.mainGO, "top/OtherBloodBar/OtherBloodBar")
	local otherBlood = goutil.findChildTextComponent(self.mainGO, "top/OtherBloodBar/OtherBlood")
	local otherBloodTail = goutil.findChild(self.mainGO, "top/OtherBloodBar/OtherBloodBar/handleRect/OtherBloodTail").transform
	local rightEffBlood = goutil.findChild(self.mainGO, "top/OtherBloodBar/OtherBloodBar/handleRect/effRight").transform

	self._rightBloodBarEff = BattleCommonBloodBar.New(GameEnum.BattleTeam.Right, rightEffBlood, otherBloodTail, otherBloodBar, otherBlood, self)
end

function BattleTopView:onEnter()
	BattleTopView.super.onEnter(self)

	self._battleUserInterfaceSkinId = BattleController.instance:getBattleUserInterfaceSkinId()

	self._otherInfo:onEnter()
	self._bossBloodBar:onEnter()
	self._leftBloodBarEff:onEnter()
	self._rightBloodBarEff:onEnter()
	self:_setExtTopView()
	self:_updateBloods()
	self:_updatePlayerIcons()
	self:_updateRoundNum(1)

	self._myName.text = BattleModel.instance:getBattleNickName()

	self:_updateNameForRankRace()
	settimer(0, self._tickBloods, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleRoundStart, self._onBattleRoundStart, self)
	GlobalDispatcher:addListener(GlobalNotify.OnBattleUnitBirth, self._onBattleUnitBirth, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleBuffDamage, self._onBattleBuffDamage, self)
	GlobalDispatcher:addListener(GlobalNotify.RankRaceResult, self._updateNameForRankRace, self)
end

function BattleTopView:onExit()
	self._otherInfo:onExit()
	self._bossBloodBar:onExit()
	self._leftBloodBarEff:onExit()
	self._rightBloodBarEff:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.BattleRoundStart, self._onBattleRoundStart, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnBattleUnitBirth, self._onBattleUnitBirth, self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleBuffDamage, self._onBattleBuffDamage, self)
	GlobalDispatcher:removeListener(GlobalNotify.RankRaceResult, self._updateNameForRankRace, self)
	BattleTopView.super.onExit(self)
	removetimer(self._tickBloods, self)
	self:_stopRoundNumEffect()
	self:_clearExtTopView()
	MaterialMgr.resetAll(self._myHeadPoint)
end

function BattleTopView:_updatePlayerIcons()
	local myHeadInfo = BattleModel.instance:getMyHeadInfo()

	if myHeadInfo == nil then
		HeadItemController.instance:setMyHeadCell(self._myHeadPoint)

		self._txtMyLevel.text = MofangModel.instance:getCurLv()
	else
		HeadItemController.instance:setHeadCell(self._myHeadPoint, myHeadInfo.headIcon, myHeadInfo.headFrame, myHeadInfo.vipLv)

		self._txtMyLevel.text = myHeadInfo.playerLv
	end
end

function BattleTopView:_updateBloods(force)
	local leftTeamId = BattleModel.instance:getLeftTeamId()

	self._leftBloodBarEff:updateBloods(force, leftTeamId)

	local rightTeamId = BattleModel.instance:getRightTeamId()

	self._rightBloodBarEff:updateBloods(force, rightTeamId)

	if self._topView then
		local otherBlood, otherTotalBlood = self._rightBloodBarEff:getBloodInfo()

		self._topView:updateValue(otherBlood, otherTotalBlood, force)
	end

	if self.tabPresentor and self.tabPresentor:isOpen() and self.tabPresentor._views then
		local vCount = #self.tabPresentor._views

		if vCount > 0 then
			local otherBlood, otherTotalBlood = self._rightBloodBarEff:getBloodInfo()

			for i = 1, vCount do
				local tempView = self.tabPresentor._views[i]

				if tempView._updateBloods then
					tempView:updateValue(otherBlood, otherTotalBlood, force)
				end
			end
		end
	end
end

function BattleTopView:_updateRoundNum(num, tween)
	local strNum = string.format(lang("text_num_round"), num)

	self._roundsNum.text = tostring(num)

	if tween then
		self:_playRoundNumEffect()
	end
end

function BattleTopView:_updateNameForRankRace()
	if not RankRaceResultController.instance:isInRankRace() then
		return
	end

	RankRaceResultController.instance:clearInRankRaceTag()

	local _myAreaName = RankRaceController.instance:getMyAreaIdAndAreaName()

	self._myName.text = _myAreaName .. " " .. self._myName.text

	local _opAreaName = RankRaceController.instance:getOpAreaInfo()

	self._otherInfo:setName(_opAreaName .. " " .. self._otherInfo:getName())
end

function BattleTopView:_onBattleRoundStart(num)
	self:_updateRoundNum(num, true)
end

function BattleTopView:_playRoundNumEffect()
	self:_stopRoundNumEffect()
	self._roundNumTween:Begin()

	if not self._roundEffect then
		local effectName = self:_getHuiheEffectName()

		self._roundEffect = UIEffectManager.instance:playEffectBrief(self, effectName, self._roundEffectNode, false)

		self._roundEffect:setEffTime(0.8)
		self._roundEffect:setParent(self._roundEffectNode)
		self._roundEffect:setScale(360)
	end
end

function BattleTopView:_stopRoundNumEffect()
	self._roundNumTween:Stop()
	Framework.TransformUtil.SetLocalScale(self._roundsNum.transform, 1, 1, 1)

	if self._roundEffect then
		UIEffectManager.instance:stopEffect(self._roundEffect)

		self._roundEffect = nil
	end
end

function BattleTopView:_onBattleUnitBirth(unit)
	self:_updateBloods(true)
end

function BattleTopView:_tickBloods(deltaTime)
	local deltaTime = UnityTime.deltaTime

	self._leftBloodBarEff:tickBloods(deltaTime)
	self._rightBloodBarEff:tickBloods(deltaTime)
end

function BattleTopView:_onBattleHurtData()
	self._leftBloodBarEff:setBloodSpeed(0.6)
	self._rightBloodBarEff:setBloodSpeed(0.6)
	self:_updateBloods()
end

function BattleTopView:_onBattleBuffDamage()
	self:_onBattleHurtData()
end

function BattleTopView:_setExtTopView()
	self._topContainer = self:getGo("topContainer")

	local go

	if BattleModel.instance.isFamilyBoss then
		go = self:getResInstance(CommonResPath.BattleFaimilyBoss)
		self._topView = BattleFamilyBossView.New(go, self, self._bossBloodBar)
	elseif BattleModel.instance.isWorldBoss then
		go = self:getResInstance(CommonResPath.BattleWorldBoss)
		self._topView = BattleWorldBossView.New(go, self, self._bossBloodBar)
	elseif BattleModel.instance.isherotrial then
		go = self:getResInstance(CommonResPath.BattleHeroTrial)
		self._topView = BattleHeroTrialView.New(go, self, self._bossBloodBar)
	elseif BattleModel.instance.isTimeLimitedChallenge and TLChallengeController.instance:isShowBossHp() then
		go = self:getResInstance(CommonResPath.BattleTimeLimitedChallenge)
		self._topView = TLCBattleTopView.New(go, self, self._bossBloodBar)
	elseif BattleModel.instance.isFBBBattle then
		go = self:getResInstance(CommonResPath.BattleTimeLimitedChallenge)
		self._topView = FBBBattleTopView.New(go, self, self._bossBloodBar)
	elseif BattleModel.instance.curMissionType == GameEnum.MissionType.LONG_NV and TLChallengeController.instance:isShowBossHp() then
		go = self:getResInstance(CommonResPath.BattleTimeLimitedChallenge)
		self._topView = TLCBattleTopView.New(go, self, self._bossBloodBar)
	elseif BattleModel.instance.isAutoChessFight then
		go = self:getResInstance(BattleMainViewPresentor.AutochessTopRes)
		self._topView = AutoChessTopView.New(go, self, self._bossBloodBar)
	elseif BattleModel.instance.kingJiChallengeType == GameEnum.KingjiChallengeType.Shizhe then
		go = self:getResInstance(CommonResPath.BattleTimeLimitedChallenge)
		self._topView = KingjiTopView.New(go, self, self._bossBloodBar)
	elseif BattleModel.instance.FamilyHoudingClg then
		go = self:getResInstance(CommonResPath.BattleFamilyHoudingClgView)
		self._topView = BattleFamilyHoudingClgView.New(go, self, self._bossBloodBar)
	end

	if go then
		goutil.addChildToParent(go, self._topContainer)
		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
	end

	if self._topView then
		goutil.setActive(self._otherBloodBarNode, false)
		self._bossBloodBar:setActive(true)
		self._topView:buildUI()
		self._topView:onEnter()
		self._otherInfo:setNameVisible(false)
	else
		self._bossBloodBar:setActive(false)
		goutil.setActive(self._otherBloodBarNode, true)
	end

	local viewName = BattleSettlementModel.instance:getBattleTopExtView()

	if not string.nilorempty(viewName) then
		self.showTabAt(self, self._topContainer, viewName, self)
	end
end

function BattleTopView:_clearExtTopView()
	if self._topView then
		self._topView:onExit()
		goutil.destroy(self._topView.mainGO)
	end

	self._topView = nil

	BattleSettlementModel.instance:setBattleTopExtView(nil)
end

function BattleTopView:_getHuiheEffectName()
	local effectName

	return self._battleUserInterfaceSkinId == 2 and "fx_ui_zhandou/fx_ui_huihe2.prefab" or "fx_ui_zhandou/fx_ui_huihe.prefab"
end

return BattleTopView
