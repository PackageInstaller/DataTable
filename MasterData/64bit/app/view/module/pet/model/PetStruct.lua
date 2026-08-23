local var_0_0 = g.core.config.pet_info
local var_0_1 = g.core.config.pet_advance_info
local var_0_2 = g.core.config.pet_level_info
local var_0_3 = g.core.config.item_info
local var_0_4 = g.core.const.ConstMgr.PetConst
local var_0_5 = g.core.model.User.knightsData
local PetStruct = class("PetStruct")

function PetStruct:ctor(arg_1_1)
	self._advanceId = arg_1_1
	self._cfg = {}
	self._svrData = {}

	self:_initServerData(arg_1_1)
end

function PetStruct:_initServerData(arg_2_1)
	self._svrData = {
		expire_time = 0,
		source = 0,
		node = 0,
		stage = 0,
		star = 0,
		position = 0,
		level = 1,
		base_id = 0,
		id = 0,
		exp = 0
	}
	self._cfg = var_0_0.get(arg_2_1)
end

function PetStruct:setServerData(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(self._svrData) do
		self._svrData[iter_3_0] = arg_3_1[iter_3_0] or 0
	end

	self._cfg = var_0_0.get(arg_3_1.base_id)
end

function PetStruct:resetServerId()
	if self._svrData then
		self._svrData.id = 0
	end
end

function PetStruct:resetServerData()
	self._svrData = {
		expire_time = 0,
		source = 0,
		node = 0,
		stage = 0,
		star = 0,
		position = 0,
		level = 1,
		id = 0,
		exp = 0,
		base_id = self._cfg.id
	}
end

function PetStruct:getServerData()
	return self._svrData
end

function PetStruct:clearServerData()
	self:_initServerData(self._advanceId)
end

function PetStruct:getSource()
	if self._svrData then
		return self._svrData.source
	end
end

function PetStruct:getExpireTime()
	if self._svrData then
		return self._svrData.expire_time
	end

	return 0
end

function PetStruct:getAdvanceId()
	return self._advanceId
end

function PetStruct:getLevel()
	return self._svrData.level
end

function PetStruct:isCurMaxLevel()
	return self:getLevel() >= self:getCurMaxLevel()
end

function PetStruct:isMaxLevel()
	return self:getLevel() >= self:getMaxLevel()
end

function PetStruct:getCurMaxLevel()
	local var_14_1 = var_0_2.get((var_0_2.getLength()))

	return (math.min((var_14_1 or nil) and var_14_1.id, (g.core.model.User:getLevel())))
end

function PetStruct:getMaxLevel()
	local var_15_1 = var_0_2.get((var_0_2.getLength()))

	return (math.min((var_15_1 or nil) and var_15_1.id, (g.core.model.User:getMaxLevel())))
end

function PetStruct:getCfg()
	return self._cfg
end

function PetStruct:getAdvCfg()
	local var_17_0, var_17_1 = self:getBigSmallStage()

	return g.core.model.User.petsData:getAdvCfg(self._advanceId, var_17_0, var_17_1)
end

function PetStruct:getNextStageAdvCfg()
	local var_18_0 = self:getAdvCfg()

	if self:isFullStage() then
		return var_18_0
	else
		return var_0_1.get(var_18_0.id_num)
	end
end

function PetStruct:isSkillChangeFromLastStage()
	local var_19_0 = self:getAdvCfg()
	local var_19_1 = var_0_1.match(function(arg_20_0)
		return arg_20_0.id_num == var_19_0.id
	end)

	if #var_19_1 > 0 then
		return var_19_1[1].skill_1 ~= var_19_0.skill_1
	else
		return true
	end
end

function PetStruct:getSid()
	return self._svrData.id
end

function PetStruct:isLineup()
	if self:isOwn() then
		return self._svrData.position > 0
	end

	return false
end

function PetStruct:getLineupPos()
	return self._svrData.position
end

function PetStruct:getStarNum()
	return self._svrData.star
end

function PetStruct:getStar()
	return self:getStarNum()
end

function PetStruct:getBigSmallStage()
	return self._svrData.stage, self._svrData.node
end

function PetStruct:isOwn()
	return self._svrData.id > 0
end

function PetStruct:getFragmentId()
	return self._cfg.fragment_id
end

function PetStruct:isComposeEnable()
	if self:isOwn() then
		return false, 0, 0
	end

	local var_29_0 = self._cfg.fragment_id

	if self._cfg.fragment_id == 0 then
		return false, 0, 0
	else
		local var_29_1 = g.core.model.User.fragmentsData:getFragmentNumById(var_29_0)
		local var_29_2 = g.core.config.fragment_info.get(var_29_0).combine_num

		return var_29_2 <= var_29_1, var_29_1, var_29_2
	end
end

function PetStruct:setLineupPos(arg_30_1)
	self._svrData.position = arg_30_1 or 0
end

function PetStruct:clearLineupPos()
	self:setLineupPos(0)
end

function PetStruct:canStarUp()
	if not self:isOwn() then
		return false
	elseif self:isMaxStar() then
		return false
	else
		local var_32_0 = g.core.model.User.fragmentsData:getFragmentNumById(self._cfg.fragment_id)

		return self._cfg.pet_num <= var_32_0, var_32_0, self._cfg.pet_num
	end
end

function PetStruct:isMaxStar()
	return self._cfg.next_star == 0
end

function PetStruct:isFullStage()
	return self:getAdvCfg().id_num == 0
end

function PetStruct:isPut()
	return self._cfg.put == 1
end

function PetStruct:getQuality()
	return self._cfg.quality or 1
end

function PetStruct:getName()
	return self._cfg.name or ""
end

function PetStruct:getMaxStarLevel()
	return 7
end

function PetStruct:getLvAttrArr(arg_39_1)
	local var_39_0 = {}

	for iter_39_0 = 1, var_0_4.LV_ATTR_NUM do
		if self._cfg["affect_type_" .. iter_39_0] > 0 then
			table.insert(var_39_0, {
				isAll = true,
				type = self._cfg["affect_type_" .. iter_39_0],
				value = self._cfg["affect_value_" .. iter_39_0] + self._cfg["develop_" .. iter_39_0] * (arg_39_1 - 1)
			})
		end
	end

	return var_39_0
end

function PetStruct:getCurLvAttrArr()
	return self:getLvAttrArr(self:getLevel())
end

function PetStruct:getNextLvAttrList()
	local var_41_0 = true
	local var_41_1 = {}
	local var_41_2 = self:getLevel()

	if var_41_2 < self:getMaxLevel() then
		var_41_0 = false
		var_41_1 = self:getLvAttrArr(var_41_2 + 1)
	end

	return var_41_0, var_41_1
end

function PetStruct:getStarAttrArr(arg_42_1)
	local var_42_0 = {}

	if not arg_42_1 then
		return var_42_0
	end

	local var_42_1 = var_0_0.get(arg_42_1)

	for iter_42_0 = 1, var_0_4.LV_ATTR_NUM do
		if var_42_1["affect_type_" .. iter_42_0] > 0 then
			table.insert(var_42_0, {
				type = var_42_1["affect_type_" .. iter_42_0],
				baseValue = var_42_1["affect_value_" .. iter_42_0],
				devValue = var_42_1["develop_" .. iter_42_0]
			})
		end
	end

	return var_42_0
end

function PetStruct:getCurStarAttrArr()
	return self:getStarAttrArr(self._cfg.id)
end

function PetStruct:getNextStarAttrArr()
	local var_44_0 = true
	local var_44_1 = {}

	if not self:isMaxStar() then
		var_44_0 = false
		var_44_1 = self:getStarAttrArr(self._cfg.next_id)
	end

	return var_44_0, var_44_1
end

function PetStruct:getNextStarCfg()
	if self:isMaxStar() then
		return self._cfg
	else
		return var_0_0.get(self._cfg.next_id)
	end
end

function PetStruct:getPassiveArr()
	local var_46_0 = {}
	local var_46_1 = 0
	local var_46_2 = false
	local var_46_3 = self:getAdvanceId()
	local var_46_4, var_46_5 = self:getBigSmallStage()

	while var_46_3 > 0 do
		local var_46_6 = var_0_1.get(var_46_3)

		if var_46_6.skill_1 > 0 and var_46_6.node == 0 then
			if var_46_1 == 0 or var_46_6.stage <= var_46_4 then
				var_46_1 = var_46_6.skill_1
				var_46_2 = var_46_6.stage <= var_46_4
			end

			table.insert(var_46_0, {
				talentLevel = var_46_6.stage,
				skillId = var_46_6.skill_1,
				value = var_46_4 or 0
			})
		end

		var_46_3 = var_46_6.id_num
	end

	return {
		id = var_46_1,
		isActive = var_46_2
	}, var_46_0
end

function PetStruct:getActiveSkillArr()
	local var_47_0 = {}
	local var_47_1 = 0
	local var_47_2 = false
	local var_47_3 = self:getAdvanceId()
	local var_47_4 = self:getStarNum()

	for iter_47_0 = 1, var_0_4.STAR_MAX + 1 do
		local var_47_5 = var_0_0.get(var_47_3)

		if var_47_5.passive_skill_1 > 0 then
			if var_47_1 == 0 or var_47_5.star <= var_47_4 then
				var_47_1 = var_47_5.passive_skill_1
				var_47_2 = var_47_5.star <= var_47_4
			end

			table.insert(var_47_0, {
				talentLevel = var_47_5.star,
				skillId = var_47_5.passive_skill_1,
				value = var_47_4 or 0
			})
		end

		var_47_3 = var_47_5.next_id
	end

	return {
		id = var_47_1,
		isActive = var_47_2
	}, var_47_0
end

function PetStruct:getAdvanceTalentData()
	local var_48_0 = {}
	local var_48_1 = self:getCfg().advance_id
	local var_48_2, var_48_3 = self:getBigSmallStage()

	while var_48_1 > 0 do
		local var_48_4 = var_0_1.get(var_48_1)
		local var_48_5

		if var_48_4.skill_1 > 0 and var_48_4.node == 0 then
			if 0 ~= var_48_4.skill_1 then
				var_48_5 = var_48_4.skill_1

				table.insert(var_48_0, {
					skillId = var_48_4.skill_1,
					value = var_48_2 or 0,
					openValue = var_48_4.stage
				})
			end
		end

		var_48_1 = var_48_4.id_num
	end

	return #var_48_0, var_48_0
end

function PetStruct:getExp()
	return self._svrData.exp
end

function PetStruct:getCurLvMaxExp()
	return var_0_2.get((self:getLevel())).next_exp
end

function PetStruct:getSmallStageMaxValue()
	local var_51_0 = self:getBigSmallStage()
	local var_51_1 = 0

	for iter_51_0, iter_51_1 in var_0_1.ipairs() do
		if var_51_0 == iter_51_1.stage and var_51_1 < iter_51_1.node then
			var_51_1 = iter_51_1.node
		end
	end

	return var_51_1
end

function PetStruct:isLinkSkillActive()
	if self._cfg.link_advance_id > 0 then
		local var_52_0 = var_0_5:getKnightByAdvanceId(self._cfg.link_advance_id)

		return var_52_0 and var_52_0:isOwn()
	end

	return false
end

function PetStruct:isLevelUpEnable()
	if not self:isOwn() then
		return false
	elseif self:isCurMaxLevel() then
		return false
	end

	local var_53_0 = var_0_2.get(self:getLevel()).next_exp - self:getExp()
	local var_53_1 = 0

	for iter_53_0, iter_53_1 in ipairs((g.core.model.User.itemsData:getPetExpItemData())) do
		var_53_1 = var_53_1 + var_0_3.get(iter_53_1.id).item_value * iter_53_1.num

		if var_53_0 <= var_53_1 then
			return true
		end
	end

	return false
end

function PetStruct:isAdvanceEnable()
	if not self:isOwn() then
		return false
	elseif self:isFullStage() then
		return false
	else
		for iter_54_0, iter_54_1 in ipairs((self:getMaterialArrNeededForAdv())) do
			if iter_54_1.numCost > iter_54_1.size then
				return false
			end
		end

		return true
	end
end

function PetStruct:getIsNewPet()
	if self._isNew == nil then
		self._isNew = not (g.core.common.Storage:load("pet_is_card_click.json", g.core.model.User:getId()) or {})[tostring(self._advanceId)]
	end

	return self._isNew and self:isOwn()
end

function PetStruct:setIsNewPet()
	if self._isNew then
		local var_56_0 = g.core.common.Storage:load("pet_is_card_click.json", g.core.model.User:getId()) or {}

		var_56_0[tostring(self._advanceId)] = true

		g.core.common.Storage:save("pet_is_card_click.json", var_56_0, g.core.model.User:getId())
	end

	self._isNew = false
end

function PetStruct:getMaterialArrNeededForAdv()
	local var_57_0 = {}

	if self:isFullStage() then
		return var_57_0
	end

	local var_57_2 = self:getAdvCfg()
	local var_57_3 = 1

	while var_0_1.hasKey("cost_type_" .. 1) do
		if var_57_2["cost_type_" .. 1] > 0 then
			table.insert(var_57_0, {
				type = var_57_2["cost_type_" .. 1],
				value = var_57_2["cost_value_" .. var_57_3],
				size = g.core.model.User.bagData:getCountById(var_57_2["cost_type_" .. 1], var_57_2["cost_value_" .. var_57_3]),
				numCost = var_57_2["cost_num_" .. var_57_3]
			})
		end

		var_57_3 = var_57_3 + 1
	end

	return var_57_0
end

function PetStruct:getPassiveSkillId()
	local var_58_0 = self:getAdvCfg()

	if var_58_0.skill_1 > 0 then
		return var_58_0.skill_1
	else
		local var_58_1, var_58_2 = self:getBigSmallStage()

		if self:isFullStage() then
			return var_58_0.skill_1
		else
			return g.core.model.User.petsData:getAdvCfg(self._advanceId, math.min(var_58_1 + 1, 10), 0).skill_1
		end
	end
end

function PetStruct:getNextBigStageAdvCfg()
	if self:isFullStage() then
		return (self:getAdvCfg())
	else
		local var_59_0, var_59_1 = self:getBigSmallStage()

		return (g.core.model.User.petsData:getAdvCfg(self._advanceId, math.min(var_59_0 + 1, 10), 0))
	end
end

function PetStruct:getLinkKnightData()
	local var_60_0 = {}
	local var_60_1 = 0
	local var_60_2 = self:getLinkKnightAdvId()
	local var_60_3 = self:getCfg()

	if var_60_2 > 0 then
		table.insert(var_60_0, {
			assId = var_60_2,
			isActivated = var_0_5:getKnightByAdvanceId(var_60_2):isOwn(),
			linkSkillId = var_60_3.link_passive_skill_1,
			petAdvId = var_60_3.advance_id
		})

		var_60_1 = 1
	end

	return var_60_0, var_60_1
end

function PetStruct:getLinkKnightAdvId()
	return self:getCfg().link_advance_id
end

function PetStruct:isLinkActivated()
	local var_62_0 = var_0_5:getKnightByAdvanceId((self:getLinkKnightAdvId()))

	if not var_62_0 then
		return false
	end

	return var_62_0:isOwn() and self:isOwn()
end

function PetStruct:getTalentSkillData(arg_63_1)
	local var_63_0 = {}
	local var_63_1 = self:getCfg().advance_id

	while var_63_1 > 0 do
		local var_63_2 = var_0_1.get(var_63_1)

		if var_63_2.talent_skill_1 > 0 and arg_63_1 >= var_63_2.id then
			table.insert(var_63_0, var_63_2.talent_skill_1)
		end

		var_63_1 = var_63_2.id_num
	end

	return var_63_0
end

function PetStruct:getTalentTotalAttrByAdvanceId(arg_64_1)
	local var_64_0 = {}
	local var_64_1 = self:getTalentSkillData(arg_64_1)

	if #var_64_1 > 0 then
		for iter_64_0, iter_64_1 in ipairs(var_64_1) do
			local var_64_2 = g.core.config.talent_skill_info.get(iter_64_1)

			for iter_64_2 = 1, 3 do
				if var_64_2["affect_type_" .. iter_64_2] > 0 then
					var_64_0[var_64_2["affect_type_" .. iter_64_2]] = not var_64_0[var_64_2["affect_type_" .. iter_64_2]] and var_64_2["affect_value_" .. iter_64_2] or var_64_0[var_64_2["affect_type_" .. iter_64_2]] + var_64_2["affect_value_" .. iter_64_2]
				end
			end
		end
	end

	local var_64_3 = {}

	for iter_64_3, iter_64_4 in pairs(var_64_0) do
		table.insert(var_64_3, {
			type = iter_64_3,
			value = iter_64_4
		})
	end

	return var_64_3
end

function PetStruct:getMaxAdvanceId()
	local var_65_1 = self:getCfg().advance_id
	local var_65_2 = var_0_1.get(var_65_1)

	while var_65_1 > 0 do
		var_65_2 = var_0_1.get(var_65_1)
		var_65_1 = var_65_2.id_num
	end

	return var_65_2.id
end

function PetStruct:getHpAttrList()
	local var_66_0 = {}
	local var_66_1 = self:getAdvanceId()

	while var_66_1 > 0 do
		local var_66_2 = var_0_0.get(var_66_1)

		if var_66_2.affect_type_5 > 0 and var_66_2.affect_value_5 > 0 then
			table.insert(var_66_0, {
				star = var_66_2.star,
				value = var_66_2.affect_value_5,
				type = var_66_2.affect_type_5
			})
		end

		var_66_1 = var_66_2.next_id
	end

	return var_66_0
end

return PetStruct
