local var_0_0 = g.core.const.ConstMgr.WushTowerConst
local var_0_1 = g.core.model.User.wushTowerData
local AIModuleTree = require("app.view.module.debug.oneKeyComp.AITree.BT.AIModuleTree")
local BNBase = require("app.view.module.debug.oneKeyComp.AITree.BNBase")
local var_0_4 = g.view.entrance
local AIWushTowerSelectTree = class("AIWushTowerSelectTree", BNBase.Base)

function AIWushTowerSelectTree:visitBN()
	local var_1_0 = g.core.module.ModuleManager:getCurModule().display

	if var_1_0.m_zoneComp then
		if self.state ~= BNBase.Base.RUN then
			var_1_0:_refreshMainLayerUI()

			for iter_1_0 = 1, var_0_0.WUSH_TOWER_STAGE_COUNT do
				if var_1_0.m_zoneComp["m_stageComp" .. iter_1_0] and self:checkCanMove(iter_1_0) then
					var_1_0.m_zoneComp["m_stageComp" .. iter_1_0]:dispatchEvent(fgui.UIEventType.Click)

					self.state = BNBase.Base.RUN

					return
				end
			end

			self.state = BNBase.Base.FAIL
		end
	else
		self.state = BNBase.Base.SUC
	end
end

function AIWushTowerSelectTree:checkCanMove(arg_2_1)
	local var_2_0 = var_0_1:getZoneId()
	local var_2_1 = var_0_1:getStateByParcel(arg_2_1)
	local var_2_2 = var_0_1:getFloorByParcel(var_2_0, arg_2_1)
	local var_2_3 = var_0_1:getCurIndex()

	return (var_2_1 ~= var_0_0.STAGE_STATE.PASS or false) and (var_2_1 ~= var_0_0.STAGE_STATE.UNOPEN or false) and (var_2_1 ~= var_0_0.STAGE_STATE.OFF or false) and (var_0_1:getFloorByParcel(var_2_0, var_2_3) ~= var_2_2 or var_2_3 == arg_2_1)
end

local AIWushTowerCardTree = class("AIWushTowerCardTree", BNBase.Base)

function AIWushTowerCardTree:visitBN()
	local var_3_0 = g.core.module.ModuleManager:getCurModule().display

	if var_3_0.m_goGetBtn then
		if var_3_0.m_goGetBtn:isVisible() and self.state ~= BNBase.Base.RUN then
			var_3_0.m_goGetBtn:dispatchEvent(fgui.UIEventType.Click)

			self.state = BNBase.Base.RUN
		else
			g.core.module.ModuleManager:onlyPopSelfByDisplay(var_3_0)

			self.state = BNBase.Base.SUC
		end
	else
		self.state = BNBase.Base.FAIL
	end
end

local AIWushTowerMonstTree = class("AIWushTowerMonstTree", BNBase.Base)

function AIWushTowerMonstTree:visitBN()
	local var_4_0 = g.core.module.ModuleManager:getCurModule()

	var_0_1:setPeriodCardTips(true)

	if var_4_0.display:getName() == "BaseConfirmPop" then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(var_4_0.display)
	end

	local var_4_1 = g.core.module.ModuleManager:getCurModule().display

	if var_4_1.m_stateController:getSelectedIndex() == 0 then
		var_4_1.m_goToBtn:dispatchEvent(fgui.UIEventType.Click)

		self.state = BNBase.Base.SUC
	elseif var_4_1.m_stateController:getSelectedIndex() == 1 then
		var_4_1.m_battleBtn:dispatchEvent(fgui.UIEventType.Click)

		self.state = BNBase.Base.SUC
	end
end

local var_0_8 = BNBase.SelectNode.new("runGoWushTowerMainLayerTree", {
	BNBase.WhileNode(function()
		return AIModuleTree.CheckModule(var_0_4.HOME)
	end, AIModuleTree.AIGoCampaignTree.new()),
	BNBase.WhileNode(function()
		return AIModuleTree.CheckModule(var_0_4.CAMPAIGN)
	end, AIModuleTree.AIGoWushTowerChooseTree.new()),
	BNBase.WhileNode(function()
		return AIModuleTree.CheckModule(var_0_4.WUSH_TOWER_CHOOSE)
	end, AIModuleTree.AIGoWushTower.new()),
	BNBase.WhileNode(function()
		return g.core.module.ModuleManager:getCurModule().module ~= var_0_4.HOME
	end, AIModuleTree.AIGoHomeTree.new())
})

return BNBase.PriorityNode.new("SequenceNode", {
	BNBase.WhileNode(function()
		return var_0_1:isUnFinishCanChallenge() or var_0_1:getCanChallengeCount() > 0
	end, (BNBase.PriorityNode.new("AIWushTowerTree", {
		BNBase.WhileNode(function()
			return AIModuleTree.CheckModule(var_0_4.WUSH_TOWER)
		end, AIWushTowerSelectTree.new()),
		BNBase.WhileNode(function()
			return AIModuleTree.CheckModule(var_0_4.WUSH_TOWER_MONSTER)
		end, AIWushTowerMonstTree.new()),
		BNBase.WhileNode(function()
			return AIModuleTree.CheckModule(var_0_4.WUSH_TOWER_CARD)
		end, AIWushTowerCardTree.new()),
		BNBase.WhileNode(function()
			return g.core.module.ModuleManager:getCurModule().module ~= var_0_4.WUSH_TOWER
		end, var_0_8)
	}))),
	BNBase.WhileNode(function()
		if var_0_1:isPassZone() then
			return var_0_1:getZoneId() ~= var_0_1:getMaxZoneId()
		else
			return false
		end
	end, BNBase.PriorityNode.new("WushTowerSendMsgPriorityNode", {
		BNBase.WhileNode(function()
			return g.core.module.ModuleManager:getCurModule().module ~= var_0_4.WUSH_TOWER
		end, var_0_8),
		BNBase.ActionNode.new(function()
			local var_16_0 = g.core.module.ModuleManager:getCurModule().display

			if var_16_0.m_zoneComp then
				if var_0_1:isPassZone() then
					if var_0_1:getZoneId() ~= var_0_1:getMaxZoneId() then
						g.core.network.GameNetProxy:send_C2S_DeadTower_NextGrids({})
					end
				else
					var_16_0:_updateMainView()
				end
			end
		end)
	}))
})
