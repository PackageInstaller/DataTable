local var_0_0 = g.core.config.dead_tower_task_info
local var_0_1 = g.core.const.ConstMgr.TaskConst.TASK_STATE
local var_0_2 = "reward_type_"
local var_0_3 = "reward_value_"
local var_0_4 = "reward_size_"
local WushTowerTaskStruct = class("WushTowerTaskStruct")

function WushTowerTaskStruct:ctor(arg_1_1)
	self.taskCfg = arg_1_1
	self.value = 0
	self.state = var_0_1.UNFINISHED
	self._received = false
	self.awardArr = self:_getAwardArr()
end

function WushTowerTaskStruct:_getAwardArr()
	local var_2_0 = {}

	while var_0_0.hasKey(var_0_2 .. 1) do
		if self.taskCfg[var_0_2 .. 1] > 0 then
			table.insert(var_2_0, {
				type = self.taskCfg[var_0_2 .. 1],
				value = self.taskCfg[var_0_3 .. 1],
				size = self.taskCfg[var_0_4 .. 1]
			})
		end
	end

	return var_2_0
end

function WushTowerTaskStruct:setToReceived()
	self._received = true

	self:_updateState()
end

function WushTowerTaskStruct:setValue(arg_4_1)
	self.value = arg_4_1

	self:_updateState()
end

function WushTowerTaskStruct:_updateState()
	self.state = self._received and var_0_1.ACCEPTED or self.value >= self.taskCfg.task_value and var_0_1.CAN_ACCEPT or var_0_1.UNFINISHED
end

function WushTowerTaskStruct:isRcvEnable()
	return self.state == var_0_1.CAN_ACCEPT
end

return WushTowerTaskStruct
