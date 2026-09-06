-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/controller/CantonOperaRoadController.lua

module("logic.extensions.cantonoperaroad.controller.CantonOperaRoadController", package.seeall)

local CantonOperaRoadController = class("CantonOperaRoadController", BaseController)

function CantonOperaRoadController:ctor()
	return
end

function CantonOperaRoadController:onInit()
	return
end

function CantonOperaRoadController:onReset()
	return
end

function CantonOperaRoadController:sendPM_CantonOperaRoadGetInfoReq(activityId)
	CantonOperaRoadAgent.instance:sendPM_CantonOperaRoadGetInfoReq(activityId)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadGetInfoRes(msg)
	CantonOperaRoadModel.instance:handlePM_CantonOperaRoadGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CORGetInfoRes)
end

function CantonOperaRoadController:sendPM_CantonOperaRoadAnswerInfoReq(activityId)
	CantonOperaRoadAgent.instance:sendPM_CantonOperaRoadAnswerInfoReq(activityId)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadAnswerInfoRes(msg)
	CantonOperaRoadModel.instance:handlePM_CantonOperaRoadAnswerInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CORAnswerInfoRes)
end

function CantonOperaRoadController:sendPM_CantonOperaRoadAnswerReq(activityId)
	CantonOperaRoadAgent.instance:sendPM_CantonOperaRoadAnswerReq(activityId)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadAnswerRes(status, msg)
	if status == 0 then
		CantonOperaRoadModel.instance:handlePM_CantonOperaRoadAnswerRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.CORAnswerRes, status, msg)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadAnswerSceneExitRes(msg)
	CantonOperaRoadModel.instance:handlePM_CantonOperaRoadAnswerSceneExitRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CORAnswerSceneExitRes, msg)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadAnswerPrizeNotifyRes(msg)
	CantonOperaRoadModel.instance:handlePM_CantonOperaRoadAnswerPrizeNotifyRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CORAnswerPrizeNotifyRes)
end

function CantonOperaRoadController:sendPM_CantonOperaRoadJigsawInfoReq(activityId)
	CantonOperaRoadAgent.instance:sendPM_CantonOperaRoadJigsawInfoReq(activityId)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadJigsawInfoRes(msg)
	CantonOperaRoadModel.instance:handlePM_CantonOperaRoadJigsawInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CORJigsawInfoRes)
end

function CantonOperaRoadController:sendPM_CantonOperaRoadJigsawClgReq(activityId, jigsawId, stageId, simpleForm)
	BattleFacade.instance:registerResultHandler(self._handlerBattleEndAsJigsaw, self)
	CantonOperaRoadAgent.instance:sendPM_CantonOperaRoadJigsawClgReq(activityId, jigsawId, stageId, simpleForm)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadJigsawClgRes(status, msg)
	if status == 0 then
		CantonOperaRoadModel.instance:handlePM_CantonOperaRoadJigsawClgRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	GlobalDispatcher:dispatch(GlobalNotify.CORJigsawClgRes)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadJigsawBattleEndRes(msg)
	CantonOperaRoadModel.instance:handlePM_CantonOperaRoadJigsawBattleEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CORJigsawBattleEndRes)
end

function CantonOperaRoadController:sendPM_CantonOperaRoadLightUpReq(activityId, jigsawId, pieceId)
	CantonOperaRoadAgent.instance:sendPM_CantonOperaRoadLightUpReq(activityId, jigsawId, pieceId)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadLightUpRes(msg)
	CantonOperaRoadModel.instance:handlePM_CantonOperaRoadLightUpRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CORLightUpRes, msg)
end

function CantonOperaRoadController:sendPM_CantonOperaRoadBossInfoReq(activityId)
	CantonOperaRoadAgent.instance:sendPM_CantonOperaRoadBossInfoReq(activityId)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadBossInfoRes(msg)
	CantonOperaRoadModel.instance:handlePM_CantonOperaRoadBossInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CORBossInfoRes)
end

function CantonOperaRoadController:sendPM_CantonOperaRoadBossClgReq(activityId, simpleForm)
	CantonOperaRoadAgent.instance:sendPM_CantonOperaRoadBossClgReq(activityId, simpleForm)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadBossClgRes(status, msg)
	if status == 0 then
		CantonOperaRoadModel.instance:handlePM_CantonOperaRoadBossClgRes(msg)
		BattleFacade.instance:registerResultHandler(self._handlerBattleEndAsCORBoss, self)
		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.CORBossChallenge)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	GlobalDispatcher:dispatch(GlobalNotify.CORBossClgRes)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadBossBattleEndRes(msg)
	if msg.changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end

	CantonOperaRoadModel.instance:handlePM_CantonOperaRoadBossBattleEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CORBossBattleEndRes)
end

function CantonOperaRoadController:sendPM_CantonOperaRoadBossFormReq(activityId, challengeTimes)
	CantonOperaRoadAgent.instance:sendPM_CantonOperaRoadBossFormReq(activityId, challengeTimes)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadBossFormRes(msg)
	CantonOperaRoadModel.instance:handlePM_CantonOperaRoadBossFormRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CORBossFormRes)
end

function CantonOperaRoadController:sendPM_CantonOperaRoadBossRankReq(activityId)
	CantonOperaRoadAgent.instance:sendPM_CantonOperaRoadBossRankReq(activityId)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadBossRankRes(msg)
	CantonOperaRoadModel.instance:handlePM_CantonOperaRoadBossRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CORBossRankRes)
end

function CantonOperaRoadController:sendPM_CantonOperaRoadPvGetPrizeReq(activityId)
	CantonOperaRoadAgent.instance:sendPM_CantonOperaRoadPvGetPrizeReq(activityId)
end

function CantonOperaRoadController:handlePM_CantonOperaRoadPvGetPrizeRes(msg)
	CantonOperaRoadModel.instance:handlePM_CantonOperaRoadPvGetPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CORPvGetPrizeRes)
end

function CantonOperaRoadController:isCanEnterModelAsCOR(modelId)
	local result = self:getEnterModelResultAsCOR(modelId)

	return result == GameEnum.ResultCode.Success
end

function CantonOperaRoadController:getTipsStrByEnterResultAsCOR(modelId)
	local str = ""
	local result = self:getEnterModelResultAsCOR(modelId)

	if modelId == GameEnum.ModelTypeAsCOR.SHOW then
		if result == GameEnum.ResultCode.Success then
			-- block empty
		elseif result == GameEnum.ResultCode.IsPass then
			str = "您已通关"
		elseif result == GameEnum.ResultCode.NotInTime then
			-- block empty
		elseif result == GameEnum.ResultCode.NotUnlockCond then
			str = "前置关卡未通过"
		end

		return
	end

	if result == GameEnum.ResultCode.Success then
		-- block empty
	elseif result == GameEnum.ResultCode.IsPass then
		str = "您已通关"
	elseif result == GameEnum.ResultCode.NotInTime then
		str = "不在开放时间内"
	elseif result == GameEnum.ResultCode.NotUnlockCond then
		str = "前置关卡未通过"
	end

	return str
end

function CantonOperaRoadController:getEnterModelResultAsCOR(modelId)
	local result = GameEnum.ResultCode.Success

	if modelId == GameEnum.ModelTypeAsCOR.SHOW then
		if not self:isInTimeAsCORModel(modelId) then
			result = GameEnum.ResultCode.NotInTime
		elseif not self:isUnlockConditionAsCORModel(modelId) then
			result = GameEnum.ResultCode.NotUnlockCond
		end
	elseif self:isPassAsCORModel(modelId) then
		result = GameEnum.ResultCode.IsPass
	elseif not self:isInTimeAsCORModel(modelId) then
		result = GameEnum.ResultCode.NotInTime
	elseif not self:isUnlockConditionAsCORModel(modelId) then
		result = GameEnum.ResultCode.NotUnlockCond
	end

	return result
end

function CantonOperaRoadController:isPassAsCORModel(modelId)
	return self:getTimePeriodAsCORModel(modelId) >= GameUtil.inTimePeriod and self:isEnoughProgressAsCORModel(modelId) and self:isUnlockConditionAsCORModel(modelId)
end

function CantonOperaRoadController:isPassAllEnergyModelAsCORModel()
	local isPass = true
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local modelCfg = CantonOperaRoadConfig.instance:getCorModelCfgById(activityId)

	for _, data in ipairs(modelCfg) do
		if self:getEnergyCostAsCORModel(data.modelId) > 0 and not self:isPassAsCORModel(data.modelId) then
			isPass = false

			break
		end
	end

	return isPass
end

function CantonOperaRoadController:isInTimeAsCORModel(modelId)
	return self:getTimePeriodAsCORModel(modelId) == GameUtil.inTimePeriod
end

function CantonOperaRoadController:getTimePeriodAsCORModel(modelId)
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local data = CantonOperaRoadConfig.instance:getCorModelDataById(activityId, modelId)

	data = data or {}

	return GameUtil.getTimePeriod(data.openTime, data.endTime)
end

function CantonOperaRoadController:isUnlockConditionAsCORModel(modelId)
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local data = CantonOperaRoadConfig.instance:getCorModelDataById(activityId, modelId)

	if data and data.unlockCondition > 0 then
		return self:isPassAsCORModel(data.unlockCondition)
	else
		return true
	end
end

function CantonOperaRoadController:isEnoughProgressAsCORModel(modelId)
	local curProgress = CantonOperaRoadModel.instance:getModelProgress(modelId)
	local maxProgress = self:getMaxProgressAsCORModel(modelId)

	return maxProgress <= curProgress
end

function CantonOperaRoadController:getMaxProgressAsCORModel(modelId)
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local data = CantonOperaRoadConfig.instance:getCorModelDataById(activityId, modelId)

	return data.maxProgress
end

function CantonOperaRoadController:isEnoughEnergyAsCORModel(modelId)
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local data = CantonOperaRoadConfig.instance:getCorModelDataById(activityId, modelId)
	local energyNum = CantonOperaRoadController.instance:getEnergyNumAsCORModel(modelId)
	local energyCost = CantonOperaRoadController.instance:getEnergyCostAsCORModel(modelId)

	return energyCost <= energyNum
end

function CantonOperaRoadController:getEnergyNumAsCORModel(modelId)
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local data = CantonOperaRoadConfig.instance:getCorModelDataById(activityId, modelId)
	local energyNum = 0

	if not string.nilorempty(data.costEnergy) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.costEnergy)

		energyNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	end

	return energyNum
end

function CantonOperaRoadController:getEnergyCostAsCORModel(modelId)
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local data = CantonOperaRoadConfig.instance:getCorModelDataById(activityId, modelId)
	local energyCost = 0

	if not string.nilorempty(data.costEnergy) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.costEnergy)

		energyCost = matNum
	end

	return energyCost
end

function CantonOperaRoadController:getProgressPercentageAsCORModel(modelId)
	local curProgress = CantonOperaRoadModel.instance:getModelProgress(modelId)
	local maxProgress = CantonOperaRoadController.instance:getMaxProgressAsCORModel(modelId)

	return curProgress / maxProgress
end

function CantonOperaRoadController:getMaxProgressAsCORModel(modelId)
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local data = CantonOperaRoadConfig.instance:getCorModelDataById(activityId, modelId)

	return (data or nil) and (data.maxProgress or 0)
end

function CantonOperaRoadController:getEnergyListAsCOR(activityId)
	local actData = CantonOperaRoadConfig.instance:getCorActData(activityId)

	if actData == nil then
		return
	end

	local energyList = {}
	local energyId = actData.energyId
	local energyCfg = EnergyConfig.instance:getEnergyCfg(energyId)

	if energyCfg then
		local matType = MatType.ACTIVITY_ENERGY
		local matId = energyId
		local matStr = string.format("%s:%s", matType, matId)

		energyList = {
			id = matStr
		}
	end

	return energyList
end

function CantonOperaRoadController:isNewMaxPassModelId(activityId, modelId)
	local oldModelId = self:getOldMaxPassModelId(activityId)

	return modelId == oldModelId
end

function CantonOperaRoadController:isViewUnlockAsCORModel(activityId, modelId)
	local oldModelId = self:getOldMaxPassModelId(activityId)

	return modelId <= oldModelId
end

function CantonOperaRoadController:getOldMaxPassModelId(activityId)
	local key = self:_getOldMaxPassModelIdUserDataKey(activityId)

	return checknumber(GameUtil.getUserData(key))
end

function CantonOperaRoadController:saveNewMaxPassModelId(activityId, modelId)
	local key = self:_getOldMaxPassModelIdUserDataKey(activityId)

	GameUtil.saveUserData(key, modelId)
end

function CantonOperaRoadController:_getOldMaxPassModelIdUserDataKey(activityId)
	return "COR" .. "ID" .. activityId
end

function CantonOperaRoadController:getEnterChallengeResultAsCORAnswer()
	local modelId = GameEnum.ModelTypeAsCOR.ANSWER

	if not self:isEnoughEnergyAsCORModel(modelId) then
		return GameEnum.ResultCode.NoEnergy
	end

	return self:getEnterModelResultAsCOR(modelId)
end

function CantonOperaRoadController:getEnterChallengeResultAsCORJigsaw(jigsawId)
	if self:isPassAsJigsaw(jigsawId) then
		return GameEnum.ResultCode.IsPassJigsaw
	end

	if self:isCollectEnoughAsPiece(jigsawId) then
		return GameEnum.ResultCode.IsCollectEnough
	end

	local modelId = GameEnum.ModelTypeAsCOR.JIGSAW

	if not self:isEnoughEnergyAsCORModel(modelId) then
		return GameEnum.ResultCode.NoEnergy
	end

	return self:getEnterModelResultAsCOR(modelId)
end

function CantonOperaRoadController:isUnlockAsCORJigsaw(jigsawId)
	return self:isInTimeAsJigsaw(jigsawId) and self:isUnlockConditionAsCORJigsaw(jigsawId)
end

function CantonOperaRoadController:isInTimeAsJigsaw(jigsawId)
	return self:getTimePeriodAsJigsaw(jigsawId) == GameUtil.inTimePeriod
end

function CantonOperaRoadController:getTimePeriodAsJigsaw(jigsawId)
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local data = CantonOperaRoadConfig.instance:getCorJigsawDataById(activityId, jigsawId)

	return GameUtil.getTimePeriod(data.openTime, data.endTime)
end

function CantonOperaRoadController:isUnlockConditionAsCORJigsaw(jigsawId)
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local data = CantonOperaRoadConfig.instance:getCorJigsawDataById(activityId, jigsawId)

	return self:isPassAsJigsaw(data.unlockCondition)
end

function CantonOperaRoadController:isPassAsJigsaw(jigsawId)
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local dataList = CantonOperaRoadConfig.instance:getCorJigsawPieceDataListById(activityId, jigsawId)
	local isPass = true

	if dataList then
		for _, data in ipairs(dataList) do
			if not self:isLightUpAsPiece(data.pieceId) then
				isPass = false

				break
			end
		end
	end

	return isPass
end

function CantonOperaRoadController:isCollectEnoughAsPiece(jigsawId)
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local dataList = CantonOperaRoadConfig.instance:getCorJigsawPieceDataListById(activityId, jigsawId)
	local isEnough = true

	if dataList then
		local isLight = false

		for _, data in ipairs(dataList) do
			isLight = self:isLightUpAsPiece(data.pieceId)

			if not isLight and CantonOperaRoadModel.instance:getPieceNum(data.pieceId) <= 0 then
				isEnough = false

				break
			end
		end
	end

	return isEnough
end

function CantonOperaRoadController:isLightUpAsPiece(pieceId)
	local isLightUp = false
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local pieceData = CantonOperaRoadConfig.instance:getCorJigsawPieceDataById(activityId, pieceId)

	if pieceData then
		local lightUpIdList = CantonOperaRoadModel.instance:getLightUpIdList(pieceData.jigsawId)

		for _, id in ipairs(lightUpIdList) do
			if id == pieceId then
				isLightUp = true

				break
			end
		end
	else
		isLightUp = true
	end

	return isLightUp
end

function CantonOperaRoadController:isFitStageIdAsCORJigsaw(stageId)
	local fitStageIdList = CantonOperaRoadModel.instance:getStageIdsAsJigsaw()

	return table.indexof(fitStageIdList, stageId) ~= false
end

function CantonOperaRoadController:getFitStageIdAsCORJigsaw()
	local fitStageIdList = CantonOperaRoadModel.instance:getStageIdsAsJigsaw()

	if #fitStageIdList >= 1 then
		local idx = math.random(1, #fitStageIdList)

		return fitStageIdList[idx]
	else
		return 0
	end
end

function CantonOperaRoadController:getOldStageIdAsCORJigsaw(activityId)
	local key = self:_getOldStageIdUserDataKeyAsCORJigsaw(activityId)

	return checknumber(GameUtil.getUserData(key))
end

function CantonOperaRoadController:saveOldStageIdAsCORJigsaw(activityId, stageId)
	local key = self:_getOldStageIdUserDataKeyAsCORJigsaw(activityId)

	GameUtil.saveUserData(key, stageId)
end

function CantonOperaRoadController:_getOldStageIdUserDataKeyAsCORJigsaw(activityId)
	return "COR" .. "Jigsaw" .. "ID" .. activityId
end

function CantonOperaRoadController:enterBattleAsJigsaw(jigsawId, stageId)
	local customFmtMo = CantonOperaRoadModel.instance:getCustomFmtMoAsJigsaw()

	customFmtMo:updateCfg(jigsawId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function CantonOperaRoadController:_handlerBattleEndAsJigsaw()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local function succHandler()
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	end

	local function failHandler()
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end

	local function pushSaveView()
		local viewInfos = CantonOperaRoadModel.instance:getViewInfos()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
		end
	end

	pushSaveView()

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		failHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		failHandler()
	end

	return true
end

function CantonOperaRoadController:getEnterChallengeResultAsCORMaking()
	local modelId = GameEnum.ModelTypeAsCOR.CAKE

	if not self:isEnoughEnergyAsCORModel(modelId) then
		return GameEnum.ResultCode.NoEnergy
	end

	return self:getEnterModelResultAsCOR(modelId)
end

function CantonOperaRoadController:getEnterChallengeResultAsCORBoss()
	local modelId = GameEnum.ModelTypeAsCOR.BOSS

	if not self:isEnoughChallengeTimesAsCORBoss(modelId) then
		return GameEnum.ResultCode.NotEnoughTimes
	end

	if not self:isEnoughEnergyAsCORModel(modelId) then
		return GameEnum.ResultCode.NoEnergy
	end

	return self:getEnterModelResultAsCOR(modelId)
end

function CantonOperaRoadController:getMaxChallengeTimesAsCORBoss()
	local activityId = CantonOperaRoadModel.instance:getCurActivityId()
	local cfg = CantonOperaRoadConfig.instance:getCorBossChallengeCfgById(activityId)

	return (cfg[#cfg] or nil) and (cfg[#cfg].times or 0)
end

function CantonOperaRoadController:getRemainChallengeTimesAsCORBoss()
	local maxTimes = self:getMaxChallengeTimesAsCORBoss()
	local costTimes = CantonOperaRoadModel.instance:getCostChallengeTimesAsCORBoss()

	return maxTimes - costTimes
end

function CantonOperaRoadController:isEnoughChallengeTimesAsCORBoss()
	local curTimes = CantonOperaRoadModel.instance:getCostChallengeTimesAsCORBoss()
	local maxTimes = self:getMaxChallengeTimesAsCORBoss()

	return curTimes < maxTimes
end

function CantonOperaRoadController:enterBattleAsCORBoss()
	local customFmtMo = CantonOperaRoadModel.instance:getCustomFmtMoAsCORBoss()
	local challengeTimes = CantonOperaRoadModel.instance:getCostChallengeTimesAsCORBoss()

	customFmtMo:updateCfg(challengeTimes + 1)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function CantonOperaRoadController:_handlerBattleEndAsCORBoss()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local function succHandler()
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	end

	local function failHandler()
		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end

	local function pushSaveView()
		local viewInfos = CantonOperaRoadModel.instance:getViewInfos()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
		end
	end

	pushSaveView()

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		failHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		failHandler()
	end

	return true
end

CantonOperaRoadController.instance = CantonOperaRoadController.New()

return CantonOperaRoadController
