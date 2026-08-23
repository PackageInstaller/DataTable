local TreeTalentCondition = require("app.view.module.tree.model.TreeTalentCondition")
local var_0_1 = g.core.config.talent_skill_info
local var_0_2 = g.core.config.tree_bonus_info
local var_0_3 = g.core.config.tree_node_info
local var_0_4 = g.core.const.ConstMgr.TreeConst
local TreeNodeStruct = class("TreeNodeStruct")

function TreeNodeStruct:ctor(arg_1_1)
	self._advanceId = arg_1_1
	self._cfgStageList = {}
	self._parentDict = {}
	self._childDict = {}
	self._levelStageDict = {}
	self._qualityStageList = {}
	self._curLevel = 0
	self._curStage = 0
end

function TreeNodeStruct:addChild(arg_2_1)
	self._childDict[arg_2_1:getAdvanceId()] = arg_2_1
end

function TreeNodeStruct:addParent(arg_3_1)
	self._parentDict[arg_3_1:getAdvanceId()] = arg_3_1
end

function TreeNodeStruct:addInfo(arg_4_1)
	self._cfgStageList[arg_4_1.node_stage] = arg_4_1
end

function TreeNodeStruct:getAdvanceId()
	return self._advanceId
end

function TreeNodeStruct:setLevelGroup(arg_6_1, arg_6_2)
	self._levelStageDict[arg_6_1] = arg_6_2
end

function TreeNodeStruct:getLevelGroup(arg_7_1)
	return self._levelStageDict[arg_7_1]
end

function TreeNodeStruct:setNodeServerData(arg_8_1)
	self:setLevel(arg_8_1.level or 0)
	self:setStage(arg_8_1.node_stage or 0)
end

function TreeNodeStruct:setLevel(arg_9_1)
	self._curLevel = arg_9_1
end

function TreeNodeStruct:getLevel()
	return self._curLevel
end

function TreeNodeStruct:isMaxLevel()
	return self._curLevel >= self:getMaxLevel()
end

function TreeNodeStruct:getMaxLevel()
	return math.min(self:getInfo().level_max, #(self._levelStageDict[self._curStage] or {}))
end

function TreeNodeStruct:isMaxStage()
	return self._curStage >= self:getInfo().stage_max
end

function TreeNodeStruct:getLevelInfo()
	if not self._levelStageDict[self._curStage] then
		return {}
	end

	return self._levelStageDict[self._curStage][self._curLevel]
end

function TreeNodeStruct:setStage(arg_15_1)
	self._curStage = arg_15_1
end

function TreeNodeStruct:getStage()
	return self._curStage
end

function TreeNodeStruct:getBeforeStageInfo()
	return self:getInfo(self._curStage - 1)
end

function TreeNodeStruct:getNextStageInfo()
	return self:getInfo(self._curStage + 1)
end

function TreeNodeStruct:getInfo(arg_19_1)
	arg_19_1 = arg_19_1 or self._curStage

	return self._cfgStageList[arg_19_1]
end

function TreeNodeStruct:getQuality()
	return self:getInfo().node_quality
end

function TreeNodeStruct:getStageDict()
	return self._cfgStageList
end

function TreeNodeStruct:getQualityStageList(arg_22_1)
	local var_22_0 = arg_22_1 or self:getQuality()

	if not self._qualityStageList[var_22_0] then
		local var_22_1 = {}

		for iter_22_0, iter_22_1 in pairs(self._cfgStageList) do
			if iter_22_1.node_quality == var_22_0 then
				table.insert(var_22_1, iter_22_1)
			end
		end

		table.sort(var_22_1, function(arg_23_0, arg_23_1)
			return arg_23_0.node_stage < arg_23_1.node_stage
		end)

		self._qualityStageList[var_22_0] = var_22_1
	end

	return self._qualityStageList[var_22_0]
end

function TreeNodeStruct:isCanUpgradeLevel()
	if self:getNodeType() ~= var_0_4.NODE_TYPE.SMALL then
		return false
	end

	if not self:isLight() then
		return false
	end

	if self:isMaxLevel() then
		return false
	end

	local var_24_0 = self:getLevelUpMaterial()

	if var_24_0.type and var_24_0.type > 0 then
		return g.core.model.User.bagData:getOwnNum(var_24_0.type, var_24_0.value) >= var_24_0.size
	else
		return true
	end
end

function TreeNodeStruct:isCanUpgradeStage()
	if self:getNodeType() == var_0_4.NODE_TYPE.SMALL and self:isLight() and not self:isMaxLevel() then
		return false
	end

	if self:isLight() and self:isMaxStage() then
		return false
	end

	if self._cfgStageList[self._curStage + 1] and self._cfgStageList[self._curStage + 1].node_quality > self:getInfo().node_quality then
		for iter_25_0, iter_25_1 in pairs(self._parentDict) do
			if iter_25_1:getQuality() < self._cfgStageList[self._curStage + 1].node_quality then
				return false
			end
		end
	end

	local var_25_0 = self:getStageUpMaterial()

	if var_25_0.type > 0 then
		return g.core.model.User.bagData:getOwnNum(var_25_0.type, var_25_0.value) >= var_25_0.size
	else
		return true
	end
end

function TreeNodeStruct:getParentDict()
	return self._parentDict
end

function TreeNodeStruct:getChildDict()
	return self._childDict
end

function TreeNodeStruct:getLevelUpMaterial()
	local var_28_0 = self:getLevelInfo()

	return {
		type = var_28_0.upgrade_type,
		value = var_28_0.upgrade_value,
		size = var_28_0.upgrade_size
	}
end

function TreeNodeStruct:getLevelUpToMaterial(arg_29_1)
	local var_29_0 = self:getLevelUpMaterial()
	local var_29_1 = self:getLevelGroup(self._curStage)

	for iter_29_0 = self._curLevel + 1, arg_29_1 do
		if not var_29_1[iter_29_0] then
			return nil
		end

		if var_29_1[iter_29_0].upgrade_type > 0 then
			var_29_0.size = var_29_0.size + var_29_1[iter_29_0].upgrade_size
		end
	end

	return var_29_0
end

function TreeNodeStruct:getCurCanLevelUpMaxLevel()
	local var_30_0 = self:getLevelUpMaterial()
	local var_30_1 = g.core.model.User.bagData:getOwnNum(var_30_0.type, var_30_0.value)
	local var_30_2 = 0
	local var_30_3 = self:getLevelGroup(self._curStage)
	local var_30_4 = 0

	for iter_30_0 = self._curLevel, self:getMaxLevel() - 1 do
		if not var_30_3[iter_30_0] then
			break
		end

		if var_30_3[iter_30_0].upgrade_type > 0 then
			var_30_2 = var_30_2 + var_30_3[iter_30_0].upgrade_size
		end

		if var_30_2 <= var_30_1 then
			var_30_4 = var_30_4 + 1
		else
			break
		end
	end

	return var_30_4
end

function TreeNodeStruct:getStageUpMaterial()
	local var_31_0 = self:getInfo()

	return {
		type = var_31_0.advance_cost_type,
		value = var_31_0.advance_cost_value,
		size = var_31_0.advance_cost_size
	}
end

function TreeNodeStruct:getNodeType()
	return self:getInfo().node_type
end

function TreeNodeStruct:isLight()
	return self._curStage > 0
end

function TreeNodeStruct:getLevelAttrDict(arg_34_1)
	arg_34_1 = arg_34_1 or self._curLevel

	local var_34_0 = {}
	local var_34_1 = self:getInfo()

	if var_34_1.cultivate_affect_type > 0 then
		var_34_0[var_34_1.cultivate_affect_type] = var_34_0[var_34_1.cultivate_affect_type] or 0
		var_34_0[var_34_1.cultivate_affect_type] = var_34_0[var_34_1.cultivate_affect_type] + var_34_1.cultivate_affect_initial_value + var_34_1.cultivate_affect_develop_value * (arg_34_1 - 1)
	end

	return var_34_0
end

function TreeNodeStruct:getIcon()
	return g.core.common.Path:getTreeIcon(self:getNodeType(), self:getInfo().node_icon)
end

function TreeNodeStruct:getBonusInfo(arg_36_1)
	if self:getNodeType() == var_0_4.NODE_TYPE.CENTER then
		return var_0_2.fetch(self:getInfo(arg_36_1).cultivate_skill)
	else
		return nil
	end
end

function TreeNodeStruct:getStageBaseAttrDict(arg_37_1)
	arg_37_1 = arg_37_1 or self._curStage

	local var_37_0 = {}
	local var_37_1 = {}

	if self:getNodeType() == var_0_4.NODE_TYPE.BIG then
		local var_37_2 = self:getInfo(arg_37_1)

		if var_37_2 then
			self:getBaseAttrDictByInfo(var_37_2, var_37_0)
		end
	elseif self:getNodeType() == var_0_4.NODE_TYPE.CENTER then
		local var_37_3 = self:getBonusInfo(arg_37_1)

		if var_37_3 then
			self:getBaseAttrDictByInfo(var_37_3, var_37_0)
		end
	end

	return var_37_0, var_37_1
end

function TreeNodeStruct:getBaseAttrDictByInfo(arg_38_1, arg_38_2)
	if self:getNodeType() == var_0_4.NODE_TYPE.BIG then
		local var_38_0 = 1

		while var_0_3.hasKey("basic_talent_" .. var_38_0) do
			if arg_38_1["basic_talent_" .. var_38_0] > 0 then
				self:_getTalentAttr(arg_38_1["basic_talent_" .. var_38_0], arg_38_2)
			end

			var_38_0 = var_38_0 + 1
		end
	elseif self:getNodeType() == var_0_4.NODE_TYPE.CENTER then
		local var_38_1 = 1

		while var_0_2.hasKey("basic_skill_type_" .. var_38_1) do
			if arg_38_1["basic_skill_type_" .. var_38_1] > 0 then
				arg_38_2[arg_38_1["basic_skill_type_" .. var_38_1]] = arg_38_2[arg_38_1["basic_skill_type_" .. var_38_1]] or 0
				arg_38_2[arg_38_1["basic_skill_type_" .. var_38_1]] = arg_38_2[arg_38_1["basic_skill_type_" .. var_38_1]] + arg_38_1["basic_skill_value_" .. var_38_1]
			end

			var_38_1 = var_38_1 + 1
		end
	end
end

function TreeNodeStruct:getStageExtraAttrDict(arg_39_1)
	arg_39_1 = arg_39_1 or self._curStage

	local var_39_0 = {}
	local var_39_1 = {}

	if self:getNodeType() == var_0_4.NODE_TYPE.BIG then
		local var_39_2 = self:getInfo(arg_39_1)

		if var_39_2 and TreeTalentCondition.isFinishCondition(var_39_2.cultivate_talent_type, var_39_2.cultivate_talent_key, var_39_2.cultivate_talent_value) then
			self:getExtraAttrDictByInfo(var_39_2, var_39_0, var_39_1, 0)
		end
	elseif self:getNodeType() == var_0_4.NODE_TYPE.CENTER then
		local var_39_3 = self:getBonusInfo(arg_39_1)

		if var_39_3 then
			local var_39_4 = math.min(math.floor(TreeTalentCondition.getValue(var_39_3.extra_type, var_39_3.extra_key) / var_39_3.extra_value), var_39_3.extra_num_max)

			if var_39_4 > 0 then
				self:getExtraAttrDictByInfo(var_39_3, var_39_0, var_39_1, var_39_4)
			end
		end
	end

	return var_39_0, var_39_1
end

function TreeNodeStruct:getExtraAttrDictByInfo(arg_40_1, arg_40_2, arg_40_3)
	if self:getNodeType() == var_0_4.NODE_TYPE.BIG then
		local var_40_0 = 1

		while var_0_3.hasKey("cultivate_talent_" .. var_40_0) do
			if arg_40_1["cultivate_talent_" .. var_40_0] > 0 then
				self:_getTalentAttr(arg_40_1["cultivate_talent_" .. var_40_0], arg_40_2)
			end

			var_40_0 = var_40_0 + 1
		end
	elseif self:getNodeType() == var_0_4.NODE_TYPE.CENTER then
		local var_40_1 = 1

		while var_0_2.hasKey("extra_skill_type_" .. var_40_1) do
			if arg_40_1["extra_skill_type_" .. var_40_1] > 0 then
				arg_40_2[arg_40_1["extra_skill_type_" .. var_40_1]] = arg_40_2[arg_40_1["extra_skill_type_" .. var_40_1]] or 0
				arg_40_2[arg_40_1["extra_skill_type_" .. var_40_1]] = arg_40_2[arg_40_1["extra_skill_type_" .. var_40_1]] + arg_40_1["extra_skill_value_" .. var_40_1] * arg_40_3
			end

			var_40_1 = var_40_1 + 1
		end
	end
end

function TreeNodeStruct:_getTalentAttr(arg_41_1, arg_41_2)
	arg_41_2 = arg_41_2 or {}

	local var_41_0 = var_0_1.fetch(arg_41_1)

	if not var_41_0 then
		return arg_41_2
	end

	local var_41_1 = 1

	while var_0_1.hasKey("affect_type_" .. var_41_1) do
		if var_41_0["affect_type_" .. var_41_1] > 0 then
			arg_41_2[var_41_0["affect_type_" .. var_41_1]] = arg_41_2[var_41_0["affect_type_" .. var_41_1]] and arg_41_2[var_41_0["affect_type_" .. var_41_1]] + var_41_0["affect_value_" .. var_41_1] or var_41_0["affect_value_" .. var_41_1]
		end

		var_41_1 = var_41_1 + 1
	end

	return arg_41_2
end

function TreeNodeStruct:isFinishCondition(arg_42_1)
	arg_42_1 = arg_42_1 or self:getInfo()

	if arg_42_1 then
		if arg_42_1.node_type == var_0_4.NODE_TYPE.BIG then
			return TreeTalentCondition.isFinishCondition(arg_42_1.cultivate_talent_type, arg_42_1.cultivate_talent_key, arg_42_1.cultivate_talent_value)
		else
			local var_42_0 = var_0_2.fetch(arg_42_1.cultivate_skill)

			return TreeTalentCondition.getValue(var_42_0.extra_type, var_42_0.extra_key) / var_42_0.extra_value >= 1
		end
	end

	return false
end

function TreeNodeStruct:getBigTalentAttrStr(arg_43_1, arg_43_2)
	arg_43_1 = arg_43_1 or self:getInfo()

	local var_43_0 = arg_43_2 and "cultivate_talent_" or "basic_talent_"
	local var_43_1 = ""

	while var_0_3.hasKey(var_43_0 .. 1) do
		if arg_43_1[var_43_0 .. 1] > 0 then
			var_43_1 = var_43_1 .. var_0_1.get(arg_43_1[var_43_0 .. 1]).description
		end
	end

	return var_43_1
end

return TreeNodeStruct
