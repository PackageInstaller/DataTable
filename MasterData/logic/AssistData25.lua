-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData25.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData25", package.seeall)

local AssistData25 = class("AssistData25", BaseAssistData)

function AssistData25:init()
	self._selectActivityIdList = {}

	local cfgList = XiaoNuoAssistantConfig.instance:getSignInBuffList() or {}

	for idx = 1, #cfgList do
		self._selectActivityIdList[idx] = self:getCellDataToNumber(self:_getActivityIdKey(idx))
	end
end

function AssistData25:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData25:setIndexData(idx, activityId)
	self._selectActivityIdList[idx] = activityId

	self:setCellData(self:_getActivityIdKey(idx), activityId)
end

function AssistData25:getIndexData(idx)
	return checknumber(self._selectActivityIdList[idx])
end

function AssistData25:getSelectableCfgList()
	local cfgList = XiaoNuoAssistantConfig.instance:getSignInBuffList() or {}
	local selectableCfgList = {}

	for _, cfg in ipairs(cfgList) do
		local activityId = checknumber(cfg.activityId)
		local timeGateCfg = self:getTimeGateCfg(activityId)
		local isInActivityTime = self:_checkActivityTime(activityId, timeGateCfg)
		local buffCfgList = SignInBuffConfig.instance:getBuffCfgsByActId(activityId)
		local info = SignInBuffModel.instance:getBaseInfo(activityId)

		if isInActivityTime and buffCfgList and #buffCfgList > 0 and info then
			table.insert(selectableCfgList, cfg)
		end
	end

	return selectableCfgList
end

function AssistData25:getSendCallbackList()
	if not self:getOpenData() then
		return
	end

	local sendMo = self:getSendMo()
	local cfgList = XiaoNuoAssistantConfig.instance:getSignInBuffList() or {}
	local cfgMap = {}

	for _, cfg in ipairs(cfgList) do
		cfgMap[cfg.activityId] = cfg
	end

	local selectedIndexes = {}

	for index, activityId in pairs(self._selectActivityIdList) do
		if checknumber(activityId) > 0 then
			table.insert(selectedIndexes, index)
		end
	end

	table.sort(selectedIndexes)

	local resultItemList = {}
	local directSignActivityIdList = {}
	local signAfterOpenActivityIdList = {}
	local openReqList = {}
	local remainTimesMap = {}

	for _, index in ipairs(selectedIndexes) do
		local activityId = checknumber(self._selectActivityIdList[index])
		local cfg = cfgMap[activityId]
		local result = self:_createResult(activityId, cfg)

		table.insert(resultItemList, result)

		if not cfg then
			self:_finishResult(result, XiaoNuoAssistantModel.Assist25ResultState.Failed, lang("当前无法签到，执行失败"))
		else
			local timeGateCfg = self:getTimeGateCfg(activityId)
			local isInActivityTime, failedText = self:_checkActivityTime(activityId, timeGateCfg)

			if not isInActivityTime then
				self:_finishResult(result, XiaoNuoAssistantModel.Assist25ResultState.Failed, failedText)
			else
				local info = SignInBuffModel.instance:getBaseInfo(activityId)

				if not info then
					self:_finishResult(result, XiaoNuoAssistantModel.Assist25ResultState.Failed, lang("当前无法签到，执行失败"))
				elseif self:isSignInBuffMax(activityId, info) then
					self:_finishResult(result, XiaoNuoAssistantModel.Assist25ResultState.Skipped, lang("签到已满级"))
				elseif info.hasSignInToday then
					self:_finishResult(result, XiaoNuoAssistantModel.Assist25ResultState.Skipped, lang("今日已签到"))
				else
					local needOpen = timeGateCfg ~= nil and not TimeGateModel.instance:isOpenByRaceId(timeGateCfg.raceId)

					if timeGateCfg then
						result.raceId = timeGateCfg.raceId or 0
					end

					result.needOpen = needOpen

					if needOpen then
						local typeIndex = timeGateCfg.type

						if remainTimesMap[typeIndex] == nil then
							remainTimesMap[typeIndex] = checknumber(TimeGateModel.instance:getLeftTime(typeIndex))
						end

						if remainTimesMap[typeIndex] > 0 then
							remainTimesMap[typeIndex] = remainTimesMap[typeIndex] - 1
							result.group = XiaoNuoAssistantModel.Assist25ResultGroup.OpenThenSign

							table.insert(signAfterOpenActivityIdList, activityId)
							table.insert(openReqList, self:_getTimeGateReq(typeIndex, timeGateCfg.raceId))
						else
							self:_finishResult(result, XiaoNuoAssistantModel.Assist25ResultState.Failed, lang("开门次数不足，执行失败"))
						end
					else
						result.group = XiaoNuoAssistantModel.Assist25ResultGroup.DirectSign

						table.insert(directSignActivityIdList, activityId)
					end
				end
			end
		end
	end

	sendMo.resultItemList = resultItemList
	sendMo.callbackStageList = {}

	if #directSignActivityIdList > 0 then
		self:_addCallback(sendMo, XiaoNuoAssistantModel.Assist25CallbackStage.DirectSign, function()
			SignInBuffAgent.instance:sendPM_BatchUpgradeSignInBuffReq(directSignActivityIdList)
		end)
	end

	if #openReqList > 0 then
		self:_addCallback(sendMo, XiaoNuoAssistantModel.Assist25CallbackStage.OpenGate, function()
			TimeGateAgent.instance:sendMultiPM_TimeGateSelectOpenReq(openReqList)
		end)
		self:_addCallback(sendMo, XiaoNuoAssistantModel.Assist25CallbackStage.SignAfterOpen, function()
			SignInBuffAgent.instance:sendPM_BatchUpgradeSignInBuffReq(signAfterOpenActivityIdList)
		end)
	end

	sendMo.emptyShowText = lang("执行完毕")

	return sendMo
end

function AssistData25:_createResult(activityId, cfg)
	local var_10_0 = {
		needOpen = false,
		raceId = 0,
		activityId = activityId
	}

	if cfg then
		var_10_0.name = cfg.name or langPara("未知挑战（%s）", activityId)
	end

	var_10_0.state = XiaoNuoAssistantModel.Assist25ResultState.Pending
	var_10_0.resultText = lang("等待执行")

	return var_10_0
end

function AssistData25:_finishResult(result, state, resultText)
	result.state = state
	result.resultText = resultText
end

function AssistData25:_getActivityIdKey(idx)
	return string.format("activityId_%d", idx)
end

function AssistData25:getTimeGateCfg(activityId)
	local activityCfg = ActivityDefineConfig.instance:getCfgByActivitYId(activityId)

	if activityCfg and activityCfg.processType == 5 then
		return TimeGateConfig.instance:getCfgByActivityId(activityId)
	end
end

function AssistData25:_checkActivityTime(activityId, timeGateCfg)
	local activityCfg = ActivityDefineConfig.instance:getCfgByActivitYId(activityId)

	if not activityCfg then
		return false, lang("当前无法签到，执行失败")
	end

	if activityCfg.processType == 5 then
		if not timeGateCfg then
			return false, lang("当前无法签到，执行失败")
		end

		local timePeriodType = GameUtil.getTimePeriodType(timeGateCfg.openTime, timeGateCfg.endTime)

		if timePeriodType == GameUtil.beforeTimePeriod then
			return false, lang("活动尚未开启，执行失败")
		elseif timePeriodType ~= GameUtil.inTimePeriod then
			return false, lang("活动时间已结束，执行失败")
		end

		return true
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		return false, lang("活动时间已结束，执行失败")
	end

	return true
end

function AssistData25:isSignInBuffMax(activityId, info)
	local buffCfgList = SignInBuffConfig.instance:getBuffCfgsByActId(activityId) or {}
	local maxLevelCfg = buffCfgList[#buffCfgList]

	return maxLevelCfg and checknumber(info.signInDays) >= checknumber(maxLevelCfg.signInDays) or false
end

function AssistData25:_addCallback(sendMo, stage, callback)
	table.insert(sendMo.callbackList, callback)
	table.insert(sendMo.callbackStageList, stage)
end

function AssistData25:_getTimeGateReq(typeIndex, raceId)
	local req = TimeGateExtension_pb.TimeGateSelectOpenItem()

	req.type = typeIndex
	req.raceId = raceId

	return req
end

return AssistData25
