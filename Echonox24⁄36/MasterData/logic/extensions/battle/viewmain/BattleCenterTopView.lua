-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/BattleCenterTopView.lua

module("logic.extensions.battle.viewmain.BattleCenterTopView", package.seeall)

local BattleCenterTopView = class("BattleCenterTopView", ViewComponent)
local kRoundRegex = "回合 %s:00"

function BattleCenterTopView:buildUI()
	self.mainGO = self:getGoByPath("bout")
	self._normalGo = goutil.findChild(self.mainGO, "objNormal")
	self._gameExplainationGo = goutil.findChild(self.mainGO, "objNormal/layout/Text1")
	self._txtExplain = goutil.findChildTextComponent(self.mainGO, "objNormal/layout/Text1")
	self._explainEnableState = GameObjectEnableState.New(self._gameExplainationGo)
	self._btnGameExplaination = Astral.ButtonAdapter.GetFrom(self.mainGO, "objNormal/layout/Text1/btn_explain")
	self._boutHintGo = goutil.findChild(self.mainGO, "objNormal/boutHint")
	self._enableState = GameObjectVisibleState.New()
	self._txtRound = goutil.findChildTextComponent(self.mainGO, "objNormal/boutHint/txtBoutNum")
	self._txtCondition = goutil.findChildTextComponent(self.mainGO, "objNormal/layout/txtVictoryConditions")
	self._conditionBgGo = goutil.findChild(self.mainGO, "objNormal/layout/imgDi")
	self._teachGo = goutil.findChild(self.mainGO, "objTeach")
	self._teachTxtCondtion = goutil.findChildTextComponent(self.mainGO, "objTeach/txtHint1")
	self._teachDescGo = goutil.findChild(self.mainGO, "objTeach/desc")
	self._teachTxtDesc = goutil.findChildTextComponent(self.mainGO, "objTeach/desc/txtDesc")
	self._TeachTxtRound = goutil.findChildTextComponent(self.mainGO, "objTeach/desc/txtRound")
end

function BattleCenterTopView:destroyUI()
	self._txtRound = nil
	self._txtCondition = nil
	self._btnRestrainHint = nil
end

function BattleCenterTopView:bindEvents()
	self._btnGameExplaination:AddClickListener(self._onClickExplaination, self)
end

function BattleCenterTopView:unbindEvents()
	self._btnGameExplaination:RemoveClickListener()
end

function BattleCenterTopView:onEnter()
	self:_setEvent(true)
	self:_init()
	self:_updateView()
end

function BattleCenterTopView:_init()
	self._activeExplain = false
	self._isTeachingDungeon = false

	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if dungeonCode then
		self._dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)

		if self._dungeonMO and self._dungeonMO:getType() == CommEnum.DungeonType.Teaching then
			self._isTeachingDungeon = true
		end

		if self._dungeonMO then
			if ControlActionUtil.isPianoDungeon(dungeonCode) then
				self._explainCode = 4201
				self._activeExplain = true
			elseif ControlActionUtil.isDoomForecastDungeon(dungeonCode) then
				self._explainCode = 4202
				self._activeExplain = true
			elseif ControlActionUtil.isStatusDungeon(dungeonCode) then
				self._explainCode = 4203
				self._activeExplain = true
			elseif self._dungeonMO:getType() == CommEnum.DungeonType.PowerChallenge then
				self._txtExplain.text = "效果说明"
				self._explainCode = false
				self._explainByGlobalCode = true

				local dungeonId = self._dungeonMO:getId()
				local dungeonCO = DungeonConfig.instance:getDungeonCfgById(dungeonId)
				local levelCO = BattleConfig.instance:getBattleLevelCO(dungeonCO.levelID)

				self._desc = ""

				for _, code in ipairs(levelCO.globalSkillCodeList) do
					local skillCO = ActiveSkillConfig.instance:getActiveSkillCOWrapper(code)

					if skillCO then
						self._desc = self._desc .. skillCO:getDescription() .. "\n"
					end
				end

				self._activeExplain = true
			end
		end
	end

	goutil.setActive(self._normalGo, not self._isTeachingDungeon)
	goutil.setActive(self._teachGo, self._isTeachingDungeon)
	goutil.setActive(self._gameExplainationGo, self._activeExplain)
end

function BattleCenterTopView:onExit()
	self:_setEvent(false)
	self._enableState:clear()
end

function BattleCenterTopView:setVisible(visible, key)
	self._enableState:setEnable(key, visible)

	local isActive = self._enableState:isEnable()

	goutil.setActive(self._boutHintGo, not self._isTeachingDungeon and isActive)
	goutil.setActive(self._txtCondition.gameObject, not self._isTeachingDungeon and isActive)
	goutil.setActive(self._conditionBgGo, not self._isTeachingDungeon and isActive)
	goutil.setActive(self._teachGo, self._isTeachingDungeon and isActive)

	if key and self._activeExplain then
		self._explainEnableState:setEnable(key, visible)
	end
end

function BattleCenterTopView:setExplainVisible(visible, key)
	if key and self._activeExplain then
		self._explainEnableState:setEnable(key, visible)
	end
end

function BattleCenterTopView:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnBattleRoundUpdate, self._onRoundUpdate, self)
		BattleDispatcher:addEventListener(BattleEventType.OnCondtionsChanged, self._onCondtionsChanged, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleRoundUpdate, self._onRoundUpdate, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnCondtionsChanged, self._onCondtionsChanged, self)
	end
end

function BattleCenterTopView:_updateView()
	local battleModel = BattleMgr.instance:getModel()

	self:_onRoundUpdate(false, battleModel:getCurrentRound(), battleModel:getMaxRound())

	if self._isTeachingDungeon then
		self._teachTxtDesc.text = StringUtil.replaceAllToColor(self._dungeonMO:getDesc(), "#ffffff")
	end

	self:_onCondtionsChanged()
end

function BattleCenterTopView:_onCondtionsChanged()
	local activeBattleFlow = BattleMgr.instance:getActiveBattleFlow()
	local winStr = "NONE"

	if OOPUtil.isInstanceOf(activeBattleFlow, LevelBattleFlowBase) then
		local winCondition = BattleMgr.instance:getWinCondition()

		winStr = winCondition:getWinConditionDescription()
	end

	if self._isTeachingDungeon then
		self._teachTxtCondtion.text = winStr
	else
		self._txtCondition.text = winStr
	end
end

function BattleCenterTopView:_onRoundUpdate(e, currentRound, maxRound)
	if self._isTeachingDungeon then
		local remainRound = maxRound - currentRound + 1

		if remainRound > 1 then
			self._TeachTxtRound.text = string.format("剩余<color=#ffffff>%d</color>回合", remainRound)
		else
			self._TeachTxtRound.text = string.format("剩余<color=#EF0F0F>%d</color>回合", remainRound)
		end
	else
		self._txtRound.text = string.format(kRoundRegex, TimeUtil.instance:numberFixPre(currentRound))
	end
end

function BattleCenterTopView:_onClickExplaination()
	if self._explainCode then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			self._explainCode
		})
	elseif self._explainByGlobalCode then
		ViewMgr.instance:open(ViewName.ImageGuide, {
			0,
			1,
			self._desc
		})
	end
end

return BattleCenterTopView
