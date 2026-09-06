-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/controller/AnnimatchController.lua

module("logic.extensions.annimatch.controller.AnnimatchController", package.seeall)

local AnnimatchController = class("AnnimatchController", BaseController)

function AnnimatchController:ctor()
	return
end

function AnnimatchController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self)
	self:onReset()
end

function AnnimatchController:onReset()
	return
end

function AnnimatchController:_onSceneLoadedFinish(sceneType, sceneId)
	if sceneType == SceneType.City then
		self:showChangeSetId()
	end
end

function AnnimatchController:getCurrActId()
	return AnnimatchModel.instance:getCurrActId()
end

function AnnimatchController:checkIsInActTime()
	local activityId = self:getCurrActId()

	return ActivityDefineController.instance:isInActivityTimeById(math.floor(activityId / 1000), activityId)
end

function AnnimatchController:sendCancelMatch(activityId)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionCancelMatchReq(activityId)
end

function AnnimatchController:sendPayTheTicket(activityId)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionParticipateReq(activityId)
end

function AnnimatchController:onJoinMatch(msg)
	self:sendGetInfoWithOpenView(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchPayTheTicket)
end

function AnnimatchController:updateTicketInfo(msg)
	AnnimatchModel.instance:updateTicketInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchTicketUpdate)
end

function AnnimatchController:sendGetInfoWithOpenView(activityId)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionGetInfoReq(activityId)
end

function AnnimatchController:onGetInfoAndOpenView(msg)
	AnnimatchModel.instance:onSetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchInfoUpdate)
end

function AnnimatchController:onMatchError(status)
	if status == -26601 then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), AnnimatchConfig.instance:getCommonByKey("ACT_TIME_OVER"), function()
			UIStateManager.instance:popByName(ViewName.AnnimatchmainView)
			UIStateManager.instance:popByName(ViewName.AnnimatchselectView)
			UIStateManager.instance:popByName(ViewName.AnnimatchfindingView)
			UIStateManager.instance:popByName(ViewName.AnnimatchBuffView)
			UIStateManager.instance:popByName(ViewName.AnnimatchfmtView)
		end)
	end
end

function AnnimatchController:checkHasNextPet(activityId)
	local info = AnnimatchModel.instance:getInfo(activityId)

	if info.alternativeCreepsIds == nil or #info.alternativeCreepsIds == 0 then
		return false
	else
		return true
	end
end

function AnnimatchController:getNextCardArr(activityId)
	local info = AnnimatchModel.instance:getInfo(activityId)

	if info.alternativeCreepsIds == nil or #info.alternativeCreepsIds == 0 then
		return nil
	else
		return info.alternativeCreepsIds
	end
end

function AnnimatchController:sendGetSysPetId(activityId, petId)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionSetSysPetReq(activityId, petId)
end

function AnnimatchController:sendPM_AnnualCompetitionBuySysPetReq(activityId, creepsId)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionBuySysPetReq(activityId, creepsId)
end

function AnnimatchController:onGetSysPet(msg)
	AnnimatchModel.instance:onUpdateSysPet(msg)

	if self:checkHasNextPet(msg.activityId) then
		-- block empty
	else
		UIStateManager.instance:push(ViewName.AnnimatchmainView)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchSelectPetUpdate)
end

function AnnimatchController:handlePM_AnnualCompetitionBuySysPetRes(msg)
	AnnimatchModel.instance:handlePM_AnnualCompetitionBuySysPetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualCompetitionBuySysPetRes)
end

function AnnimatchController:sendPM_AnnualCompetitionRefreshSysPetShopReq(activityId)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionRefreshSysPetShopReq(activityId)
end

function AnnimatchController:handlePM_AnnualCompetitionRefreshSysPetShopRes(msg)
	AnnimatchModel.instance:handlePM_AnnualCompetitionRefreshSysPetShopRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualCompetitionRefreshSysPetShopRes)
end

function AnnimatchController:sendPM_AnnualCompetitionBanPetInfoReq(activityId)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionBanPetInfoReq(activityId)
end

function AnnimatchController:handlePM_AnnualCompetitionBanPetInfoRes(msg)
	AnnimatchModel.instance:handlePM_AnnualCompetitionBanPetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualCompetitionBanPetInfoRes)
end

function AnnimatchController:sendPM_AnnualCompetitionBanPetReq(activityId, raceIds)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionBanPetReq(activityId, raceIds)
end

function AnnimatchController:handlePM_AnnualCompetitionBanPetRes(msg)
	AnnimatchModel.instance:handlePM_AnnualCompetitionBanPetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualCompetitionBanPetRes)
end

function AnnimatchController:sendPM_AnnualCompetitionFinishBuyPetReq(activityId)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionFinishBuyPetReq(activityId)
end

function AnnimatchController:handlePM_AnnualCompetitionFinishBuyPetRes(msg)
	AnnimatchModel.instance:handlePM_AnnualCompetitionFinishBuyPetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_AnnualCompetitionFinishBuyPetRes)
end

function AnnimatchController:sendSetForm(activityId, fmo)
	local simpleForm = fmo:createFormPb()

	simpleForm.formId = 0

	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionSetFormReq(activityId, simpleForm)
end

function AnnimatchController:onSetForm(msg)
	AnnimatchModel.instance:onSetForm(msg)
end

function AnnimatchController:sendSetBuff(activityId, buffId)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionSetBuffReq(activityId, buffId)
end

function AnnimatchController:onSetBuff(msg)
	AnnimatchModel.instance:onSetBuff(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchBuffUpdate)
end

function AnnimatchController:sendReplaceCreeps(activityId, oldCreepsId, newCreepsId)
	AnnualCompetitionAgent.instance:sendPM_AnnualComptitionReplaceCreepsReq(activityId, oldCreepsId, newCreepsId)
end

function AnnimatchController:onReplaceCreeps(msg)
	AnnimatchModel.instance:onReplaceCreeps(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchReplaceCreeps)
end

function AnnimatchController:sendGoGiveup(activityId)
	self.temFindingActID = activityId

	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionGiveUpReq(activityId)
end

function AnnimatchController:onGiveup(msg)
	AnnimatchModel.instance:onGiveup(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchGiveUp)
end

function AnnimatchController:sendGoFinding(activityId)
	self.temFindingActID = activityId

	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionMatchFightReq(activityId)
end

function AnnimatchController:onGoFinding(msg)
	UIStateManager.instance:push(ViewName.AnnimatchfindingView, self.temFindingActID)
end

function AnnimatchController:sendGetRankInfo(activityId)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionViewRankReq(activityId, 1, 100)
end

function AnnimatchController:onGetRankInfo(msg)
	AnnimatchModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchGetRankInfo)
end

function AnnimatchController:sendGetTaskPrize(activityId, taskId)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionGainTaskPrizeReq(activityId, taskId)
end

function AnnimatchController:onGetTaskPrize(msg)
	local info = AnnimatchModel.instance:getTaskInfo(msg.activityId, msg.taskId)

	info.hasGainedPrize = true

	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchGetTaskInfo)
end

function AnnimatchController:sendGetTaskInfo(activityId)
	AnnualCompetitionAgent.instance:sendPM_AnnualCompetitionGetTaskInfoReq(activityId)
end

function AnnimatchController:onGetTaskInfo(msg)
	AnnimatchModel.instance:onGetTaskInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchGetTaskInfo)
end

function AnnimatchController:onNotifyFightResult(msg)
	local myCurWinTimes = msg.myCurWinTimes
	local myCurFailTimes = msg.myCurFailTimes
	local activityId = msg.activityId

	self.curSavechangeSetId = msg.changeSetId

	AnnimatchModel.instance:updateTicketInfo(msg)
	AnnimatchModel.instance:updateWinFalseTime(activityId, myCurWinTimes, myCurFailTimes)
	MaterialController.instance:saveChangeSetToTemp(self.curSavechangeSetId)
	AnnimatchModel.instance:setBattleRes(msg)
	UIStateManager.instance:popByName(ViewName.AnnimatchenterView)
	UIStateManager.instance:popByName(ViewName.AnnimatchmainView)
	UIStateManager.instance:push(ViewName.AnnimatchinfoView)
	GlobalDispatcher:dispatch(GlobalNotify.OnAnnimatchMatchSuccess)
end

function AnnimatchController:showChangeSetId()
	if checknumber(self.curSavechangeSetId) > 0 then
		MaterialController.instance:showChangeSetInTemp(self.curSavechangeSetId)
	end

	self.curSavechangeSetId = 0
end

function AnnimatchController:goBattle()
	local currBattleRes = AnnimatchModel.instance:getBattleRes()

	AnnimatchModel.instance:setBattleRes(nil)

	local attackResult = currBattleRes.battleResult
	local myTeamId = currBattleRes.myTeamId

	BattleModel.instance:setLeftTeamId(myTeamId)
	BattleFacade.instance:startFightingByBtlResult(attackResult, GameEnum.BattleRecordEntry.Scuffle)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self.onBattleEnd, self, currBattleRes))
end

function AnnimatchController:onBattleEnd(msg)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local info = AnnimatchModel.instance:getInfo(msg.activityId)
	local hasTicket = AnnimatchModel.instance:getIsAdmission(msg.activityId)

	if hasTicket then
		UIJumper.instance:pushOneStack(ViewName.AnnimatchmainView, true)
	else
		UIJumper.instance:pushOneStack(ViewName.AnnimatchenterView, true)
	end

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess or BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		UIStateManager.instance:push(ViewName.AnnimatchwinView, true)
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		UIStateManager.instance:push(ViewName.AnnimatchfailView, false)
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		UIStateManager.instance:push(ViewName.AnnimatchfailView, false)
	end

	return true
end

function AnnimatchController:getPlayerUsePetDataList()
	local petDataList = {}
	local petCfgs = CharacterConfig.instance:getPetCfg()

	for i, petCfg in ipairs(petCfgs) do
		if petCfg.raceId < 20000 and checknumber(petCfg.bookIds) > 0 then
			local petData = {}

			petData.raceId = petCfg.raceId
			petData.faceId = checknumber(petCfg.faceIds)

			table.insert(petDataList, petData)
		end
	end

	return petDataList
end

function AnnimatchController:getAllPetMoList()
	local petMoList = {}
	local raceIdList = self:getPlayerUsePetDataList()

	for i, data in ipairs(raceIdList) do
		local petMo = FightingPowerPetMo.getMaxPetMo(data.raceId, data.faceId)

		table.insert(petMoList, petMo)
	end

	return petMoList
end

function AnnimatchController:getAllPetIdxMap()
	local petMap = {}
	local petMoList = self:getAllPetMoList()
	local names, opt = self:GetSortParms()

	names[1] = FormationGroupModel.instance.checkIsInTeamByMo

	ArraySort.sortOn(petMoList, names, opt)

	for idx, petMo in ipairs(petMoList) do
		if self:onFilter(petMo) then
			local id = petMo.raceId

			petMap[id] = idx
		end
	end

	return petMap
end

function AnnimatchController:getActSysPetMoList(activityId)
	local petMoList = {}
	local actCfg = AnnimatchConfig.instance:getCfgById(activityId)
	local planId = actCfg.systemPetPlanId
	local sysPetCfgs = AnnimatchConfig.instance:getPetCfgs(planId)

	for i, cfg in pairs(sysPetCfgs) do
		local raceId = cfg.raceId
		local petMo = FightingPowerPetMo.getMaxPetMo(raceId, cfg.faceId)

		table.insert(petMoList, petMo)
	end

	return petMoList
end

function AnnimatchController:getAllSysPetIdxMap(activityId)
	local petMap = {}
	local petMoList = self:getActSysPetMoList(activityId)
	local names, opt = self:GetSortParms()

	names[1] = FormationGroupModel.instance.checkIsInTeamByMo

	ArraySort.sortOn(petMoList, names, opt)

	for idx, petMo in ipairs(petMoList) do
		if self:onFilter(petMo) then
			local id = petMo.raceId

			petMap[id] = idx
		end
	end

	return petMap
end

function AnnimatchController:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)

	return (self:_isMatch(petCo, pet.rare, pet.faceId))
end

function AnnimatchController:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_ANNI_MATCH_BAN, cfg, rare, skinId)
end

function AnnimatchController:GetSortParms(checkIsInTeamFunc)
	local parm1 = {}
	local parm2 = {}
	local sortName

	local function func(data)
		local res = 0

		if checkIsInTeamFunc then
			if data ~= nil then
				res = checkIsInTeamFunc(data)
			end
		elseif data ~= nil and FormationNewModel.instance:HasPetAtCurFormation(data.petId) then
			res = 1
		end

		return res
	end

	local function funcTop(petMo)
		local isTop = BagPetsController.instance:getPetIsTop(petMo.petId)

		return isTop and 1 or 0
	end

	table.insert(parm1, func)
	table.insert(parm2, ArraySort.DESCENDING)
	table.insert(parm1, funcTop)
	table.insert(parm2, ArraySort.DESCENDING)
	table.insert(parm1, "isSupportedPet")
	table.insert(parm2, ArraySort.DESCENDING)

	local sortValue = {}

	for i = 1, #BagModel.SORT_NAME do
		sortValue[i] = i == 1 and 1 or 0
	end

	for k, v in ipairs(sortValue) do
		local vArr = BagModel.SORT_VALUE[k]

		if vArr[v + 1] ~= -1 then
			table.insert(parm1, BagModel.SORT_NAME[k])
			table.insert(parm2, vArr[v + 1])
		end
	end

	return parm1, parm2
end

AnnimatchController.instance = AnnimatchController.New()

return AnnimatchController
