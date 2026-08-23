local var_0_0 = g.core.common.ServerTime
local BNBase = class("BNBase")

BNBase.READY = 1
BNBase.RUN = 2
BNBase.SUC = 3
BNBase.FAIL = 4

function BNBase:ctor(arg_1_1, arg_1_2)
	self.name = arg_1_1 or ""
	self._nextUpdateTime = 0
	self.parent = nil
	self.state = BNBase.READY
	self.children = arg_1_2 or {}

	for iter_1_0, iter_1_1 in ipairs(self.children) do
		arg_1_2.parent = self
	end
end

function BNBase:dumpName()
	if config.DEBUG_VERSION then
		dump(self.name, self.__cname)
	end
end

function BNBase:visitBnBase(arg_3_1)
	if arg_3_1 then
		self:dumpName()
	end

	self:visitBN(arg_3_1)
end

function BNBase:visitBN()
	self.state = BNBase.FAIL
end

function BNBase:saveStateBN()
	self.lastState = self.state

	for iter_5_0, iter_5_1 in ipairs(self.children) do
		iter_5_1:saveStateBN()
	end
end

function BNBase:stepBN()
	if self.state ~= BNBase.RUN then
		self:resetBN()
	else
		for iter_6_0, iter_6_1 in ipairs(self.children) do
			iter_6_1:stepBN()
		end
	end
end

function BNBase:stopBN()
	if self.onStop then
		self:onStop()
	end

	for iter_7_0, iter_7_1 in ipairs(self.children) do
		iter_7_1:stopBN()
	end
end

function BNBase:resetBN()
	if self.state ~= BNBase.READY then
		self.state = BNBase.READY

		for iter_8_0, iter_8_1 in ipairs(self.children) do
			iter_8_1:resetBN()
		end
	end
end

function BNBase:sleepBN(arg_9_1)
	self._nextUpdateTime = var_0_0:getTime() + arg_9_1
end

function BNBase:is_a(arg_10_1)
	return self.__cname == arg_10_1.__cname
end

local ConditionNode = class("ConditionNode", BNBase)

function ConditionNode:ctor(arg_11_1, arg_11_2)
	ConditionNode.super.ctor(self, arg_11_2)

	self.fn = arg_11_1
end

function ConditionNode:visitBN()
	self.state = self.fn and (self.fn() and BNBase.SUC or BNBase.FAIL) or BNBase.FAIL
end

local ActionNode = class("ActionNode", BNBase)

function ActionNode:ctor(arg_13_1, arg_13_2, arg_13_3)
	ActionNode.super.ctor(self, arg_13_2, arg_13_3)

	self.action = arg_13_1
end

function ActionNode:visitBN()
	self.action()

	self.state = BNBase.SUC
end

local WaitNode = class("WaitNode", BNBase)

function WaitNode:ctor(arg_15_1, arg_15_2, arg_15_3)
	WaitNode.super.ctor(self, arg_15_2, arg_15_3)

	self.waitTime = arg_15_1
end

function WaitNode:visitBN(arg_16_1)
	local var_16_0 = var_0_0:getTime()

	if self.state ~= BNBase.RUN then
		self.wakeTime = var_16_0 + self.waitTime
		self.state = BNBase.RUN
	end

	if self.state == BNBase.RUN then
		if var_16_0 >= self.wakeTime then
			self.state = BNBase.SUC
		else
			self:sleepBN(var_16_0 - self.wakeTime)
		end
	end
end

local SequenceNode = class("SequenceNode", BNBase)

function SequenceNode:ctor(arg_17_1, arg_17_2)
	SequenceNode.super.ctor(self, arg_17_1, arg_17_2)

	self.index = 1
end

function SequenceNode:resetBN()
	SequenceNode.super.resetBN(self)

	self.index = 1
end

function SequenceNode:visitBN(arg_19_1)
	if self.state ~= BNBase.RUN then
		self.index = 1
	end

	while self.index <= #self.children do
		self.children[self.index]:visitBnBase(arg_19_1)

		if self.children[self.index].state == BNBase.RUN or self.children[self.index].state == BNBase.FAIL then
			self.state = self.children[self.index].state

			return
		end

		self.index = self.index + 1
	end

	self.state = BNBase.SUC
end

local SelectNode = class("SelectNode", BNBase)

function SelectNode:ctor(arg_20_1, arg_20_2)
	SelectNode.super.ctor(self, arg_20_1, arg_20_2)

	self.index = 1
end

function SelectNode:resetBN()
	SelectNode.super.resetBN(self)

	self.index = 1
end

function SelectNode:visitBN(arg_22_1)
	if self.state ~= BNBase.RUN then
		self.index = 1
	end

	while self.index <= #self.children do
		self.children[self.index]:visitBnBase(arg_22_1)

		if self.children[self.index].state == BNBase.RUN or self.children[self.index].state == BNBase.SUC then
			self.state = self.children[self.index].state

			return
		end

		self.index = self.index + 1
	end

	self.state = BNBase.FAIL
end

local LoopNode = class("LoopNode", BNBase)

function LoopNode:ctor(arg_23_1, arg_23_2, arg_23_3)
	LoopNode.super.ctor(self, arg_23_1, arg_23_2)

	self.index = 1
	self._repeat = 0
	self._maxRepeatCount = arg_23_3 or 0
end

function LoopNode:resetBN()
	LoopNode.super.resetBN(self)

	self.index = 1
	self._repeat = 0
end

function LoopNode:visitBN(arg_25_1)
	if self.state ~= BNBase.RUN then
		self.index = 1
	end

	while self.index <= #self.children do
		self.children[self.index]:visitBnBase(arg_25_1)

		if self.children[self.index].state == BNBase.RUN or self.children[self.index].state == BNBase.FAIL then
			self.state = self.children[self.index].state

			return
		end

		self.index = self.index + 1
	end

	self.index = 1
	self._repeat = self._repeat + 1

	if self._maxRepeatCount > 0 and self._repeat >= self._maxRepeatCount then
		self.state = BNBase.SUC
	else
		for iter_25_0, iter_25_1 in ipairs(self.children) do
			iter_25_1:resetBN()
		end
	end
end

local ParallelNode = class("ParallelNode", BNBase)

function ParallelNode:ctor(arg_26_1, arg_26_2, arg_26_3)
	LoopNode.super.ctor(self, arg_26_1 or "ParallelNode", arg_26_2)
end

function ParallelNode:stepBN()
	if self.state ~= BNBase.RUN then
		self:resetBN()
	elseif self.children then
		for iter_27_0, iter_27_1 in ipairs(self.children) do
			if iter_27_1.state == BNBase.SUC and iter_27_1:is_a(ConditionNode) then
				iter_27_1:resetBN()
			end
		end
	end
end

function ParallelNode:visitBN(arg_28_1)
	local var_28_0 = true

	for iter_28_0, iter_28_1 in ipairs(self.children) do
		if iter_28_1:is_a(ConditionNode) then
			iter_28_1:resetBN()
		end

		if iter_28_1.state ~= BNBase.SUC then
			iter_28_1:visitBnBase(arg_28_1)

			if iter_28_1.state == BNBase.FAIL then
				self.state = BNBase.FAIL

				return
			end
		end

		if iter_28_1.state == BNBase.RUN then
			var_28_0 = false
		end
	end

	self.state = var_28_0 and BNBase.SUC or BNBase.RUN
end

local PriorityNode = class("PriorityNode", BNBase)

function PriorityNode:ctor(arg_29_1, arg_29_2, arg_29_3)
	LoopNode.super.ctor(self, arg_29_1 or "PriorityNode", arg_29_2)

	self.index = nil
	self.period = 1
end

function PriorityNode:resetBN()
	PriorityNode.super.resetBN(self)

	self.index = nil
end

function PriorityNode:visitBN(arg_31_1)
	local var_31_0 = false

	for iter_31_0, iter_31_1 in ipairs(self.children) do
		if not var_31_0 then
			if iter_31_1.state == BNBase.FAIL or iter_31_1.state == BNBase.SUC then
				iter_31_1:resetBN()
			end

			iter_31_1:visitBnBase(arg_31_1)

			if iter_31_1.state == BNBase.SUC or iter_31_1.state == BNBase.RUN then
				var_31_0 = true
				self.state = iter_31_1.state
				self.index = iter_31_0
			end
		else
			iter_31_1:resetBN()
		end
	end

	if not var_31_0 then
		self.state = BNBase.FAIL
	end
end

return {
	Base = BNBase,
	ConditionNode = ConditionNode,
	ActionNode = ActionNode,
	WaitNode = WaitNode,
	SequenceNode = SequenceNode,
	SelectNode = SelectNode,
	ParallelNode = ParallelNode,
	PriorityNode = PriorityNode,
	LoopNode = LoopNode,
	WhileNode = function(arg_32_0, arg_32_1)
		return ParallelNode.new("WhileNode", {
			ConditionNode.new(arg_32_0, "ConditionNode"),
			arg_32_1
		})
	end,
	RunViewFunction = function(arg_33_0, arg_33_1)
		local function var_33_0(arg_34_0, arg_34_1, arg_34_2)
			for iter_34_0 = 1, arg_34_0:numChildren() do
				local var_34_0 = arg_34_0:getChildAt(iter_34_0 - 1)

				if var_34_0:getName() == arg_34_1 and var_34_0[arg_34_2] then
					var_34_0[arg_34_2](var_34_0, ...)

					return true
				elseif var_33_0(var_34_0, arg_34_1, arg_34_2, ...) then
					return true
				end
			end

			return false
		end

		return var_33_0(g.core.layer.LayerManager:getRoot(), arg_33_0, arg_33_1, ...)
	end
}
