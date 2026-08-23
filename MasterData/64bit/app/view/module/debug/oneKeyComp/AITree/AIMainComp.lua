local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.common.ModuleUnlock
local var_0_2 = g.core.model.User
local AIWushTowerTree = require("app.view.module.debug.oneKeyComp.AITree.BT.AIWushTowerTree")
local AIFirstRechargeTree = require("app.view.module.debug.oneKeyComp.AITree.BT.AIFirstRechargeTree")
local AIModuleTree = require("app.view.module.debug.oneKeyComp.AITree.BT.AIModuleTree")
local BNBase = require("app.view.module.debug.oneKeyComp.AITree.BNBase")
local BehaviourTree = require("app.view.module.debug.oneKeyComp.AITree.BehaviourTree")
local AIMainComp = class("AIMainComp", function()
	return fgui.GComponent:create()
end)

function AIMainComp:ctor()
	self.bt = BehaviourTree.new(self, (BNBase.LoopNode.new("rootLoop", {
		BNBase.SequenceNode.new("rootSequence", {
			BNBase.WhileNode(function()
				return g.core.module.ModuleManager:getCurModule() ~= nil
			end, BNBase.ActionNode.new(function()
				return
			end)),
			AIModuleTree.AIDebugReturnTree.new(),
			AIModuleTree.AILoginTree.new(),
			AIModuleTree.AIBattleTree.new(),
			BNBase.PriorityNode.new("RootPriorityNode", {
				BNBase.WhileNode(function()
					return var_0_2.firstRechargeData:hasGanGetAward()
				end, AIFirstRechargeTree),
				BNBase.WhileNode(function()
					return var_0_1:isModuleUnlock(var_0_0.FUNCTION_TYPE.WUSH_TOWER)
				end, AIWushTowerTree),
				AIModuleTree.AIGoHomeTree.new()
			})
		})
	})))

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_KEY_PAD, handler(self, self.stopAI), self)
end

function AIMainComp:stopAI()
	self:cancelAllSchedule()
	self.bt:resetBT()
end

function AIMainComp:startBt()
	self:newSchedule(handler(self, self.doBT), 1)
end

function AIMainComp:doBT()
	self.bt:updateBT()
end

return AIMainComp
