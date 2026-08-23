local var_0_0 = g.core.config.recycle_cultivate_group_info
local var_0_1 = g.core.config.recycle_cultivate_info
local var_0_2 = g.core.config.recycle_cultivate_node_info
local RecycleCultivateData = class("RecycleCultivateData")

function RecycleCultivateData:ctor()
	self:initData()
end

function RecycleCultivateData:initData()
	self._recycleGroup = nil
	self._recycleGroupCfg = nil
	self._curRecycleItems = {}
	self._openRecycleState = {}
	self._curIncreaseNodeId = 1
	self._talentSkillList = {}
	self._isNeedPopConfirm = true
end

function RecycleCultivateData:getRecycleInfo()
	self:initRecycleDetailCfg()

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self._recycleGroupCfg) do
		if self:isGroupUnlock(iter_3_1) then
			table.insert(var_3_0, iter_3_1)
		end
	end

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		return arg_4_0.order < arg_4_1.order
	end)

	return var_3_0
end

function RecycleCultivateData:getGroupBanInfo(arg_5_1)
	local var_5_0 = self._curRecycleItems[arg_5_1]
	local var_5_1

	if not self._curRecycleItems[arg_5_1] then
		var_5_0 = 0
		var_5_1 = {
			canExchangeNum = self._recycleGroupCfg[arg_5_1].ban_num - var_5_0
		}
	end

	var_5_1.groupCfg = self._recycleGroupCfg[arg_5_1]

	return var_5_1
end

function RecycleCultivateData:onS2CRedPoint(arg_6_1)
	self._curIncreaseNodeId = arg_6_1.cur_info_id or self._curIncreaseNodeId

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.open_states or {}) do
		self._openRecycleState[iter_6_1.id] = iter_6_1.num == 1
	end
end

function RecycleCultivateData:checkItemExchangeIsVaild(arg_7_1, arg_7_2)
	local var_7_0 = self._curRecycleItems[arg_7_1] or 0
	local var_7_1 = self._recycleGroupCfg[arg_7_1].ban_num - var_7_0

	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		var_7_0 = var_7_0 + arg_7_2.cfg.size * iter_7_1.num

		if var_7_0 > self._recycleGroupCfg[arg_7_1].ban_num then
			return false, var_7_1
		end
	end

	return true
end

function RecycleCultivateData:initRecycleDetailCfg()
	if not self._recycleGroup then
		self._recycleGroup = {}

		for iter_8_0, iter_8_1 in var_0_1.ipairs() do
			self._recycleGroup[iter_8_1.group] = self._recycleGroup[iter_8_1.group] or {}

			table.insert(self._recycleGroup[iter_8_1.group], iter_8_1)
		end
	end

	if not self._recycleGroupCfg then
		self._recycleGroupCfg = {}

		for iter_8_2, iter_8_3 in var_0_0.ipairs() do
			table.insert(self._recycleGroupCfg, iter_8_3)
		end
	end
end

function RecycleCultivateData:isGroupUnlock(arg_9_1)
	return self._openRecycleState[arg_9_1.group]
end

function RecycleCultivateData:getRecycleDetailGroupInfo(arg_10_1)
	self:initRecycleDetailCfg()

	return self._recycleGroup[arg_10_1]
end

function RecycleCultivateData:isCurTimeNeedPopConfirm()
	return self._isNeedPopConfirm
end

function RecycleCultivateData:setNeedPopConfirm(arg_12_1)
	self._isNeedPopConfirm = arg_12_1
end

function RecycleCultivateData:onS2CGetInfo(arg_13_1)
	if arg_13_1.data then
		self._curIncreaseNodeId = arg_13_1.data.info_id or self._curIncreaseNodeId
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_1.open_states) do
		self._openRecycleState[iter_13_1.id] = iter_13_1.num == 1
	end

	for iter_13_2, iter_13_3 in ipairs(arg_13_1.data.already_num or {}) do
		self._curRecycleItems[iter_13_3.id] = iter_13_3.num
	end
end

function RecycleCultivateData:onS2CRecycle(arg_14_1)
	local var_14_0 = self._curRecycleItems[arg_14_1.group] or 0

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.costs) do
		var_14_0 = var_14_0 + var_0_1.get(iter_14_1.id).size * iter_14_1.num
	end

	self._curRecycleItems[arg_14_1.group] = var_14_0
end

function RecycleCultivateData:onS2CRecycleNotify(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1.open_states) do
		self._openRecycleState[iter_15_1.id] = iter_15_1.num == 1
	end
end

function RecycleCultivateData:onS2CUpgrade(arg_16_1)
	if arg_16_1 then
		self._curIncreaseNodeId = arg_16_1.cur_info_id or self._curIncreaseNodeId
	end
end

function RecycleCultivateData:getCurIncreaseCfgInfo()
	return (var_0_2.get(self._curIncreaseNodeId))
end

function RecycleCultivateData:getCurIncreaseStageNodeId()
	local var_18_0 = self:getCurIncreaseCfgInfo()

	return var_18_0.stage * 100 + var_18_0.node
end

function RecycleCultivateData:isIncreaseMax()
	return self:getCurIncreaseCfgInfo().next_id == 0
end

function RecycleCultivateData:getNextIncreaseCfgInfo()
	local var_20_0 = self:getCurIncreaseCfgInfo().next_id

	if var_20_0 ~= 0 then
		return (var_0_2.fetch(var_20_0))
	end
end

function RecycleCultivateData:getTalentSkillList()
	if #self._talentSkillList > 0 then
		return self._talentSkillList
	end

	local var_21_0 = {}

	for iter_21_0, iter_21_1 in var_0_2.ipairs() do
		if iter_21_1.node_type == 2 and iter_21_1.talent > 0 then
			table.insert(var_21_0, {
				stageNodeId = iter_21_1.stage * 100 + iter_21_1.node,
				stage = iter_21_1.stage,
				skillId = iter_21_1.talent
			})
		end
	end

	table.sort(var_21_0, function(arg_22_0, arg_22_1)
		return arg_22_0.stageNodeId < arg_22_1.stageNodeId
	end)

	self._talentSkillList = var_21_0

	return self._talentSkillList
end

function RecycleCultivateData:getCurShowTalentSkill()
	local var_23_0 = self:getCurIncreaseStageNodeId()
	local var_23_1 = 0
	local var_23_2 = self:getTalentSkillList()

	for iter_23_0, iter_23_1 in ipairs(var_23_2) do
		if var_23_0 < iter_23_1.stageNodeId or iter_23_0 == #var_23_2 then
			var_23_1 = iter_23_1.skillId

			break
		end
	end

	return var_23_1
end

function RecycleCultivateData:isCanIncrease()
	if #self:getRecycleInfo() <= 0 then
		return false
	end

	if self:isIncreaseMax() then
		return false
	end

	local var_24_0 = self:getCurIncreaseCfgInfo()

	for iter_24_0 = 1, 2 do
		if var_24_0["size_" .. iter_24_0] > 0 and var_24_0["size_" .. iter_24_0] > g.core.model.User.bagData:getOwnNum(var_24_0["type_" .. iter_24_0], var_24_0["value_" .. iter_24_0]) then
			return false
		end
	end

	return true
end

return RecycleCultivateData
