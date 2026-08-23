local var_0_0 = g.core.config.artifact_info
local var_0_1 = g.core.config.artifact_spirit_level_info
local var_0_2 = g.core.config.artifact_spirit_info
local var_0_3 = g.core.config.artifact_upgrade_info
local var_0_4 = g.core.common.GlobalFunc
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_6 = g.core.model.User.artifactData
local ArtifactStruct = class("ArtifactStruct")

function ArtifactStruct:ctor(arg_1_1)
	self._advanceId = arg_1_1
	self._serverData = nil
	self._cfg = {}
	self._allStarCfg = {}
	self._spiritCfgMap = {}
	self._spiritStage = 0
	self._maxSpiritStage = 0
	self._isSpiritLvUpFlag = false
	self._spiritLv = 0
end

function ArtifactStruct:setServerData(arg_2_1)
	if self._serverData and arg_2_1.spirit_stage > self._spiritStage then
		self._isSpiritLvUpFlag = true
	end

	self._serverData = arg_2_1
	self._spiritStage = arg_2_1.spirit_stage or 0
	self._spiritLv = arg_2_1.spirit_level or 0
end

function ArtifactStruct:setCfg(arg_3_1)
	self._cfg = arg_3_1
end

function ArtifactStruct:setStarCfg(arg_4_1)
	self._allStarCfg[arg_4_1.star] = arg_4_1
end

function ArtifactStruct:getServerData()
	return self._serverData
end

function ArtifactStruct:getServerOnlyId()
	if self._serverData then
		return self._serverData.id
	end
end

function ArtifactStruct:getCfg()
	return self._cfg
end

function ArtifactStruct:isOwn()
	return self._serverData ~= nil
end

function ArtifactStruct:deleteSelf()
	self._serverData = nil
end

function ArtifactStruct:isLineup()
	return self._serverData and self._serverData.pos > 0
end

function ArtifactStruct:isPut()
	return self._cfg.put == 1
end

function ArtifactStruct:getAdvanceId()
	return self._advanceId
end

function ArtifactStruct:getArtifactBaseId()
	if self._serverData then
		return self._serverData.base_id
	else
		return self._cfg.id
	end
end

function ArtifactStruct:getQuality()
	return self._cfg.quality
end

function ArtifactStruct:getArtifactName()
	return self._cfg.name
end

function ArtifactStruct:getName()
	return self._cfg.name
end

function ArtifactStruct:getNextArtifactBaseId()
	return g.core.config.artifact_info.get((self:getArtifactBaseId())).nextstar
end

function ArtifactStruct:getStarInfo()
	return
end

function ArtifactStruct:getPreStarInfo()
	return not self._serverData and g.core.config.artifact_star_info.get(self._advanceId, 1) or g.core.config.artifact_star_info.get(self._advanceId, math.max(1, self._serverData.star - 1))
end

function ArtifactStruct:updatePosition(arg_20_1)
	if self._serverData then
		self._serverData.pos = arg_20_1
	end
end

function ArtifactStruct:getFormationPos()
	if self._serverData then
		return self._serverData.pos
	end

	return 0
end

function ArtifactStruct:getWearKnight()
	return (self._serverData and self._serverData.pos > 0 or nil) and g.core.model.User.knightsData:getKnight({
		id = g.core.model.User.formationData:getKnightList()[self._serverData.pos]
	})
end

function ArtifactStruct:canCompose()
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

function ArtifactStruct:getFragNums()
	local var_24_0 = self:getCfg()
	local var_24_1 = g.core.model.User.fragmentsData:getFragmentNumById(var_24_0.fragment_id)
	local var_24_2 = g.core.config.fragment_info.fetch(var_24_0.fragment_id)

	if not var_24_2 then
		return 0, var_24_1
	end

	return var_24_2.combine_num, var_24_1
end

function ArtifactStruct:canStarUp()
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

function ArtifactStruct:canEnhance()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_ENHANCE) then
		return false
	end

	if self:calCanLevelUpNum() > 0 and self:isOwn() then
		return true
	end

	return false
end

function ArtifactStruct:isMaxStar()
	if self:getCfg().nextstar == 0 then
		return true
	else
		return false
	end
end

function ArtifactStruct:hasNotEnoughFrag()
	if self:isOwn() or self:canCompose() then
		return false
	end

	return true
end

function ArtifactStruct:isHasOwnFrag()
	return g.core.model.User.fragmentsData:getFragmentNumById(self:getCfg().fragment_id) > 0
end

function ArtifactStruct:getLevel()
	return (self._serverData or nil) and self._serverData.level
end

function ArtifactStruct:getMaxLevel()
	local var_31_0 = 1

	for iter_31_0, iter_31_1 in g.core.config.artifact_upgrade_info.ipairs() do
		if iter_31_1.id == self:getUpgradeCodeId() then
			var_31_0 = math.max(var_31_0, iter_31_1.level)
		end
	end

	return var_31_0
end

function ArtifactStruct:getMaxStar()
	return (BATTLE_CONFIG_TYPE.isOs or nil) and self._cfg.show_quality
end

function ArtifactStruct:getMaxStarLevel()
	return self:getMaxStar()
end

function ArtifactStruct:getMaxStarId()
	local var_34_0 = self:getAdvanceId()

	if var_34_0 then
		for iter_34_0, iter_34_1 in g.core.config.artifact_info.ipairs() do
			if iter_34_1.advance_code == var_34_0 and iter_34_1.nextstar == 0 then
				return iter_34_1.id
			end
		end
	end
end

function ArtifactStruct:getLevelAttrs(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0, var_35_1, var_35_2

	if self._serverData then
		arg_35_1 = arg_35_1 or self._serverData.level
	elseif not arg_35_1 then
		arg_35_1 = 1
		var_35_0 = self:getUpgradeCodeId()
		var_35_1 = var_0_3.get(var_35_0, arg_35_1)
		var_35_2 = nil
	end

	if var_0_6:getMaxFullEnhanceLevel() >= arg_35_1 + 1 then
		var_35_2 = var_0_3.get(var_35_0, arg_35_1 + 1)
	end

	local var_35_3 = {}

	for iter_35_0 = 1, ArtifactConst.ATTR_NUM do
		if var_35_1["upgrade_type_" .. iter_35_0] > 0 then
			var_35_3[iter_35_0] = {
				type = var_35_1["upgrade_type_" .. iter_35_0],
				value = var_35_1["upgrade_value_" .. iter_35_0],
				value2 = (arg_35_3 and var_35_2 or nil) and var_35_2["upgrade_value_" .. iter_35_0]
			}
		end
	end

	return var_35_3
end

function ArtifactStruct:getStar()
	if self._serverData then
		return self._serverData.star
	else
		return 0
	end
end

function ArtifactStruct:getSkillLevel()
	return self:getStar()
end

function ArtifactStruct:getStarAttrs(arg_38_1, arg_38_2)
	local var_38_0 = {}
	local var_38_1 = self:getArtifactBaseId()
	local var_38_2 = 1

	if arg_38_1 then
		var_38_1 = arg_38_1
	elseif self:isNonExclusive() then
		var_38_2 = 2
	end

	if var_38_1 then
		local var_38_3 = var_0_0.get(var_38_1)

		for iter_38_0 = 1, ArtifactConst.ATTR_NUM do
			if var_38_3["affect_type_" .. iter_38_0] > 0 then
				var_38_0[iter_38_0] = {
					type = var_38_3["affect_type_" .. iter_38_0],
					value = var_38_3["affect_value_" .. iter_38_0] / var_38_2,
					value2 = (var_38_3.nextstar ~= 0 and arg_38_2 or nil) and var_0_0.get(var_38_3.nextstar)["affect_value_" .. iter_38_0] / var_38_2
				}
			end
		end
	end

	return var_38_0
end

function ArtifactStruct:getCastingID()
	return self._cfg.casting_id
end

function ArtifactStruct:isHasCast()
	return self._cfg.casting_id ~= 0
end

function ArtifactStruct:getCastLevel()
	local var_41_0 = self._serverData.castLevel or 1

	var_41_0 = var_41_0 == 0 and 1 or var_41_0

	return var_41_0
end

function ArtifactStruct:getCastExp()
	return self._serverData.castExp or 0
end

function ArtifactStruct:getCurPhase()
	if not self:isHasCast() then
		return 1
	end

	local var_43_0 = 0
	local var_43_1 = ""

	for iter_43_0 = 1, g.core.config.casting_info.getLength() do
		local var_43_2 = g.core.config.casting_info.indexOf(iter_43_0)

		if iter_43_0 == 1 then
			var_43_1 = var_43_2.name
		end

		if var_43_2.level == self:getCastLevel() and var_43_2.id == self:getCastingID() then
			var_43_0 = math.floor(self:getCastExp() / var_43_2.stage_1)
			var_43_1 = var_43_2.name
		end
	end

	return var_43_0, var_43_1
end

function ArtifactStruct:getCastAtt(arg_44_1, arg_44_2)
	arg_44_1 = arg_44_1 or self:getCastLevel()

	local var_44_0, var_44_1

	if not arg_44_2 then
		arg_44_2 = self:getCastExp()
		var_44_0 = self:getCastingID()
		var_44_1 = {}
	end

	for iter_44_0 = 1, g.core.config.casting_info.getLength() do
		local var_44_2 = g.core.config.casting_info.indexOf(iter_44_0)

		if arg_44_1 >= var_44_2.level and var_44_2.id == var_44_0 then
			if arg_44_1 > var_44_2.level or arg_44_1 >= var_44_2.level and self:isMaxCast(arg_44_1, arg_44_2) then
				for iter_44_1 = 1, 10 do
					if g.core.config.casting_info.hasKey("advance_affect_type" .. iter_44_1) and var_44_2["advance_affect_type" .. iter_44_1] > 0 then
						var_44_1[var_44_2["advance_affect_type" .. iter_44_1]] = (var_44_1[var_44_2["advance_affect_type" .. iter_44_1]] or 0) + ((g.core.config.casting_info.hasKey("advance_affect_value" .. iter_44_1) or nil) and (var_44_2["advance_affect_value" .. iter_44_1] or 0))
					end
				end
			end

			if arg_44_1 > var_44_2.level then
				for iter_44_2 = 1, 10 do
					if g.core.config.casting_info.hasKey("affect_type" .. iter_44_2) and var_44_2["affect_type" .. iter_44_2] > 0 then
						var_44_1[var_44_2["affect_type" .. iter_44_2]] = (var_44_1[var_44_2["affect_type" .. iter_44_2]] or 0) + ((g.core.config.casting_info.hasKey("affect_value" .. iter_44_2) or nil) and (var_44_2["affect_value" .. iter_44_2] or 0))
					end
				end
			else
				for iter_44_3 = 1, math.floor(arg_44_2 / var_44_2.stage_1) do
					if g.core.config.casting_info.hasKey("affect_type" .. iter_44_3) and var_44_2["affect_type" .. iter_44_3] > 0 then
						var_44_1[var_44_2["affect_type" .. iter_44_3]] = (var_44_1[var_44_2["affect_type" .. iter_44_3]] or 0) + ((g.core.config.casting_info.hasKey("affect_value" .. iter_44_3) or nil) and (var_44_2["affect_value" .. iter_44_3] or 0))
					end
				end
			end
		end
	end

	return var_44_1
end

function ArtifactStruct:isCanCast()
	if not self:isHasCast() then
		return false
	end

	local var_45_0 = self:getCastingID()
	local var_45_1 = self:getCastLevel()
	local var_45_2 = self:getCastExp()
	local var_45_3 = g.core.config.casting_info.hasData(var_45_0, var_45_1 + 1)
	local var_45_4 = g.core.config.casting_info.get(var_45_0, var_45_1)

	if self:getStar() < var_45_4.star_limit then
		return 1, var_45_4.star_limit
	end

	if var_45_3 then
		return 0
	else
		return var_45_2 < g.core.config.casting_info.get(var_45_0, var_45_1).cost_experience and 0 or 2
	end
end

function ArtifactStruct:isMaxCast(arg_46_1, arg_46_2)
	if not self:isHasCast() then
		return false
	end

	local var_46_0 = self:getCastLevel()
	local var_46_1 = self:getCastingID()

	arg_46_1 = arg_46_1 or var_46_0
	arg_46_2 = arg_46_2 or self:getCastExp()

	if not g.core.config.casting_info.hasData(var_46_1, arg_46_1 + 1) and arg_46_2 >= g.core.config.casting_info.get(var_46_1, arg_46_1).cost_experience then
		return true
	end

	return false
end

function ArtifactStruct:isCanCastSuccess()
	if not self:isHasCast() then
		return false
	end

	local var_47_0 = self:getCastLevel()
	local var_47_1 = self:getCastingID()
	local var_47_2 = g.core.config.casting_info.get(var_47_1, var_47_0)
	local var_47_3 = self:getCastExp()

	if not g.core.config.casting_info.hasData(var_47_1, var_47_0 + 1) and var_47_3 >= var_47_2.cost_experience then
		return false
	end

	if self:getStar() < var_47_2.star_limit then
		return false
	end

	local var_47_4 = var_47_2.casting_develop
	local var_47_5 = {}

	for iter_47_0, iter_47_1 in g.core.config.casting_develop.ipairs() do
		if var_47_4 == iter_47_1.id then
			table.insert(var_47_5, {
				cost_type = iter_47_1.cost_type,
				cost_value = iter_47_1.cost_value,
				addExp = iter_47_1.casting_experience
			})
		end
	end

	local var_47_6 = 0

	for iter_47_2, iter_47_3 in ipairs(var_47_5) do
		var_47_6 = var_47_6 + iter_47_3.addExp * g.core.model.User.bagData:getCountById(iter_47_3.cost_type, iter_47_3.cost_value)
	end

	local var_47_7 = {}

	for iter_47_4 = 1, 10 do
		if g.core.config.casting_info.hasKey("stage_" .. iter_47_4) then
			table.insert(var_47_7, var_47_2["stage_" .. iter_47_4])
		end
	end

	table.insert(var_47_7, var_47_2.cost_experience)

	local var_47_8 = var_47_7[math.floor(var_47_3 / var_47_2.stage_1) + 1]

	if var_47_8 and var_47_8 <= var_47_6 + var_47_3 then
		return true
	end

	return false
end

function ArtifactStruct:getStarUpTalentDesc()
	local var_48_0 = self:getStarInfo().star

	if not self:isMaxStar() then
		var_48_0 = var_48_0 + 1
	end

	local var_48_1 = self:getCfg()

	if var_48_1["talent_skill_" .. var_48_0] > 0 then
		return g.core.config.talent_skill_info.get(var_48_1["talent_skill_" .. var_48_0]).description
	end
end

function ArtifactStruct:getSkillInfo(arg_49_1)
	local var_49_0 = self:getSkillId(arg_49_1)

	if var_49_0 > 0 then
		return (g.core.config.passive_skill_info.get(var_49_0))
	end
end

function ArtifactStruct:getSkillId(arg_50_1)
	local var_50_0 = self:getCfg()["passive_skill_" .. (arg_50_1 or 1)]

	if var_50_0 and var_50_0 > 0 then
		return var_50_0
	end
end

function ArtifactStruct:getShowSkills()
	local var_51_0 = {}
	local var_51_1 = self:getCfg()
	local var_51_3 = ""
	local var_51_4 = self:getSkillInfo(1)
	local var_51_5 = self:getSkillInfo(2)
	local var_51_6 = g.core.utils.String.formatSkillDesc(var_51_4.id)

	if var_51_1.passive_skill_2 > 0 then
		local var_51_7 = g.core.utils.String.formatSkillDesc(var_51_5.id)

		if var_51_1.skill_type == 2 then
			var_51_6 = var_51_6 .. var_51_7
		else
			var_51_3 = var_51_7
		end
	end

	table.insert(var_51_0, {
		quality = var_51_1.quality,
		skillId = var_51_4.id,
		level = self:getStar(),
		desc = var_51_6
	})

	if var_51_3 ~= "" then
		table.insert(var_51_0, {
			quality = var_51_1.quality,
			skillId = var_51_5.id,
			level = self:getStar(),
			desc = var_51_3
		})
	end

	return var_51_0
end

function ArtifactStruct:getSkillPromoteList()
	local var_52_0 = {}
	local var_52_1 = self:getCfg()

	for iter_52_0, iter_52_1 in var_0_0.ipairs() do
		if var_52_1.advance_code == iter_52_1.advance_code and iter_52_1.star > 0 then
			local var_52_3 = ""
			local var_52_4

			if iter_52_1.passive_skill_1 > 0 then
				local var_52_5 = g.core.config.skill_info.get(g.core.config.passive_skill_info.get(iter_52_1.passive_skill_1).passive_skill_value)
				local var_52_6 = var_0_4.getFormatSkillPromoteDes(var_52_5.id)

				if var_52_6 ~= "0" then
					var_52_3 = var_52_3 .. var_52_6
					var_52_4 = var_52_5
				end
			end

			if iter_52_1.passive_skill_2 > 0 and iter_52_1.skill_type == 2 then
				local var_52_7 = g.core.config.skill_info.get(g.core.config.passive_skill_info.get(iter_52_1.passive_skill_2).passive_skill_value)
				local var_52_8 = var_0_4.getFormatSkillPromoteDes(var_52_7.id)

				if var_52_8 ~= "0" then
					var_52_3 = var_52_3 .. var_52_8
					var_52_4 = var_52_7
				end
			end

			if var_52_3 ~= "" then
				table.insert(var_52_0, {
					skillInfo = var_52_4,
					level = iter_52_1.star,
					promoteDes = var_52_3
				})
			end
		end
	end

	return var_52_0
end

function ArtifactStruct:calCanLevelUpNum()
	local var_53_0 = 0
	local var_53_1 = 0
	local var_53_2 = 0
	local var_53_3 = 0
	local var_53_4 = 0
	local var_53_5 = self:getLevel()
	local var_53_6 = self:getMaxLevel()
	local var_53_7 = self:getUpgradeCodeId()
	local var_53_8

	for iter_53_0 = 1, 10 do
		local var_53_10

		if var_53_5 + iter_53_0 - 1 < var_53_6 then
			local var_53_9 = var_0_3.get(var_53_7, var_53_5 + iter_53_0 - 1)

			if var_53_1 == 0 and var_53_9.cost_num > 0 then
				var_53_1 = g.core.model.User.bagData:getCountById(var_53_9.cost_type, var_53_9.cost_value)
			end

			if var_53_2 == 0 and var_53_9.cost_num_2 > 0 then
				var_53_2 = g.core.model.User.bagData:getCountById(var_53_9.cost_type_2, var_53_9.cost_value_2)
			end

			var_53_3 = var_53_3 + var_53_9.cost_num
			var_53_4 = var_53_4 + var_53_9.cost_num_2

			if var_53_3 <= var_53_1 and var_53_4 <= var_53_2 then
				var_53_0 = var_53_0 + 1
			elseif var_53_1 < var_53_3 then
				var_53_8 = var_53_9.cost_type
				var_53_10 = var_53_9.cost_value

				break
			elseif var_53_2 < var_53_4 then
				var_53_8 = var_53_9.cost_type_2
				var_53_10 = var_53_9.cost_value_2

				break
			end
		end
	end

	return var_53_0, var_53_8, nil
end

function ArtifactStruct:getUpgradeCodeId()
	return (self:getCfg() or {}).upgrade_code
end

function ArtifactStruct:getBaseAttrsData(arg_55_1)
	local var_55_0 = {}
	local var_55_1 = {}

	if arg_55_1 then
		var_55_0 = clone(self:getLevelAttrs((self:getMaxLevel())))
		var_55_1 = self:getStarAttrs((self:getMaxStarId()))
	else
		var_55_0 = clone(self:getLevelAttrs())
		var_55_1 = self:getStarAttrs()
	end

	for iter_55_0 = 1, #var_55_1 do
		for iter_55_1 = 1, #var_55_0 do
			if var_55_1[iter_55_0].type == var_55_0[iter_55_1].type then
				var_55_0[iter_55_1].value = var_55_0[iter_55_1].value + var_55_1[iter_55_0].value

				break
			end

			if iter_55_1 == #var_55_0 then
				table.insert(var_55_0, {
					type = var_55_1[iter_55_0].type,
					value = var_55_1[iter_55_0].value
				})
			end
		end
	end

	return var_55_0 or {}
end

function ArtifactStruct:getBelongToKnightAdvanceCode()
	return self:getCfg().knight_advance_code
end

function ArtifactStruct:getBelongToKnightInfo()
	return (g.core.model.User.knightsData:getKnightByAdvanceId((self:getBelongToKnightAvdIdIncludingMainRole())))
end

function ArtifactStruct:isMainRoleRelatedArtifact()
	local var_58_0 = self:getCfg().knight_advance_code

	if var_58_0 == 200000 or var_58_0 == 210000 then
		return true
	end

	return false
end

function ArtifactStruct:getShowEnhanceTalentId()
	return (var_0_6:getEnhanceTalentByCodeAndLevel(self:getUpgradeCodeId(), (self:getLevel())))
end

function ArtifactStruct:getUpgradeInfo()
	return (var_0_3.get(self:getUpgradeCodeId(), (self:getLevel())))
end

function ArtifactStruct:getPopShowStarAttrs(arg_61_1)
	local var_61_0 = {}
	local var_61_1 = self:getArtifactBaseId()
	local var_61_2 = 1

	if arg_61_1 then
		var_61_1 = arg_61_1
	elseif self:isNonExclusive() then
		var_61_2 = 2
	end

	if var_61_1 then
		local var_61_3 = var_0_0.get(var_61_1)

		for iter_61_0 = 1, ArtifactConst.ATTR_NUM do
			if var_61_3["affect_type_" .. iter_61_0] > 0 then
				local var_61_5 = {
					type = var_61_3["affect_type_" .. iter_61_0],
					value = var_61_3["affect_value_" .. iter_61_0] / var_61_2
				}

				var_61_0[iter_61_0] = var_61_3.nextstar ~= 0 and {
					attrs = var_61_5,
					nextValue = var_0_0.get(var_61_3.nextstar)["affect_value_" .. iter_61_0] / var_61_2
				} or {
					attrs = var_61_5
				}
			end
		end
	end

	return var_61_0
end

function ArtifactStruct:isActiveTalentInfo()
	local var_62_0 = self:getLevel()
	local var_62_1 = g.core.model.User.artifactData:getArtifactEnhanceTalentByUpgradeCode((self:getUpgradeCodeId())) or {}

	if var_62_1 then
		for iter_62_0, iter_62_1 in ipairs(var_62_1) do
			if var_62_0 == iter_62_1.info.level and iter_62_1.info.talent ~= 0 then
				return true
			end
		end
	end

	return false
end

function ArtifactStruct:getBelongToGroup()
	return self:getBelongToKnightInfo():getBaseInfo().group
end

function ArtifactStruct:getWearKnightIconUrl()
	local var_64_0 = self:getWearKnight()

	if var_64_0 then
		return (g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(var_64_0:getBaseInfo().res_id).icon_id))
	end

	return ""
end

function ArtifactStruct:getBelongToKnightAvdIdIncludingMainRole()
	local var_65_0 = self:getCfg().knight_advance_code

	if var_65_0 == 210000 or var_65_0 == 200000 then
		var_65_0 = 200000

		if g.core.model.User:isBoy() then
			var_65_0 = 210000
		end
	end

	return var_65_0
end

function ArtifactStruct:isDemo()
	return self._cfg.if_try == 1
end

function ArtifactStruct:isNonExclusive()
	local var_67_0 = self:getWearKnight()

	return self:isDemo() and var_67_0 and var_67_0:getAdvanceId() ~= self:getBelongToKnightAvdIdIncludingMainRole()
end

function ArtifactStruct:checkWearKnight(arg_68_1)
	if self._cfg.dedicated == ArtifactConst.BIND_KNIGHT.ALL then
		return true
	elseif self._cfg.dedicated == ArtifactConst.BIND_KNIGHT.ONCE_KNIGHT then
		return self:getBelongToKnightAvdIdIncludingMainRole() == arg_68_1
	end
end

function ArtifactStruct:checkIsOnlyKnight()
	return self._cfg.dedicated == ArtifactConst.BIND_KNIGHT.ONCE_KNIGHT
end

function ArtifactStruct:setSpiritStageCfg(arg_70_1, arg_70_2)
	self._spiritCfgMap[arg_70_2] = arg_70_1

	if arg_70_1.next_stage == 0 then
		self._maxSpiritStage = arg_70_1.spirit_stage
	end
end

function ArtifactStruct:isHasWeaponSpirit()
	return self._cfg.quality >= 4
end

function ArtifactStruct:isSpiritMaxStage()
	return self._spiritStage >= self._maxSpiritStage
end

function ArtifactStruct:isSpiritMaxLevel()
	return self._spiritLv >= self:getSpiritStageMaxLevel()
end

function ArtifactStruct:getSpiritStage()
	return self._spiritStage
end

function ArtifactStruct:getStageUpCost()
	local var_75_0 = self:getSpiritStageCfg()

	return {
		type = var_75_0.up_stage_type,
		value = var_75_0.up_stage_value,
		size = var_75_0.up_stage_size
	}
end

function ArtifactStruct:getLevelUpCost()
	return self:getSpiritLevelUpCost()[1]
end

function ArtifactStruct:getSpiritStageCfg(arg_77_1)
	return self._spiritCfgMap[arg_77_1 or self._spiritStage]
end

function ArtifactStruct:getMaxSpiritStage()
	return self._maxSpiritStage
end

function ArtifactStruct:getSpiritStageMaxLevel(arg_79_1)
	local var_79_0 = self:getSpiritStageCfg(arg_79_1)

	if var_79_0 then
		return var_79_0.level_max
	end

	return 0
end

function ArtifactStruct:getSpiritLevel()
	return self._spiritLv
end

function ArtifactStruct:getCanFastLvUpTimesAndCosts()
	if self:getSpiritStageMaxLevel() <= self._spiritLv then
		return 0
	end
end

function ArtifactStruct:getCostToTargetLevel(arg_82_1)
	local var_82_0 = self:getSpiritStageCfg()
	local var_82_1 = {}

	for iter_82_0 = self:getSpiritLevel(), arg_82_1 do
		local var_82_2 = var_0_1.fetch(iter_82_0, var_82_0.level_group)

		if var_82_2.upgrade_type > 0 then
			local var_82_3 = table.concat({
				var_82_2.upgrade_type,
				"_",
				var_82_2.upgrade_value
			})

			var_82_1[var_82_3] = var_82_1[var_82_3] or 0
			var_82_1[var_82_3] = var_82_1[var_82_3] + var_82_2.upgrade_size
		end
	end

	return var_82_1
end

function ArtifactStruct:getSpiritLevelUpCost(arg_83_1, arg_83_2, arg_83_3)
	arg_83_1 = arg_83_1 or self._spiritLv

	if arg_83_1 >= self:getSpiritStageMaxLevel() then
		return arg_83_2
	end

	arg_83_2 = arg_83_2 or {}

	local var_83_0 = var_0_1:fetch(self:getSpiritStageCfg().level_group)

	if not var_83_0 then
		return arg_83_2
	end

	if arg_83_3 then
		if arg_83_3[var_83_0.upgrade_type .. "_" .. var_83_0.upgrade_value] then
			arg_83_2[arg_83_3[var_83_0.upgrade_type .. "_" .. var_83_0.upgrade_value]].size = arg_83_2[arg_83_3[var_83_0.upgrade_type .. "_" .. var_83_0.upgrade_value]].size + var_83_0.upgrade_num
		else
			table.insert(arg_83_2, {
				type = var_83_0.upgrade_type,
				value = var_83_0.upgrade_value,
				size = var_83_0.upgrade_size
			})

			arg_83_3[var_83_0.upgrade_type .. "_" .. var_83_0.upgrade_value] = #arg_83_2
		end
	else
		table.insert(arg_83_2, {
			type = var_83_0.upgrade_type,
			value = var_83_0.upgrade_value,
			size = var_83_0.upgrade_size
		})
	end

	return arg_83_2
end

function ArtifactStruct:isEnoughStageLevelUp(arg_84_1, arg_84_2, arg_84_3)
	for iter_84_0, iter_84_1 in ipairs(self:getSpiritLevelUpCost(arg_84_1, arg_84_2, arg_84_3) or {}) do
		if g.core.model.User.bagData:getOwnNum(iter_84_1.type, iter_84_1.value) < iter_84_1.size then
			return false, iter_84_1
		end
	end

	return true
end

function ArtifactStruct:isEnoughStageUp()
	local var_85_0 = self:getStageUpCost()

	if g.core.model.User.bagData:getOwnNum(var_85_0.type, var_85_0.value) >= var_85_0.size then
		return true
	else
		return false, var_85_0
	end
end

function ArtifactStruct:getSpiritAdjointSkill(arg_86_1)
	if self._spiritCfgMap[arg_86_1 or self._spiritStage] then
		return self._spiritCfgMap[arg_86_1 or self._spiritStage].adjoint_skill_1
	end

	return 0
end

function ArtifactStruct:getAllAdjointSkill()
	local var_87_0 = {}

	for iter_87_0 = 0, self._maxSpiritStage do
		local var_87_1 = self:getSpiritAdjointSkill(iter_87_0)

		if var_87_1 > 0 then
			table.insert(var_87_0, {
				skillId = var_87_1,
				stage = iter_87_0
			})
		end
	end

	return var_87_0
end

function ArtifactStruct:getFirstActiveAdjointSkill()
	for iter_88_0 = 0, self._maxSpiritStage do
		local var_88_0 = self:getSpiritAdjointSkill(iter_88_0)

		if var_88_0 > 0 then
			return var_88_0
		end
	end
end

function ArtifactStruct:getFirstActiveAdjointStage()
	for iter_89_0 = 0, self._maxSpiritStage do
		if self:getSpiritAdjointSkill(iter_89_0) > 0 then
			return iter_89_0
		end
	end
end

function ArtifactStruct:getSpiritAdjointSkillIcon(arg_90_1)
	local var_90_0 = self:getSpiritAdjointSkill(arg_90_1)

	if var_90_0 > 0 then
		return g.core.config.skill_info.get(g.core.config.passive_skill_info.get(var_90_0).passive_skill_value).icon
	end

	return 0
end

function ArtifactStruct:getSpiritFullTalentSkill()
	local var_91_0 = {}

	for iter_91_0 = 1, self._maxSpiritStage do
		if self._spiritCfgMap[iter_91_0] then
			local var_91_1 = {}

			while var_0_2.hasKey("talent_skill_" .. 1) do
				if self._spiritCfgMap[iter_91_0]["talent_skill_" .. 1] > 0 then
					table.insert(var_91_1, self._spiritCfgMap[iter_91_0]["talent_skill_" .. 1])
				end
			end

			table.insert(var_91_0, {
				stage = iter_91_0,
				skills = var_91_1
			})
		end
	end

	return var_91_0
end

function ArtifactStruct:getSpiritStageTalent(arg_92_1)
	local var_92_0 = {}

	if self._spiritCfgMap[arg_92_1] then
		while var_0_2.hasKey("talent_skill_" .. 1) do
			if self._spiritCfgMap[arg_92_1]["talent_skill_" .. 1] > 0 then
				table.insert(var_92_0, self._spiritCfgMap[arg_92_1]["talent_skill_" .. 1])
			end
		end
	end

	return var_92_0
end

function ArtifactStruct:getSpiritLevelAttrs(arg_93_1)
	local var_93_0 = {}
	local var_93_1 = {}

	arg_93_1 = arg_93_1 or self._spiritLv

	local var_93_2 = var_0_1.fetch(arg_93_1, self:getSpiritStageCfg().level_group)
	local var_93_3 = 1

	while var_0_1.hasKey("affect_type_" .. var_93_3) do
		if var_93_2["affect_value_" .. var_93_3] > 0 then
			var_93_1[var_93_2["affect_type_" .. var_93_3]] = {
				type = var_93_2["affect_type_" .. var_93_3],
				value = var_93_2["affect_value_" .. var_93_3]
			}
		end

		var_93_3 = var_93_3 + 1
	end

	local var_93_4 = var_0_1.fetch(arg_93_1 + 1, self:getSpiritStageCfg().level_group)

	if var_93_4 then
		for iter_93_0 = 1, var_93_3 - 1 do
			if var_93_4["affect_value_" .. iter_93_0] > 0 then
				local var_93_6 = {}

				var_93_6.attrs = var_93_1[var_93_4["affect_type_" .. iter_93_0]] or {
					value = 0,
					type = var_93_4["affect_type_" .. iter_93_0]
				}
				var_93_6.nextValue = var_93_4["affect_value_" .. iter_93_0]

				table.insert(var_93_0, var_93_6)
			end
		end
	else
		for iter_93_1, iter_93_2 in pairs(var_93_1) do
			table.insert(var_93_0, {
				attrs = iter_93_2
			})
		end
	end

	return var_93_0
end

function ArtifactStruct:getSpiritStageAttrs()
	local var_94_0 = {}
	local var_94_1 = {}
	local var_94_2 = 1

	while var_0_2.hasKey("affect_type_" .. var_94_2) do
		if self._spiritCfgMap[self._spiritStage]["affect_value_" .. var_94_2] > 0 then
			var_94_1[self._spiritCfgMap[self._spiritStage]["affect_type_" .. var_94_2]] = {
				type = self._spiritCfgMap[self._spiritStage]["affect_type_" .. var_94_2],
				value = self._spiritCfgMap[self._spiritStage]["affect_value_" .. var_94_2]
			}
		end

		var_94_2 = var_94_2 + 1
	end

	local var_94_3 = self._spiritCfgMap[self._spiritStage + 1]

	if self._spiritCfgMap[self._spiritStage + 1] then
		for iter_94_0 = 1, var_94_2 - 1 do
			if var_94_3["affect_value_" .. iter_94_0] > 0 then
				local var_94_5 = {}

				var_94_5.attrs = var_94_1[var_94_3["affect_type_" .. iter_94_0]] or {
					value = 0,
					type = var_94_3["affect_type_" .. iter_94_0]
				}
				var_94_5.nextValue = var_94_3["affect_value_" .. iter_94_0]

				table.insert(var_94_0, var_94_5)
			end
		end
	else
		for iter_94_1, iter_94_2 in pairs(var_94_1) do
			table.insert(var_94_0, {
				attrs = iter_94_2
			})
		end
	end

	return var_94_0
end

function ArtifactStruct:getSpiritLvUpStageAttrs()
	local var_95_0 = {
		{
			name = g.core.lang:get(205551),
			attr1 = g.core.lang:get(205552, {
				level = self:getSpiritStageMaxLevel(self:getSpiritStage() - 1)
			}),
			attr2 = g.core.lang:get(205552, {
				level = self:getSpiritStageMaxLevel(self:getSpiritStage())
			})
		}
	}

	for iter_95_0, iter_95_1 in ipairs((self:getTalentAttrChanged(self:getSpiritStageTalent(self:getSpiritStage() - 1), (self:getSpiritStageTalent(self:getSpiritStage()))))) do
		local var_95_1, var_95_2 = g.core.lang:getAttr(iter_95_1.type, iter_95_1.oldValue, true)
		local var_95_3, var_95_4 = g.core.lang:getAttr(iter_95_1.type, iter_95_1.value, true)

		table.insert(var_95_0, {
			name = var_95_1,
			attr1 = var_95_2,
			attr2 = var_95_4
		})
	end

	return var_95_0
end

function ArtifactStruct:getTalentAttrChanged(arg_96_1, arg_96_2)
	local var_96_0 = {}
	local var_96_1 = {}

	for iter_96_0, iter_96_1 in ipairs(arg_96_2) do
		local var_96_2 = g.core.config.talent_skill_info.get(iter_96_1)

		for iter_96_2 = 1, 3 do
			if var_96_2["affect_type_" .. iter_96_2] > 0 then
				var_96_1[var_96_2["affect_type_" .. iter_96_2]] = var_96_1[var_96_2["affect_type_" .. iter_96_2]] or 0
				var_96_1[var_96_2["affect_type_" .. iter_96_2]] = var_96_1[var_96_2["affect_type_" .. iter_96_2]] + var_96_2["affect_value_" .. iter_96_2]
			end
		end
	end

	local var_96_3 = {}

	for iter_96_3, iter_96_4 in ipairs(arg_96_1) do
		local var_96_4 = g.core.config.talent_skill_info.get(iter_96_4)

		for iter_96_5 = 1, 3 do
			if var_96_4["affect_type_" .. iter_96_5] > 0 and var_96_1[var_96_4["affect_type_" .. iter_96_5]] then
				var_96_1[var_96_4["affect_type_" .. iter_96_5]] = var_96_1[var_96_4["affect_type_" .. iter_96_5]] - var_96_4["affect_value_" .. iter_96_5]
				var_96_3[var_96_4["affect_type_" .. iter_96_5]] = var_96_4["affect_value_" .. iter_96_5]
			end
		end
	end

	for iter_96_6, iter_96_7 in pairs(var_96_1) do
		local var_96_6 = iter_96_7 + (var_96_3[iter_96_6] or 0)
		local var_96_7 = var_96_3[iter_96_6] or 0

		table.insert(var_96_0, {
			type = iter_96_6,
			value = var_96_6,
			oldValue = var_96_7
		})
	end

	return var_96_0
end

function ArtifactStruct:getBreakUpTalentSkill()
	local var_97_0 = {}

	for iter_97_0 = 0, #self._allStarCfg do
		if self._allStarCfg[iter_97_0] then
			local var_97_1 = {}

			for iter_97_1 = 1, 5 do
				if self._allStarCfg[iter_97_0]["talent_skill_" .. iter_97_1] > 0 then
					table.insert(var_97_1, self._allStarCfg[iter_97_0]["talent_skill_" .. iter_97_1])
				end
			end

			table.insert(var_97_0, {
				star = iter_97_0,
				skills = var_97_1
			})
		end
	end

	return var_97_0
end

function ArtifactStruct:getStarCfg(arg_98_1)
	return self._allStarCfg[arg_98_1]
end

function ArtifactStruct:getBreakUpTalent(arg_99_1)
	local var_99_0 = {}

	if self._allStarCfg[arg_99_1] then
		for iter_99_0 = 1, 5 do
			if self._allStarCfg[arg_99_1]["talent_skill_" .. iter_99_0] > 0 then
				table.insert(var_99_0, self._allStarCfg[arg_99_1]["talent_skill_" .. iter_99_0])
			end
		end
	end

	return var_99_0
end

function ArtifactStruct:isStageUpSpiritSkillChange()
	local var_100_0 = self:getSpiritStageCfg()

	if var_100_0.skill_stars ~= -1 and var_100_0.skill_stars ~= self:getSpiritStageCfg(self._spiritStage + 1).skill_stars then
		return true
	end

	return false
end

function ArtifactStruct:isStageUpSpiritSkillActive()
	local var_101_0 = self:getSpiritStageCfg(self._spiritStage + 1)

	if var_101_0.skill_stars == -1 then
		return false
	end

	if self:getSpiritStageCfg().skill_stars == -1 and var_101_0.skill_stars >= 0 then
		return true
	end

	return false
end

function ArtifactStruct:isLastSpiritStageSkillChange()
	local var_102_0 = self:getSpiritStageCfg(self._spiritStage - 1)
	local var_102_1 = self:getSpiritStageCfg(self._spiritStage)

	if var_102_0.skill_stars == -1 and var_102_1.skill_stars == 0 then
		return false, true
	end

	if var_102_0.skill_stars ~= var_102_1.skill_stars then
		return var_102_0.skill_stars ~= var_102_1.skill_stars, false
	end

	return false, false
end

function ArtifactStruct:getCurSpiritSkillStar()
	return self:getSpiritStageCfg().skill_stars
end

function ArtifactStruct:isAdjointSkillActive()
	return self:getSpiritStageCfg().adjoint_skill_1 > 0
end

function ArtifactStruct:canSpiritUpgrade()
	if not self:isHasWeaponSpirit() or not self:isOwn() then
		return false
	end

	if self._spiritStage < self._maxSpiritStage then
		local var_105_0, var_105_1 = self:isEnoughStageUp()

		if var_105_0 then
			return true
		end
	end

	if self._spiritLv < self:getSpiritStageMaxLevel() then
		local var_105_2, var_105_3 = self:isEnoughStageLevelUp()

		if var_105_2 then
			return true
		end
	end

	return false
end

function ArtifactStruct:canSpiritStageUp()
	if not self:isHasWeaponSpirit() or not self:isOwn() then
		return false
	end

	if self._spiritStage < self._maxSpiritStage then
		local var_106_0, var_106_1 = self:isEnoughStageUp()

		if var_106_0 then
			return true
		end
	end

	return false
end

function ArtifactStruct:isNowSpiritStageUp()
	self._isSpiritLvUpFlag = false

	return self._isSpiritLvUpFlag
end

return ArtifactStruct
