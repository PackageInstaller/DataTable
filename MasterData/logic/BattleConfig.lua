-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/config/BattleConfig.lua

module("logic.extensions.battle.config.BattleConfig", package.seeall)

local BattleConfig = class("BattleConfig", BaseConfig)

function BattleConfig:onInit()
	BattleConfig.super.onInit(self)

	self._monsterCfg = nil
	self._skillCfg = nil
	self._buffCfg = nil
	self._skillbuffaffixCfg = nil
	self._effectCfg = nil
	self._formationCfg = nil
	self._formationUnlockCfg = nil
	self._formationPosCfg = nil
	self._skillflowAICfg = nil
	self._battleitemCfg = nil
	self._petRaceCfg = nil
	self._battleSpeedCfg = nil
	self._formStrengthCfg = nil
	self._formStrengthTriggerCfg = nil
	self._formStrengthUpgradeCfg = nil
end

function BattleConfig:getNames()
	return {
		"monster",
		"btl_skill",
		"btl_skill_affix",
		"btl_character_buff",
		"formation",
		"formation_unlock",
		"formation_pos",
		"skillflow_ai",
		"battle_item",
		"pet_race_type",
		"challenge_team",
		"buff_effect",
		"spine_effect",
		"btl_hero_skill_buff",
		"battle_speed",
		"retreat_tips",
		"form_strength",
		"form_common",
		"btl_skill_skin_effect",
		"btl_buff_skin_effect",
		"btl_combination_skill",
		"btl_skill_label",
		"btl_combination_skill_formula",
		"btl_awaken_skill_effect",
		"form_strength_trigger",
		"btl_domain_skill_level",
		"btl_source_skill_effect"
	}
end

function BattleConfig:handleConfig(name, content)
	if name == "monster" then
		self._monsterCfg = content
	elseif name == "btl_skill" then
		self._skillCfg = content
	elseif name == "btl_skill_skin_effect" then
		self._skill_skin_Cfg = content
	elseif name == "form_common" then
		self._form_common = content
	elseif name == "btl_skill_label" then
		self._btl_skill_labelCfg = content
	elseif name == "btl_character_buff" then
		self._buffCfg = content
	elseif name == "btl_skill_affix" then
		self._skillbuffaffixCfg = content
		self._skillAffBuffs = {}
		self._skillBuffIds = {}

		for k, v in pairs(content) do
			if type(k) == "number" then
				local skillId = v.skillId

				self._skillAffBuffs[v.buffId] = v.skillId

				local buff = self._skillBuffIds[skillId]

				if not buff then
					buff = {}
					self._skillBuffIds[skillId] = buff
				end

				table.insert(buff, v.buffId)
			end
		end
	elseif name == "formation" then
		self._formationCfg = content
	elseif name == "formation_unlock" then
		self._formationUnlockCfg = content
	elseif name == "formation_pos" then
		self._formationPosCfg = content
	elseif name == "skillflow_ai" then
		self._skillflowAICfg = content
	elseif name == "battle_item" then
		self._battleitemCfg = content
	elseif name == "pet_race_type" then
		self._petRaceCfg = content
	elseif name == "challenge_team" then
		self:_handleChallengeTeam(content)
	elseif name == "buff_effect" then
		self._buffEffects = content
	elseif name == "spine_effect" then
		self._spineEffects = content
	elseif name == "btl_hero_skill_buff" then
		self._heroSkillsBuff = {}

		for k, v in pairs(content) do
			if type(k) == "number" then
				local skillId = v.heroSkillId
				local buffs = self._heroSkillsBuff[skillId]

				if not buffs then
					buffs = {}
					self._heroSkillsBuff[skillId] = buffs
				end

				table.insert(buffs, v)
			end
		end
	elseif name == "battle_speed" then
		self._battleSpeedCfg = content
	elseif name == "retreat_tips" then
		self._retreatTips = content
	elseif name == "form_strength" then
		self._formStrengthCfg = content
	elseif name == "form_strength_trigger" then
		self._formStrengthTriggerCfg = content
	elseif name == "btl_combination_skill" then
		self.btl_combination_skillCfg = content
	elseif name == "btl_combination_skill_formula" then
		self.btl_combination_skill_formulaCfg = content
	elseif name == "btl_domain_skill_level" then
		self._domainSkillLevelCfg = content
	elseif name == "btl_buff_skin_effect" then
		self._buffEffPlans = content
	elseif name == "btl_awaken_skill_effect" then
		self._btl_awaken_skill_effect = content
	elseif name == "btl_source_skill_effect" then
		self._btl_source_skill_effect = content
	end
end

function BattleConfig:getCombinionSkillformulaCfg(skillId)
	local arr = self.btl_combination_skill_formulaCfg[skillId]

	if arr then
		local list = {}

		for k, v in pairs(arr) do
			table.insert(list, v)
		end

		ArraySort.sortOn(list, {
			"priority",
			"formulaId"
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})

		return list
	end
end

function BattleConfig:getFormCommon(key)
	if self._form_common[key] then
		return self._form_common[key].value
	end
end

function BattleConfig:getCombinionSkillCfg(skillId)
	return self.btl_combination_skillCfg[skillId]
end

function BattleConfig:getCombinionSkillformulaCo(skillId, formulaId)
	return self.btl_combination_skill_formulaCfg[skillId][formulaId]
end

function BattleConfig:_handleChallengeTeam(content)
	self._challengeTeam = {}

	for k, v in pairs(content) do
		if type(k) == "number" then
			local cs = self._challengeTeam[v.challengeId]

			if not cs then
				cs = {}
				self._challengeTeam[v.challengeId] = cs
			end

			local ps = cs[v.phaseId]

			if not ps then
				ps = {}
				cs[v.phaseId] = ps
			end

			ps[v.branchId] = ps[v.branchId] or {}

			table.insert(ps[v.branchId], v)
		end
	end

	for k, v in pairs(self._challengeTeam) do
		for k1, v1 in pairs(v) do
			for k2, v2 in pairs(v1) do
				table.sort(v2, function(x, y)
					if x == y then
						return false
					end

					if x.incId < y.incId then
						return true
					end

					if x.incId > y.incId then
						return false
					end

					return false
				end)
			end
		end
	end
end

function BattleConfig:getDomainSkillLevels(skillId)
	return self._domainSkillLevelCfg[skillId]
end

function BattleConfig:getDomainSkillLevelCo(skillId, skillLv)
	if self._domainSkillLevelCfg[skillId] then
		return self._domainSkillLevelCfg[skillId][skillLv]
	end
end

function BattleConfig:getBuffsBySkillId(skillId)
	return self._skillBuffIds[skillId]
end

function BattleConfig:getBuffSkillId(buffId)
	return self._skillAffBuffs[buffId]
end

function BattleConfig:getSpineEffCo(id)
	return self._spineEffects[id]
end

function BattleConfig:getBuffEffCo(id)
	return self._buffEffects[id]
end

function BattleConfig:getBuffEffPlanCo(buffId, skinId)
	if not self._buffEffPlans or not self._buffEffPlans[buffId] then
		return
	end

	return self._buffEffPlans[buffId][skinId]
end

function BattleConfig:getAwakenSkillConfig(skillId)
	return self._btl_awaken_skill_effect[skillId]
end

function BattleConfig:getSkillflowCo()
	return self._skillflowAICfg.behaviorConfigData
end

function BattleConfig:getMonsterCo(battleId, posId)
	local obj = self._monsterCfg[battleId]

	if obj then
		return obj[posId]
	end

	return nil
end

function BattleConfig:getFormationCo(formationId)
	return self._formationCfg[formationId]
end

function BattleConfig:getFormationPosKVList(formationId)
	self._formationPosKVList = self._formationKV or {}

	local list = self._formationPosKVList[formationId]

	if not list then
		list = {}

		local cfg = self._formationCfg[formationId]

		if cfg then
			for _, v in pairs(cfg.posList) do
				list[v] = true
			end
		else
			for i = 1, 9 do
				list[i] = true
			end
		end

		self._formationPosKVList[formationId] = list
	end

	return list
end

function BattleConfig:getFormationUnlockCfg(formationId)
	return self._formationUnlockCfg[formationId]
end

function BattleConfig:getFormationPos(camp, posId)
	local obj = self._formationPosCfg[camp]

	if obj then
		return obj[posId].pos
	end

	return nil
end

function BattleConfig:getSkillCo(id, skinId)
	if checknumber(skinId) > 0 and self._skill_skin_Cfg[id] and self._skill_skin_Cfg[id][skinId] then
		return self._skill_skin_Cfg[id][skinId]
	end

	return self._skillCfg[id]
end

function BattleConfig:getSkillLabel(id)
	return self._btl_skill_labelCfg[id]
end

function BattleConfig:getSkillLabelList()
	return self._btl_skill_labelCfg.dataList
end

function BattleConfig:getBuffCo(id)
	return self._buffCfg[id]
end

function BattleConfig:getSkillBuffAffixCo(id)
	return self._skillbuffaffixCfg[id].buffs.buffs
end

function BattleConfig:getBattleItem(id)
	return self._battleitemCfg[id]
end

function BattleConfig:getBattleItems()
	return self._battleitemCfg
end

function BattleConfig:getPetRace()
	return self._petRaceCfg
end

function BattleConfig:getPetRaceRestrain(frontStr, backStr)
	local frontNum = GameEnum.Races[frontStr]
	local backNum = GameEnum.Races[backStr]

	if self._petRaceCfg[frontNum] and self._petRaceCfg[frontNum]["attr" .. backNum] then
		return self._petRaceCfg[frontNum]["attr" .. backNum]
	end

	return 1
end

function BattleConfig:getPetRaceRestrainById(frontAttrIdx, backAttrIdx)
	if self._petRaceCfg[frontAttrIdx] and self._petRaceCfg[frontAttrIdx]["attr" .. backAttrIdx] then
		return self._petRaceCfg[frontAttrIdx]["attr" .. backAttrIdx]
	end

	return 1
end

function BattleConfig:getSkillAnimTake(skillId, skinId)
	local skillCo = self._skillCfg[skillId]

	if not skillCo then
		return
	end

	local atlTakeId = skillCo.atlTakeId
	local atlTakeIdEx = skillCo.atlTakeIdEx

	if checknumber(skinId) > 0 and self._skill_skin_Cfg[skillId] and self._skill_skin_Cfg[skillId][skinId] then
		local cfg = self._skill_skin_Cfg[skillId][skinId]

		atlTakeId = cfg.atlTakeId
		atlTakeIdEx = cfg.atlTakeIdEx
	end

	local take, takeFemale = {}, {}
	local attackCount = skillCo.attackCount

	if atlTakeId and #atlTakeId > 0 then
		take = self:_parseTakes(atlTakeId, attackCount, skillId, skinId)
	end

	return take, (atlTakeIdEx and #atlTakeIdEx > 0 or nil) and self:_parseTakes(atlTakeIdEx, attackCount, skillId, skinId)
end

function BattleConfig:getSkillCfgBySkinId(skillId, skinId)
	if checknumber(skinId) > 0 and self._skill_skin_Cfg[skillId] and self._skill_skin_Cfg[skillId][skinId] then
		return self._skill_skin_Cfg[skillId][skinId]
	end

	return nil
end

function BattleConfig:_parseTakes(str, maxCount, skillId, skinId)
	local takes = {}

	if not string.nilorempty(str) then
		local t = string.split(str, "#")

		for i = 1, math.min(#t, maxCount) do
			table.insert(takes, GameUrl.getSkillAnimTakePath(t[i], skillId, skinId))
		end
	end

	return takes
end

function BattleConfig:getChallengeTeamId(challengeId, phaseId, branchId, idx)
	if self._challengeTeam[challengeId] and self._challengeTeam[challengeId][phaseId] then
		local branches = self._challengeTeam[challengeId][phaseId][branchId]

		if branches then
			return branches[idx].teamId
		end
	end

	return nil
end

function BattleConfig:getHeroSkillBuffs(skillId)
	if self._heroSkillsBuff then
		return self._heroSkillsBuff[skillId]
	end
end

function BattleConfig:getBattleSpeedByRoundNumber(id)
	return self._battleSpeedCfg[id]
end

function BattleConfig:getRetreatTips(id)
	local cfg = self._retreatTips[id]

	return cfg.text
end

function BattleConfig:getFormStrengthMaxLv(formationId)
	if formationId and self._formStrengthCfg[formationId] then
		return #self._formStrengthCfg[formationId]
	else
		return 0
	end
end

function BattleConfig:getFormStrengthLvCfg(formationId, lv)
	if self._formStrengthCfg[formationId] then
		return self._formStrengthCfg[formationId][lv]
	end
end

function BattleConfig:getFormStrengthTriggerCfgs()
	return self._formStrengthTriggerCfg
end

function BattleConfig:getFormStrengthTriggerCfgByStateId(stateId)
	if self._formStrengthTriggerCfg then
		return self._formStrengthTriggerCfg[stateId]
	end
end

BattleConfig.instance = BattleConfig.New()

return BattleConfig
