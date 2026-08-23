local var_0_0 = g.core.const.ConstMgr.AchievementConst
local var_0_2 = "reward_type_"
local var_0_3 = "reward_value_"
local var_0_4 = "reward_size_"
local var_0_5 = g.core.config.achievement_reward_info
local var_0_6 = g.core.common.Goods
local var_0_7 = g.core.model.User.resourceData
local AchievementAwardDataStruct = class("AchievementAwardDataStruct")

function AchievementAwardDataStruct:ctor(arg_1_1)
	self._info = arg_1_1
	self._awardArr = {}
	self._finish = false

	self:_initAwardArr()
end

function AchievementAwardDataStruct:_initAwardArr()
	while var_0_5.hasKey(var_0_2 .. 1) do
		if self._info[var_0_2 .. 1] > 0 then
			table.insert(self._awardArr, {
				type = self._info[var_0_2 .. 1],
				value = self._info[var_0_3 .. 1],
				size = self._info[var_0_4 .. 1]
			})
		end
	end
end

function AchievementAwardDataStruct:getId()
	return self._info.id
end

function AchievementAwardDataStruct:getInfo()
	return self._info
end

function AchievementAwardDataStruct:getAwardArr()
	return self._awardArr
end

function AchievementAwardDataStruct:isFinish()
	return self._finish
end

function AchievementAwardDataStruct:setFinish(arg_7_1)
	self._finish = arg_7_1
end

function AchievementAwardDataStruct:getCurNum()
	return var_0_7:getResourceById(var_0_6.RESOURCE.TYPE_ACHIEVEMENT)
end

function AchievementAwardDataStruct:getState()
	if self._finish then
		return var_0_0.RECEIVE_STATE.HAS_RECEIVED
	elseif self:getCurNum() < self._info.num then
		return var_0_0.RECEIVE_STATE.NOT_ACHIEVE
	else
		return var_0_0.RECEIVE_STATE.CAN_RECEIVE
	end
end

return AchievementAwardDataStruct
