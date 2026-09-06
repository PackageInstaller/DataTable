-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/controller/BoccaccioChapterController.lua

module("logic.extensions.boccacciochapter.controller.BoccaccioChapterController", package.seeall)

local BoccaccioChapterController = class("BoccaccioChapterController", BaseController)

BoccaccioChapterController.BoccaccioChapter = "boccacciochapter"

function BoccaccioChapterController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	GlobalDispatcher:addListener(BoccaccioChapterController.BoccaccioChapter, self._enterBoccaccioChapter, self)
end

function BoccaccioChapterController:onReset()
	return
end

function BoccaccioChapterController:_onStartEnterGame()
	local activityId = self:getActivityId()

	self:_updateAllChapterFirstRedPoint(activityId)
end

function BoccaccioChapterController:_enterBoccaccioChapter(params)
	local activityId = checknumber(params[1])
	local chapterId = checknumber(params[2])

	self:enterBoccaccioChapter(activityId, chapterId)
end

function BoccaccioChapterController:enterBoccaccioChapter(activityId, chapterId)
	local isInActivityTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if not isInActivityTime then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	if chapterId > 0 then
		local subMo = self:getSubMo(activityId)
		local isUnlock = subMo:isUnlockChapter(chapterId)

		if not isUnlock then
			FloatWordMgr.instance:show("不在开放时间内")

			return
		end
	end

	UIStateManager.instance:push(ViewName.BoccaccioChapterHomeView, activityId)

	if chapterId > 0 then
		self:pushBoccaccioChapterView(activityId, chapterId)
	end
end

function BoccaccioChapterController:pushBoccaccioChapterView(activityId, chapterId)
	if chapterId == BoccaccioChapterEnum.ChapterId_1 then
		UIStateManager.instance:push(ViewName.BoccaccioChapterOneMainView, activityId)
	elseif chapterId == BoccaccioChapterEnum.ChapterId_2 then
		UIStateManager.instance:push(ViewName.BoccaccioChapterTwoMainView, activityId)
	elseif chapterId == BoccaccioChapterEnum.ChapterId_3 then
		UIStateManager.instance:push(ViewName.BoccaccioChapter3MainView, activityId)
	elseif chapterId == BoccaccioChapterEnum.ChapterId_4 then
		UIStateManager.instance:push(ViewName.BoccaccioChapter4MainView, activityId)
	end
end

function BoccaccioChapterController:sendPM_BoccaccioChapterInfoReq(activityId)
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapterInfoReq(activityId)
end

function BoccaccioChapterController:handlePM_BoccaccioChapterInfoRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_BoccaccioChapterInfoRes(msg)
		self:_updateProgressRedPoint(msg.activityId, 0)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapterInfoRes, status, msg)
end

function BoccaccioChapterController:sendPM_BoccaccioChapter1ClgReq(activityId, stageId, form)
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapter1ClgReq(activityId, stageId, form)
end

function BoccaccioChapterController:sendPM_BoccaccioChapter2ClgReq(activityId, storyId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local subMo = self:getSubMo(activityId)
		local msg = subMo:getClgResultC2()

		if msg and msg.isWin then
			UIStateManager.instance:push(ViewName.BoccaccioChapterTwoStageResultView, msg)

			result = true
		end

		return result
	end)
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapter2ClgReq(activityId, storyId, stageId, form)
end

function BoccaccioChapterController:sendPM_BoccaccioChapter3ClgReq(activityId, stageId, form, signUpBuff)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onC3BattleEnd, self))
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapter3ClgReq(activityId, stageId, form, signUpBuff)
end

function BoccaccioChapterController:sendPM_BoccaccioChapter4ClgReq(activityId, form, isTrail)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onC4BattleEnd, self))
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapter4ClgReq(activityId, form, isTrail)
end

function BoccaccioChapterController:handlePM_BoccaccioChapterClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapterClgRes)
end

function BoccaccioChapterController:sendPM_BoccaccioChapterOneClickGainProgressPrizeReq(activityId, chapter)
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapterOneClickGainProgressPrizeReq(activityId, chapter)
end

function BoccaccioChapterController:handlePM_BoccaccioChapterOneClickGainProgressPrizeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapterOneClickGainProgressPrizeRes(msg)
	self:_updateProgressRedPoint(msg.activityId, msg.chapter)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapterOneClickGainProgressPrizeRes)
end

function BoccaccioChapterController:sendPM_BoccaccioChapter2RecoverySequenceReq(activityId, storyId)
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapter2RecoverySequenceReq(activityId, storyId)
end

function BoccaccioChapterController:handlePM_BoccaccioChapter2RecoverySequenceRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapter2RecoverySequenceRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapter2RecoverySequenceRes, msg)
end

function BoccaccioChapterController:sendPM_BoccaccioChapter2FindErrorWordReq(activityId, storyId, errorWordId)
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapter2FindErrorWordReq(activityId, storyId, errorWordId)
end

function BoccaccioChapterController:handlePM_BoccaccioChapter2FindErrorWordRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapter2FindErrorWordRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapter2FindErrorWordRes, msg)
end

function BoccaccioChapterController:sendPM_BoccaccioChapter2ReplaceWordReq(activityId, storyId, errorWordId)
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapter2ReplaceWordReq(activityId, storyId, errorWordId)
end

function BoccaccioChapterController:handlePM_BoccaccioChapter2ReplaceWordRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapter2ReplaceWordRes(msg)
	self:_updateProgressRedPoint(msg.activityId, BoccaccioChapterEnum.ChapterId_2)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapter2ReplaceWordRes, msg)
end

function BoccaccioChapterController:sendPM_BoccaccioChapter3SignUpReq(activityId)
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapter3SignUpReq(activityId)
end

function BoccaccioChapterController:handlePM_BoccaccioChapter3SignUpRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapter3SignUpRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapter3SignUpRes)
end

function BoccaccioChapterController:sendPM_BoccaccioChapter3SaveClgReq(activityId, isSave)
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapter3SaveClgReq(activityId, isSave)
end

function BoccaccioChapterController:handlePM_BoccaccioChapter3SaveClgRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapter3SaveClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapter3SaveClgRes)
end

function BoccaccioChapterController:sendPM_BoccaccioChapter4RankViewReq(activityId)
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapter4RankViewReq(activityId)
end

function BoccaccioChapterController:handlePM_BoccaccioChapter4RankViewRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapter4RankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapter4RankViewRes)
end

function BoccaccioChapterController:sendPM_BoccaccioChapterFirstClickReq(activityId, chapterId)
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapterFirstClickReq(activityId, chapterId)
end

function BoccaccioChapterController:handlePM_BoccaccioChapterFirstClickRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapterFirstClickRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapterFirstClickRes)
end

function BoccaccioChapterController:handlePM_BoccaccioChapter1NotifyClgRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapter1NotifyClgRes(msg)
	self:_updateProgressRedPoint(msg.activityId, BoccaccioChapterEnum.ChapterId_1)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapter1NotifyClgRes)
end

function BoccaccioChapterController:handlePM_BoccaccioChapter2NotifyClgRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapter2NotifyClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapter2NotifyClgRes)
end

function BoccaccioChapterController:handlePM_BoccaccioChapter3NotifyClgRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapter3NotifyClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapter3NotifyClgRes)
end

function BoccaccioChapterController:handlePM_BoccaccioChapter4NotifyClgRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapter4NotifyClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapter4NotifyClgRes)
end

function BoccaccioChapterController:sendPM_BoccaccioChapterUnlockPlotReq(activityId, plotId)
	BoccaccioChapterAgent.instance:sendPM_BoccaccioChapterUnlockPlotReq(activityId, plotId)
end

function BoccaccioChapterController:handlePM_BoccaccioChapterUnlockPlotRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_BoccaccioChapterUnlockPlotRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_BoccaccioChapterUnlockPlotRes)
end

function BoccaccioChapterController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.BoccaccioChapter)
end

function BoccaccioChapterController:getSubMo(activityId)
	return BoccaccioChapterModel.instance:getSubMo(activityId)
end

function BoccaccioChapterController:getChapterInfo(activityId, chapterId)
	local subMo = self:getSubMo(activityId)

	if subMo then
		return subMo:getChapterInfo(chapterId)
	else
		return nil
	end
end

function BoccaccioChapterController:getChapter3SelectedBuffId(activityId)
	local key = string.format("BoccaccioChapter3SelectedBuffId_%d", activityId)

	return checknumber(GameUtil.getUserData(key))
end

function BoccaccioChapterController:setChapter3SelectedBuffId(activityId, buffId)
	local key = string.format("BoccaccioChapter3SelectedBuffId_%d", activityId)

	GameUtil.saveUserData(key, buffId)
	GlobalDispatcher:dispatch(GlobalNotify.HandleBoccaccioChapter3SelectBuffId)
end

function BoccaccioChapterController:openChapterRule(activityId, chapterId)
	local field = string.format("ruleKeyC%d", chapterId)
	local actData = BoccaccioChapterConfig.instance:getActivityData(activityId)

	if actData then
		if not actData[field] then
			local key = ""

			TipsFacade.instance:openRulesView(key)
		end
	end
end

function BoccaccioChapterController:enterBattleC1(activityId, stageId)
	local fmtMo = BoccaccioChapterModel.instance:getFmtMoC1(activityId)

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function BoccaccioChapterController:enterBattleC2(activityId, stageId)
	local fmtMo = BoccaccioChapterModel.instance:getFmtMoC2(activityId)

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function BoccaccioChapterController:enterBattleC3(activityId, stageId)
	local fmtMo = BoccaccioChapterModel.instance:getFmtMoC3(activityId)

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function BoccaccioChapterController:_onC3BattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local lastClgResultC3
	local subMo = self:getSubMo(self:getActivityId())

	if subMo then
		lastClgResultC3 = subMo:getLastClgResultC3()
	end

	if lastClgResultC3 then
		if lastClgResultC3.isWin then
			UIStateManager.instance:push(ViewName.BoccaccioChapter3ResultView, lastClgResultC3)
		else
			UIStateManager.instance:open(ViewName.BattleSettlementFailSimple)
		end
	else
		UIStateManager.instance:open(ViewName.BattleSettlementFailSimple)
	end

	return true
end

function BoccaccioChapterController:enterBattleC4(activityId, isTrail)
	local fmtMo = BoccaccioChapterModel.instance:getFmtMoC4(activityId)

	fmtMo:initParams(activityId, isTrail)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function BoccaccioChapterController:_onC4BattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local bossDamage = 0
	local subMo = self:getSubMo(self:getActivityId())

	if subMo then
		local lastClgResultC4 = subMo:getLastClgResultC4()

		if lastClgResultC4 then
			bossDamage = checknumber(lastClgResultC4.curClgDamage)
		end
	end

	BattleSettlementController.instance:addConditionElement(langPara("累计造成伤害：<color=#99FFB0>%s</color>", bossDamage))
	UIStateManager.instance:open(ViewName.BattleSettlementSuccess)

	return true
end

function BoccaccioChapterController:unlockPlot(activityId, unlockType, unlockParms)
	local subMo = self:getSubMo(activityId)

	if not subMo then
		return
	end

	local storyCfgs = BoccaccioChapterConfig.instance:getPlotDatas(activityId) or {}

	for _, cfg in ipairs(storyCfgs) do
		local isUnlock = subMo:isUnlockPlot(cfg.plotId)
		local isMatchType = cfg.unlockType == unlockType

		if not cfg.unlockParams then
			local unlockParams = ""

			if isMatchType and not isUnlock then
				local isMatchParms = false

				if unlockType == BoccaccioChapterEnum.PolotUnlockType.FirstEnter then
					isMatchParms = unlockParms == unlockParams
				elseif unlockType == BoccaccioChapterEnum.PolotUnlockType.C1PassStage then
					local passStageId = checknumber(unlockParms)

					isMatchParms = passStageId == checknumber(unlockParams)
				elseif unlockType == BoccaccioChapterEnum.PolotUnlockType.C2AllRight then
					isMatchParms = checknumber(unlockParms) == checknumber(unlockParams)
				elseif unlockType == BoccaccioChapterEnum.PolotUnlockType.EatPetCount then
					local eatPetCount = checknumber(unlockParms)

					isMatchParms = eatPetCount > 0 and eatPetCount >= checknumber(unlockParams)
				elseif unlockType == BoccaccioChapterEnum.PolotUnlockType.TotalDamage then
					local totalDamage = checknumber(unlockParms)

					isMatchParms = totalDamage > 0 and totalDamage >= checknumber(unlockParams)
				end

				if isMatchParms then
					self:sendPM_BoccaccioChapterUnlockPlotReq(activityId, cfg.plotId)
					GlobalDispatcher:dispatch(GlobalNotify.PushStory, cfg.storyId, StoryModel.StoryType.SCCopy)
				end
			end
		end
	end
end

function BoccaccioChapterController:getChapterFirstRedId(activityId, chapterId)
	return string.format("BoccaccioChapterFirstRedId_%s_%s", activityId, chapterId)
end

function BoccaccioChapterController:setChapterFirstRedPointTrigger(activityId, chapterId)
	local redId = self:getChapterFirstRedId(activityId, chapterId)

	RedPointController.instance:saveUserOnceRedPoint(redId, true)
end

function BoccaccioChapterController:_updateAllChapterFirstRedPoint(activityId)
	local subMo = self:getSubMo(activityId)
	local isInActivityTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)
	local servantRedList = {}
	local datas = BoccaccioChapterConfig.instance:getChapterDatas(activityId) or {}

	for _, data in ipairs(datas) do
		local chapterId = data.chapterId
		local redId = self:getChapterFirstRedId(activityId, chapterId)
		local isUnlock = subMo:isUnlockChapter(chapterId)

		if isInActivityTime and isUnlock then
			RedPointController.instance:regUserOnceRedPoint(redId)
		else
			RedPointController.instance:setRedPointInfo(redId, false)
		end

		table.insert(servantRedList, redId)
	end

	if isInActivityTime then
		local actData = BoccaccioChapterConfig.instance:getActivityData(activityId)
		local totalRedId = actData and actData.clientRedId

		if totalRedId then
			RedPointController.instance:regMasterServantRed(totalRedId, false, unpack(servantRedList))
		else
			printError(string.format("薄伽丘：activityId:%s, totalRedId is nil", activityId))
		end
	end
end

function BoccaccioChapterController:getProgressRedId(activityId, chapterId)
	return string.format("BoccaccioChapterProgressRedId_%s_%s", activityId, chapterId)
end

function BoccaccioChapterController:_updateProgressRedPoint(activityId, chapterId)
	chapterId = checknumber(chapterId)

	local list = {}

	if chapterId > 0 then
		table.insert(list, chapterId)
	else
		local datas = BoccaccioChapterConfig.instance:getChapterDatas(activityId) or {}

		for _, data in ipairs(datas) do
			table.insert(list, data.chapterId)
		end
	end

	local subMo = self:getSubMo(activityId)
	local isInActivityTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	for _, chapterId in ipairs(list) do
		local redId = self:getProgressRedId(activityId, chapterId)
		local isActive = false

		if isInActivityTime then
			local isUnlock = subMo:isUnlockChapter(chapterId)

			if isUnlock and subMo:isHasCanGetPrize(chapterId) then
				isActive = true
			end
		end

		RedPointController.instance:setRedPointInfo(redId, isActive)
	end
end

BoccaccioChapterController.instance = BoccaccioChapterController.New()

return BoccaccioChapterController
