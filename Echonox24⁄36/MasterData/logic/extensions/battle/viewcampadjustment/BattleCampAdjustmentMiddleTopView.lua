-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentMiddleTopView.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentMiddleTopView", package.seeall)

local BattleCampAdjustmentMiddleTopView = class("BattleCampAdjustmentMiddleTopView", ViewComponent)
local kUICamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

function BattleCampAdjustmentMiddleTopView:buildUI()
	self._txtInTeamCount = self:getText("prewar_prepare_view_-744511557")
	self._goCampBuffIcons = {
		self:getGo("prewar_prepare_view_-1202029983"),
		self:getGo("prewar_prepare_view_-1723897956"),
		self:getGo("prewar_prepare_view_-526275377"),
		self:getGo("prewar_prepare_view_-273855269"),
		(self:getGo("prewar_prepare_view_-1697746701"))
	}
	self._winConditionTxt = self:getText("prewar_prepare_view_1913933748")
	self._gameExplainationGo = self:getGo("prewar_prepare_view_-13486294")
	self._btnGameExplaination = self:getBtn("0&btn_explain_-1936547904")
	self._txtExplain = self:getText("prewar_prepare_view_-13486294")
end

function BattleCampAdjustmentMiddleTopView:destroyUI()
	self._txtInTeamCount = nil
	self._goCampBuffIcons = nil
end

function BattleCampAdjustmentMiddleTopView:bindEvents()
	self._btnGameExplaination:AddClickListener(self._onClickExplaination, self)
end

function BattleCampAdjustmentMiddleTopView:unbindEvents()
	self._btnGameExplaination:RemoveClickListener()
end

function BattleCampAdjustmentMiddleTopView:onEnter()
	self:_setEvent(true)
	self:_updateView()
	self:_updateSameCampCountView()
end

function BattleCampAdjustmentMiddleTopView:onExit()
	self._explainCode = false

	self:_setEvent(false)
end

function BattleCampAdjustmentMiddleTopView:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.Adjustment_OnAvailableHeroListUpdate, self._onAvailableHeroListUpdate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.Adjustment_OnAvailableHeroListUpdate, self._onAvailableHeroListUpdate, self)
	end
end

function BattleCampAdjustmentMiddleTopView:_updateView()
	local teamCodeList = BattleCampAdjustmentModel.instance:getCurrentTeamCharacterCodeList()
	local maxCount = BattleCampAdjustmentModel.instance:getEntityCountLimit()

	self._txtInTeamCount.text = string.format("%s/%s", #teamCodeList, maxCount)

	local activeBattleFlow = BattleMgr.instance:getActiveBattleFlow()

	if OOPUtil.isInstanceOf(activeBattleFlow, LevelBattleFlowBase) then
		local winCondition = BattleMgr.instance:getWinCondition()

		self._winConditionTxt.text = winCondition:getWinConditionDescription()
	else
		self._winConditionTxt.text = "NONE"
	end

	local isActive = false
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	self._explainByGlobalCode = false

	if dungeonCode then
		local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)

		if dungeonMO and ControlActionUtil.isControlActionDungeon(dungeonMO:getType()) or dungeonMO:getType() == CommEnum.DungeonType.PowerChallenge then
			if ControlActionUtil.isPianoDungeon(dungeonCode) then
				self._explainCode = 4201
				isActive = true
			elseif ControlActionUtil.isDoomForecastDungeon(dungeonCode) then
				self._explainCode = 4202
				isActive = true
			elseif ControlActionUtil.isStatusDungeon(dungeonCode) then
				self._explainCode = 4203
				isActive = true
			elseif dungeonMO:getType() == CommEnum.DungeonType.PowerChallenge then
				self._txtExplain.text = "效果说明"
				self._explainCode = false
				self._explainByGlobalCode = true

				local dungeonId = dungeonMO:getId()
				local dungeonCO = DungeonConfig.instance:getDungeonCfgById(dungeonId)
				local levelCO = BattleConfig.instance:getBattleLevelCO(dungeonCO.levelID)

				self._desc = ""

				for _, code in ipairs(levelCO.globalSkillCodeList) do
					local skillCO = ActiveSkillConfig.instance:getActiveSkillCOWrapper(code)

					if skillCO then
						self._desc = self._desc .. skillCO:getDescription() .. "\n"
					end
				end

				isActive = true
			end
		end
	end

	goutil.setActive(self._gameExplainationGo, isActive)
end

function BattleCampAdjustmentMiddleTopView:_updateSameCampCountView()
	local targetCount = BattleCampAdjustmentModel.instance:getSameCampCount() or 0

	for count, go in pairs(self._goCampBuffIcons) do
		if count <= targetCount then
			goutil.setActive(go, true)
		else
			goutil.setActive(go, false)
		end
	end
end

function BattleCampAdjustmentMiddleTopView:_onClickExplaination()
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

function BattleCampAdjustmentMiddleTopView:_onAvailableHeroListUpdate()
	self:_updateView()
end

return BattleCampAdjustmentMiddleTopView
