-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/config/AoQiAttackForceConfig.lua

module("logic.extensions.aoqiattackforce.config.AoQiAttackForceConfig", package.seeall)

local AoQiAttackForceConfig = class("AoQiAttackForceConfig", BaseConfig)

function AoQiAttackForceConfig:getNames()
	return {
		"ao_qi_attack_force_rank_prize",
		"ao_qi_attack_force_activity",
		"ao_qi_attack_force_buff_ingame",
		"ao_qi_attack_force_bullet_ingame",
		"ao_qi_attack_force_challenge",
		"ao_qi_attack_force_challenge_prize",
		"ao_qi_attack_force_equipment",
		"ao_qi_attack_force_equipment_ingame",
		"ao_qi_attack_force_equipment_upgrade",
		"ao_qi_attack_force_final_challenge",
		"ao_qi_attack_force_img_rules",
		"ao_qi_attack_force_monster_plan_ingame",
		"ao_qi_attack_force_shape_define",
		"ao_qi_attack_force_store_plan_ingame",
		"ao_qi_attack_force_buff_plan_ingame",
		"ao_qi_attack_force_model",
		"ao_qi_attack_force_buff",
		"ao_qi_attack_force_hero_challenge_info",
		"ao_qi_attack_force_hero_challenge",
		"ao_qi_attack_force_hero_challenge_lottery",
		"ao_qi_attack_force_hero_rank_prize"
	}
end

function AoQiAttackForceConfig:handleConfig(name, content)
	if name == "ao_qi_attack_force_rank_prize" then
		self._ao_qi_attack_force_rank_prize = content
	elseif name == "ao_qi_attack_force_activity" then
		self._ao_qi_attack_force_activity = content
	elseif name == "ao_qi_attack_force_buff_ingame" then
		self._ao_qi_attack_force_buff_ingame = content
	elseif name == "ao_qi_attack_force_bullet_ingame" then
		self._ao_qi_attack_force_bullet_ingame = content
	elseif name == "ao_qi_attack_force_challenge" then
		self._ao_qi_attack_force_challenge = content
	elseif name == "ao_qi_attack_force_challenge_prize" then
		self._ao_qi_attack_force_challenge_prize = content
	elseif name == "ao_qi_attack_force_equipment" then
		self._ao_qi_attack_force_equipment = content
	elseif name == "ao_qi_attack_force_equipment_ingame" then
		self._ao_qi_attack_force_equipment_ingame = content
	elseif name == "ao_qi_attack_force_equipment_upgrade" then
		self._ao_qi_attack_force_equipment_upgrade = content
	elseif name == "ao_qi_attack_force_final_challenge" then
		self._ao_qi_attack_force_final_challenge = content
	elseif name == "ao_qi_attack_force_img_rules" then
		self._ao_qi_attack_force_img_rules = content
	elseif name == "ao_qi_attack_force_monster_plan_ingame" then
		self._ao_qi_attack_force_monster_plan_ingame = content
	elseif name == "ao_qi_attack_force_shape_define" then
		self._ao_qi_attack_force_shape_define = content
	elseif name == "ao_qi_attack_force_store_plan_ingame" then
		self._ao_qi_attack_force_store_plan_ingame = content
	elseif name == "ao_qi_attack_force_buff_plan_ingame" then
		self._ao_qi_attack_force_buff_plan_ingame = content
	elseif name == "ao_qi_attack_force_model" then
		self._ao_qi_attack_force_model = content
	elseif name == "ao_qi_attack_force_buff" then
		self._ao_qi_attack_force_buff = content
	elseif name == "ao_qi_attack_force_hero_challenge_info" then
		self._ao_qi_attack_force_hero_challenge_info = content
	elseif name == "ao_qi_attack_force_hero_challenge" then
		self._ao_qi_attack_force_hero_challenge = content
	elseif name == "ao_qi_attack_force_hero_challenge_lottery" then
		self._ao_qi_attack_force_hero_challenge_lottery = content
	elseif name == "ao_qi_attack_force_hero_rank_prize" then
		self._ao_qi_attack_force_hero_rank_prize = content
	end
end

function AoQiAttackForceConfig:getActivityCfg(actId)
	return self._ao_qi_attack_force_activity[actId]
end

function AoQiAttackForceConfig:getImgRuleCfgs(actId)
	return self._ao_qi_attack_force_img_rules[actId]
end

function AoQiAttackForceConfig:getFinalChallengeCfg(actId)
	return self._ao_qi_attack_force_final_challenge[actId]
end

function AoQiAttackForceConfig:getRankCfgByRank(actId, rank)
	if not self._ao_qi_attack_force_rank_prize[actId] then
		for range, cfg in pairs(self._ao_qi_attack_force_rank_prize[actId]) do
			if rank >= range[1] and rank <= range[2] then
				return cfg
			end
		end
	end
end

function AoQiAttackForceConfig:getEquipmentUpgradeCfgByLv(activityId, equipmentId, lv)
	return self._ao_qi_attack_force_equipment_upgrade[activityId][equipmentId][lv]
end

function AoQiAttackForceConfig:getEquipmentUpgradeCfgs(activityId, equipmentId)
	return self._ao_qi_attack_force_equipment_upgrade[activityId][equipmentId]
end

function AoQiAttackForceConfig:getChallengeCfg(activityId, challengeId)
	return self._ao_qi_attack_force_challenge[activityId][challengeId]
end

function AoQiAttackForceConfig:getBulletCfg(bulletId)
	return self._ao_qi_attack_force_bullet_ingame[bulletId]
end

function AoQiAttackForceConfig:getChallengeWaveCfg(activityId, challengeId, waveId)
	return self._ao_qi_attack_force_challenge_prize[activityId][challengeId][waveId]
end

function AoQiAttackForceConfig:getChallengeWaveTotalNums(activityId, challengeId)
	local cfgs = self._ao_qi_attack_force_challenge_prize[activityId][challengeId]

	return #cfgs
end

function AoQiAttackForceConfig:getMonsterPlanInGameCfg(planId)
	return self._ao_qi_attack_force_monster_plan_ingame[planId]
end

function AoQiAttackForceConfig:getEquipmentCfg(activityId, equipmentId)
	return self._ao_qi_attack_force_equipment[activityId][equipmentId]
end

function AoQiAttackForceConfig:getEquipmentIdByIdInGame(activityId, equipmentIdInGame)
	if not self._ao_qi_attack_force_equipment[activityId] then
		for _, cfg in pairs(self._ao_qi_attack_force_equipment[activityId]) do
			if cfg.equipmentInGameId == equipmentIdInGame then
				return cfg.equipmentId
			end
		end

		return 0
	end
end

function AoQiAttackForceConfig:getEquipmentCfgs(activityId)
	return self._ao_qi_attack_force_equipment[activityId]
end

function AoQiAttackForceConfig:getEquipmentInGameCfg(equipmentId, starLv)
	return self._ao_qi_attack_force_equipment_ingame[equipmentId][starLv]
end

function AoQiAttackForceConfig:getBuffCfgInGameCfg(buffId)
	return self._ao_qi_attack_force_buff_ingame[buffId]
end

function AoQiAttackForceConfig:getBuffPlanInGameCfg(planId)
	return self._ao_qi_attack_force_buff_plan_ingame[planId]
end

function AoQiAttackForceConfig:getTiliIconPath(activityId)
	local cfg = self:getActivityCfg(activityId)

	return cfg and cfg.tiliIconPath
end

function AoQiAttackForceConfig:getCoinIconPath(activityId)
	local cfg = self:getActivityCfg(activityId)

	return cfg and cfg.coinIconPath
end

function AoQiAttackForceConfig:getEquipmentInGameIconPath(equipmentId)
	local equipmentInGameCfg = self:getEquipmentInGameCfg(equipmentId, 1)

	return GameUrl.getBigbgFolderUrl("aqafweapon", equipmentInGameCfg.iconPath)
end

function AoQiAttackForceConfig:getRCListByShapeTypeID(shapeTypeID)
	local itemRCList = {}
	local cfg = self._ao_qi_attack_force_shape_define[shapeTypeID]

	if cfg then
		if not cfg.cutdownId then
			for i = 1, cfg.width do
				for j = 1, cfg.height do
					local rcId = (i - 1) * cfg.height + j

					if not table.keyof(cfg.cutdownId, rcId) then
						table.insert(itemRCList, {
							i = i,
							j = j
						})
					end
				end
			end
		end
	end

	return itemRCList
end

function AoQiAttackForceConfig:getStorePlanInGameCfg(planId)
	return self._ao_qi_attack_force_store_plan_ingame[planId]
end

function AoQiAttackForceConfig:getModelCfg(modelId)
	return self._ao_qi_attack_force_model[modelId]
end

function AoQiAttackForceConfig:getBuffCfg(buffId)
	return self._ao_qi_attack_force_buff[buffId]
end

function AoQiAttackForceConfig:getHeroChallengeInfoClg(activityId)
	return self._ao_qi_attack_force_hero_challenge_info[activityId]
end

function AoQiAttackForceConfig:getHeroChallengeWaveClg(activityId, waveId)
	if self._ao_qi_attack_force_hero_challenge[activityId] then
		return self._ao_qi_attack_force_hero_challenge[activityId][waveId]
	end
end

function AoQiAttackForceConfig:getHeroChallengeWaveTotalNums(activityId)
	local cfgs = self._ao_qi_attack_force_hero_challenge[activityId]

	return #cfgs
end

function AoQiAttackForceConfig:getHeroChallengeLotteryClgs(lotteryPlanId)
	return self._ao_qi_attack_force_hero_challenge_lottery[lotteryPlanId]
end

function AoQiAttackForceConfig:getHeroRankCfgByRank(activityId, rank)
	if not self._ao_qi_attack_force_hero_rank_prize[activityId] then
		for range, cfg in pairs(self._ao_qi_attack_force_hero_rank_prize[activityId]) do
			if rank >= range[1] and rank <= range[2] then
				return cfg
			end
		end
	end
end

AoQiAttackForceConfig.instance = AoQiAttackForceConfig.New()

return AoQiAttackForceConfig
