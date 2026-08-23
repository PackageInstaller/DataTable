local var_0_0 = g.core.config.achievement_info
local var_0_1 = g.core.const.ConstMgr.AchievementConst
local var_0_2 = g.core.const.ConstMgr.AchievementConst.RECEIVE_STATE
local var_0_3 = "reward_type_"
local var_0_4 = "reward_value_"
local var_0_5 = "reward_size_"
local var_0_6 = g.core.common.Goods
local AchievementItemDataStruct = class("AchievementItemDataStruct")

function AchievementItemDataStruct:ctor(arg_1_1)
	self._info = arg_1_1
	self._awardList = {}
	self._bestAwardGoodsMap = nil

	local var_1_0 = self:_getPreTaskInfo()

	if var_1_0 then
		self._preTaskNum = var_1_0.num or 0
	end

	self._state = var_0_2.NOT_ACHIEVE
	self._curNum = 0
	self._finish = false

	self:_initAwardList()
	self:_initBestAwardGoodsMap()
end

function AchievementItemDataStruct:_getPreTaskInfo()
	if self._info.id - 1 > 0 then
		local var_2_0 = var_0_0.fetch(self._info.id - 1)

		if var_2_0 and var_2_0.target == self._info.target then
			return var_2_0
		end
	end
end

function AchievementItemDataStruct:_initAwardList()
	while var_0_0.hasKey(var_0_3 .. 1) do
		if self._info[var_0_3 .. 1] > 0 then
			table.insert(self._awardList, {
				type = self._info[var_0_3 .. 1],
				value = self._info[var_0_4 .. 1],
				size = self._info[var_0_5 .. 1]
			})
		end
	end
end

function AchievementItemDataStruct:_initBestAwardGoodsMap()
	if #self._awardList < 1 then
		self._bestAwardGoodsMap = nil

		return
	elseif #self._awardList == 1 then
		self._bestAwardGoodsMap = var_0_6:convert(self._awardList[1])

		return
	end

	local var_4_0 = {}

	for iter_4_0 = 1, #self._awardList do
		table.insert(var_4_0, (var_0_6:convert(self._awardList[iter_4_0])))
	end

	table.sort(var_4_0, function(arg_5_0, arg_5_1)
		if arg_5_0.quality == arg_5_1.quality then
			if arg_5_0.size == arg_5_1.size then
				return arg_5_0.info.id > arg_5_1.info.id
			else
				return arg_5_0.size > arg_5_1.size
			end
		else
			return arg_5_0.quality > arg_5_1.quality
		end
	end)

	local var_4_1 = var_4_0[1]

	if var_4_0[1].type == var_0_6.TYPE_RESOURCE and var_4_1.value == var_0_6.RESOURCE.TYPE_ACHIEVEMENT then
		var_4_1 = var_4_0[2]
	end

	self._bestAwardGoodsMap = var_4_1
end

function AchievementItemDataStruct:getAwardList()
	return self._awardList
end

function AchievementItemDataStruct:getBestAwardGoodsMap()
	return self._bestAwardGoodsMap
end

function AchievementItemDataStruct:setCurNum(arg_8_1)
	if not arg_8_1 or arg_8_1 == self._curNum then
		return
	end

	self._curNum = arg_8_1

	self:_updateState()
end

function AchievementItemDataStruct:_isMetTarget()
	local var_9_0 = self._info.num

	if self._info.target == var_0_1.Target.ARENA then
		return self._curNum > 0 and var_9_0 >= self._curNum
	else
		return var_9_0 <= self._curNum
	end
end

function AchievementItemDataStruct:getCurNum()
	return self._curNum
end

function AchievementItemDataStruct:getInfo()
	return self._info
end

function AchievementItemDataStruct:setFinish(arg_12_1)
	self._finish = arg_12_1

	self:_updateState()
end

function AchievementItemDataStruct:isFinish()
	return self._finish
end

function AchievementItemDataStruct:_isLvEnough()
	return g.core.model.User:getLevel() >= self._info.unlock_level
end

function AchievementItemDataStruct:getState()
	return self._state
end

function AchievementItemDataStruct:_updateState()
	self._state = self._finish and var_0_2.HAS_RECEIVED or self:_isMetTarget() and self:_isLvEnough() and var_0_2.CAN_RECEIVE or var_0_2.NOT_ACHIEVE
end

function AchievementItemDataStruct:getProgressRelativePre()
	return self:_getProgress(self._preTaskNum, self._info.num)
end

function AchievementItemDataStruct:_getProgress(arg_18_1, arg_18_2)
	if arg_18_2 - arg_18_1 <= 0 then
		return 100
	else
		return math.max(0, self._curNum - arg_18_1) / (arg_18_2 - arg_18_1) * 100
	end
end

function AchievementItemDataStruct:isNewReachWithNum(arg_19_1)
	local var_19_0 = self._info.num

	if self._info.target == var_0_1.Target.ARENA then
		return arg_19_1 <= var_19_0 and (var_19_0 < self._curNum or self._curNum == 0)
	else
		return self._curNum < var_19_0 and var_19_0 <= arg_19_1
	end
end

function AchievementItemDataStruct:isHideAchievement()
	return self._info.achievement_type == var_0_1.Type.HIDE
end

function AchievementItemDataStruct:isPromptOnReach()
	return self._info.show == var_0_1.PromptOnReach.YES
end

return AchievementItemDataStruct
