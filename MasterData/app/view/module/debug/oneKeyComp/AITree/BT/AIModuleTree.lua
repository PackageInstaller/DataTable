local var_0_0 = g.core.model.User
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local BNBase = require("app.view.module.debug.oneKeyComp.AITree.BNBase")
local var_0_3 = g.view.entrance
local AIModuleBase = class("AIModuleBase", BNBase.Base)

function AIModuleBase:ctor(arg_1_1)
	AIModuleBase.super.ctor(self, self.__cname, arg_1_1)
end

local AILoginTree = class("AILoginTree", AIModuleBase)

function AILoginTree:visitBN()
	local var_2_0 = g.core.module.ModuleManager:getCurModule()

	if var_2_0.module == var_0_3.LOGIN then
		if var_2_0.display._onLogin then
			var_2_0.display:_onLogin()

			self.state = BNBase.Base.RUN
		else
			self.state = BNBase.Base.FAIL
		end
	else
		self.state = BNBase.Base.SUC
	end
end

local AIBattleTree = class("AIBattleTree", AIModuleBase)

function AIBattleTree:visitBN()
	if g.core.battle.BattleProxy:isInBattle() then
		g.core.battle.BattleProxy:skipBattle()

		local var_3_0 = g.core.module.ModuleManager:getCurModule()

		if var_3_0.display:getName() == "BattleResultLayer" then
			var_3_0.display:onBattleShowFinish()
		end

		self.state = BNBase.Base.RUN
	else
		self.state = BNBase.Base.SUC
	end
end

local AIGoHomeTree = class("AIGoHomeTree", AIModuleBase)

function AIGoHomeTree:visitBN()
	if g.core.module.ModuleManager:getCurModule().module == var_0_3.HOME then
		self.state = BNBase.Base.SUC
	else
		self.state = BNBase.Base.SUC

		g.core.module.ModuleManager:popAllPopup()
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

local AIDebugReturnTree = class("AIDebugReturnTree", AIModuleBase)

function AIDebugReturnTree:visitBN()
	local var_5_0 = g.core.module.ModuleManager:getCurModule()

	if var_5_0.module == var_0_3.DEBUG then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(var_5_0.display)

		self.state = BNBase.Base.RUN
	else
		self.state = BNBase.Base.SUC
	end
end

local AIGoFirstRechargeTree = class("AIGoFirstRechargeTree", AIModuleBase)

function AIGoFirstRechargeTree:visitBN()
	local var_6_0 = g.core.module.ModuleManager:getCurModule()

	if var_6_0.module == var_0_3.NEW_FIRST_RECHARGE or var_6_0.module == var_0_3.FIRST_RECHARGE then
		self.state = BNBase.Base.SUC
	elseif var_6_0.module == var_0_3.HOME then
		if var_6_0.display.m_activityComp and var_6_0.display.m_activityComp then
			if var_0_0.firstRechargeData:isNewFirstRecharge() then
				if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_FIRST_RECHARGE) then
					g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_FIRST_RECHARGE)
				end
			elseif g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FIRST_CHARGE) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.FIRST_RECHARGE)
			end

			self.state = BNBase.Base.RUN
		else
			self.state = BNBase.Base.FAIL
		end
	else
		self.state = BNBase.Base.FAIL
	end
end

local AIGoCampaignTree = class("AIGoCampaignTree", AIModuleBase)

function AIGoCampaignTree:visitBN()
	local var_7_0 = g.core.module.ModuleManager:getCurModule()

	if var_7_0.module == var_0_3.CAMPAIGN then
		self.state = BNBase.Base.SUC
	elseif var_7_0.module == var_0_3.HOME then
		if var_7_0.display.m_entranceComp and var_7_0.display.m_entranceComp.m_campaignBtn then
			var_7_0.display.m_entranceComp.m_campaignBtn:dispatchEvent(fgui.UIEventType.Click)

			self.state = BNBase.Base.RUN
		else
			self.state = BNBase.Base.FAIL
		end
	else
		self.state = BNBase.Base.FAIL
	end
end

local AIGoWushTowerChooseTree = class("AIGoWushTowerChooseTree", AIModuleBase)

function AIGoWushTowerChooseTree:visitBN()
	local var_8_0 = g.core.module.ModuleManager:getCurModule()

	if var_8_0.module == var_0_3.WUSH_TOWER_CHOOSE then
		self.state = BNBase.Base.SUC
	elseif var_8_0.module == var_0_3.CAMPAIGN then
		if var_8_0.display.m_scrollList then
			local var_8_1 = 0

			for iter_8_0, iter_8_1 in pairs(g.core.model.User.CampaignData:getShowEntranceStructArr()) do
				if iter_8_1.info.id == var_0_1.WUSH_TRIAL then
					var_8_1 = iter_8_0
				end
			end

			var_8_0.display.m_scrollList:scrollToView(var_8_1 - 1)

			local var_8_2 = var_8_0.display.m_scrollList:itemIndexToChildIndex(var_8_1 - 1)

			if var_8_2 >= 0 and var_8_2 < var_8_0.display.m_scrollList:numChildren() then
				var_8_0.display.m_scrollList:getChildAt(var_8_2):dispatchEvent(fgui.UIEventType.Click)
			end

			self.state = BNBase.Base.RUN
		else
			self.state = BNBase.Base.FAIL
		end
	else
		self.state = BNBase.Base.FAIL
	end
end

local AIGoWushTower = class("AIGoWushTower", AIModuleBase)

function AIGoWushTower:visitBN()
	local var_9_0 = g.core.module.ModuleManager:getCurModule()

	if var_9_0.module == var_0_3.WUSH_TOWER then
		self.state = BNBase.Base.SUC
	elseif var_9_0.module == var_0_3.WUSH_TOWER_CHOOSE then
		if var_9_0.display.m_hardWushComp then
			var_9_0.display.m_hardWushComp:dispatchEvent(fgui.UIEventType.Click)

			self.state = BNBase.Base.SUC
		else
			self.state = BNBase.Base.FAIL
		end
	else
		self.state = BNBase.Base.FAIL
	end
end

return {
	AIGoHomeTree = AIGoHomeTree,
	AILoginTree = AILoginTree,
	AIBattleTree = AIBattleTree,
	AIDebugReturnTree = AIDebugReturnTree,
	AIGoFirstRechargeTree = AIGoFirstRechargeTree,
	AIGoCampaignTree = AIGoCampaignTree,
	AIGoWushTowerChooseTree = AIGoWushTowerChooseTree,
	AIGoWushTower = AIGoWushTower,
	CheckModule = function(self)
		if self.modType == var_0_3.FULL_SCREEN then
			g.core.module.ModuleManager:popAllPopup()
		end

		return g.core.module.ModuleManager:getCurModule().module == self
	end
}
