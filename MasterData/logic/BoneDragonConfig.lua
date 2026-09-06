-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonedragon/config/BoneDragonConfig.lua

module("logic.extensions.bonedragon.config.BoneDragonConfig", package.seeall)

local BoneDragonConfig = class("BoneDragonConfig", BaseConfig)

function BoneDragonConfig:onInit()
	return
end

function BoneDragonConfig:getNames()
	return {
		"bone_dragon_clg_activity",
		"bone_dragon_clg_stage",
		"bone_dragon_clg_foramtion",
		"bone_dragon_clg_support_pet",
		"bone_dragon_clg_creeps_master",
		"bone_dragon_clg_creeps"
	}
end

function BoneDragonConfig:handleConfig(name, content)
	if name == "bone_dragon_clg_activity" then
		self._bone_dragon_clg_activity = content
	elseif name == "bone_dragon_clg_stage" then
		self._bone_dragon_clg_stage = content
	elseif name == "bone_dragon_clg_foramtion" then
		self._bone_dragon_clg_foramtion = content
	elseif name == "bone_dragon_clg_support_pet" then
		self._bone_dragon_clg_support_pet = content
	elseif name == "bone_dragon_clg_creeps_master" then
		self._bone_dragon_clg_creeps_master = content
	elseif name == "bone_dragon_clg_creeps" then
		self._bone_dragon_clg_creeps = content
	end
end

function BoneDragonConfig:getActCfg(activityId)
	return self._bone_dragon_clg_activity[activityId]
end

function BoneDragonConfig:getStageCfgs(activityId)
	return self._bone_dragon_clg_stage[activityId]
end

function BoneDragonConfig:getStageCfgByStageId(activityId, stageId)
	return self._bone_dragon_clg_stage[activityId] and self._bone_dragon_clg_stage[activityId][stageId]
end

function BoneDragonConfig:getFormationCfgByPlanId(activityId, formationPlanId)
	return self._bone_dragon_clg_foramtion[activityId] and self._bone_dragon_clg_foramtion[formationPlanId]
end

function BoneDragonConfig:getSupportCfg(creepsId)
	return self._bone_dragon_clg_support_pet[creepsId]
end

function BoneDragonConfig:getMasterCfg(creepMasterId)
	return self._bone_dragon_clg_creeps_master[creepMasterId]
end

function BoneDragonConfig:getCreepsCfg(creepMasterId)
	return self._bone_dragon_clg_creeps[creepMasterId]
end

function BoneDragonConfig:getFormationPosDicByStageId(activityId, stageId, formationId)
	local stageCfg = self:getStageCfgByStageId(activityId, stageId)
	local formationPlanId = stageCfg.formationPlanId

	if self._bone_dragon_clg_foramtion[activityId] then
		local formationCfgs = self._bone_dragon_clg_foramtion[activityId][formationPlanId]
		local formationCfg = formationCfgs and formationCfgs[formationId]
		local formationDic = {}

		if formationCfg then
			local positionLimit = formationCfg.positionLimit
			local posArr = string.split(positionLimit, "_")

			for i, posStr in ipairs(posArr) do
				local arr = string.split(posStr, "#")
				local pos = checknumber(arr[1])

				formationDic[pos] = arr[2]
			end
		end

		return formationDic
	end
end

function BoneDragonConfig:getSummonPosList(activityId, stageId, formationId)
	local summonPosList = {}
	local formationPosList = {}
	local formationDic = self:getFormationPosDicByStageId(activityId, stageId, formationId)

	for posIdx, v in pairs(formationDic) do
		table.insert(formationPosList, posIdx)
	end

	for i = 1, BoneDragonModel.FORMATION_POS_NUM do
		if not table.indexof(formationPosList, i) then
			table.insert(summonPosList, i)
		end
	end

	return summonPosList
end

function BoneDragonConfig:getFirstChoosePosId(activityId, stageId)
	local posLimitDic = self:getFormationPosDicByStageId(activityId, stageId)

	for i = 1, BoneDragonModel.FORMATION_POS_NUM do
		if posLimitDic[i] then
			return i
		end
	end
end

function BoneDragonConfig:getRecommendJobCfgDic(activityId)
	local actCfg = self._bone_dragon_clg_activity[activityId]
	local recommendStr = actCfg.recommendJob
	local recommendDic = {}

	for k, jobStr in ipairs(recommendStr) do
		local arr = string.split(jobStr, "#")
		local jobName = arr[2]
		local recommendNum = arr[1]

		recommendDic[jobName] = checknumber(recommendNum)
	end

	return recommendDic
end

function BoneDragonConfig:getFormationNum(activityId, stageId)
	local stageCfg = self:getStageCfgByStageId(activityId, stageId)

	if self._bone_dragon_clg_foramtion[activityId] then
		return (self._bone_dragon_clg_foramtion[activityId] or nil) and #self._bone_dragon_clg_foramtion[activityId]
	end
end

function BoneDragonConfig:getSupportPetIdList()
	local supportCfg = self._bone_dragon_clg_support_pet
	local petIdList = {}

	for creepsId, cfg in pairs(supportCfg) do
		table.insert(petIdList, creepsId)
	end

	return petIdList
end

function BoneDragonConfig:getCreepsMasterId(activityId, stageId)
	local stageCfg = self:getStageCfgByStageId(activityId, stageId)

	return stageCfg.creepsMasterId
end

BoneDragonConfig.instance = BoneDragonConfig.New()

return BoneDragonConfig
