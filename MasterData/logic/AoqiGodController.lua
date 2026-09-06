-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/controller/AoqiGodController.lua

module("logic.extensions.aoqigod.controller.AoqiGodController", package.seeall)

local AoqiGodController = class("AoqiGodController", BaseController)

function AoqiGodController:onInit()
	GlobalDispatcher:addListener("openaoqigod", self._openAoqiGod, self)
	GlobalDispatcher:addListener(GlobalNotify.HandleMsgExtension, self._handleMsgExtension, self)
	self:onReset()
end

function AoqiGodController:onReset()
	self:_destroyAllMgr()

	self._helpWallPetNameMap = {}
end

function AoqiGodController:sendPM_AoqiGodInfoReq(activityId)
	AoqiGodAgent.instance:sendPM_AoqiGodInfoReq(activityId)
end

function AoqiGodController:handlePM_AoqiGodInfoRes(msg)
	local mo = self:getAoqiGodMo(msg.activityId)

	mo:handlePM_AoqiGodInfoRes(msg)
	AoqiGodModel.instance:setBuffEnable(msg.buffEnable)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AoqiGodInfoRes)
end

function AoqiGodController:sendPM_AoqiGodSeekHelpReq(activityId, challengeId, costDiamond, selectItem)
	AoqiGodAgent.instance:sendPM_AoqiGodSeekHelpReq(activityId, challengeId, costDiamond, selectItem)
end

function AoqiGodController:handlePM_AoqiGodSeekHelpRes(msg)
	local mo = self:getAoqiGodMo(msg.activityId)

	mo:handlePM_AoqiGodSeekHelpRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AoqiGodSeekHelpRes)
end

function AoqiGodController:sendPM_AoqiGodSeekHelpWallReq(activityId)
	AoqiGodAgent.instance:sendPM_AoqiGodSeekHelpWallReq(activityId)
end

function AoqiGodController:handlePM_AoqiGodSeekHelpWallRes(msg)
	local mo = self:getAoqiGodMo(msg.activityId)

	mo:handlePM_AoqiGodSeekHelpWallRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AoqiGodSeekHelpWallRes)
end

function AoqiGodController:sendPM_AoqiGodRefreshHelpWallReq(activityId, challengeId)
	AoqiGodAgent.instance:sendPM_AoqiGodRefreshHelpWallReq(activityId, challengeId)
end

function AoqiGodController:handlePM_AoqiGodRefreshHelpWallRes(msg)
	local mo = self:getAoqiGodMo(msg.activityId)

	mo:handlePM_AoqiGodRefreshHelpWallRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AoqiGodRefreshHelpWallRes)
end

function AoqiGodController:sendPM_AoqiGodSearchSeekHelpItemReq(activityId, searchInfo, searchUserId)
	AoqiGodAgent.instance:sendPM_AoqiGodSearchSeekHelpItemReq(activityId, searchInfo, searchUserId)
end

function AoqiGodController:handlePM_AoqiGodSearchSeekHelpItemRes(msg)
	local mo = self:getAoqiGodMo(msg.activityId)

	mo:handlePM_AoqiGodSearchSeekHelpItemRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AoqiGodSearchSeekHelpItemRes)
end

function AoqiGodController:sendPM_AoqiGodGetHelpItemInfoReq(activityId, targetUserId, id)
	AoqiGodAgent.instance:sendPM_AoqiGodGetHelpItemInfoReq(activityId, targetUserId, id)
end

function AoqiGodController:handlePM_AoqiGodGetHelpItemInfoRes(status, msg)
	if status == 0 then
		local mo = self:getAoqiGodMo(msg.activityId)

		mo:handlePM_AoqiGodGetHelpItemInfoRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AoqiGodGetHelpItemInfoRes, status, msg)
end

function AoqiGodController:sendPM_AoqiGodAcceptHelpItemReq(activityId, targetUserId, id)
	AoqiGodAgent.instance:sendPM_AoqiGodAcceptHelpItemReq(activityId, targetUserId, id)
end

function AoqiGodController:handlePM_AoqiGodAcceptHelpItemRes(msg)
	local mo = self:getAoqiGodMo(msg.activityId)

	mo:handlePM_AoqiGodAcceptHelpItemRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AoqiGodAcceptHelpItemRes)
end

function AoqiGodController:sendPM_AoqiGodGiveUpHelpItemReq(activityId, targetUserId, id)
	AoqiGodAgent.instance:sendPM_AoqiGodGiveUpHelpItemReq(activityId, targetUserId, id)
end

function AoqiGodController:handlePM_AoqiGodGiveUpHelpItemRes(msg)
	local mo = self:getAoqiGodMo(msg.activityId)

	mo:handlePM_AoqiGodGiveUpHelpItemRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AoqiGodGiveUpHelpItemRes)
end

function AoqiGodController:sendPM_AoqiGodHelpRecordReq(activityId)
	AoqiGodAgent.instance:sendPM_AoqiGodHelpRecordReq(activityId)
end

function AoqiGodController:handlePM_AoqiGodHelpRecordRes(msg)
	local mo = self:getAoqiGodMo(msg.activityId)

	mo:handlePM_AoqiGodHelpRecordRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AoqiGodHelpRecordRes)
end

function AoqiGodController:sendPM_AoqiGodRankReq(activityId)
	AoqiGodAgent.instance:sendPM_AoqiGodRankReq(activityId)
end

function AoqiGodController:handlePM_AoqiGodRankRes(msg)
	local mo = self:getAoqiGodMo(msg.activityId)

	mo:handlePM_AoqiGodRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AoqiGodRankRes)
end

function AoqiGodController:sendPM_AoqiGodChallengeRankReq(activityId)
	AoqiGodAgent.instance:sendPM_AoqiGodChallengeRankReq(activityId)
end

function AoqiGodController:handlePM_AoqiGodChallengeRankRes(msg)
	local mo = self:getAoqiGodMo(msg.activityId)

	mo:handlePM_AoqiGodChallengeRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AoqiGodChallengeRankRes)
end

function AoqiGodController:handlePM_NotifyAoqiGodChallengeFinishRes(msg)
	local mo = self:getAoqiGodMo(msg.activityId)

	mo:handlePM_NotifyAoqiGodChallengeFinishRes(msg)

	if msg:HasField("changeSetId") then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyAoqiGodChallengeFinishRes)
end

function AoqiGodController:sendPM_AoqiGodChangeBuffSwitchReq(enable)
	AoqiGodAgent.instance:sendPM_AoqiGodChangeBuffSwitchReq(enable)
end

function AoqiGodController:handlePM_AoqiGodChangeBuffSwitchRes(msg)
	AoqiGodModel.instance:setBuffEnable(msg.enable)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_AoqiGodChangeBuffSwitchRes)
end

function AoqiGodController:doHandleChallengeFinishReady(activityType, activityId)
	local aoqiActId = self:getActivityId()
	local aoqiGodMo = self:getAoqiGodMo(aoqiActId)
	local challengeId = aoqiGodMo:getChallengeIdsByAct(activityType, activityId)
	local msg = aoqiGodMo:getFinishResMsg()

	if msg == nil or msg.challengeId ~= challengeId then
		return
	end

	aoqiGodMo:clearFinishResMsg()
	UIJumper.instance:clear()

	if AoqiGodController.instance:isInActivityTime(aoqiActId) then
		UIJumper.instance:pushOneStack(ViewName.AoqiGodMainView, nil, aoqiActId)
	end
end

function AoqiGodController:checkChallengeFinishAndPopResult(activityId)
	local aoqiGodMo = self:getAoqiGodMo(activityId)
	local info = aoqiGodMo:popFinishResMsg()

	if info == nil then
		return
	end

	if info.msg.success then
		UIStateManager.instance:push(ViewName.AoqiGodFinishPopView, activityId, info)
	else
		local tipsContent = "很遗憾，本挑战已有其它小奥奇抢先完成，挑战结束"

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, nil, "确定", UnityEngine.TextAnchor.MiddleCenter)
	end
end

function AoqiGodController:_openAoqiGod(params)
	self:enterAoqiGod()
end

function AoqiGodController:enterAoqiGod()
	local activityId = self:getActivityId()

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.AoqiGodMainView, activityId)
end

function AoqiGodController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function AoqiGodController:getActivityType()
	return GameEnum.ActivityType.AoqiGod
end

function AoqiGodController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function AoqiGodController:getAoqiGodMo(activityId)
	return AoqiGodModel.instance:getAoqiGodMo(activityId)
end

function AoqiGodController:getStartTimeAndEndTime()
	local activityId = self:getActivityId()
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
end

function AoqiGodController:isBuffEnable()
	return AoqiGodModel.instance:isBuffEnable()
end

function AoqiGodController:enterInMgr(activityId)
	if self._mgrs[activityId] == nil then
		self._mgrs[activityId] = AoqiGodMgr.New(activityId)
		self._mgrDeltas[activityId] = 0
	end

	if self._mgrDeltas[activityId] == 0 then
		self._mgrs[activityId]:onEnter()
	end

	self._mgrDeltas[activityId] = self._mgrDeltas[activityId] + 1
end

function AoqiGodController:exitInMgr(activityId)
	if self._mgrs[activityId] then
		self._mgrDeltas[activityId] = Mathf.Max(self._mgrDeltas[activityId] - 1, 0)

		if self._mgrDeltas[activityId] <= 0 then
			self._mgrs[activityId]:onExit()
		end
	end
end

function AoqiGodController:_destroyAllMgr()
	if self._mgrs then
		for activityId, mgr in pairs(self._mgrs) do
			mgr:onDestroy()

			self._mgrs[activityId] = nil
			self._mgrDeltas[activityId] = 0
		end
	else
		self._mgrs = {}
		self._mgrDeltas = {}
	end
end

function AoqiGodController:getMgr()
	return self._mgrs
end

function AoqiGodController:FormatLeftTime(timeStamp)
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(timeStamp)

	if day >= 1 then
		return string.format("%02d天%02d时%02d分", day, hour, min)
	elseif hour >= 1 then
		return string.format("%02d时%02d分%02d秒", hour, min, sec)
	elseif min >= 1 then
		return string.format("%02d分%02d秒", min, sec)
	else
		return string.format("%02d秒", sec)
	end
end

function AoqiGodController:getTryPublicCallerResultAndTips(isShowTips, activityId, challengeId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local aoqiGodMo = self:getAoqiGodMo(activityId)

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif not aoqiGodMo:getCaller():isEmpty() then
		result = GameEnum.ResultCode.Error
		tips = "不能同时发布多条求助消息"
	elseif aoqiGodMo:getLeftCountOfCaller() <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "本次活动可获得精灵数量已不足"
	elseif aoqiGodMo:getLeftCountOfCallerPublicInWeek() <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "本周可发布求助次数已不足"
	elseif aoqiGodMo:getFinishItem(challengeId) ~= nil then
		result = GameEnum.ResultCode.Error
		tips = "精灵已获得"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function AoqiGodController:getTryAcceptHelpResultAndTips(isShowTips, activityId, itemHelp)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local aoqiGodMo = self:getAoqiGodMo(activityId)

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif not aoqiGodMo:isEnoughZdl() then
		result = GameEnum.ResultCode.Error
		tips = "战力不足"
	elseif not aoqiGodMo:getHelper():isEmpty() then
		result = GameEnum.ResultCode.Error
		tips = "领取失败，每人同时最多领取1个求助单"
	elseif itemHelp:isEmpty() then
		result = GameEnum.ResultCode.Error
		tips = "求助不存在"
	elseif itemHelp:getUserId() == tostring(RoleModel.instance:getUserId()) then
		result = GameEnum.ResultCode.Error
		tips = "无法接取自己的求助"
	elseif itemHelp:isExcHelperNumLimit() then
		result = GameEnum.ResultCode.Error
		tips = "已达帮打人数上限"
	elseif not itemHelp:isInTime() then
		result = GameEnum.ResultCode.Error
		tips = "求助已过期"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function AoqiGodController:getTryGiveUpHelpResultAndTips(isShowTips, activityId, itemHelp)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local aoqiGodMo = self:getAoqiGodMo(activityId)

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif itemHelp:isEmpty() then
		result = GameEnum.ResultCode.Error
		tips = "求助不存在"
	elseif not itemHelp:isInTime() then
		result = GameEnum.ResultCode.Error
		tips = "求助已过期"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function AoqiGodController:getTryStartHelpResultAndTips(isShowTips, activityId, itemHelp)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local aoqiGodMo = self:getAoqiGodMo(activityId)

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间范围内"
	elseif not itemHelp:isInTime() then
		result = GameEnum.ResultCode.Error
		tips = "求助已过期"
	elseif itemHelp:isEmpty() then
		result = GameEnum.ResultCode.Error
		tips = "求助不存在"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function AoqiGodController:enterChallenge(activityId, challengeId)
	local result = self:getTryClgResultAndTips(true, activityId, challengeId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local data = AoqiGodConfig.instance:getClgData(activityId, challengeId)

	if not string.nilorempty(data.jumpTo) then
		GotoMgr.gotoByString(data.jumpTo)
	else
		FloatWordMgr.instance:show("未配置跳转")
	end
end

function AoqiGodController:popHelpItemWin(activityId, targetUserId, id)
	if not self:isInActivityTime(activityId) then
		return
	end

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_AoqiGodGetHelpItemInfoRes, self._handlePM_AoqiGodGetHelpItemInfoRes, self)
	AoqiGodController.instance:sendPM_AoqiGodGetHelpItemInfoReq(activityId, targetUserId, id)
end

function AoqiGodController:_handlePM_AoqiGodGetHelpItemInfoRes(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_AoqiGodGetHelpItemInfoRes, self._handlePM_AoqiGodGetHelpItemInfoRes, self)

	if status == 0 and msg:HasField("helpItem") then
		local aoqiGodMo = self:getAoqiGodMo(msg.activityId)
		local helpItem = aoqiGodMo:createHelpItem(msg.helpItem)

		UIStateManager.instance:push(ViewName.AoqiGodHelpSurePopView, msg.activityId, helpItem)
	end
end

function AoqiGodController:getTryClgResultAndTipsByAct(isShowTips, activityType, activityId)
	local aoqiActId = self:getActivityId()
	local aoqiGodMo = self:getAoqiGodMo(aoqiActId)
	local challengeId = aoqiGodMo:getChallengeIdsByAct(activityType, activityId)

	return self:getTryClgResultAndTips(isShowTips, aoqiActId, challengeId)
end

function AoqiGodController:getTryClgResultAndTips(isShowTips, activityId, challengeId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	elseif challengeId <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "挑战不存在"
	end

	if result == GameEnum.ResultCode.Success then
		local aoqiGodMo = self:getAoqiGodMo(activityId)
		local helpItem = aoqiGodMo:getHelper()

		if helpItem:isEmpty() then
			tips = "未接取挑战"
			result = GameEnum.ResultCode.Error
		elseif helpItem:getChallengeId() ~= challengeId then
			tips = "非对应挑战"
			result = GameEnum.ResultCode.Error
		elseif not helpItem:isInTime() then
			tips = "已过期"
			result = GameEnum.ResultCode.Error
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function AoqiGodController:getChallengeIdByParam(challengeParam)
	local challengeId = 0
	local activityId = self:getActivityId()
	local cfg = AoqiGodConfig.instance:getClgCfg(activityId)

	for _, data in ipairs(cfg or {}) do
		if data.challengeParam == challengeParam then
			challengeId = data.challengeId

			break
		end
	end

	return challengeId
end

function AoqiGodController:getActivityIdByType(activityType)
	local aoqiActId = self:getActivityId()
	local aoqiGodMo = self:getAoqiGodMo(aoqiActId)

	return aoqiGodMo:getActivityIdByType(activityType)
end

function AoqiGodController:_handleMsgExtension(extId, cmd, status)
	if status == 0 then
		return
	end

	if status == -26802 or status == -26803 then
		local tipsContent = "很遗憾，本挑战已被完成或过期，挑战结束"

		local function okFunc()
			UIStateManager.instance:clear()

			local activityId = self:getActivityId()

			if self:isInActivityTime(activityId) then
				self:enterAoqiGod()
			end
		end

		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", tipsContent, okFunc, "确定", alignment)
	end
end

function AoqiGodController:getClgCfgSort(activityId)
	local clgCfg = AoqiGodConfig.instance:getClgCfg(activityId)
	local dontGetPetCfgList = {}
	local hasGetPetCfgList = {}

	for i, cfg in ipairs(clgCfg) do
		local skinId = cfg.skinId
		local hasPet = PetskinController.instance:checkHasForeverSkinBySkinId(skinId)

		if not hasPet then
			table.insert(dontGetPetCfgList, cfg)
		else
			table.insert(hasGetPetCfgList, cfg)
		end
	end

	table.insertto(dontGetPetCfgList, hasGetPetCfgList)

	return dontGetPetCfgList
end

function AoqiGodController:getPetMoList(activityId)
	local petMoList = {}
	local petChallengeIdMap = self:getPetChallengeIdMap(activityId)
	local clgCfg = AoqiGodConfig.instance:getClgCfg(activityId)
	local aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(activityId)
	local caller = aoqiGodMo:getCaller()
	local curChallengeId = caller and caller:getChallengeId() or 0

	for i, cfg in ipairs(clgCfg) do
		local skinId = cfg.skinId
		local petCfg = CharacterConfig.instance:getPetCo(skinId)

		if petCfg then
			local powerPetMo = FightingPowerPetMo.getMaxPetMo(skinId)

			if powerPetMo then
				table.insert(petMoList, powerPetMo)
			end
		end
	end

	local names, opt = self:GetSortParms(activityId)

	ArraySort.sortOn(petMoList, names, opt)

	return petMoList
end

function AoqiGodController:getPetChallengeIdMap(activityId)
	local challengeMap = {}
	local clgCfg = AoqiGodConfig.instance:getClgCfg(activityId)

	for i, cfg in ipairs(clgCfg) do
		local skinId = cfg.skinId
		local petCfg = CharacterConfig.instance:getPetCo(skinId)

		if petCfg then
			local powerPetMo = FightingPowerPetMo.getMaxPetMo(skinId)

			if powerPetMo then
				challengeMap[powerPetMo.raceId] = cfg.challengeId
			end
		end
	end

	return challengeMap
end

function AoqiGodController:GetSortParms(activityId)
	local petChallengeIdMap = self:getPetChallengeIdMap(activityId)
	local clgCfg = AoqiGodConfig.instance:getClgCfg(activityId)
	local aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(activityId)
	local caller = aoqiGodMo:getCaller()
	local curChallengeId = caller and caller:getChallengeId() or 0

	local function func1(petMo)
		local challengeId = petChallengeIdMap[petMo.raceId]
		local isDoing = challengeId == curChallengeId

		if not isDoing then
			return 0
		else
			return 1
		end
	end

	local function func2(petMo)
		local challengeId = petChallengeIdMap[petMo.raceId]

		if challengeId then
			local finishItem = aoqiGodMo:getFinishItem(challengeId)
			local isHasGain = finishItem ~= nil

			if isHasGain then
				return 0
			else
				return 1
			end
		end

		return 0
	end

	local function func3(petMo)
		local raceId = petMo.raceId
		local petList = BagModel.instance:getPetsByRaceId(raceId)
		local hasPet = #petList > 0

		if hasPet then
			return 0
		else
			return 1
		end
	end

	local function func4(petMo)
		local raceId = petMo.raceId
		local cfg = AoqiGodConfig.instance:getClgDataBySkinId(activityId, raceId)

		return cfg.challengeId
	end

	local function func5(petMo)
		local raceId = petMo.raceId
		local petId = BagModel.instance:getMaxZdlPetIdByRaceId(raceId)

		return (petId or nil) and BagModel.instance:getMaxAwakenLv(raceId)
	end

	local names = {
		func1,
		func2,
		func3,
		func4,
		func5
	}
	local opt = {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NONE
	}

	return names, opt
end

function AoqiGodController:getHelpItemNameListByPetName(activityId, findStr)
	local aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(activityId)
	local wallItemList = aoqiGodMo:getWallItemList()
	local itemList = {}

	if not string.nilorempty(findStr) then
		for i, wallItem in ipairs(wallItemList) do
			local challengeId = wallItem:getChallengeId()
			local cfg = AoqiGodConfig.instance:getClgData(activityId, challengeId)
			local skinId = cfg.skinId
			local petData = CharacterConfig.instance:getPetCo(skinId)

			if petData then
				local petName = petData.name

				if string.find(petName, findStr) then
					table.insert(itemList, wallItem)
				end
			end
		end
	end

	return itemList
end

function AoqiGodController:getSortClgCfgList(activityId)
	local cfg = AoqiGodConfig.instance:getClgCfg(activityId)
	local clgCfgList = {}

	for i, v in ipairs(cfg) do
		table.insert(clgCfgList, v)
	end

	local function func(cfg)
		return cfg.challengeId
	end

	ArraySort.sortOn(clgCfgList, {
		func
	}, {
		ArraySort.DESCENDING
	})

	return clgCfgList
end

AoqiGodController.instance = AoqiGodController.New()

return AoqiGodController
