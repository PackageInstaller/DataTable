-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/controller/AnnualFubenController.lua

module("logic.extensions.annualfuben.controller.AnnualFubenController", package.seeall)

local AnnualFubenController = class("AnnualFubenController", BaseController)

function AnnualFubenController:ctor()
	return
end

function AnnualFubenController:onInit()
	AnnualFubenController.super.onInit(self)
	self:onReset()
end

function AnnualFubenController:onReset()
	AnnualFubenController.super.onReset(self)
end

function AnnualFubenController:handlePM_AnnualFubenInfoRes(msg)
	AnnualFubenModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualFubenInfoRes)
end

function AnnualFubenController:handlePM_AnnualFubenGainClueRes(msg)
	AnnualFubenModel.instance:saveGainClue(msg.activityId, msg.clueId)
	AnnualFubenModel.instance:saveGainClueTime(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualFubenGainClueRes, msg.clueId)
end

function AnnualFubenController:sendPM_AnnualFubenFormulaReq(activityId, clueId)
	self._newClueId = nil

	AnnualFubenAgent.instance:sendPM_AnnualFubenFormulaReq(activityId, clueId)
end

function AnnualFubenController:handlePM_AnnualFubenFormulaRes(msg)
	local isCombineCorrect = true

	if checknumber(msg.newClueId) == 0 then
		FloatWordMgr.instance:show(lang("无关联结果"))

		isCombineCorrect = false
	end

	if checknumber(msg.newClueId) ~= 0 and AnnualFubenModel.instance:isGainClue(msg.activityId, msg.newClueId) == true and self._newClueId ~= msg.newClueId then
		FloatWordMgr.instance:show(lang("已获得该线索"))

		isCombineCorrect = false
	end

	if isCombineCorrect == true then
		AnnualFubenModel.instance:saveGainClue(msg.activityId, msg.newClueId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_FusionSoulCombineClueRes, isCombineCorrect, msg.newClueId)
end

function AnnualFubenController:handlePM_AnnualFubenGainCluePrizeRes(msg)
	AnnualFubenModel.instance:saveCluePrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualFubenInfoRes)
end

function AnnualFubenController:handlePM_AnnualFubenStageRankInfoRes(msg)
	AnnualFubenModel.instance:saveTempRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualFubenRankInfoRes)
end

function AnnualFubenController:handlePM_AnnualFubenStageResetRes(msg)
	AnnualFubenModel.instance:saveResetBrokenStage(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualFubenInfoRes)
end

function AnnualFubenController:handlePM_AnnualFubenGainBossPrizeRes(msg)
	AnnualFubenModel.instance:saveBossPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualFubenInfoRes)
end

function AnnualFubenController:handlePM_AnnualFubenBossRankInfoRes(msg)
	AnnualFubenModel.instance:saveTempRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualFubenRankInfoRes)
end

function AnnualFubenController:handlePM_NotifyAnnualFubenStageFinishRes(msg)
	if msg.isWin then
		AnnualFubenModel.instance:saveBrokenStageBattleInfo(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualFubenInfoRes)
end

function AnnualFubenController:handlePM_NotifyAnnualFubenBossFinishRes(msg)
	AnnualFubenModel.instance:saveBossBattleInfo(msg)
	BattleFacade.instance:registerResultHandler(function()
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)

		return true
	end, self)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualFubenInfoRes)
end

function AnnualFubenController:handlePM_NotifyAnnualFubenSimpleStageFinishRes(msg)
	if msg.isWin then
		AnnualFubenModel.instance:saveHoldStageBattleInfo(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualFubenInfoRes)
end

function AnnualFubenController:getWorldProgressCfgInfo(activityId)
	local actCfg = AnnualFubenConfig.instance:getActivityCfg(activityId)
	local curTime = ServerTime.now()
	local worldProgressConfigs = AnnualFubenConfig.instance:getWorldCfgs(actCfg.wordProgressPlanId)
	local curProgressId = 0
	local nexProgressId = 0
	local totalProgress = 0

	for i = 1, #worldProgressConfigs do
		local cfg = worldProgressConfigs[i]
		local time = GameUtil.string2time(cfg.openTime)

		if time <= curTime then
			curProgressId = i
		elseif nexProgressId == 0 then
			nexProgressId = i
		end

		if totalProgress < cfg.progress then
			totalProgress = cfg.progress
		end
	end

	local nextProgressTime, startProgressTime, precentStart, precentEnd

	precentStart = worldProgressConfigs[curProgressId].progress / totalProgress
	startProgressTime = GameUtil.string2time(worldProgressConfigs[curProgressId].openTime)

	if checknumber(nexProgressId) ~= 0 then
		nextProgressTime = GameUtil.string2time(worldProgressConfigs[nexProgressId].openTime)
		precentEnd = worldProgressConfigs[nexProgressId].progress / totalProgress
	else
		precentEnd = precentStart
	end

	return curProgressId, precentStart, startProgressTime, nexProgressId, nextProgressTime, precentEnd
end

function AnnualFubenController:getWorldProgressInfo(activityId, curProgressId, precentStart, startProgressTime, nexProgressId, nextProgressTime, precentEnd)
	local actCfg = AnnualFubenConfig.instance:getActivityCfg(activityId)
	local starWorldProgressConfig = AnnualFubenConfig.instance:getWorldCfg(actCfg.wordProgressPlanId, curProgressId)
	local endWorldProgressConfig = AnnualFubenConfig.instance:getWorldCfg(actCfg.wordProgressPlanId, nexProgressId)
	local curTime = ServerTime.now()
	local timeRate = (curTime - startProgressTime) / (checknumber(nextProgressTime) - startProgressTime)

	if curTime >= checknumber(nextProgressTime) then
		timeRate = 1
	end

	local curPrecent = timeRate * (precentEnd - precentStart) + precentStart
	local curProgress = math.floor(timeRate * ((endWorldProgressConfig or nil) and endWorldProgressConfig.progress - starWorldProgressConfig.progress) + starWorldProgressConfig.progress)
	local curShowTime = math.ceil(actCfg.wordTotalTime * (1 - curPrecent))

	return curPrecent, curProgress, curShowTime
end

function AnnualFubenController:getAllGainClueIds(activityId)
	local clueCfgs = AnnualFubenConfig.instance:getClueCfgs(activityId)
	local resultMap = {}

	for i, v in ipairs(clueCfgs) do
		if AnnualFubenModel.instance:isGainClue(activityId, v.clueId) == true then
			resultMap[v.clueId] = true
		end
	end

	return resultMap
end

function AnnualFubenController:isCollectAllClue(activityId)
	local clueCfgs = AnnualFubenConfig.instance:getClueCfgs(activityId)
	local isGetAll = true

	for i, v in ipairs(clueCfgs) do
		if not AnnualFubenModel.instance:isGainClue(activityId, v.clueId) then
			isGetAll = false

			break
		end
	end

	return isGetAll
end

function AnnualFubenController:openHoldMissionView(activityId, stageId)
	local fmtMo = AnnualFubenModel.instance:getHoldFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function AnnualFubenController:openBrokenMissionView(activityId, stageId)
	local fmtMo = AnnualFubenModel.instance:getBrokenFmtMo()

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function AnnualFubenController:openBossMissionView(activityId)
	local fmtMo = AnnualFubenModel.instance:getBossFmtMo()

	fmtMo:initParams(activityId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function AnnualFubenController:isCanGetCluePrize(activityId)
	local clueMaps = AnnualFubenController:getAllGainClueIds(activityId)
	local curGainClueCount = table.nums(clueMaps)
	local prizeCfgs = AnnualFubenConfig.instance:getCluePrizeCfgs(activityId)
	local isCanGet = false

	for i, v in ipairs(prizeCfgs) do
		local isGain = AnnualFubenModel.instance:isGainCluePrize(activityId, v.prizeId)

		if not isGain and curGainClueCount >= v.clueNum then
			isCanGet = true

			break
		end
	end

	return isCanGet
end

AnnualFubenController.instance = AnnualFubenController.New()

return AnnualFubenController
