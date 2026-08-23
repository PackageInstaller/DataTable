local SpecialArtifactStruct = class("SpecialArtifactStruct")
local var_0_1 = g.core.config.artifact_info
local var_0_2 = g.core.config.artifact_upgrade_info
local var_0_3 = loadCfg("core.config.cfg.skill_enchant_info")
local var_0_4 = g.core.common.GlobalFunc
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_6 = g.core.model.User.artifactData

function SpecialArtifactStruct:ctor(arg_1_1)
	self._advanceId = arg_1_1
	self._serverData = nil
	self._cfg = {}
end

function SpecialArtifactStruct:setOwnKnight(arg_2_1)
	self._ownKnight = arg_2_1
end

function SpecialArtifactStruct:getOwnKnight()
	return self._ownKnight
end

function SpecialArtifactStruct:setServerData(arg_4_1)
	self._serverData = arg_4_1
end

function SpecialArtifactStruct:setCfg(arg_5_1)
	self._cfg = arg_5_1
end

function SpecialArtifactStruct:getServerData()
	return self._serverData
end

function SpecialArtifactStruct:getServerOnlyId()
	if self._serverData then
		return self._serverData.id
	end
end

function SpecialArtifactStruct:getCfg()
	return self._cfg
end

function SpecialArtifactStruct:isOwn()
	return self._serverData ~= nil
end

function SpecialArtifactStruct:deleteSelf()
	self._serverData = nil
end

function SpecialArtifactStruct:isLineup()
	return self._serverData and self._serverData.pos > 0
end

function SpecialArtifactStruct:isPut()
	return self._cfg.put == 1
end

function SpecialArtifactStruct:getAdvanceId()
	return self._advanceId
end

function SpecialArtifactStruct:getArtifactBaseId()
	if self._serverData then
		return self._serverData.base_id
	else
		return self._cfg.id
	end
end

function SpecialArtifactStruct:getQuality()
	return self._cfg.quality
end

function SpecialArtifactStruct:getArtifactName()
	return self._cfg.name
end

function SpecialArtifactStruct:getNextArtifactBaseId()
	return g.core.config.artifact_info.get((self:getArtifactBaseId())).nextstar
end

function SpecialArtifactStruct:getStarInfo()
	return
end

function SpecialArtifactStruct:getPreStarInfo()
	return not self._serverData and g.core.config.artifact_star_info.get(self._advanceId, 1) or g.core.config.artifact_star_info.get(self._advanceId, math.max(1, self._serverData.star - 1))
end

function SpecialArtifactStruct:updatePosition(arg_20_1)
	if self._serverData then
		self._serverData.pos = arg_20_1
	end
end

function SpecialArtifactStruct:getFormationPos()
	if self._serverData then
		return self._serverData.pos
	end

	return 0
end

function SpecialArtifactStruct:getWearKnight()
	return (self._serverData and self._serverData.pos > 0 or nil) and g.core.model.User.knightsData:getKnight({
		id = g.core.model.User.formationData:getKnightList()[self._serverData.pos]
	})
end

function SpecialArtifactStruct:canCompose()
	local var_23_0 = self:getCfg()
	local var_23_1 = g.core.model.User.fragmentsData:getFragmentNumById(var_23_0.fragment_id)
	local var_23_2 = g.core.config.fragment_info.fetch(var_23_0.fragment_id) or {}
	local var_23_3 = var_23_2.combine_num or 0

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT) then
		return false, var_23_3, var_23_1
	end

	if self:isOwn() then
		return false, 0, 0
	end

	if var_23_0.fragment_id == 0 then
		return false, var_23_3, var_23_1
	end

	if not var_23_2 then
		return false, var_23_3, var_23_1
	end

	return var_23_3 <= var_23_1, var_23_3, var_23_1
end

function SpecialArtifactStruct:getFragNums()
	local var_24_0 = self:getCfg()
	local var_24_1 = g.core.model.User.fragmentsData:getFragmentNumById(var_24_0.fragment_id)
	local var_24_2 = g.core.config.fragment_info.fetch(var_24_0.fragment_id)

	if not var_24_2 then
		return 0, var_24_1
	end

	return var_24_2.combine_num, var_24_1
end

function SpecialArtifactStruct:canStarUp()
	local var_25_0 = self:getCfg()
	local var_25_1 = g.core.model.User.fragmentsData:getFragmentNumById(var_25_0.fragment_id)
	local var_25_2 = g.core.config.fragment_info.fetch(var_25_0.fragment_id) or {}
	local var_25_3 = var_25_0.next_star_num

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_STARUP) then
		return false, var_25_3, var_25_1
	end

	if not var_25_2 then
		return false, var_25_3, var_25_1
	end

	if self:isMaxStar() then
		return false, var_25_3, var_25_1
	end

	if not self:isOwn() then
		return false, var_25_3, var_25_1
	end

	if var_25_1 < var_25_3 then
		return false, var_25_3, var_25_1
	end

	return true, var_25_3, var_25_1
end

function SpecialArtifactStruct:canEnhance()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_ENHANCE) then
		return false
	end

	if self:calCanLevelUpNum() > 0 then
		return true
	end

	return false
end

function SpecialArtifactStruct:isMaxStar()
	if self:getCfg().nextstar == 0 then
		return true
	else
		return false
	end
end

function SpecialArtifactStruct:hasNotEnoughFrag()
	if self:isOwn() or self:canCompose() then
		return false
	end

	return true
end

function SpecialArtifactStruct:isHasOwnFrag()
	return g.core.model.User.fragmentsData:getFragmentNumById(self:getCfg().fragment_id) > 0
end

function SpecialArtifactStruct:getLevel()
	return (self._serverData or nil) and self._serverData.level
end

function SpecialArtifactStruct:getMaxLevel()
	local var_31_0 = 1

	for iter_31_0, iter_31_1 in g.core.config.artifact_upgrade_info.ipairs() do
		if iter_31_1.id == self:getUpgradeCodeId() then
			var_31_0 = math.max(var_31_0, iter_31_1.level)
		end
	end

	return var_31_0
end

function SpecialArtifactStruct:getMaxStar()
	return (BATTLE_CONFIG_TYPE.isOs and self:getQuality() <= g.core.const.ConstMgr.QUALITY_TYPE.UR or nil) and 3
end

function SpecialArtifactStruct:getMaxStarId()
	local var_33_0 = self:getAdvanceId()

	if var_33_0 then
		for iter_33_0, iter_33_1 in g.core.config.artifact_info.ipairs() do
			if iter_33_1.advance_code == var_33_0 and iter_33_1.nextstar == 0 then
				return iter_33_1.id
			end
		end
	end
end

function SpecialArtifactStruct:getLevelAttrs(arg_34_1, arg_34_2, arg_34_3)
	local var_34_0, var_34_1, var_34_2

	if self._serverData then
		arg_34_1 = arg_34_1 or self._serverData.level
	elseif not arg_34_1 then
		arg_34_1 = 1
		var_34_0 = self:getUpgradeCodeId()
		var_34_1 = var_0_2.get(var_34_0, arg_34_1)
		var_34_2 = nil
	end

	if var_0_6:getMaxFullEnhanceLevel() >= arg_34_1 + 1 then
		var_34_2 = var_0_2.get(var_34_0, arg_34_1 + 1)
	end

	local var_34_3 = {}

	for iter_34_0 = 1, ArtifactConst.ATTR_NUM do
		if var_34_1["upgrade_type_" .. iter_34_0] > 0 then
			var_34_3[iter_34_0] = {
				type = var_34_1["upgrade_type_" .. iter_34_0],
				value = var_34_1["upgrade_value_" .. iter_34_0],
				value2 = (arg_34_3 and var_34_2 or nil) and var_34_2["upgrade_value_" .. iter_34_0]
			}
		end
	end

	return var_34_3
end

function SpecialArtifactStruct:getStar()
	if self._serverData then
		return self._serverData.star
	else
		return 0
	end
end

function SpecialArtifactStruct:getSkillLevel()
	return self:getStar()
end

function SpecialArtifactStruct:getStarAttrs(arg_37_1, arg_37_2)
	local var_37_0 = {}
	local var_37_1 = self:getArtifactBaseId()

	if arg_37_1 then
		var_37_1 = arg_37_1
	end

	if var_37_1 then
		local var_37_2 = var_0_1.get(var_37_1)

		for iter_37_0 = 1, ArtifactConst.ATTR_NUM do
			if var_37_2["affect_type_" .. iter_37_0] > 0 then
				var_37_0[iter_37_0] = {
					type = var_37_2["affect_type_" .. iter_37_0],
					value = var_37_2["affect_value_" .. iter_37_0],
					value2 = (var_37_2.nextstar ~= 0 and arg_37_2 or nil) and var_0_1.get(var_37_2.nextstar)["affect_value_" .. iter_37_0]
				}
			end
		end
	end

	return var_37_0
end

function SpecialArtifactStruct:getCastingID()
	return self._cfg.casting_id
end

function SpecialArtifactStruct:isHasCast()
	return self._cfg.casting_id ~= 0
end

function SpecialArtifactStruct:getCastLevel()
	local var_40_0 = self._serverData.castLevel or 1

	var_40_0 = var_40_0 == 0 and 1 or var_40_0

	return var_40_0
end

function SpecialArtifactStruct:getCastExp()
	return self._serverData.castExp or 0
end

function SpecialArtifactStruct:getCurPhase()
	if not self:isHasCast() then
		return 1
	end

	local var_42_0 = 0
	local var_42_1 = ""

	for iter_42_0 = 1, g.core.config.casting_info.getLength() do
		local var_42_2 = g.core.config.casting_info.indexOf(iter_42_0)

		if iter_42_0 == 1 then
			var_42_1 = var_42_2.name
		end

		if var_42_2.level == self:getCastLevel() and var_42_2.id == self:getCastingID() then
			var_42_0 = math.floor(self:getCastExp() / var_42_2.stage_1)
			var_42_1 = var_42_2.name
		end
	end

	return var_42_0, var_42_1
end

function SpecialArtifactStruct:getCastAtt(arg_43_1, arg_43_2)
	arg_43_1 = arg_43_1 or self:getCastLevel()

	local var_43_0, var_43_1

	if not arg_43_2 then
		arg_43_2 = self:getCastExp()
		var_43_0 = self:getCastingID()
		var_43_1 = {}
	end

	for iter_43_0 = 1, g.core.config.casting_info.getLength() do
		local var_43_2 = g.core.config.casting_info.indexOf(iter_43_0)

		if arg_43_1 >= var_43_2.level and var_43_2.id == var_43_0 then
			if arg_43_1 > var_43_2.level or arg_43_1 >= var_43_2.level and self:isMaxCast(arg_43_1, arg_43_2) then
				for iter_43_1 = 1, 10 do
					if g.core.config.casting_info.hasKey("advance_affect_type" .. iter_43_1) and var_43_2["advance_affect_type" .. iter_43_1] > 0 then
						var_43_1[var_43_2["advance_affect_type" .. iter_43_1]] = (var_43_1[var_43_2["advance_affect_type" .. iter_43_1]] or 0) + ((g.core.config.casting_info.hasKey("advance_affect_value" .. iter_43_1) or nil) and (var_43_2["advance_affect_value" .. iter_43_1] or 0))
					end
				end
			end

			if arg_43_1 > var_43_2.level then
				for iter_43_2 = 1, 10 do
					if g.core.config.casting_info.hasKey("affect_type" .. iter_43_2) and var_43_2["affect_type" .. iter_43_2] > 0 then
						var_43_1[var_43_2["affect_type" .. iter_43_2]] = (var_43_1[var_43_2["affect_type" .. iter_43_2]] or 0) + ((g.core.config.casting_info.hasKey("affect_value" .. iter_43_2) or nil) and (var_43_2["affect_value" .. iter_43_2] or 0))
					end
				end
			else
				for iter_43_3 = 1, math.floor(arg_43_2 / var_43_2.stage_1) do
					if g.core.config.casting_info.hasKey("affect_type" .. iter_43_3) and var_43_2["affect_type" .. iter_43_3] > 0 then
						var_43_1[var_43_2["affect_type" .. iter_43_3]] = (var_43_1[var_43_2["affect_type" .. iter_43_3]] or 0) + ((g.core.config.casting_info.hasKey("affect_value" .. iter_43_3) or nil) and (var_43_2["affect_value" .. iter_43_3] or 0))
					end
				end
			end
		end
	end

	return var_43_1
end

function SpecialArtifactStruct:isCanCast()
	if not self:isHasCast() then
		return false
	end

	local var_44_0 = self:getCastingID()
	local var_44_1 = self:getCastLevel()
	local var_44_2 = self:getCastExp()
	local var_44_3 = g.core.config.casting_info.hasData(var_44_0, var_44_1 + 1)
	local var_44_4 = g.core.config.casting_info.get(var_44_0, var_44_1)

	if self:getStar() < var_44_4.star_limit then
		return 1, var_44_4.star_limit
	end

	if var_44_3 then
		return 0
	else
		return var_44_2 < g.core.config.casting_info.get(var_44_0, var_44_1).cost_experience and 0 or 2
	end
end

function SpecialArtifactStruct:isMaxCast(arg_45_1, arg_45_2)
	if not self:isHasCast() then
		return false
	end

	local var_45_0 = self:getCastLevel()
	local var_45_1 = self:getCastingID()

	arg_45_1 = arg_45_1 or var_45_0
	arg_45_2 = arg_45_2 or self:getCastExp()

	if not g.core.config.casting_info.hasData(var_45_1, arg_45_1 + 1) and arg_45_2 >= g.core.config.casting_info.get(var_45_1, arg_45_1).cost_experience then
		return true
	end

	return false
end

function SpecialArtifactStruct:isCanCastSuccess()
	if not self:isHasCast() then
		return false
	end

	local var_46_0 = self:getCastLevel()
	local var_46_1 = self:getCastingID()
	local var_46_2 = g.core.config.casting_info.get(var_46_1, var_46_0)
	local var_46_3 = self:getCastExp()

	if not g.core.config.casting_info.hasData(var_46_1, var_46_0 + 1) and var_46_3 >= var_46_2.cost_experience then
		return false
	end

	if self:getStar() < var_46_2.star_limit then
		return false
	end

	local var_46_4 = var_46_2.casting_develop
	local var_46_5 = {}

	for iter_46_0, iter_46_1 in g.core.config.casting_develop.ipairs() do
		if var_46_4 == iter_46_1.id then
			table.insert(var_46_5, {
				cost_type = iter_46_1.cost_type,
				cost_value = iter_46_1.cost_value,
				addExp = iter_46_1.casting_experience
			})
		end
	end

	local var_46_6 = 0

	for iter_46_2, iter_46_3 in ipairs(var_46_5) do
		var_46_6 = var_46_6 + iter_46_3.addExp * g.core.model.User.bagData:getCountById(iter_46_3.cost_type, iter_46_3.cost_value)
	end

	local var_46_7 = {}

	for iter_46_4 = 1, 10 do
		if g.core.config.casting_info.hasKey("stage_" .. iter_46_4) then
			table.insert(var_46_7, var_46_2["stage_" .. iter_46_4])
		end
	end

	table.insert(var_46_7, var_46_2.cost_experience)

	local var_46_8 = var_46_7[math.floor(var_46_3 / var_46_2.stage_1) + 1]

	if var_46_8 and var_46_8 <= var_46_6 + var_46_3 then
		return true
	end

	return false
end

function SpecialArtifactStruct:getStarUpTalentDesc()
	local var_47_0 = self:getStarInfo().star

	if not self:isMaxStar() then
		var_47_0 = var_47_0 + 1
	end

	local var_47_1 = self:getCfg()

	if var_47_1["talent_skill_" .. var_47_0] > 0 then
		return g.core.config.talent_skill_info.get(var_47_1["talent_skill_" .. var_47_0]).description
	end
end

function SpecialArtifactStruct:getSkillInfo(arg_48_1)
	local var_48_0 = self:getSkillId(arg_48_1)

	if var_48_0 > 0 then
		return (g.core.config.passive_skill_info.get(var_48_0))
	end
end

function SpecialArtifactStruct:getSkillId(arg_49_1)
	local var_49_0 = self:getCfg()["passive_skill_" .. (arg_49_1 or 1)]

	if var_49_0 and var_49_0 > 0 then
		return var_49_0
	end
end

function SpecialArtifactStruct:getShowSkills()
	local var_50_0 = {}
	local var_50_1 = self:getCfg()
	local var_50_3 = ""
	local var_50_4 = self:getSkillInfo(1)
	local var_50_5 = self:getSkillInfo(2)
	local var_50_6 = g.core.utils.String.formatSkillDesc(var_50_4.id)

	if var_50_1.passive_skill_2 > 0 then
		local var_50_7 = g.core.utils.String.formatSkillDesc(var_50_5.id)

		if var_50_1.skill_type == 2 then
			var_50_6 = var_50_6 .. var_50_7
		else
			var_50_3 = var_50_7
		end
	end

	table.insert(var_50_0, {
		quality = var_50_1.quality,
		skillId = var_50_4.id,
		level = self:getStar(),
		desc = var_50_6
	})

	if var_50_3 ~= "" then
		table.insert(var_50_0, {
			quality = var_50_1.quality,
			skillId = var_50_5.id,
			level = self:getStar(),
			desc = var_50_3
		})
	end

	return var_50_0
end

function SpecialArtifactStruct:getSkillPromoteList()
	local var_51_0 = {}
	local var_51_1 = self:getCfg()

	for iter_51_0, iter_51_1 in var_0_1.ipairs() do
		if var_51_1.advance_code == iter_51_1.advance_code and iter_51_1.star > 0 then
			local var_51_3 = ""
			local var_51_4

			if iter_51_1.passive_skill_1 > 0 then
				local var_51_5 = g.core.config.skill_info.get(g.core.config.passive_skill_info.get(iter_51_1.passive_skill_1).passive_skill_value)
				local var_51_6 = var_0_4.getFormatSkillPromoteDes(var_51_5.id)

				if var_51_6 ~= "0" then
					var_51_3 = var_51_3 .. var_51_6
					var_51_4 = var_51_5
				end
			end

			if iter_51_1.passive_skill_2 > 0 and iter_51_1.skill_type == 2 then
				local var_51_7 = g.core.config.skill_info.get(g.core.config.passive_skill_info.get(iter_51_1.passive_skill_2).passive_skill_value)
				local var_51_8 = var_0_4.getFormatSkillPromoteDes(var_51_7.id)

				if var_51_8 ~= "0" then
					var_51_3 = var_51_3 .. var_51_8
					var_51_4 = var_51_7
				end
			end

			if var_51_3 ~= "" then
				table.insert(var_51_0, {
					skillInfo = var_51_4,
					level = iter_51_1.star,
					promoteDes = var_51_3
				})
			end
		end
	end

	return var_51_0
end

function SpecialArtifactStruct:calCanLevelUpNum()
	local var_52_0 = 0
	local var_52_1 = 0
	local var_52_2 = 0
	local var_52_3 = 0
	local var_52_4 = 0
	local var_52_5 = self:getLevel()
	local var_52_6 = self:getMaxLevel()
	local var_52_7 = self:getUpgradeCodeId()
	local var_52_8

	for iter_52_0 = 1, 10 do
		local var_52_10

		if var_52_5 + iter_52_0 - 1 < var_52_6 then
			local var_52_9 = var_0_2.get(var_52_7, var_52_5 + iter_52_0 - 1)

			if var_52_1 == 0 and var_52_9.cost_num > 0 then
				var_52_1 = g.core.model.User.bagData:getCountById(var_52_9.cost_type, var_52_9.cost_value)
			end

			if var_52_2 == 0 and var_52_9.cost_num_2 > 0 then
				var_52_2 = g.core.model.User.bagData:getCountById(var_52_9.cost_type_2, var_52_9.cost_value_2)
			end

			var_52_3 = var_52_3 + var_52_9.cost_num
			var_52_4 = var_52_4 + var_52_9.cost_num_2

			if var_52_3 <= var_52_1 and var_52_4 <= var_52_2 then
				var_52_0 = var_52_0 + 1
			elseif var_52_1 < var_52_3 then
				var_52_8 = var_52_9.cost_type
				var_52_10 = var_52_9.cost_value

				break
			elseif var_52_2 < var_52_4 then
				var_52_8 = var_52_9.cost_type_2
				var_52_10 = var_52_9.cost_value_2

				break
			end
		end
	end

	return var_52_0, var_52_8, nil
end

function SpecialArtifactStruct:getUpgradeCodeId()
	return (self:getCfg() or {}).upgrade_code
end

function SpecialArtifactStruct:getBaseAttrsData(arg_54_1)
	local var_54_0 = {}
	local var_54_1 = {}

	if arg_54_1 then
		var_54_0 = clone(self:getLevelAttrs((self:getMaxLevel())))
		var_54_1 = self:getStarAttrs((self:getMaxStarId()))
	else
		var_54_0 = clone(self:getLevelAttrs())
		var_54_1 = self:getStarAttrs()
	end

	for iter_54_0 = 1, #var_54_1 do
		for iter_54_1 = 1, #var_54_0 do
			if var_54_1[iter_54_0].type == var_54_0[iter_54_1].type then
				var_54_0[iter_54_1].value = var_54_0[iter_54_1].value + var_54_1[iter_54_0].value

				break
			end

			if iter_54_1 == #var_54_0 then
				table.insert(var_54_0, {
					type = var_54_1[iter_54_0].type,
					value = var_54_1[iter_54_0].value
				})
			end
		end
	end

	return var_54_0 or {}
end

function SpecialArtifactStruct:getBelongToKnightAdvanceCode()
	return self:getCfg().knight_advance_code
end

function SpecialArtifactStruct:getBelongToKnightInfo()
	return (g.core.model.User.knightsData:getKnightByAdvanceId((self:getBelongToKnightAdvanceCode())))
end

function SpecialArtifactStruct:isMainRoleRelatedArtifact()
	local var_57_0 = self:getCfg().knight_advance_code

	if var_57_0 == 200000 or var_57_0 == 210000 then
		return true
	end

	return false
end

function SpecialArtifactStruct:getShowEnhanceTalentId()
	return (var_0_6:getEnhanceTalentByCodeAndLevel(self:getUpgradeCodeId(), (self:getLevel())))
end

function SpecialArtifactStruct:getUpgradeInfo()
	return (var_0_2.get(self:getUpgradeCodeId(), (self:getLevel())))
end

function SpecialArtifactStruct:getPopShowStarAttrs(arg_60_1)
	local var_60_0 = {}
	local var_60_1 = self:getArtifactBaseId()

	if arg_60_1 then
		var_60_1 = arg_60_1
	end

	if var_60_1 then
		local var_60_2 = var_0_1.get(var_60_1)

		for iter_60_0 = 1, ArtifactConst.ATTR_NUM do
			if var_60_2["affect_type_" .. iter_60_0] > 0 then
				local var_60_4 = {
					type = var_60_2["affect_type_" .. iter_60_0],
					value = var_60_2["affect_value_" .. iter_60_0]
				}

				var_60_0[iter_60_0] = var_60_2.nextstar ~= 0 and {
					attrs = var_60_4,
					nextValue = var_0_1.get(var_60_2.nextstar)["affect_value_" .. iter_60_0]
				} or {
					attrs = var_60_4
				}
			end
		end
	end

	return var_60_0
end

function SpecialArtifactStruct:isActiveTalentInfo()
	local var_61_0 = self:getLevel()
	local var_61_1 = g.core.model.User.artifactData:getArtifactEnhanceTalentByUpgradeCode((self:getUpgradeCodeId())) or {}

	if var_61_1 then
		for iter_61_0, iter_61_1 in ipairs(var_61_1) do
			if var_61_0 == iter_61_1.info.level and iter_61_1.info.talent ~= 0 then
				return true
			end
		end
	end

	return false
end

function SpecialArtifactStruct:getBelongToGroup()
	return self:getBelongToKnightInfo():getBaseInfo().group
end

function SpecialArtifactStruct:getWearKnightIconUrl()
	local var_63_0 = self:getWearKnight()

	if var_63_0 then
		return (g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(var_63_0:getBaseInfo().res_id).icon_id))
	end

	return ""
end

function SpecialArtifactStruct:getBelongToKnightAvdIdIncludingMainRole()
	local var_64_0 = self:getCfg().knight_advance_code

	if var_64_0 == 210000 or var_64_0 == 200000 then
		var_64_0 = 200000

		if g.core.model.User:isBoy() then
			var_64_0 = 210000
		end
	end

	return var_64_0
end

function SpecialArtifactStruct:isDemo()
	return self._cfg and self._cfg.if_try == 1
end

return SpecialArtifactStruct
