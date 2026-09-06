-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/controller/CampScuffleController.lua

module("logic.extensions.funcamp.controller.CampScuffleController", package.seeall)

local CampScuffleController = class("CampScuffleController", BaseController)

function CampScuffleController:ctor()
	return
end

function CampScuffleController:onInit()
	CampScuffleAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.showChangeSet, self))
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updateByDay, self)
end

function CampScuffleController:showChangeSet(changeSetId, msgName)
	if msgName == "handleCS_NotifyGameEndRes" then
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

function CampScuffleController:_updateByDay()
	GlobalDispatcher:dispatch(GlobalNotify.CS_ScuffleInfoRes)
end

function CampScuffleController:onInfoRes(status, msg)
	if status == 0 then
		CampScuffleModel.instance:onScuffleInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CS_ScuffleInfoRes, true)
	else
		GlobalDispatcher:dispatch(GlobalNotify.CS_ScuffleInfoRes, false)
	end
end

function CampScuffleController:onStartMatchingRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.CS_StartMatchingRes, msg)
	end
end

function CampScuffleController:onCancelMatchingRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.CS_CancelMatchingRes, true)
	else
		GlobalDispatcher:dispatch(GlobalNotify.CS_CancelMatchingRes, false)
	end
end

function CampScuffleController:onLeaveGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.CS_LeaveGameRes, msg)
	end
end

function CampScuffleController:onBanPetRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.CS_BanPetRes, msg)
	end
end

function CampScuffleController:onSetFormRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.CS_SetFormRes, msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function CampScuffleController:onGetRankInfoRes(status, msg)
	if status == 0 then
		CampScuffleModel.instance:onGetRankInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CS_GetRankInfoRes, msg)
	end
end

function CampScuffleController:onGetBattleRecordRes(status, msg)
	if status == 0 then
		CampScuffleModel.instance:onGetBattleRecordRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CS_GetBattleRecordRes)
	end
end

function CampScuffleController:onGetBattleVideoRes(status, msg)
	if status == 0 then
		CampScuffleModel.instance:onGetBattleVideoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CS_GetBattleVideoRes, msg.battleResult)
	end
end

function CampScuffleController:onAchievePrizeInfoRes(status, msg)
	if status == 0 then
		CampScuffleModel.instance:onAchievePrizeInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CS_AchievePrizeInfoRes)
	end
end

function CampScuffleController:onGainAchievePrizeRes(status, msg)
	if status == 0 then
		CampScuffleModel.instance:updateAchievePrizeGainBit(msg.id)
		GlobalDispatcher:dispatch(GlobalNotify.CS_GainAchievePrizeRes, msg.id)
	end
end

function CampScuffleController:onNotifyMatchingOverTimeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.CS_NotifyMatchingOverTimeRes, msg)
	end
end

function CampScuffleController:onNotifyMatchFailRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.CS_NotifyMatchFailRes, msg)
	end
end

function CampScuffleController:onNotifyGameStartRes(status, msg)
	if status == 0 then
		CampScuffleModel.instance:onGameStartRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CS_NotifyGameStartRes, msg)
	end
end

function CampScuffleController:onNotfiyStartSetFormRes(status, msg)
	if status == 0 then
		CampScuffleModel.instance:onNofityStartSetFormRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CS_NotfiyStartSetFormRes, msg)
	end
end

function CampScuffleController:onNotifiyOpReadyFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.CS_NotifiyOpReadyFightRes, msg)
	end
end

function CampScuffleController:onNotifyGameEndRes(status, msg)
	if status == 0 then
		CampScuffleModel.instance:onGameEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CS_NotifyGameEndRes, msg)
	end
end

function CampScuffleController:onBuyTimesRes(status, msg)
	if status == 0 then
		CampScuffleModel.instance:onBuyTimesRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CS_BuyTimesRes, msg)
	end
end

function CampScuffleController:sendCS_BanPetReq()
	CampScuffleAgent.instance:sendCS_BanPetReq(CampScuffleModel.instance:getMyBanList())
end

function CampScuffleController:isExistCfgInActivityTime()
	return (ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.FUN_CAMP_BATTLE))
end

function CampScuffleController:getCurLevelCfg()
	local score = CampScuffleModel.instance:getScore()

	return CampGameConfig.instance:getLevelCfgByScore(score)
end

function CampScuffleController:getScoreDisctanceOnNextLevel()
	local curScore = CampScuffleModel.instance:getScore()
	local cfgs = CampGameConfig.instance:getLevelCfgs()
	local curCfg = self:getCurLevelCfg()

	if curCfg.level + 1 > #cfgs then
		return 0
	else
		local nextLevel = cfgs[curCfg.level + 1].baseScore

		return nextLevel - curScore
	end
end

function CampScuffleController:_isInTime(key)
	return
end

function CampScuffleController:isInOpenTimeDaily()
	local value = CampGameConfig.instance:getCommonValueByKey("OPEN_TIME")
	local array = string.split(value, ",")

	for i, v in ipairs(array) do
		local times = string.split(v, "#")

		if GameUtil.checkIsInTimePeriod(times[1], times[2], true) then
			return true
		end
	end

	return false
end

function CampScuffleController:getOpenTimeTxt()
	local value = CampGameConfig.instance:getCommonValueByKey("OPEN_TIME")

	return string.gsub(value, "#", "-")
end

function CampScuffleController:onGameEndRes(callback)
	if CampScuffleModel.instance:isNormalBattle() then
		local attackResult = CampScuffleModel.instance:getBattleResult()

		BattleFacade.instance:startFightingByBtlResult(attackResult, GameEnum.BattleRecordEntry.CampScuffle)
		BattleFacade.instance:startCampScuffle()
		printInfo("test 我的teamId", CampScuffleModel.instance:getMyTeamId())
		BattleModel.instance:setLeftTeamId(CampScuffleModel.instance:getMyTeamId())
		UIJumper.instance:pushOneStack(ViewName.FunCampMainView, true)
		UIJumper.instance:pushOneStack(ViewName.CampScuffleMainView, true)
	else
		local state = CampScuffleModel.instance:getResultState()

		if state == 2 then
			FloatWordMgr.instance:show(lang("scuffleTip1"))
		elseif state == 3 then
			FloatWordMgr.instance:show(lang("scuffleTip2"))
		else
			FloatWordMgr.instance:show(lang("scuffleTip3"))
		end

		GameUtil.callBack(callback)
	end
end

function CampScuffleController:onClickAddBuyScuffleTimes()
	local maxCfgGameCount = checknumber(CampGameConfig.instance:getCommonValueByKey("DAILY_TIME_LIMIT"))
	local curGameTime = CampScuffleModel.instance:getCurGameTimes()
	local maxGameTime = CampScuffleModel.instance:getTotalMaxGameTimes(maxCfgGameCount)
	local isLeftTime = curGameTime < maxGameTime

	if isLeftTime then
		FloatWordMgr.instance:show("次数用完才可购买哦")

		return
	end

	local buyTimes = CampScuffleModel.instance:getGameBuyTimes()
	local activityId = FunCampModel.instance:getActivityId()
	local cfgActivity = CampGameConfig.instance:getSeasonCfg(activityId)
	local cfg = CampGameConfig.instance:getGameBuyCfg(cfgActivity.buyPlanId, buyTimes)

	if cfg then
		local matType, id, count = MaterialMgr.getMatParams(cfg.price)
		local content = langPara("是否花费%s%s增加1次次数", count, MaterialMgr.getMaterialsName(matType, id))

		TipsFacade.instance:openPopupCostMatViewNew(matType, id, count, content, function()
			CampScuffleAgent.instance:sendCS_BuyTimesReq()
		end)
	end
end

function CampScuffleController:getGameTimesText()
	local maxCfgGameCount = checknumber(CampGameConfig.instance:getCommonValueByKey("DAILY_TIME_LIMIT"))
	local curUseGameCount = CampScuffleModel.instance:getCurGameTimes()
	local maxGameCount = CampScuffleModel.instance:getTotalMaxGameTimes(maxCfgGameCount)
	local leftGameCount = Mathf.Max(maxGameCount - curUseGameCount, 0)

	return string.format("今日次数：%d/%d", leftGameCount, maxCfgGameCount), leftGameCount
end

function CampScuffleController:isMatchGameTime()
	local activityId = FunCampModel.instance:getActivityId()
	local cfgActivity = FunCampConfig.instance:getActivityCfg(activityId)

	if cfgActivity then
		return GameUtil.checkIsInTimePeriod(cfgActivity.battleStartTime, cfgActivity.battleEndTime)
	else
		return false
	end
end

CampScuffleController.instance = CampScuffleController.New()

return CampScuffleController
