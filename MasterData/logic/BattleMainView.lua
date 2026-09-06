-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleMainView.lua

module("logic.extensions.battle.view.BattleMainView", package.seeall)

local BattleMainView = class("BattleMainView", ViewComponent)
local waitingRetreatLimitTime = 3
local passFuncId = 29
local speedFuncId = 30
local retreatFuncId = 45
local friendFuncId = 22
local mailFuncId = 23
local UnityTime = UnityEngine.Time
local spiritInvocationEnterOffsetX = -50
local spiritInvocationEnterDuration = 0.4

BattleMainView.ShipPos = {
	Left = 1,
	Right = 2
}
BattleMainView.ShipNodeName = {
	SIShip = "SIShip",
	PShip = "PShip",
	BgshipFront = "BgshipFront",
	BgshipBack = "BgshipBack",
	GShip = "GShip"
}
BattleMainView.ShipType = {
	SpiritInvocation = 3,
	Genesis = 1,
	Psychic = 2
}

function BattleMainView:ctor()
	BattleMainView.super.ctor(self)

	self._dynamicGos = {}
	self._resLoader = MultiResLoader.New()
end

function BattleMainView:destroyUI()
	if self._dragParent then
		goutil.destroy(self._dragParent.gameObject)

		self._dragParent = nil
	end

	self._resLoader = nil
end

function BattleMainView:buildUI()
	self:_initDragParent()
	self:_buildLeftTop()
	self:_buildRightTop()
	self:_buildLeftBottom()
	self:_buildRightBottom()
	self:_initActionBar()
	self:_buildDomainSkill()
	self:_buildDynamicUI()
	self:_buildSticker()
	self:_buildBtnBgs()
	self:_buildBasicShipNodes()
	self:_buildSpiritInvocationPet()

	self._totalDamage = self:getGo("totalDamage")
end

function BattleMainView:_buildBasicShipNodes()
	self._shipNodes = {}

	local lpshipGo = self:getGo("top/myship/Mediumship")
	local lgshipGo = self:getGo("top/myship/Genesisship")
	local lsishipGo = self:getGo("spiritInvocationPet/left/ship/SpiritInvocationship")
	local rgshipGo = self:getGo("top/othership/OtherGenesisship")
	local rsishipGo = self:getGo("spiritInvocationPet/right/ship/OtherSpiritInvocationship")
	local rpshipGo = self:getGo("top/othership/OtherMediumship")

	self._shipNodes[BattleMainView.ShipPos.Left] = {}
	self._shipNodes[BattleMainView.ShipPos.Right] = {}
	self._shipNodes[BattleMainView.ShipPos.Left][BattleMainView.ShipNodeName.GShip] = lgshipGo
	self._shipNodes[BattleMainView.ShipPos.Left][BattleMainView.ShipNodeName.PShip] = lpshipGo
	self._shipNodes[BattleMainView.ShipPos.Left][BattleMainView.ShipNodeName.SIShip] = lsishipGo
	self._shipNodes[BattleMainView.ShipPos.Left][BattleMainView.ShipNodeName.BgshipFront] = self:getGo("top/myship/bgshipfront")
	self._shipNodes[BattleMainView.ShipPos.Left][BattleMainView.ShipNodeName.BgshipBack] = self:getGo("top/myship/bgship")
	self._shipNodes[BattleMainView.ShipPos.Right][BattleMainView.ShipNodeName.GShip] = rgshipGo
	self._shipNodes[BattleMainView.ShipPos.Right][BattleMainView.ShipNodeName.PShip] = rpshipGo
	self._shipNodes[BattleMainView.ShipPos.Right][BattleMainView.ShipNodeName.SIShip] = rsishipGo
	self._shipNodes[BattleMainView.ShipPos.Right][BattleMainView.ShipNodeName.BgshipFront] = self:getGo("top/othership/bgshipfront")
	self._shipNodes[BattleMainView.ShipPos.Right][BattleMainView.ShipNodeName.BgshipBack] = self:getGo("top/othership/bgship")
end

function BattleMainView:_buildDynamicSubRoot(battleUserInterfaceSkinId)
	self._actionsBgPrefabName = string.format("ui/views/battle/mainviewsub/actionsbg%s.prefab", battleUserInterfaceSkinId)
	self._roundBgPrefabName = string.format("ui/views/battle/mainviewsub/roundbg%s.prefab", battleUserInterfaceSkinId)
	self._dynamicSubParent = {}

	local resPaths = {}

	self:_insertDynamicSub(self._actionsBgPrefabName, resPaths, "actionsbgcon")
	self:_insertDynamicSub(self._roundBgPrefabName, resPaths, "top/Round/roundbgcon")
	self._resLoader:setResPaths(resPaths)
	self._resLoader:load(nil, self._onDynamicSubLoaded, self)
end

function BattleMainView:_buildBtnBgs()
	self._btnBgGos = {
		self:getGo("rightTop/TweenNode/Layouts/SysSetting/img"),
		self:getGo("rightTop/TweenNode/Layouts/Pass/img"),
		self:getGo("rightTop/TweenNode/Layouts/PassWaitingcon/PassWaiting/img"),
		self:getGo("rightTop/TweenNode/Layouts/SpeedX/img"),
		self:getGo("rightTop/TweenNode/Layouts/Speed6X/img")
	}
end

function BattleMainView:_onDynamicSubLoaded(res)
	if res.IsSuccess then
		local prefab = res:GetMainAsset()
		local parentGo = self:getGo(self._dynamicSubParent[res.ResPath])

		if prefab and parentGo then
			local go = goutil.cloneAndSetParent(prefab, parentGo.transform)

			self._dynamicGos[res.ResPath] = go

			GameUtil.resetUITransform(go)
		end
	end
end

function BattleMainView:_insertDynamicSub(prefabName, resPaths, parentName)
	if not self._dynamicGos[prefabName] then
		table.insert(resPaths, prefabName)
	end

	self._dynamicSubParent[prefabName] = parentName
end

function BattleMainView:_initActionBar()
	local go = self:getGo("actions")

	self._battleActionBar = BattleActionBar.New(go, self)

	self._battleActionBar:buildUI()
end

function BattleMainView:_initDragParent()
	local pefabs = self._viewPresentor:getPrefab(CommonResPath.BattleDragParent)

	self._dragParent = goutil.clone(pefabs).transform
	self._dragParentCanvas = self._dragParent.gameObject:GetComponent("Canvas")
	self._dragClone = goutil.findChild(self._dragParent, "dragClone")
	self._dragCloneSkill = goutil.findChild(self._dragParent, "dragSkill")
	self._dragCloneBall = goutil.findChild(self._dragParent, "dragClone/ball"):GetComponent("Image")

	self._dragClone:SetActive(false)
	self._dragCloneSkill:SetActive(false)
	self._dragParent.gameObject:SetActive(false)
end

function BattleMainView:_buildLeftTop()
	self._leftTopsTween = self:getGo("leftTop/TweenNode"):GetComponent(UnityTweensType.TweenPosition)
	self._passWaiting = self:getBtn("rightTop/TweenNode/Layouts/PassWaitingcon/PassWaiting")
	self._passWaitingSlider = self:getGo("rightTop/TweenNode/Layouts/PassWaitingcon/PassWaiting/Slider"):GetComponent("Slider")
	self._passWaitingTime = self:getGo("rightTop/TweenNode/Layouts/PassWaitingcon/PassWaiting/Slider/Text"):GetComponent("Text")
	self._pass = self:getBtn("rightTop/TweenNode/Layouts/Pass")
	self._passLock = self:getGo("rightTop/TweenNode/Layouts/Pass/Lock")
	self._retreat = self:getBtn("leftTop/TweenNode/Retreat")
	self._retreatLock = self:getGo("leftTop/TweenNode/Retreat/Lock")
	self._btnSysSetting = self:getBtn("rightTop/TweenNode/Layouts/SysSetting")
	self._funcBtnLayouts = self:getGo("rightTop/TweenNode/Layouts"):GetComponent(ComponentType.UILayoutSingleLine)
end

function BattleMainView:_buildRightTop()
	self._rightTop = self:getGo("rightTop")
	self._rightTopsTween = self:getGo("rightTop/TweenNode"):GetComponent(UnityTweensType.TweenPosition)
	self._speedX = self:getGo("rightTop/TweenNode/Layouts/SpeedX")
	self._speedXBtn = self:getBtn("rightTop/TweenNode/Layouts/SpeedX")
	self._speedLock = self:getGo("rightTop/TweenNode/Layouts/SpeedX/Lock")
	self._speedStateXImage = self:getGo("rightTop/TweenNode/Layouts/SpeedX/SpeedX"):GetComponent(ComponentType.UIImageSpriteChange)
	self._speedXImage = self:getGo("rightTop/TweenNode/Layouts/SpeedX/imgSpeed"):GetComponent(ComponentType.UIImageSpriteChange)
	self._speedX6 = self:getGo("rightTop/TweenNode/Layouts/Speed6X")
	self._speedX6Btn = self:getBtn("rightTop/TweenNode/Layouts/Speed6X")
	self._speedX6StateImage = self:getGo("rightTop/TweenNode/Layouts/Speed6X/Speed6X"):GetComponent(ComponentType.UIImageSpriteChange)
	self._speedX6Image = self:getGo("rightTop/TweenNode/Layouts/Speed6X/imgSpeed"):GetComponent(ComponentType.UIImageSpriteChange)
end

function BattleMainView:_buildLeftBottom()
	self._negoChat = self:getGo("Nego_Chat")
	self._btnSetting = self:getBtn("Nego_Chat/Btn_Setting")
	self._btnMail = self:getBtn("Nego_Chat/bg/Btn_MailEx")
	self._btnFriend = self:getBtn("Nego_Chat/bg/Btn_FriendEx")
	self._btnChat = self:getBtn("Nego_Chat")

	goutil.setActive(self._btnSetting.gameObject, false)

	self._txtBattleId = self:getTxt("battleId/txtBattleId")
end

function BattleMainView:_buildRightBottom()
	self._itemsNode = self:getGo("rightBotton/ItemsNode")
	self._itemsDivLine = self:getGo("rightBotton/ItemsNode/DivLine")

	local itemBalls = self:getGo("rightBotton/ItemsNode/ballsView")
	local itemSkills = self:getGo("rightBotton/ItemsNode/skillsNode")

	self._autoUseItemBtn = self:getBtn("rightBotton/ItemsNode/AutoUseItem")
	self._itemsView = {}
	self._itemsView[GameEnum.ActionModel.UserAction_Catch] = BattleItemsBallView.New(self, itemBalls, self._itemsDivLine, self._dragParent, self._dragClone, self._dragCloneBall)
	self._itemsView[GameEnum.ActionModel.UserAction_Skill] = BattleItemsSkillView.New(self, itemSkills, self._itemsDivLine, self._dragParent, self._dragCloneSkill)
	self._currItemsView = nil
end

function BattleMainView:_buildDomainSkill()
	self._domainSkill = self:getGo("DomainSkill")

	if self._domainSkill then
		self._domainSkillBg = self._domainSkill:GetComponent(ComponentType.UIImageSpriteChange)
		self._btnDomainSkill = Framework.ButtonAdapter.Get(self._domainSkill)
		self._domainSkillIcon = self:getGo("DomainSkill/Icon")

		self._domainSkill:SetActive(false)
	end
end

function BattleMainView:_buildSticker()
	self._stickerLeft = self:getGo("stickerLeft")
	self._stickerRight = self:getGo("stickerRight")
	self._txtLeftSticker = self:getTxt("stickerLeft/txt")
	self._txtRightSticker = self:getTxt("stickerRight/txt")
	self._effectConLeftSticker = self:getGo("stickerLeft/effectCon")
	self._effectConRightSticker = self:getGo("stickerRight/effectCon")
end

function BattleMainView:_buildSpiritInvocationPet()
	self._spiritInvocationObjs = {
		[GameEnum.BattleTeam.Left] = {
			rootGo = self:getGo("spiritInvocationPet/left"),
			headRootGo = self:getGo("spiritInvocationPet/left/head"),
			headGo = self:getGo("spiritInvocationPet/left/head/headIcon"),
			backGo = self:getGo("spiritInvocationPet/left/head/headIconBack"),
			frontGo = self:getGo("spiritInvocationPet/left/head/headIconFront"),
			enterEffectGo = self:getGo("spiritInvocationPet/left/enter/effectSpiritEnter"),
			skillEffectGo = self:getGo("spiritInvocationPet/left/leftEffect"),
			idleEffectGo = self:getGo("spiritInvocationPet/left/leftIdleEffect"),
			shipGo = self:getGo("spiritInvocationPet/left/ship")
		},
		[GameEnum.BattleTeam.Right] = {
			rootGo = self:getGo("spiritInvocationPet/right"),
			headRootGo = self:getGo("spiritInvocationPet/right/head"),
			headGo = self:getGo("spiritInvocationPet/right/head/headIcon"),
			backGo = self:getGo("spiritInvocationPet/right/head/headIconBack"),
			frontGo = self:getGo("spiritInvocationPet/right/head/headIconFront"),
			enterEffectGo = self:getGo("spiritInvocationPet/right/enter/effectSpiritEnter"),
			skillEffectGo = self:getGo("spiritInvocationPet/right/rightEffect"),
			idleEffectGo = self:getGo("spiritInvocationPet/right/rightIdleEffect"),
			shipGo = self:getGo("spiritInvocationPet/right/ship")
		}
	}

	for _, data in pairs(self._spiritInvocationObjs) do
		local pos = GameUtil.getAnchoredPos(data.headGo)

		data.endPos = Vector3.New(pos.x, pos.y, 0)
		data.canvasGroup = data.headGo:GetComponent(ComponentType.CanvasGroup) or data.headGo:AddComponent(ComponentType.CanvasGroup)
	end
end

function BattleMainView:onEnter()
	self.addGEvent(self, GlobalNotify.OnPsychicSkillFight, self._updatePsychicSkillFight, self)
	self.addGEvent(self, GlobalNotify.OnGenesisSkillFight, self._updateGenesisSkillFight, self)
	self.addGEvent(self, GlobalNotify.OnSpiritInvocationSkillFight, self._updateSpiritInvocationSkillFight, self)
	self.addGEvent(self, GlobalNotify.OnUseSpiritInvocationSkillStart, self._onUseSpiritInvocationSkillStart, self)
	self.addGEvent(self, GlobalNotify.PlayBattleSpiritInvocationEnter, self._playSpiritInvocationEnter, self)
	self.addGEvent(self, GlobalNotify.OnBattleSkillCameraStart, self._onBattleSkillCameraStart, self)
	self.addGEvent(self, GlobalNotify.OnBattleSkillCameraFinish, self._onBattleSkillCameraFinish, self)

	self._skillCameraCount = 0
	self._battleUserInterfaceSkinId = BattleController.instance:getBattleUserInterfaceSkinId()

	self:_changUIStyle(self._battleUserInterfaceSkinId)
	self._negoChat:SetActive(not BattleModel.instance.isPlayingCgBattle)
	self._rightTop:SetActive(not BattleModel.instance.isPlayingCgBattle)
	self:_calWaitingPassLimitTime()

	BattleController.instance.battleMainview = self
	self._isPauseViewOnOpened = nil
	self._enabledSpeedX = false
	self._hasStartRotateSpeedX = false
	self._hasStartRotateSpeed6X = false
	self._currSpeed = UnityEngine.PlayerPrefs.GetInt(self:_getSpeedXKey())
	self._speedX6Enabled = UnityEngine.PlayerPrefs.GetInt(self:_getSpeedX6Key()) ~= 0
	self._isTouchedDown = nil

	self:_updateSpeed()
	self:_startWaitingPass()
	self:_startWaitingRetreat()
	self:_updateActionModes()

	if self._currItemsView then
		self._currItemsView:onEnter()
	end

	UnitCompBattleUI.totalDamage = self._totalDamage

	self:_registerEvents()
	self:_setAutoUsingItem(false)
	settimer(0, self._tickClickUnit, self)

	if self._battleActionBar then
		self._battleActionBar:onEnter()
	end

	self:_updateDomainSkill()

	self._txtBattleId.text = BattleModel.instance:getBattleId()

	GameUtil.SetActive(self._stickerLeft, false)
	GameUtil.SetActive(self._stickerRight, false)

	self._impressionStickerShowQueue = Queue.New()
	self._isPlayingImpressionSticker = false

	self:_resetShipDatas()
	self:_updateShipNodes()
	self:_initSpiritInvocationSkill(BattleModel.instance:getLeftTeamId())
	self:_initSpiritInvocationSkill(BattleModel.instance:getRightTeamId())
	self:_prepareSpiritInvocationEnter(BattleModel.instance:getLeftTeamId())
	self:_prepareSpiritInvocationEnter(BattleModel.instance:getRightTeamId())
end

function BattleMainView:_updateDomainSkill()
	if not self._domainSkill then
		return
	end

	local domainSkill = BattleDoaminSkillMgr.instance:getCurrDomainSkill()

	if not domainSkill then
		self._domainSkill:SetActive(false)

		return
	end

	self._domainSkill:SetActive(true)
	MaterialMgr.setIcon(self._domainSkillIcon, MatType.Pet, domainSkill.raceId)
	self._domainSkillBg:ChangeStateNow(domainSkill.teamId)
end

function BattleMainView:_calWaitingPassLimitTime()
	self._waitingPassLimitTime = BattleSkipTimeMgr.instance:getSkipTime()
end

function BattleMainView:_registerEvents()
	GlobalDispatcher:addListener(GlobalNotify.OnDomainSkillTrigged, self._updateDomainSkill, self)
	GlobalDispatcher:addListener(GlobalNotify.OnDomainSkillRemoved, self._updateDomainSkill, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleUnitDead, self._onBattleUnitDead, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpenStart, self._onViewOpened, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClosed, self)
	GlobalDispatcher:addListener(GlobalNotify.StartBattlePassWaiting, self._onReqNextBattleWaiting, self)
	self._speedX6Btn:AddClickListener(self._onClickSpeedX6, self)
	self._speedXBtn:AddClickListener(self._onClickSpeedX, self)
	self._pass:AddClickListener(self._onClickPass, self)
	self._retreat:AddClickListener(self._onClickRetreat, self)
	self._passWaiting:AddClickListener(self._onClickPassWaiting, self)
	self._btnSetting:AddClickListener(self._onClickSetting, self)
	self._btnMail:AddClickListener(self._onClickMail, self)
	self._btnFriend:AddClickListener(self._onClickFriend, self)
	self._btnChat:AddClickListener(self._onClickChat, self)

	if self._btnDomainSkill then
		self._btnDomainSkill:AddClickListener(self._onClickDomainSkill, self)
	end

	self._autoUseItemBtn:AddClickListener(self._onClickAutoUseItemBtn, self)
	self._btnSysSetting:AddClickListener(self._onClickBtnSetting, self)
	GlobalDispatcher:addListener(GlobalNotify.OnSkillStart, self.onUseSkillStart, self)
	GlobalDispatcher:addListener(GlobalNotify.OnSkillEnd, self.onUseSkillEnd, self)
	self.addGEvent(self, GlobalNotify.OnBattleRoundStart, self._pushImpressionSticker, self)
	self.addGEvent(self, GlobalNotify.OnBattleRoundPush, self._hideImpressionSticker, self)
end

function BattleMainView:onUseSkillStart(unit, skill)
	if not skill then
		return
	end

	local skillCo = skill.skillCo
	local type = GameEnum.SkillNameToType[skillCo.type]

	if type == GameEnum.SkillRaceType.Ult or type == GameEnum.SkillRaceType.PsychicSkillUtl then
		self.isSkillUlt = true

		CommonTipsMgr.instance:closeAllTips()
	end
end

function BattleMainView:onUseSkillEnd(unit, skill)
	local skillCo = skill.skillCo
	local type = GameEnum.SkillNameToType[skillCo.type]

	if type == GameEnum.SkillRaceType.Ult or type == GameEnum.SkillRaceType.PsychicSkillUtl then
		self.isSkillUlt = false
	end
end

function BattleMainView:_onBattleSkillCameraStart(unit)
	if self:_isSpiritInvocationPetSkillUnit(unit) then
		return
	end

	self._skillCameraCount = self._skillCameraCount + 1

	self:_onHideSpiritInvocationPet(true, unit)
end

function BattleMainView:_onBattleSkillCameraFinish(unit)
	if self:_isSpiritInvocationPetSkillUnit(unit) then
		return
	end

	self._skillCameraCount = math.max(self._skillCameraCount - 1, 0)

	if self._skillCameraCount == 0 then
		self:_onHideSpiritInvocationPet(false, unit)
	end
end

function BattleMainView:_onReqNextBattleWaiting(sec)
	self._passLock:SetActive(false)
	self._pass.gameObject:SetActive(false)
	self._passWaiting.gameObject:SetActive(true)
	settimer(0.033, self._tickNextReq, self)

	self._waitingNextTime = sec
	self._waitingNextLimitTime = sec
	self._passWaitingTime.text = tostring(self._waitingNextTime)
end

function BattleMainView:_tickNextReq()
	self._waitingNextTime = self._waitingNextTime - 0.033

	if self._waitingNextTime >= 0 then
		self._passWaitingTime.text = tostring(math.ceil(self._waitingNextTime))
		self._passWaitingSlider.value = self._waitingNextTime / self._waitingNextLimitTime
	else
		self._pass.gameObject:SetActive(true)
		self._passWaiting.gameObject:SetActive(false)
		removetimer(self._tickNextReq, self)
		EndlessBattleController.instance:reqNextBattle()
	end
end

function BattleMainView:_startWaitingPass()
	if BattleModel.instance.enableSkip == GameEnum.SkipType.UNABLE_SKIP and not self:_showSkippedOnEditor() and not BattleModel.instance.viewFightBtl or BattleModel.instance.isAutoChessFight then
		self._pass.gameObject:SetActive(false)
		self._passWaiting.gameObject:SetActive(false)
		self._passLock:SetActive(false)
		removetimer(self._tickPassTime, self)
	elseif BattleModel.instance.enableSkip == GameEnum.SkipType.UNABLE_SKIP_FORCED then
		if self:_showSkippedOnEditor() then
			self._passLock:SetActive(false)
			self._pass.gameObject:SetActive(false)
			self._passWaiting.gameObject:SetActive(true)
			settimer(0.033, self._tickPassTime, self)

			self._waitingPassTime = self._waitingPassLimitTime
			self._passWaitingTime.text = tostring(self._waitingPassTime)
		else
			self._pass.gameObject:SetActive(false)
			self._passLock:SetActive(false)
			self._passWaiting.gameObject:SetActive(false)
		end
	else
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(passFuncId)

		if self:_showSkippedOnEditor() or FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
			self._passLock:SetActive(false)
			self._pass.gameObject:SetActive(false)
			self._passWaiting.gameObject:SetActive(true)
			settimer(0.033, self._tickPassTime, self)

			self._waitingPassTime = self._waitingPassLimitTime
			self._passWaitingTime.text = tostring(self._waitingPassTime)
		else
			self._passWaiting.gameObject:SetActive(false)

			if cfg.form == 1 then
				self._pass.gameObject:SetActive(true)
				self._passLock:SetActive(true)
			else
				self._pass.gameObject:SetActive(false)
				self._passLock:SetActive(false)
			end
		end
	end

	self._funcBtnLayouts:Layout()
end

function BattleMainView:_startWaitingRetreat()
	if BattleModel.instance.retreatMsgType == 0 then
		self._retreat.gameObject:SetActive(false)
		self._retreatLock:SetActive(false)
		removetimer(self._tickRetreatTime, self)
	else
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(retreatFuncId)

		if FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
			self._retreatLock:SetActive(false)
			self._retreat.gameObject:SetActive(true)
			settimer(0.033, self._tickRetreatTime, self)

			self._waitingRetreatTime = waitingRetreatLimitTime
		elseif cfg.form == 1 then
			self._retreat.gameObject:SetActive(true)
			self._retreatLock:SetActive(true)
		else
			self._retreat.gameObject:SetActive(false)
			self._retreatLock:SetActive(false)
		end
	end
end

function BattleMainView:onExit()
	self:_stopSpiritInvocationEnter()

	if self._domainSkillIcon then
		MaterialMgr.clearIcon(self._domainSkillIcon)
	end

	UnitCompBattleUI.totalDamage = nil

	if self._currItemsView then
		self._currItemsView:onExit()

		self._currItemsView = nil
	end

	removetimer(self._tickClickUnit, self)
	removetimer(self._tickPassTime, self)
	removetimer(self._tickRetreatTime, self)

	self._waitingPassLimitTime = nil
	self._waitingPassTime = nil
	self._waitingRetreatTime = nil
	UnityEngine.Time.timeScale = 1
	self._isTouchedDown = nil
	self._touchDonwPos = nil
	self._timeOnTouchDown = nil

	self:_destroyAutoUsingEffect()

	AMPlayer.saveTimeScale = UnityEngine.Time.timeScale

	self:_unregisterEvents()

	if self._battleActionBar then
		self._battleActionBar:onExit()
	end

	if self._stickerEffect then
		RoleObjectPool.instance:removeRole(self._stickerEffect)

		self._stickerEffect = nil
	end

	self._impressionStickerShowQueue:clear()

	for _, go in pairs(self._dynamicGos) do
		goutil.destroy(go)
	end

	self._dynamicGos = {}

	GameUtil.unloadMultiResLoaderResource(self._resLoader)
end

function BattleMainView:_unregisterEvents()
	GlobalDispatcher:removeListener(GlobalNotify.OnDomainSkillTrigged, self._updateDomainSkill, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnDomainSkillRemoved, self._updateDomainSkill, self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleUnitDead, self._onBattleUnitDead, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpenStart, self._onViewOpened, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClosed, self)
	GlobalDispatcher:removeListener(GlobalNotify.StartBattlePassWaiting, self._onReqNextBattleWaiting, self)
	self._speedXBtn:RemoveClickListener()
	self._passWaiting:RemoveClickListener()
	self._speedX6Btn:RemoveClickListener()
	self._pass:RemoveClickListener()
	self._btnSysSetting:RemoveClickListener()
	self._retreat:RemoveClickListener()
	self._btnSetting:RemoveClickListener()
	self._btnMail:RemoveClickListener()
	self._btnFriend:RemoveClickListener()
	self._btnChat:RemoveClickListener()
	self._autoUseItemBtn:RemoveClickListener()

	if self._btnDomainSkill then
		self._btnDomainSkill:RemoveClickListener()
	end
end

function BattleMainView:_onBattleUnitDead(unit)
	if unit.teamId == BattleModel.instance:getEnemyPlayerTeam() and self._currItemsView then
		self._currItemsView:updateItems()
	end
end

function BattleMainView:_tickClickUnit()
	if self._currItemsView and self._currItemsView:tickClickUnit() then
		self._isTouchedDown = nil
		self._touchDonwPos = nil
		self._timeOnTouchDown = nil

		return
	end

	if not self._isTouchedDown then
		if UGUIToolHelper.IsTouchDown() and not UGUIToolHelper.IsOverUI() then
			self._isTouchedDown = true
			self._touchDonwPos = UGUIToolHelper.GetTouchPosition()
			self._timeOnTouchDown = UnityEngine.Time.unscaledTime
		end
	elseif BattleModel.instance.isRunning and UGUIToolHelper.IsTouchUp() then
		self:_onTouchUp()
	end
end

function BattleMainView:_onTouchUp()
	self._isTouchedDown = nil

	local mousePos = UGUIToolHelper.GetTouchPosition()
	local a, b = GameUtil.checkVector2(mousePos), GameUtil.checkVector2(self._touchDonwPos)

	if GameUtil.getVector2Distance(a, b) >= UGUIToolHelper.touchDragThreshold then
		self._touchDonwPos = nil
		self._timeOnTouchDown = nil

		return
	end

	if UnityEngine.Time.unscaledTime - self._timeOnTouchDown >= 0.2 then
		self._touchDonwPos = nil
		self._timeOnTouchDown = nil

		return
	end

	self._touchDonwPos = nil
	self._timeOnTouchDown = nil

	if UGUIToolHelper.IsOverUI() then
		return
	end

	local unit = self:_judgeTarget()

	if unit and not self.isSkillUlt then
		CommonTipsMgr.instance:showBattleTips(unit)
	end
end

function BattleMainView:_judgeTarget()
	local bounds = {}
	local battleScene = SceneMgr.instance:getCurScene()
	local leftTeamId = BattleModel.instance:getLeftTeamId()
	local units = battleScene.unitFactory:getBttleAliveUnits(leftTeamId)

	if units then
		local unit = self:_judgeTargets(units, bounds)

		if unit then
			return unit
		end
	end

	local rightTeamId = BattleModel.instance:getRightTeamId()

	units = battleScene.unitFactory:getBttleAliveUnits(rightTeamId)

	if units then
		local unit = self:_judgeTargets(units, bounds)

		if unit then
			return unit
		end
	end
end

function BattleMainView:_judgeTargets(units, bounds)
	if units then
		local cnt = #units

		for i = 1, cnt do
			local unit = units[i]

			if not unit.attrs:isCombinedSource() and unit:isTouchHitTarget(bounds) and not unit.attrs:IsOraclePet() and (not unit.attrs:isDoppelganger() or unit.attrs:isHaveBeenDoppelgangerCreated()) then
				return unit
			end
		end

		for i = 1, cnt do
			local unit = units[i]

			if not unit.attrs:isCombinedSource() and unit:isTouchHitTarget(bounds, 2, 2) and not unit.attrs:IsOraclePet() and (not unit.attrs:isDoppelganger() or unit.attrs:isHaveBeenDoppelgangerCreated()) then
				return unit
			end
		end
	end
end

function BattleMainView:_onClickBtnSetting()
	if BattleModel.instance.isBirthing then
		return
	end

	ViewMgr.instance:open(ViewName.BattleSysSetting)
end

function BattleMainView:_onClickSpeedX()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickSpeedUpFight)

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(speedFuncId)

	if not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
		FloatWordMgr.instance:show(cfg.lockedTips)

		return
	end

	if BattleModel.instance.forceSpeedIndex ~= nil then
		return
	end

	self._currSpeed = self._currSpeed % 3 + 1

	UnityEngine.PlayerPrefs.SetInt(self:_getSpeedXKey(), self._currSpeed)
	self:_updateSpeed()
end

function BattleMainView:_onClickSpeedX6()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickSpeedUpFight)

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(speedFuncId)

	if not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
		FloatWordMgr.instance:show(cfg.lockedTips)

		return
	end

	self._speedX6Enabled = not self._speedX6Enabled

	local speedX6Enabled = self._speedX6Enabled and 1 or 0

	UnityEngine.PlayerPrefs.SetInt(self:_getSpeedX6Key(), speedX6Enabled)
	self:_updateSpeed()
end

function BattleMainView:_getSpeedXKey()
	return "speedCfg_" .. LoginModel.instance.userId
end

function BattleMainView:_getSpeedX6Key()
	return "speed6Cfg_" .. LoginModel.instance.userId
end

function BattleMainView:_onClickPassWaiting()
	if checknumber(self._waitingNextTime) > 0 then
		FloatWordMgr.instance:show(string.format("%d秒后进入下一场战斗", math.ceil(self._waitingNextTime)))

		return
	end

	if not self:_checkSippedBattle(true) then
		return
	end

	local nextVipLv, skipTime = BattleSkipTimeMgr.instance:getNextSkipTimeVipLv()

	if nextVipLv and skipTime then
		local tips = VipConfig.instance:getParamString("SKIP_FIGHT_COOL_TIME")

		FloatWordMgr.instance:show(string.format(tips, nextVipLv, skipTime))
	else
		FloatWordMgr.instance:show(string.format("%d秒后才能跳过", math.ceil(self._waitingPassTime)))
	end
end

function BattleMainView:_onClickDomainSkill()
	ViewMgr.instance:open(ViewName.BattleDomainSkills)
end

function BattleMainView:_onClickPass()
	if BattleModel.instance.pauseBattle or BattleModel.instance.isBirthing then
		return
	end

	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickJumpOverFight)

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(passFuncId)

	if not self:_showSkippedOnEditor() and not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
		FloatWordMgr.instance:show(cfg.lockedTips)

		return
	end

	if BattleModel.instance.viewFightBtl then
		BattleController.instance:pass()
	elseif BattleModel.instance:hasReceivedResult() then
		if self:_checkSippedBattle(true) then
			self:_doSippedBattle()
		end
	elseif BattleModel.instance.enableSkip ~= GameEnum.SkipType.UNABLE_SKIP then
		if self:_checkSippedBattle(true) then
			self:_doSippedBattle()
		end
	elseif BattleModel.instance.retreatMsgType ~= 0 then
		BattleController.instance:onRetreatPass()
	elseif BattleModel.instance:hasReceivedResult() then
		BattleController.instance:pass()
	end
end

function BattleMainView:_checkSippedBattle(showtips)
	if self:_showSkippedOnEditor() or BattleModel.instance.enableSkip == GameEnum.SkipType.NORMAL_SKIP then
		return true
	else
		local currLv = MofangModel.instance:getCurLv()
		local vip0Level = VipConfig.instance:getParamInt("SKIP_FIGHT_LV_LIMIT")

		if currLv < vip0Level and not VipModel.instance:getIsAbleToSkippedBattle() then
			if not showtips then
				return false
			end

			local vipLv = VipModel.instance:getAbleToSkippedBattleVipLevel()
			local tips = VipConfig.instance:getParamString("VIP0_SKIP_FIGHT_LV_LIMIT_TIPS")

			FloatWordMgr.instance:show(string.format(tips, vip0Level, vipLv))

			return false
		else
			return true
		end
	end
end

function BattleMainView:_doSippedBattle()
	if BattleModel.instance:hasReceivedResult() then
		BattleController.instance:pass()
	else
		BattleController.instance:onSkipBattle()
	end
end

function BattleMainView:_showSkippedOnEditor()
	return false
end

function BattleMainView:_onClickRetreat()
	if BattleModel.instance.pauseBattle or BattleModel.instance.isBirthing then
		return
	end

	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_FIGHT_QUIT)

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(retreatFuncId)

	if not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
		FloatWordMgr.instance:show(cfg.lockedTips)

		return
	end

	if self._waitingRetreatTime and self._waitingRetreatTime > 0 then
		TipsFacade.instance:openCommonTips(string.format("%d秒后才能撤退", math.ceil(self._waitingRetreatTime)))

		return
	end

	if BattleModel.instance.viewFightBtl then
		BattleController.instance:pass()
	else
		BattleController.instance:pauseAll(true)
		TipsFacade.instance:openPopupWindow(lang("tip"), BattleConfig.instance:getRetreatTips(BattleModel.instance.retreatMsgType), function()
			BattleController.instance:pauseAll(false)
			BattleController.instance:onRetreat()
		end, function()
			BattleController.instance:pauseAll(false)
		end)

		TipsFacade.popupWindowSource = self._viewPresentor.viewName
	end
end

function BattleMainView:_onClickAutoUseItemBtn()
	if self._isAutoUsingItem then
		self:_setAutoUsingItem(false)
	else
		self:_setAutoUsingItem(true)
	end
end

function BattleMainView:_setAutoUsingItem(auto)
	self._isAutoUsingItem = auto

	if self._isAutoUsingItem then
		self:_playAutoUsingEffect()
	else
		self:_stopAutoUsingEffect()
	end

	if self._currItemsView then
		self._currItemsView:setAutoUsingItem(auto)
	end
end

function BattleMainView:_playAutoUsingEffect()
	return
end

function BattleMainView:_stopAutoUsingEffect()
	if self._autoUseItemEff then
		self._autoUseItemEff:setVisible(false)
	end
end

function BattleMainView:_destroyAutoUsingEffect()
	if self._autoUseItemEff then
		UIEffectManager.instance:stopEffect(self._autoUseItemEff)

		self._autoUseItemEff = nil
	end
end

function BattleMainView:_tickPassTime()
	self._waitingPassTime = self._waitingPassTime - 0.033

	if self._waitingPassTime >= 0 then
		self._passWaitingTime.text = tostring(math.ceil(self._waitingPassTime))
		self._passWaitingSlider.value = self._waitingPassTime / self._waitingPassLimitTime
	else
		self._pass.gameObject:SetActive(true)
		self._passWaiting.gameObject:SetActive(false)
		removetimer(self._tickPassTime, self)
	end
end

function BattleMainView:_tickRetreatTime()
	self._waitingRetreatTime = self._waitingRetreatTime - 0.033

	if self._waitingRetreatTime <= 0 then
		removetimer(self._tickRetreatTime, self)
	end
end

function BattleMainView:_updateSpeed()
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(speedFuncId)

	if not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
		self._currSpeed = 1

		if cfg.form == 1 then
			self._speedLock:SetActive(true)
			self._speedX.gameObject:SetActive(true)
		else
			self._speedLock:SetActive(false)
			self._speedX.gameObject:SetActive(false)
		end
	else
		self._speedLock:SetActive(false)
		self._speedX.gameObject:SetActive(true)
	end

	if not self._currSpeed or self._currSpeed == 0 then
		self._currSpeed = 1
	end

	self._enabledSpeedX = self._currSpeed ~= 1

	self:_updateSpeedState()
	self:_updateSpeedXAnim()
	self:_updateSpeedX6Anim()
	self:_setBattleSpeed()
	self._funcBtnLayouts:Layout()
end

function BattleMainView:_updateSpeedState()
	if BattleModel.instance.forceSpeedIndex ~= nil then
		self._currSpeed = BattleModel.instance.forceSpeedIndex

		self._speedLock:SetActive(true)

		local var_59_0

		if self._enabledSpeedX then
			var_59_0 = 2 * self._battleUserInterfaceSkinId - 1 or 2 * self._battleUserInterfaceSkinId - 2
		end
	end

	self._speedStateXImage:ChangeStateNow(var_59_0)
	self._speedX6StateImage:ChangeStateNow(self._speedX6Enabled and 1 or 0)

	if self._currSpeed == 1 then
		self._baseSpeed = 1

		self._speedXImage:ChangeStateNow(self._enabledSpeedX and 1 or 0)
	elseif self._currSpeed == 2 then
		self._baseSpeed = 2

		self._speedXImage:ChangeStateNow(self._enabledSpeedX and 3 or 2)
	elseif self._currSpeed == 3 then
		self._baseSpeed = 3

		self._speedXImage:ChangeStateNow(self._enabledSpeedX and 5 or 4)
	end

	if BattleModel.instance.isEndlessBattle and self._speedX6Enabled then
		self._baseSpeed = 6
	end

	self._speedX6.gameObject:SetActive(false)
	self._speedX6Image:ChangeStateNow(self._speedX6Enabled and 1 or 0)
end

function BattleMainView:_updateSpeedXAnim()
	if self._enabledSpeedX then
		if not self._hasStartRotateSpeedX then
			self._hasStartRotateSpeedX = true
			UnityTweens.TweenRotate.StartTween(self._speedStateXImage.gameObject, Vector3.New(0, 0, 0), Vector3.New(0, 0, 360), 2).loopType = UnityTweens.LoopType.loop
		end
	else
		self._hasStartRotateSpeedX = false

		UnityTweens.TweenRotate.StopTween(self._speedStateXImage.gameObject)
		Framework.TransformUtil.SetLocalRotation(self._speedStateXImage.transform, 0, 0, 0)
	end
end

function BattleMainView:_updateSpeedX6Anim()
	if self._speedX6Enabled then
		if not self._hasStartRotateSpeed6X then
			self._hasStartRotateSpeed6X = true
			UnityTweens.TweenRotate.StartTween(self._speedX6StateImage.gameObject, Vector3.New(0, 0, 0), Vector3.New(0, 0, 360), 2).loopType = UnityTweens.LoopType.loop
		end
	else
		self._hasStartRotateSpeed6X = false

		UnityTweens.TweenRotate.StopTween(self._speedX6StateImage.gameObject)
		Framework.TransformUtil.SetLocalRotation(self._speedX6StateImage.transform, 0, 0, 0)
	end
end

function BattleMainView:_updateActionModes()
	if BattleModel.instance:getActionMode() ~= GameEnum.ActionModel.NoneAction then
		self._dragParent.gameObject:SetActive(true)
		self._itemsNode:SetActive(true)

		self._currItemsView = self._itemsView[BattleModel.instance:getActionMode()]
	else
		self._dragParent.gameObject:SetActive(false)
		self._itemsNode:SetActive(false)

		self._currItemsView = nil
	end

	self._dragClone:SetActive(false)
end

function BattleMainView:_onClickChat()
	print("click chat")
	FuncOpenController.instance:openFunc(55)
end

function BattleMainView:_onClickSetting()
	if BattleModel.instance.isBirthing then
		return
	end

	ChatController.instance:OpenChatSettingView()
end

function BattleMainView:_onClickMail()
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(mailFuncId)

	FuncOpenController.instance:onClickFunc(cfg)
end

function BattleMainView:_onClickFriend()
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(friendFuncId)

	FuncOpenController.instance:onClickFunc(cfg)
end

function BattleMainView:_setBattleSpeed()
	UnityEngine.Time.timeScale = self._baseSpeed
	AMPlayer.saveTimeScale = UnityEngine.Time.timeScale
end

function BattleMainView:_onViewOpened(view)
	return
end

function BattleMainView:_onViewClosed(view)
	local topView = GlobalModel.instance:getTopView()

	if topView and topView.viewName == self._viewPresentor.viewName then
		GlobalModel.instance:visibleMainCamera(true)
	end
end

function BattleMainView:_buildDynamicUI()
	self._changeGroup = self.mainGO:GetComponent(ComponentType.UIChangeGroup)
	self._bgPassGo = self:getGo("rightTop/TweenNode/Layouts/Pass/bgPass")
	self._bgSysSettingGo = self:getGo("rightTop/TweenNode/Layouts/SysSetting/bgSysSetting")
	self._bgSpeedXGo = self:getGo("rightTop/TweenNode/Layouts/SpeedX/bgSpeedX")
	self._bgPassWaitingGo = self:getGo("rightTop/TweenNode/Layouts/PassWaitingcon/PassWaiting/bgPassWaiting")
	self._PassWaitingconGo = self:getGo("rightTop/TweenNode/Layouts/PassWaitingcon")
	self._bgPassGo2 = self:getGo("rightTop/TweenNode/Layouts/Pass/bgPass2")
	self._ImageGo = self:getGo("rightTop/TweenNode/Layouts/SysSetting/Image")
	self._FillGo = self:getGo("rightTop/TweenNode/Layouts/PassWaitingcon/PassWaiting/Slider/Fill Area/Fill")
	self._bgSysSetting2Go = self:getGo("rightTop/TweenNode/Layouts/SysSetting/bgSysSetting2")
	self._SpeedXGo = self:getGo("rightTop/TweenNode/Layouts/SpeedX/SpeedX")
	self._bgshipGoMy = self:getGo("top/myship/bgship")
	self._bgshipfrontGoMy = self:getGo("top/myship/bgshipfront")
	self._bgshipfrontGoOp = self:getGo("top/othership/bgshipfront")
	self._bgshipGoOp = self:getGo("top/othership/bgship")
	self._shipGos = {
		self._bgshipGoMy,
		self._bgshipfrontGoMy,
		self._bgshipfrontGoOp,
		self._bgshipGoOp
	}
	self._dynamicUIBgGos = {
		bgs = {
			self._bgPassGo,
			self._bgSysSettingGo,
			self._bgSpeedXGo,
			self._bgPassWaitingGo
		},
		fgs = {
			self._bgPassGo2,
			self._bgSysSetting2Go
		}
	}
end

function BattleMainView:_changUIStyle(battleUserInterfaceSkinId)
	self:_buildDynamicSubRoot(battleUserInterfaceSkinId)

	if battleUserInterfaceSkinId >= 13 then
		local cfg = BattleStartAnimConfig.instance:getBattleUISkinCfg(battleUserInterfaceSkinId)
		local btnBgIconUrl = GameUrl.getBigbgFolderUrl("battle", cfg.btnBgIcon)
		local btnFgIconUrl = GameUrl.getBigbgFolderUrl("battle", cfg.btnFgIcon)
		local chilunIconUrl = GameUrl.getBigbgFolderUrl("battle", cfg.chilunIcon)
		local speedRingIconUrl = GameUrl.getBigbgFolderUrl("battle", cfg.speedRingIcon)
		local passBtnRingIconUrl = GameUrl.getBigbgFolderUrl("battle", cfg.passBtnRingIcon)
		local showFg = not string.nilorempty(cfg.btnFgIcon)

		for _, go in ipairs(self._dynamicUIBgGos.bgs) do
			uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, btnBgIconUrl)
		end

		for _, go in ipairs(self._dynamicUIBgGos.fgs) do
			GameUtil.SetActive(go, showFg)

			if showFg then
				uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, btnFgIconUrl)
			end
		end

		uGuiUtil.setSpriteToImage(self._FillGo, uGuiUtil.SpriteType.BigBg, passBtnRingIconUrl)
		uGuiUtil.setSpriteToImage(self._ImageGo, uGuiUtil.SpriteType.BigBg, chilunIconUrl)
		uGuiUtil.setSpriteToImage(self._SpeedXGo, uGuiUtil.SpriteType.BigBg, speedRingIconUrl)

		for k, v in pairs(self._shipGos) do
			local change = v:GetComponent(ComponentType.UIImageSpriteChange)

			change:SetState(battleUserInterfaceSkinId - 1)
		end
	else
		for _, go in ipairs(self._dynamicUIBgGos.fgs) do
			GameUtil.SetActive(go, true)
		end

		self._changeGroup:SetState(battleUserInterfaceSkinId - 1)
	end

	self:_changeOpBtnUIStyle(self._bgSpeedXGo, battleUserInterfaceSkinId)
	self:_changeOpBtnUIStyle(self._bgPassGo, battleUserInterfaceSkinId)
	self:_changeOpBtnUIStyle(self._bgSysSettingGo, battleUserInterfaceSkinId)
	self:_setBtnBgsActive(battleUserInterfaceSkinId)
	self:_setupScale(battleUserInterfaceSkinId)
end

function BattleMainView:_setupScale(battleUserInterfaceSkinId)
	local scale1List = {
		1,
		2,
		3,
		4
	}
	local scale = 1

	scale = table.indexof(scale1List, battleUserInterfaceSkinId) and 1 or 1.2

	Framework.TransformUtil.SetLocalScale(self._PassWaitingconGo.transform, scale, scale, 1)
end

function BattleMainView:_setBtnBgsActive(battleUserInterfaceSkinId)
	for i, v in ipairs(self._btnBgGos) do
		goutil.setActive(v, battleUserInterfaceSkinId == 4)
	end
end

function BattleMainView:_changeOpBtnUIStyle(go, battleUserInterfaceSkinId)
	local img = go:GetComponent(goutil.Type_UIImage)

	if battleUserInterfaceSkinId == 1 then
		GameUtil.setWidth(go, 74)
		GameUtil.setHeight(go, 74)
		Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
	elseif battleUserInterfaceSkinId == 2 then
		img:SetNativeSize()
		Framework.TransformUtil.SetLocalPos(go.transform, 0, 4.6, 0)
	elseif battleUserInterfaceSkinId == 13 then
		GameUtil.setWidth(go, 82)
		GameUtil.setHeight(go, 82)
		Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
	else
		img:SetNativeSize()
		Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
	end
end

function BattleMainView:_pushImpressionSticker()
	local round = BattleController.instance:getCurRound()

	self._tempResult = round:getCharactorResult()

	if not self._isPlayingImpressionSticker then
		GameUtil.SetActive(self._stickerLeft, false)
		GameUtil.SetActive(self._stickerRight, false)
	end

	local round = BattleController.instance:getCurRound()

	if round then
		local result = self._tempResult

		if result then
			local characterId = result.caster.targetCharacterId
			local teamId = result.caster.targetTeamId
			local petView = BattleModel.instance:getCharactorById(teamId, characterId)
			local battleScene = SceneMgr.instance:getScene(SceneType.Battle)
			local unit = battleScene.unitFactory:getUnit(teamId, characterId)
			local skinId = 0
			local skillId = result.skillId

			if unit then
				skinId = unit.raceId

				if unit.modelId > 0 then
					skinId = unit.modelId
				end
			end

			local skillCo = BattleConfig.instance:getSkillCo(skillId, skinId)
			local haveSticker = petView.impressionStickersDefineId > 0 and skillCo.type == GameEnum.SkillType.Utl

			if haveSticker then
				if not ImpressionStickersModel.instance:isShowIn(petView.impressionStickersDefineId) then
					return
				end

				local data = {
					id = petView.impressionStickersDefineId,
					teamId = teamId,
					rank = petView.impressionStickersRank
				}

				self._impressionStickerShowQueue:enqueue(data)
				self:_showImpressionSticker()
			end
		end
	end
end

function BattleMainView:_showImpressionSticker()
	local function onAnimPlashFinish(effect, effectHandler)
		if effectHandler then
			RoleObjectPool.instance:removeRole(effectHandler)
		end

		RoleObjectPool.instance:removeRole(self._stickerEffect)

		self._stickerEffect = nil
		self._isPlayingImpressionSticker = false

		self._impressionStickerShowQueue:dequeue()
		GameUtil.SetActive(self._stickerLeft, false)
		GameUtil.SetActive(self._stickerRight, false)

		if self._impressionStickerShowQueue:count() > 0 then
			self:_showImpressionSticker()
		end
	end

	if not self._isPlayingImpressionSticker and self._impressionStickerShowQueue:peek() then
		self._isPlayingImpressionSticker = true

		local data = self._impressionStickerShowQueue:peek()
		local stickCfg = ImpressionStickersConfig.instance:getSticker(data.id)

		if data.teamId == GameEnum.BattleTeam.Left then
			if not self._effectConLeftSticker then
				local targetGo = self._effectConRightSticker
				local animPath = GameUrl.getImpressionStickerUrl(stickCfg.animRes)

				if self._stickerEffect then
					RoleObjectPool.instance:removeRole(self._stickerEffect)

					self._stickerEffect = nil
				end

				self._stickerEffect = {}

				local stickerEffect = self._stickerEffect

				self._stickerEffect.loader = RoleObjectPool.instance:getSpineAsset(animPath, function(go)
					if go ~= nil then
						go:SetActive(true)
						goutil.addChildToParent(go, targetGo)
						Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
						Framework.TransformUtil.SetLocalRotation(go.transform, 0, 0, 0)
						Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
					end

					stickerEffect.asset = go

					RoleObjectPool.instance:playAnimation(go, "idle", false, GameUtil.handler(onAnimPlashFinish, self, stickerEffect), true)
				end)

				if data.teamId == GameEnum.BattleTeam.Left then
					if not self._txtLeftSticker then
						local targetTxt = self._txtRightSticker
						local petCfg = CharacterConfig.instance:getPetCo(stickCfg.raceId)

						targetTxt.text = data.rank <= 0 and stickCfg.defaultDesc or langPara("全服第%d只 %s", data.rank, petCfg.name)

						GameUtil.SetActive(self._stickerLeft, data.teamId == GameEnum.BattleTeam.Left)
						GameUtil.SetActive(self._stickerRight, data.teamId == GameEnum.BattleTeam.Right)
					end
				end
			end
		end
	end
end

function BattleMainView:_hideImpressionSticker()
	if not self._isPlayingImpressionSticker then
		GameUtil.SetActive(self._stickerLeft, false)
		GameUtil.SetActive(self._stickerRight, false)
		uGuiUtil.clearImage(self._stickerLeft)
		uGuiUtil.clearImage(self._stickerRight)
	end
end

BattleMainView.ShipType = {
	SpiritInvocation = 3,
	Genesis = 1,
	Psychic = 2
}

function BattleMainView:_resetShipDatas()
	local leftTeamId = BattleModel.instance:getLeftTeamId()
	local rightTeamId = BattleModel.instance:getRightTeamId()
	local lPInfo = BattlePsychicModel.instance:getPsychicInfo(leftTeamId)
	local rPInfo = BattlePsychicModel.instance:getPsychicInfo(rightTeamId)
	local lGInfo = BattleGenesisModel.instance:getGenesisInfo(leftTeamId)
	local rGInfo = BattleGenesisModel.instance:getGenesisInfo(rightTeamId)
	local lSIInfo = BattleSpiritInvocationModel.instance:getSpiritInvocationInfo(leftTeamId)
	local rSIInfo = BattleSpiritInvocationModel.instance:getSpiritInvocationInfo(rightTeamId)

	self._shipDatas = {
		[leftTeamId] = {
			[BattleMainView.ShipType.Psychic] = self:_checkIsActive(lPInfo),
			[BattleMainView.ShipType.Genesis] = self:_checkIsActive(lGInfo),
			[BattleMainView.ShipType.SpiritInvocation] = self:_checkSpiritInvocationIsActive(lSIInfo)
		},
		[rightTeamId] = {
			[BattleMainView.ShipType.Psychic] = self:_checkIsActive(rPInfo),
			[BattleMainView.ShipType.Genesis] = self:_checkIsActive(rGInfo),
			[BattleMainView.ShipType.SpiritInvocation] = self:_checkSpiritInvocationIsActive(rSIInfo)
		}
	}
end

function BattleMainView:_checkIsActive(info)
	if info and info.hasTriggerCount < info.maxTriggerCount then
		return true
	end

	return false
end

function BattleMainView:_checkSpiritInvocationIsActive(info)
	if info and info.spiritInvocationSkillId > 0 and info.minTriggerProgress > 0 then
		return true
	end

	return false
end

function BattleMainView:_updateShipNodes()
	for index, map in pairs(self._shipDatas) do
		local pActive = map[BattleMainView.ShipType.Psychic]
		local gActive = map[BattleMainView.ShipType.Genesis]
		local time = ServerTime.now()
		local shipPos = BattleMainView.ShipPos.Right

		if index == BattleModel.instance:getLeftTeamId() then
			shipPos = BattleMainView.ShipPos.Left
		end

		local dir = shipPos == BattleMainView.ShipPos.Left and 1 or -1
		local gship = self._shipNodes[shipPos][BattleMainView.ShipNodeName.GShip]
		local pship = self._shipNodes[shipPos][BattleMainView.ShipNodeName.PShip]
		local bgshipFront = self._shipNodes[shipPos][BattleMainView.ShipNodeName.BgshipFront]
		local bgshipBack = self._shipNodes[shipPos][BattleMainView.ShipNodeName.BgshipBack]

		if pActive and gActive then
			local bgshipFrontWidth = 98.35
			local gshipWidth = 82
			local pshipWidth = 151

			GameUtil.setWidth(bgshipFront, bgshipFrontWidth)
			GameUtil.setWidth(gship, gshipWidth)
			GameUtil.setWidth(pship, pshipWidth)

			local pshipPosx = 78 * dir

			Framework.TransformUtil.SetAnchoredPos(pship.transform, pshipPosx, 0)
		elseif pActive then
			local pshipWidth = 229

			GameUtil.setWidth(pship, pshipWidth)
			Framework.TransformUtil.SetAnchoredPos(pship.transform, 0, 0)
		elseif gActive then
			local bgshipFrontWidth = 247.5
			local gshipWidth = 230

			GameUtil.setWidth(bgshipFront, bgshipFrontWidth)
			GameUtil.setWidth(gship, gshipWidth)
		end

		goutil.setActive(bgshipFront, gActive)
		goutil.setActive(bgshipBack, pActive)
	end
end

function BattleMainView:_updateGenesisSkillFight(teamId)
	local info = BattleGenesisModel.instance:getGenesisInfo(teamId)
	local index = teamId

	index = teamId == GameEnum.BattleTeam.Left and BattleModel.instance:getLeftTeamId() or BattleModel.instance:getRightTeamId()
	self._shipDatas[index] = self._shipDatas[index] or {}
	self._shipDatas[index][BattleMainView.ShipType.Genesis] = self:_checkIsActive(info)

	self:_updateShipNodes()
end

function BattleMainView:_initSpiritInvocationSkill(teamId)
	local info = BattleSpiritInvocationModel.instance:getSpiritInvocationInfo(teamId)
	local teamDirection = BattleModel.instance:getTeamDirection(teamId)
	local objs = self._spiritInvocationObjs[teamDirection]
	local isActive = self:_checkSpiritInvocationIsActive(info)

	GameUtil.SetActive(objs.rootGo, isActive)
	self:stopViewEffectUniGo(objs.idleEffectGo)

	if not info then
		uGuiUtil.clearImage(objs.headGo)
		uGuiUtil.clearImage(objs.backGo)
		uGuiUtil.clearImage(objs.frontGo)

		return
	end

	if isActive == true then
		local getCfg = ContractConfig.instance:getSpiritInvocationCfg(info.spiritInvocationSkillId)
		local image = objs.headGo:GetComponent(goutil.Type_UIImage)

		if getCfg and not string.nilorempty(getCfg.headImgRes) then
			uGuiUtil.setSpriteToImage(objs.headGo, nil, GameUrl.getSpiriteInvocationPetUrl(getCfg.headImgRes), function()
				image:SetNativeSize()
			end, self)
		else
			uGuiUtil.clearImage(objs.headGo)
		end

		local backImage = objs.backGo:GetComponent(goutil.Type_UIImage)

		if getCfg and not string.nilorempty(getCfg.backImgRes) then
			uGuiUtil.setSpriteToImage(objs.backGo, nil, GameUrl.getSpiriteInvocationPetUrl(getCfg.backImgRes), function()
				backImage:SetNativeSize()
			end, self)
		else
			uGuiUtil.clearImage(objs.backGo)
		end

		local forntImage = objs.frontGo:GetComponent(goutil.Type_UIImage)

		if getCfg and not string.nilorempty(getCfg.frontImgRes) then
			uGuiUtil.setSpriteToImage(objs.frontGo, nil, GameUrl.getSpiriteInvocationPetUrl(getCfg.frontImgRes), function()
				forntImage:SetNativeSize()
			end, self)
		else
			uGuiUtil.clearImage(objs.frontGo)
		end

		if not string.nilorempty(getCfg.idleEffectRes) then
			local eff = self:playViewEffectUniGo(getCfg.idleEffectRes, objs.idleEffectGo, nil, true, nil, function(target, eff)
				if teamDirection == GameEnum.BattleTeam.Right then
					eff:setLocalEulerAngle(0, 180, 0)
				else
					eff:setLocalEulerAngle(0, 0, 0)
				end
			end)

			GameUtil.setAnchoredPos(objs.idleEffectGo, checknumber(getCfg.idleEffectOffset[1]), checknumber(getCfg.idleEffectOffset[2]))
		end

		GameUtil.setAnchoredPos(objs.headRootGo, checknumber(getCfg.headOffset[1]), checknumber(getCfg.headOffset[2]))
	else
		uGuiUtil.clearImage(objs.headGo)
		uGuiUtil.clearImage(objs.backGo)
		uGuiUtil.clearImage(objs.frontGo)
	end
end

function BattleMainView:_canPlaySpiritInvocationEnter(teamId)
	local info = BattleSpiritInvocationModel.instance:getSpiritInvocationInfo(teamId)

	if not self:_checkSpiritInvocationIsActive(info) then
		return false
	end

	local cfg = ContractConfig.instance:getSpiritInvocationCfg(info.spiritInvocationSkillId)

	return cfg and not string.nilorempty(cfg.headImgRes)
end

function BattleMainView:_prepareSpiritInvocationEnter(teamId)
	local teamDirection = BattleModel.instance:getTeamDirection(teamId)
	local objs = self._spiritInvocationObjs[teamDirection]
	local go = objs.headGo
	local pos = objs.endPos

	GameUtil.SetActive(objs.headGo, false)
	GameUtil.SetActive(objs.backGo, false)
	GameUtil.SetActive(objs.frontGo, false)
	GameUtil.SetActive(objs.idleEffectGo, false)
	GameUtil.SetActive(objs.shipGo, false)
	UnityTweens.TweenPosition.StopTween(go)
	UnityTweens.UITweenFade.StopTween(go)

	local isActive = self:_canPlaySpiritInvocationEnter(teamId)

	if isActive == true then
		GameUtil.setAnchoredPos(go, pos.x + spiritInvocationEnterOffsetX, pos.y)
	else
		GameUtil.setAnchoredPos(go, pos.x, pos.y)
	end

	objs.canvasGroup.alpha = isActive and 0 or 1

	return isActive
end

function BattleMainView:_playSpiritInvocationEnter()
	self:_stopSpiritInvocationEnter(false)

	local leftTeamId = BattleModel.instance:getLeftTeamId()
	local rightTeamId = BattleModel.instance:getRightTeamId()

	self:_initSpiritInvocationSkill(leftTeamId)
	self:_initSpiritInvocationSkill(rightTeamId)

	local isLeftActive = self:_prepareSpiritInvocationEnter(leftTeamId)
	local isRightActive = self:_prepareSpiritInvocationEnter(rightTeamId)

	if not isLeftActive and not isRightActive then
		GlobalDispatcher:dispatch(GlobalNotify.BattleSpiritInvocationEnterFinish)

		return
	end

	self._isPlayingSpiritInvocationEnter = true
	self._spiritInvocationEnterRemainCount = 0

	if isLeftActive == true then
		local objs = self._spiritInvocationObjs[GameEnum.BattleTeam.Left]
		local info = BattleSpiritInvocationModel.instance:getSpiritInvocationInfo(leftTeamId)
		local getCfg = ContractConfig.instance:getSpiritInvocationCfg(info.spiritInvocationSkillId)

		GameUtil.setAnchoredPos(objs.enterEffectGo, getCfg.enterEffectOffset[1], getCfg.enterEffectOffset[2])
		self:_playSpiritInvocationEnterTween(objs, getCfg, GameEnum.BattleTeam.Left)

		self._spiritInvocationEnterRemainCount = self._spiritInvocationEnterRemainCount + 1
	end

	if isRightActive == true then
		local objs = self._spiritInvocationObjs[GameEnum.BattleTeam.Right]
		local info = BattleSpiritInvocationModel.instance:getSpiritInvocationInfo(rightTeamId)
		local getCfg = ContractConfig.instance:getSpiritInvocationCfg(info.spiritInvocationSkillId)

		GameUtil.setAnchoredPos(objs.enterEffectGo, getCfg.enterEffectOffset[1], getCfg.enterEffectOffset[2])
		self:_playSpiritInvocationEnterTween(objs, getCfg, GameEnum.BattleTeam.Right)

		self._spiritInvocationEnterRemainCount = self._spiritInvocationEnterRemainCount + 1
	end
end

function BattleMainView:_playSpiritInvocationEnterTween(objs, getCfg, teamId)
	local enterEffectPath = getCfg.enterEffectRes

	if not string.nilorempty(enterEffectPath) then
		local effect = UIEffectManager.instance:playEffect(self, enterEffectPath, nil, 0, 0, false)

		effect.hideEffWhileNotOnTop = false

		effect:setParent(objs.enterEffectGo.transform)
		effect:setLocalPos(0, 0, 0)
		effect:setScale(1)

		if teamId == GameEnum.BattleTeam.Right then
			effect:setLocalEulerAngle(0, 180, 0)
		else
			effect:setLocalEulerAngle(0, 0, 0)
		end
	end

	GameUtil.SetActive(objs.headGo, true)
	GameUtil.SetActive(objs.backGo, true)
	GameUtil.SetActive(objs.frontGo, true)

	local pos = objs.endPos

	UnityTweens.UITweenFade.StartTween(objs.headGo, 0, 1, spiritInvocationEnterDuration, UnityTweens.EaseType.easeOutSine)

	local tween = UnityTweens.TweenPosition.StartTween(objs.headGo, Vector3.New(pos.x + spiritInvocationEnterOffsetX, pos.y, 0), Vector3.New(pos.x, pos.y, 0), spiritInvocationEnterDuration, UnityTweens.EaseType.easeOutSine, 0, UnityTweens.CoordSpace.Anchor)

	tween:AddListener(self._onSpiritInvocationEnterTweenFinish, self)
end

function BattleMainView:_onSpiritInvocationEnterTweenFinish()
	if not self._isPlayingSpiritInvocationEnter then
		return
	end

	GameUtil.SetActive(self._spiritInvocationObjs[GameEnum.BattleTeam.Right].shipGo, true)
	GameUtil.SetActive(self._spiritInvocationObjs[GameEnum.BattleTeam.Left].shipGo, true)
	GameUtil.SetActive(self._spiritInvocationObjs[GameEnum.BattleTeam.Right].idleEffectGo, true)
	GameUtil.SetActive(self._spiritInvocationObjs[GameEnum.BattleTeam.Left].idleEffectGo, true)

	self._spiritInvocationEnterRemainCount = self._spiritInvocationEnterRemainCount - 1

	if self._spiritInvocationEnterRemainCount <= 0 then
		self._isPlayingSpiritInvocationEnter = nil
		self._spiritInvocationEnterRemainCount = nil

		GlobalDispatcher:dispatch(GlobalNotify.BattleSpiritInvocationEnterFinish)
	end
end

function BattleMainView:_stopSpiritInvocationEnter(resetPosition)
	self._isPlayingSpiritInvocationEnter = nil
	self._spiritInvocationEnterRemainCount = nil

	if not self._spiritInvocationObjs then
		return
	end

	for _, objs in pairs(self._spiritInvocationObjs) do
		UnityTweens.TweenPosition.StopTween(objs.headGo)
		UnityTweens.UITweenFade.StopTween(objs.headGo)

		if resetPosition ~= false then
			GameUtil.setAnchoredPos(objs.headGo, objs.endPos.x, objs.endPos.y)

			objs.canvasGroup.alpha = 1
		end
	end
end

function BattleMainView:_updateSpiritInvocationSkillFight(teamId)
	local info = BattleSpiritInvocationModel.instance:getSpiritInvocationInfo(teamId)
	local index = teamId

	index = teamId == GameEnum.BattleTeam.Left and BattleModel.instance:getLeftTeamId() or BattleModel.instance:getRightTeamId()
	self._shipDatas[index] = self._shipDatas[index] or {}
	self._shipDatas[index][BattleMainView.ShipType.SpiritInvocation] = self:_checkSpiritInvocationIsActive(info)

	self:_updateShipNodes()

	if not BattleController.instance.battleStartEffFinished then
		self:_initSpiritInvocationSkill(teamId)
		self:_prepareSpiritInvocationEnter(teamId)
	end
end

function BattleMainView:_updatePsychicSkillFight(teamId)
	local info = BattlePsychicModel.instance:getPsychicInfo(teamId)
	local index = teamId

	index = teamId == GameEnum.BattleTeam.Left and BattleModel.instance:getLeftTeamId() or BattleModel.instance:getRightTeamId()
	self._shipDatas[index] = self._shipDatas[index] or {}
	self._shipDatas[index][BattleMainView.ShipType.Psychic] = self:_checkIsActive(info)

	self:_updateShipNodes()
end

function BattleMainView:_onUseSpiritInvocationSkillStart(unit, curFaceId)
	local teamId = unit.teamId
	local teamDirection = BattleModel.instance:getTeamDirection(teamId)
	local showCon = self._spiritInvocationObjs[teamDirection].skillEffectGo
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(curFaceId)

	if not skinCfg or checknumber(skinCfg.spiritInvocationSkillId) <= 0 then
		BattleController.instance:showEndUIBattleEffect()

		return
	end

	local spiritInvocationCfg = ContractConfig.instance:getSpiritInvocationCfg(skinCfg.spiritInvocationSkillId)

	if not spiritInvocationCfg then
		BattleController.instance:showEndUIBattleEffect()

		return
	end

	GameUtil.setAnchoredPos(showCon, spiritInvocationCfg.uiEffectOffset[1], spiritInvocationCfg.uiEffectOffset[2])
	self:_syncSpiritInvocationUnitPos(unit, showCon)

	if string.nilorempty(spiritInvocationCfg.uiEffectRes) then
		BattleController.instance:showEndUIBattleEffect()

		return
	end

	self:_onHideSpiritInvocationPet(false)

	local path = spiritInvocationCfg.uiEffectRes
	local effect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, false, nil, function()
		BattleController.instance:showEndUIBattleEffect()
	end)

	effect:setParent(showCon.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)

	if teamDirection == GameEnum.BattleTeam.Right then
		effect:setLocalEulerAngle(0, 180, 0)
	else
		effect:setLocalEulerAngle(0, 0, 0)
	end
end

function BattleMainView:_syncSpiritInvocationUnitPos(unit, showCon)
	if not unit or not showCon or goutil.isNil(unit.go) or goutil.isNil(showCon) then
		return
	end

	local uiCamera = GlobalModel.instance.uiCamera
	local battleCamera = GlobalModel.instance.mainCamera

	if not uiCamera or not battleCamera then
		return
	end

	local screenPos = uiCamera:WorldToScreenPoint(showCon.transform.position)
	local unitScreenPos = battleCamera:WorldToScreenPoint(unit.go.transform.position)

	screenPos.z = unitScreenPos.z

	local worldPos = battleCamera:ScreenToWorldPoint(screenPos)

	unit.transform:setPos(worldPos.x, worldPos.y, worldPos.z, true)
	unit.attrs:setBirthPoint(worldPos.x, worldPos.y, worldPos.z)
end

function BattleMainView:_isSpiritInvocationPetSkillUnit(unit)
	local var_101_0

	if unit then
		::label_101_0::

		var_101_0 = unit.attrs and unit.attrs:isSpiritInvocationPet()
	end

	return var_101_0
end

function BattleMainView:_onHideSpiritInvocationPet(hide, unit)
	if hide and self:_isSpiritInvocationPetSkillUnit(unit) then
		return
	end

	hide = hide or self._skillCameraCount > 0

	local leftInfo = BattleSpiritInvocationModel.instance:getSpiritInvocationInfo(BattleModel.instance:getLeftTeamId())
	local rightInfo = BattleSpiritInvocationModel.instance:getSpiritInvocationInfo(BattleModel.instance:getRightTeamId())

	GameUtil.SetActive(self._spiritInvocationObjs[GameEnum.BattleTeam.Left].rootGo, not hide and self:_checkSpiritInvocationIsActive(leftInfo))
	GameUtil.SetActive(self._spiritInvocationObjs[GameEnum.BattleTeam.Right].rootGo, not hide and self:_checkSpiritInvocationIsActive(rightInfo))
end

return BattleMainView
