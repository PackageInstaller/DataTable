-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/config/CantonOperaRoadConfig.lua

module("logic.extensions.cantonoperaroad.config.CantonOperaRoadConfig", package.seeall)

local CantonOperaRoadConfig = class("CantonOperaRoadConfig", BaseConfig)

function CantonOperaRoadConfig:onInit()
	CantonOperaRoadConfig.super.onInit(self)
end

function CantonOperaRoadConfig:getNames()
	return {
		"canton_opera_road_common",
		"canton_opera_road_activity",
		"canton_opera_road_model",
		"canton_opera_road_answer",
		"canton_opera_road_answer_prize",
		"canton_opera_road_jigsaw",
		"canton_opera_road_jigsaw_piece",
		"canton_opera_road_jigsaw_challenge",
		"canton_opera_road_boss_challenge",
		"canton_opera_road_boss_prize",
		"canton_opera_road_help_pet",
		"canton_opera_road_enemy",
		"canton_opera_road_creeps"
	}
end

function CantonOperaRoadConfig:handleConfig(name, content)
	if name == "canton_opera_road_common" then
		self._corCommonCfg = content
	elseif name == "canton_opera_road_activity" then
		self._corActCfg = content
	elseif name == "canton_opera_road_model" then
		self._corModelCfgs = content
	elseif name == "canton_opera_road_answer" then
		self._corAnswerCfg = content
	elseif name == "canton_opera_road_answer_prize" then
		self._corAnswerPrizeCfg = content
	elseif name == "canton_opera_road_jigsaw" then
		self._corJigsawCfgs = content
	elseif name == "canton_opera_road_jigsaw_piece" then
		self._corJigsawPieceCfgs = content

		self:_handleJigsawDataListPool(content)
	elseif name == "canton_opera_road_jigsaw_challenge" then
		self._corJigsawChallengeCfgs = content
	elseif name == "canton_opera_road_boss_challenge" then
		self._corBossChallengeCfgs = content
	elseif name == "canton_opera_road_boss_prize" then
		self._corBossPrizeCfgs = content

		self:_handleCorBossPrizeDataList(content)
	elseif name == "canton_opera_road_help_pet" then
		self._corHelpPetCfg = content
	elseif name == "canton_opera_road_enemy" then
		self._corEnemyCfg = content
	elseif name == "canton_opera_road_creeps" then
		self._corCreepsCfgs = content
	end
end

function CantonOperaRoadConfig:getCorCommonValue(key)
	return self._corCommonCfg[key] and self._corCommonCfg[key].value
end

function CantonOperaRoadConfig:getCorSTORYIDAsBOSS()
	return checknumber(self:getCorCommonValue("BOSS_STORYID"))
end

function CantonOperaRoadConfig:getCorActData(activityId)
	return self._corActCfg[activityId]
end

function CantonOperaRoadConfig:getCorModelCfg(planId)
	return self._corModelCfgs[planId]
end

function CantonOperaRoadConfig:getCorModelData(planId, modelId)
	return self._corModelCfgs[planId][modelId]
end

function CantonOperaRoadConfig:getCorModelCfgById(activityId)
	local actData = self:getCorActData(activityId)

	return self._corModelCfgs[actData.planId]
end

function CantonOperaRoadConfig:getCorModelDataById(activityId, modelId)
	return self:getCorModelCfgById(activityId)[modelId]
end

function CantonOperaRoadConfig:getCorAnswerData(planId)
	return self._corAnswerCfg[planId]
end

function CantonOperaRoadConfig:getCorAnswerDataById(activityId)
	local actData = self:getCorActData(activityId) or {}

	return self._corAnswerCfg[actData.planId]
end

function CantonOperaRoadConfig:getCorAnswerPrizeCfg(planId)
	return self._corAnswerPrizeCfg[planId]
end

function CantonOperaRoadConfig:getCorAnswerPrizeData(planId, answerPrizeId)
	return self._corAnswerPrizeCfg[planId][answerPrizeId]
end

function CantonOperaRoadConfig:getCorAnswerPrizeCfgById(activityId)
	local actData = self:getCorActData(activityId)

	return self._corAnswerPrizeCfg[actData.planId]
end

function CantonOperaRoadConfig:getCorAnswerPrizeDataById(activityId, answerPrizeId)
	return self:getCorAnswerPrizeCfgById(activityId)[answerPrizeId]
end

function CantonOperaRoadConfig:getCorJigsawCfg(planId)
	return self._corJigsawCfgs[planId]
end

function CantonOperaRoadConfig:getCorJigsawData(planId, jigsawId)
	return self._corJigsawCfgs[planId][jigsawId]
end

function CantonOperaRoadConfig:getCorJigsawCfgById(activityId)
	local actData = self:getCorActData(activityId)

	return self._corJigsawCfgs[actData.planId]
end

function CantonOperaRoadConfig:getCorJigsawDataById(activityId, jigsawId)
	return self:getCorJigsawCfgById(activityId)[jigsawId]
end

function CantonOperaRoadConfig:getCorJigsawPieceCfg(planId)
	return self._corJigsawPieceCfgs[planId]
end

function CantonOperaRoadConfig:getCorJigsawPieceData(planId, pieceId)
	return self._corJigsawPieceCfgs[planId][pieceId]
end

function CantonOperaRoadConfig:getCorJigsawPieceCfgById(activityId)
	local actData = self:getCorActData(activityId)

	return self._corJigsawPieceCfgs[actData.planId]
end

function CantonOperaRoadConfig:getCorJigsawPieceDataById(activityId, pieceId)
	return self:getCorJigsawPieceCfgById(activityId)[pieceId]
end

function CantonOperaRoadConfig:_handleJigsawDataListPool(content)
	self._jigsawPieceDataListPools = {}

	for _, data in ipairs(content.dataList) do
		if self._jigsawPieceDataListPools[data.planId] == nil then
			self._jigsawPieceDataListPools[data.planId] = {}
		end

		if self._jigsawPieceDataListPools[data.planId][data.jigsawId] == nil then
			self._jigsawPieceDataListPools[data.planId][data.jigsawId] = {}
		end

		table.insert(self._jigsawPieceDataListPools[data.planId][data.jigsawId], data)
	end
end

function CantonOperaRoadConfig:getCorJigsawPieceDataList(planId, jigsawId)
	return self._jigsawPieceDataListPools[planId][jigsawId]
end

function CantonOperaRoadConfig:getCorJigsawPieceDataListById(activityId, jigsawId)
	local actData = self:getCorActData(activityId)

	return self:getCorJigsawPieceDataList(actData.planId, jigsawId)
end

function CantonOperaRoadConfig:getCorJigsawChallengeCfg(planId)
	return self._corJigsawChallengeCfgs[planId]
end

function CantonOperaRoadConfig:getCorJigsawChallengeData(planId, stageId)
	return self._corJigsawChallengeCfgs[planId][stageId]
end

function CantonOperaRoadConfig:getCorJigsawChallengeCfgById(activityId)
	local actData = self:getCorActData(activityId)

	return self._corJigsawChallengeCfgs[actData.planId]
end

function CantonOperaRoadConfig:getCorJigsawChallengeDataById(activityId, stageId)
	return self:getCorJigsawChallengeCfgById(activityId)[stageId]
end

function CantonOperaRoadConfig:getCorBossChallengeCfg(planId)
	return self._corBossChallengeCfgs[planId]
end

function CantonOperaRoadConfig:getCorBossChallengeData(planId, times)
	return self._corBossChallengeCfgs[planId][times]
end

function CantonOperaRoadConfig:getCorBossChallengeCfgById(activityId)
	local actData = self:getCorActData(activityId)

	return self._corBossChallengeCfgs[actData.planId]
end

function CantonOperaRoadConfig:getCorBossChallengeDataById(activityId, times)
	return self:getCorBossChallengeCfgById(activityId)[times]
end

function CantonOperaRoadConfig:getCorBossPrizeCfg(planId)
	return self._corBossPrizeCfgs[planId]
end

function CantonOperaRoadConfig:getCorBossPrizeData(planId, processorSection)
	return self._corBossPrizeCfgs[planId][processorSection]
end

function CantonOperaRoadConfig:getCorBossPrizeCfgById(activityId)
	local actData = self:getCorActData(activityId)

	return self._corBossPrizeCfgs[actData.planId]
end

function CantonOperaRoadConfig:getCorBossPrizeDataById(activityId, processorSection)
	return self:getCorBossPrizeCfgById(activityId)[processorSection]
end

function CantonOperaRoadConfig:getCorBossPrizeDataList(planId)
	return self._dataListPoolAsBossPrize[planId]
end

function CantonOperaRoadConfig:getCorBossPrizeDataListById(activityId)
	local actData = self:getCorActData(activityId)

	return self._dataListPoolAsBossPrize[actData.planId]
end

function CantonOperaRoadConfig:_handleCorBossPrizeDataList(content)
	self._dataListPoolAsBossPrize = {}

	for _, data in ipairs(content.dataList) do
		if self._dataListPoolAsBossPrize[data.planId] == nil then
			self._dataListPoolAsBossPrize[data.planId] = {}
		end

		table.insert(self._dataListPoolAsBossPrize[data.planId], data)
	end
end

function CantonOperaRoadConfig:getCorHelpPetCfgData(creepsId)
	return self._corHelpPetCfg[creepsId]
end

function CantonOperaRoadConfig:getCorEnemyData(creepsMasterId)
	return self._corEnemyCfg[creepsMasterId]
end

function CantonOperaRoadConfig:getCorCreepsCfg(creepsMasterId)
	return self._corCreepsCfgs[creepsMasterId]
end

function CantonOperaRoadConfig:getCorCreepsData(creepsMasterId, creepsId)
	return self._corCreepsCfgs[creepsMasterId][creepsId]
end

CantonOperaRoadConfig.instance = CantonOperaRoadConfig.New()

return CantonOperaRoadConfig
