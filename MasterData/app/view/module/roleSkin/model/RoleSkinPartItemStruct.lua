local RoleSkinPartItemStruct = class("RoleSkinPartItemStruct")
local var_0_1 = g.core.config.role_skin_info
local var_0_2 = g.core.config.role_skin_level_info
local var_0_3 = g.core.model.User.bagData

function RoleSkinPartItemStruct:ctor(arg_1_1)
	self._skinInfoId = arg_1_1.id
	self._levelGroup = arg_1_1.levelGroup
	self._level = 0
	self._levelId = self:_getLevelIdByGroupAndLevel(self._levelGroup, self._level)
	self._skinInfoIdMap = {}
	self._stage = 0
	self._isOwn = false
end

function RoleSkinPartItemStruct:_getLevelIdByGroupAndLevel(arg_2_1, arg_2_2)
	for iter_2_0, iter_2_1 in var_0_2.ipairs() do
		if iter_2_1.group == arg_2_1 and iter_2_1.level == arg_2_2 then
			return iter_2_1.id
		end
	end

	return 0
end

function RoleSkinPartItemStruct:updateStruct(arg_3_1)
	if arg_3_1.level then
		self._level = arg_3_1.level
		self._levelId = self:_getLevelIdByGroupAndLevel(self._levelGroup, self._level)
	end

	if arg_3_1.stage then
		self._stage = arg_3_1.stage
		self._skinInfoId = self._skinInfoIdMap[self._stage]
	end

	self._isOwn = arg_3_1.isOwn ~= false
end

function RoleSkinPartItemStruct:updateSkinInfoMap(arg_4_1)
	self._skinInfoIdMap[arg_4_1.stage] = arg_4_1.id
end

function RoleSkinPartItemStruct:getLevelUpCost(arg_5_1)
	local var_5_0 = {}
	local var_5_1 = var_0_2.fetch(var_0_2.get(self._levelId).next_id)

	while var_5_1 and arg_5_1 >= var_5_1.level do
		var_5_0[var_5_1.type .. "_" .. var_5_1.value] = var_5_0[var_5_1.type .. "_" .. var_5_1.value] or {
			size = 0,
			type = var_5_1.type,
			value = var_5_1.value
		}
		var_5_0[var_5_1.type .. "_" .. var_5_1.value].size = var_5_0[var_5_1.type .. "_" .. var_5_1.value].size + var_5_1.size
		var_5_1 = var_0_2.fetch(var_5_1.next_id)
	end

	return var_5_0
end

function RoleSkinPartItemStruct:getCanLevelUpLvAndCost(arg_6_1)
	local var_6_0 = {}
	local var_6_1 = 0
	local var_6_2 = var_0_2.fetch(var_0_2.get(self._levelId).next_id)

	while var_6_2 and arg_6_1 >= var_6_2.level do
		var_6_0[var_6_2.type .. "_" .. var_6_2.value] = var_6_0[var_6_2.type .. "_" .. var_6_2.value] or {
			size = 0,
			type = var_6_2.type,
			value = var_6_2.value
		}

		if var_0_3:getOwnNum(var_6_0[var_6_2.type .. "_" .. var_6_2.value].type, var_6_0[var_6_2.type .. "_" .. var_6_2.value].value) >= var_6_0[var_6_2.type .. "_" .. var_6_2.value].size + var_6_2.size then
			var_6_0[var_6_2.type .. "_" .. var_6_2.value].size = var_6_0[var_6_2.type .. "_" .. var_6_2.value].size + var_6_2.size
			var_6_1 = math.max(var_6_1, var_6_2.level)
		else
			break
		end

		var_6_2 = var_0_2.fetch(var_6_2.next_id)
	end

	if var_6_1 == 0 then
		var_6_1 = self:getLevel() + 1
		var_6_0 = self:getLevelUpCost(var_6_1)
	end

	return var_6_1, var_6_0
end

function RoleSkinPartItemStruct:canLevelUp()
	if not self:isOwn() or self:isMaxLevel() then
		return false
	end

	for iter_7_0, iter_7_1 in pairs((self:getLevelUpCost(self._level + 1))) do
		if g.core.model.User.bagData:getOwnNum(iter_7_1.type, iter_7_1.value) < iter_7_1.size then
			return false
		end
	end

	return true
end

function RoleSkinPartItemStruct:getStageUpCost()
	local var_8_0 = self:getRoleSkinInfo()

	if var_8_0 then
		return {
			type = var_8_0.stage_type,
			value = var_8_0.stage_value,
			size = var_8_0.stage_size
		}
	end
end

function RoleSkinPartItemStruct:canStageUp()
	if not self:isOwn() or self:isMaxStage() then
		return false
	end

	local var_9_0 = self:getStageUpCost()

	return g.core.model.User.bagData:getOwnNum(var_9_0.type, var_9_0.value) >= var_9_0.size
end

function RoleSkinPartItemStruct:getStageTalentByStage(arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self._skinInfoIdMap) do
		local var_10_1 = var_0_1.get(iter_10_1)

		if arg_10_1 >= var_10_1.stage and var_10_1.talent > 0 then
			table.insert(var_10_0, var_10_1.talent)
		end
	end

	return var_10_0
end

function RoleSkinPartItemStruct:getNextStageTalent()
	local var_11_0 = self:getStageTalentArr()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1.stage > self._stage then
			return iter_11_1
		end
	end

	return var_11_0[#var_11_0]
end

function RoleSkinPartItemStruct:getTalentByStage(arg_12_1)
	return var_0_1.get(self._skinInfoIdMap[arg_12_1]).talent
end

function RoleSkinPartItemStruct:getStageTalentArr()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(self._skinInfoIdMap) do
		local var_13_1 = self:_getStageTalentById(iter_13_1)

		if var_13_1 > 0 then
			table.insert(var_13_0, {
				talentId = var_13_1,
				stage = iter_13_0
			})
		end
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0.stage < arg_14_1.stage
	end)

	return var_13_0
end

function RoleSkinPartItemStruct:_getStageTalentById(arg_15_1)
	return var_0_1.get(arg_15_1).talent
end

function RoleSkinPartItemStruct:getCurStageAttr()
	return self:_getStageAttrById(self._skinInfoId)
end

function RoleSkinPartItemStruct:getNextStageAttr()
	return self:_getStageAttrById((self:getNextSkinInfoId()))
end

function RoleSkinPartItemStruct:_getStageAttrById(arg_18_1)
	if arg_18_1 == 0 then
		return {}
	end

	local var_18_0 = {}
	local var_18_1 = var_0_1.get(arg_18_1)

	while var_0_1.hasKey("affect_type_" .. 1) do
		if var_18_1["affect_type_" .. 1] > 0 then
			var_18_0[var_18_1["affect_type_" .. 1]] = {
				type = var_18_1["affect_type_" .. 1],
				value = var_18_1["affect_value_" .. 1]
			}
		end
	end

	return var_18_0
end

function RoleSkinPartItemStruct:getCurLevelAttrMap()
	return self:_getLevelAttrById(self._levelId)
end

function RoleSkinPartItemStruct:getNextLevelAttr()
	return self:_getLevelAttrById((self:getNextLevelInfoId()))
end

function RoleSkinPartItemStruct:_getLevelAttrById(arg_21_1)
	if arg_21_1 == 0 then
		return {}
	end

	local var_21_0 = {}
	local var_21_1 = var_0_2.get(arg_21_1)

	while var_0_2.hasKey("affect_type_" .. 1) do
		if var_21_1["affect_type_" .. 1] > 0 then
			var_21_0[var_21_1["affect_type_" .. 1]] = {
				type = var_21_1["affect_type_" .. 1],
				value = var_21_1["affect_value_" .. 1]
			}
		end
	end

	return var_21_0
end

function RoleSkinPartItemStruct:getNextActivateLevelTalent()
	local var_22_0 = g.core.model.User.roleSkinData:getLevelTalentByGroup(self._levelGroup)

	if self:isMaxLevel() then
		return var_22_0[#var_22_0]
	end

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if iter_22_1.talentId > 0 and self._level <= iter_22_1.level then
			return iter_22_1
		end
	end
end

function RoleSkinPartItemStruct:getSkinInfoId()
	return self._skinInfoId
end

function RoleSkinPartItemStruct:getNextSkinInfoId()
	local var_24_0 = self:getRoleSkinInfo()

	return (var_24_0 or nil) and (var_24_0.next_id or 0)
end

function RoleSkinPartItemStruct:getLevelInfoId()
	return self._levelId
end

function RoleSkinPartItemStruct:getNextLevelInfoId()
	return var_0_2.get(self._levelId).next_id
end

function RoleSkinPartItemStruct:getRoleSkinInfo()
	return var_0_1.fetch(self._skinInfoId)
end

function RoleSkinPartItemStruct:getPart()
	local var_28_0 = self:getRoleSkinInfo()

	return (var_28_0 or nil) and (var_28_0.part or 0)
end

function RoleSkinPartItemStruct:getQuality()
	local var_29_0 = self:getRoleSkinInfo()

	return (var_29_0 or nil) and (var_29_0.quality or 0)
end

function RoleSkinPartItemStruct:getAdvanceId()
	local var_30_0 = self:getRoleSkinInfo()

	return (var_30_0 or nil) and (var_30_0.advance_id or 0)
end

function RoleSkinPartItemStruct:getPart()
	local var_31_0 = self:getRoleSkinInfo()

	return (var_31_0 or nil) and (var_31_0.part or 0)
end

function RoleSkinPartItemStruct:getLevelGroup()
	return self._levelGroup
end

function RoleSkinPartItemStruct:getSpineId()
	local var_33_0 = self:getRoleSkinInfo()

	return (var_33_0 or nil) and (var_33_0.spine or "")
end

function RoleSkinPartItemStruct:getSkinName()
	local var_34_0 = self:getRoleSkinInfo()

	return (var_34_0 or nil) and (var_34_0.skin_name or "")
end

function RoleSkinPartItemStruct:getIcon()
	local var_35_0 = self:getRoleSkinInfo()

	return (var_35_0 or nil) and (var_35_0.icon or 0)
end

function RoleSkinPartItemStruct:getLevel()
	return self._level
end

function RoleSkinPartItemStruct:getStage()
	return self._stage
end

function RoleSkinPartItemStruct:isOwn()
	return self._isOwn
end

function RoleSkinPartItemStruct:isMaxStage()
	return self:getNextSkinInfoId() == 0
end

function RoleSkinPartItemStruct:isWear()
	return g.core.model.User.roleSkinData:getWearAdvanceIdByPart(self:getPart()) == self:getAdvanceId()
end

function RoleSkinPartItemStruct:isMaxLevel()
	return var_0_2.get(self._levelId).next_id == 0
end

function RoleSkinPartItemStruct:getName()
	return self:getRoleSkinInfo().name
end

function RoleSkinPartItemStruct:getDesc()
	return self:getRoleSkinInfo().des
end

function RoleSkinPartItemStruct:getSuffix()
	return self:getRoleSkinInfo().suffix
end

function RoleSkinPartItemStruct:isPut()
	local var_45_0 = self:getRoleSkinInfo()
	local var_45_1 = true

	if var_45_0 then
		var_45_1 = var_45_0.put
	end

	var_45_1 = var_45_1 and not g.core.model.User.homeData:checkItemIsInUnputList("role_skin_info", self._skinInfoId)

	return var_45_1
end

return RoleSkinPartItemStruct
