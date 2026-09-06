-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/agent/ArenaAgent.lua

module("logic.extensions.arena.agent.ArenaAgent", package.seeall)

local ArenaAgent = class("ArenaAgent", BaseAgent)

ArenaAgent.OpenArenaRes = "ArenaAgent_OpenArenaRes"
ArenaAgent.ArenaSweepRes = "ArenaAgent_ArenaSweepRes"
ArenaAgent.GetMyZoneInRes = "ArenaAgent_GetMyZoneInRes"
ArenaAgent.GainDailyTaskPrizeRes = "ArenaAgent_GainDailyTaskPrizeRes"
ArenaAgent.BuyChallengeTimesRes = "ArenaAgent_BuyChallengeTimesRes"
ArenaAgent.ClearChallengeCdRes = "ArenaAgent.ClearChallengeCdRes"
ArenaAgent.ArenaChallengeRes = "ArenaAgent_ArenaChallengeRes"
ArenaAgent.SetMyArenaFormationRes = "ArenaAgent.SetMyArenaFormationRes"

function ArenaAgent:sendOpenArenaReq(handler, handlerObj, errHandler)
	local req = ArenaExtension_pb.OpenArenaReq()

	self:sendMsg(req)
	self:addEventOnce(ArenaAgent.OpenArenaRes, handler, handlerObj, errHandler)
end

function ArenaAgent:handleOpenArenaRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadArena===back")
	self:dispatch(ArenaAgent.OpenArenaRes, status, msg)
end

function ArenaAgent:sendRefreshChallengeTargetsReq(seasonId)
	local req = ArenaExtension_pb.RefreshChallengeTargetsReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function ArenaAgent:handleRefreshChallengeTargetsRes(status, msg)
	if status == 0 then
		ArenaModel.instance:setTargets(msg)
		ArenaModel.instance:setRefreshCd(msg.cd)
		ArenaModel.instance:setRefreshCnt(msg.usedTimes)
		ArenaController.instance:localNotify("RefreshArenaInfo")
	end
end

function ArenaAgent:sendGetMyArenaChallengeRecordsReq()
	local req = ArenaExtension_pb.GetMyArenaChallengeRecordsReq()

	self:sendMsg(req)
end

function ArenaAgent:handleGetMyArenaChallengeRecordsRes(status, msg)
	if status == 0 then
		local rec = msg.records

		table.sort(rec, function(x, y)
			return x.challnegeTime > y.challnegeTime
		end)

		if SceneMgr.instance.isGogingToEnterBattleScene then
			return
		end

		UIStateManager.instance:open(ViewName.ArenaReportView, rec)
	end
end

function ArenaAgent:sendArenaChallengeReq(seasonId, position, isXiaoNuoAssist)
	local req = ArenaExtension_pb.ArenaChallengeReq()

	req.seasonId = seasonId
	req.position = position

	self:sendMsg(req)

	self._isXiaoNuoAssist = isXiaoNuoAssist
end

function ArenaAgent:handleArenaChallengeRes(status, msg)
	if status == 0 then
		printInfo("test ArenaAgent:handleArenaChallengeRes", self._isXiaoNuoAssist)

		if self._isXiaoNuoAssist then
			ArenaModel.instance:onArenaChallengeRes(msg)
		else
			if msg.battleResult then
				BattleFacade.instance:startFightingByBtlResult(msg.battleResult, GameEnum.BattleRecordEntry.Arena)
				UIJumper.instance:pushOneStack(ViewName.ArenaMainView, true)
			end

			ArenaController.instance:getArenaInfos()

			local oldPosition = ArenaModel.instance:getPosition()
			local newPosition = msg.newPosition == 0 and oldPosition or msg.newPosition
			local params = {
				preRank = oldPosition,
				postRank = newPosition
			}

			BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Arena, params)
		end
	elseif status == -2427 then
		FloatWordMgr.instance:show("请重新选择挑战对象")
	elseif status == -2428 then
		ArenaController.instance:showBuyCD()
	elseif status == -2402 then
		local buyTimes = ArenaModel.instance:getChallengeBuyTime()
		local totalCanBuyTimes = VipModel.instance:getAbleToBuyTimesOfArena()
		local leftBuyCnt = totalCanBuyTimes - buyTimes

		if leftBuyCnt > 0 then
			local cost = ArenaConfig.instance:getBuyTimeCost(buyTimes + 1)
			local list = string.split(cost, ":")

			if list and #list >= 3 then
				local matType, matId, num = tonumber(list[1]), tonumber(list[2]), tonumber(list[3])

				TipsFacade.instance:openPopupCostDiamondView(num, string.format("确定花费<color=#d44c28>%d钻石</color>购买挑战次数吗？\n<size=20>每天最多可购买%d次，还能购买%d次</size>", num, totalCanBuyTimes, leftBuyCnt), function()
					ArenaController.instance:addClg()
				end)
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)

	self._isXiaoNuoAssist = nil

	self:dispatch(ArenaAgent.ArenaChallengeRes, status, msg)
end

function ArenaAgent:showChangeSet(changeSetId, name)
	if name == "handleArenaChallengeRes" then
		printInfo("竞技场设置changeSetId", changeSetId, name)
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
		ArenaModel.instance:setChangeSetId(changeSetId)
	elseif name == "handleArenaSweepRes" then
		-- block empty
	else
		ArenaAgent.super.showChangeSet(self, changeSetId, name)
	end
end

function ArenaAgent:sendGetVideoReq(battleId)
	local req = ArenaExtension_pb.GetVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function ArenaAgent:handleGetVideoRes(status, msg)
	if status == 0 and msg.btlResult then
		BattleFacade.instance:onViewUserFightMonsterBtlResult(msg.btlResult)
	end
end

function ArenaAgent:sendGetTopDetailReq(zoneId, fromPosition, endPosition)
	local req = ArenaExtension_pb.GetTopDetailReq()

	self._cacheIndex = zoneId
	req.zoneId = zoneId
	req.fromPosition = fromPosition
	req.endPosition = endPosition

	self:sendMsg(req)
end

function ArenaAgent:handleGetTopDetailRes(status, msg)
	if status == 0 then
		local ranks = {}

		ranks.rankList = {}
		ranks.myRank = 0

		printInfo("LoginModel.instance.userId:" .. LoginModel.instance.userId)

		for i, v in ipairs(msg.topInfos) do
			local rankInfo = {}

			rankInfo.isShowDefBtn = true
			rankInfo.headInfo = v.headInfo
			rankInfo.familyName = v.familyName
			rankInfo.everMaxZdl = v.everMaxZdl or 10000
			rankInfo.rank = v.position

			table.insert(ranks.rankList, rankInfo)

			if tonumber(v.headInfo.userId) == tonumber(LoginModel.instance.userId) then
				ranks.myRank = rankInfo.rank
			end
		end

		ranks.myRankTip = lang("提示：竞技场在每天4:00-5:00关闭并更新排名")

		RankModel.instance:setRankData(ranks, GameEnum.RankType.Arena, 0)
		GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
	end
end

function ArenaAgent:sendGetDailyTaskInfoReq()
	local req = ArenaExtension_pb.GetDailyTaskInfoReq()

	self:sendMsg(req)
end

function ArenaAgent:handleGetDailyTaskInfoRes(status, msg)
	if status == 0 then
		if SceneMgr.instance.isGogingToEnterBattleScene then
			return
		end

		if ViewMgr.instance:isOpen(ViewName.ArenaTaskView) then
			ViewMgr.instance:close(ViewName.ArenaTaskView)
		end

		UIStateManager.instance:open("arenaTaskView", msg.tasks)
	end
end

function ArenaAgent:sendGetAchievePrizeInfoReq()
	local req = ArenaExtension_pb.GetAchievePrizeInfoReq()

	self:sendMsg(req)
end

function ArenaAgent:handleGetAchievePrizeInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ArenaAchievePrize, msg.arenaAchieveInfos)
	end
end

function ArenaAgent:sendGainAchievePrizeReq()
	local req = ArenaExtension_pb.GainAchievePrizeReq()

	self:sendMsg(req)
end

function ArenaAgent:handleGainAchievePrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ArenaGainAchieve, msg)
	end
end

function ArenaAgent:sendRefreshDailyTaskInfoReq(index)
	local req = ArenaExtension_pb.RefreshDailyTaskInfoReq()

	req.index = index

	self:sendMsg(req)
end

function ArenaAgent:handleRefreshDailyTaskInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ArenaTaskRefresh, msg)
	end
end

function ArenaAgent:sendSetMyArenaFormationReq(req)
	self:sendMsg(req)
end

function ArenaAgent:handleSetMyArenaFormationRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.FormationRefresh)
		GlobalDispatcher:dispatch(ArenaAgent.SetMyArenaFormationRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseSaveFmtFailed)
	end
end

local nowFromUserId = -1

function ArenaAgent:sendGetMyArenaFormationReq()
	local req = ArenaExtension_pb.GetMyArenaFormationReq()

	nowFromUserId = RoleModel.instance:getUserId()

	print("sendGetMyArenaFormationReq@@@@@@@@")
	self:sendMsg(req)
end

function ArenaAgent:sendGetOtherArenaFormationReq(targetUserId)
	local req = ArenaExtension_pb.GetOtherArenaFormationReq()

	req.targetUserId = targetUserId
	nowFromUserId = targetUserId

	print("sendGetOtherArenaFormationReq!!!!!!")
	self:sendMsg(req)
end

function ArenaAgent:handleGetArenaFormationRes(status, msg)
	if status == 0 then
		local playerview = msg.playerView

		if nowFromUserId == RoleModel.instance:getUserId() then
			FormationNewModel.instance:setArenaTeam(playerview.curForm)
			ArenaModel.instance:setOtherPlayerForm(playerview)
			ArenaController.instance:localNotify("RefreshOtherForm")

			if ArenaModel.instance:getOpenArenaFmtViewTag() then
				ArenaModel.instance:setOpenArenaFmtViewTag(false)

				local oriTeamId = FormationNewModel.instance:GetCurTeamId()

				UIStateManager.instance:push(ViewName.ArenaFmtView, oriTeamId)
			end
		else
			ArenaModel.instance:setOtherPlayerForm(playerview)
			ArenaController.instance:localNotify("RefreshOtherForm")
		end
	elseif status == -2401 then
		local str = MsgFlowMgr.instance:getResultCodeStr(status)

		UIStateManager.instance:popByName(ViewName.Arenamission)
		UIStateManager.instance:popByName(ViewName.ArenaMainView)
		TipsFacade.instance:openTipWindow("提示", str)
	end
end

function ArenaAgent:sendBuyChallengeTimesReq(seasonId, time)
	local req = ArenaExtension_pb.BuyChallengeTimesReq()

	req.seasonId = seasonId
	req.buyTimes = time

	self:sendMsg(req)
end

function ArenaAgent:handleBuyChallengeTimesRes(status, msg)
	if status == 0 then
		ArenaModel.instance:setChallengeBuyTime(msg.hasBuyTimes)
		ArenaModel.instance:setLeftChallengeTimes(msg.leftChallengeTimes)
		ArenaController.instance:localNotify(ArenaController.RefreshChallengeTimes)
		GlobalDispatcher:dispatch(GlobalNotify.RefreshSweepView)
		FloatWordMgr.instance:show("成功购买次数")
	end

	GlobalDispatcher:dispatch(ArenaAgent.BuyChallengeTimesRes, status)
end

function ArenaAgent:sendClearChallengeCdReq(seasonId, expectBuyCount)
	local req = ArenaExtension_pb.ClearChallengeCdReq()

	req.seasonId = seasonId
	req.expectBuyCount = expectBuyCount

	self:sendMsg(req)
end

function ArenaAgent:handleClearChallengeCdRes(status, msg)
	printInfo("handleClearChallengeCdRes:" .. status)

	if status == 0 then
		ArenaModel.instance:clearChallengeCD()
		ArenaController.instance:localNotify("ChallengeCdChange")
	end

	ArenaController.instance:SetWaitingClearTime(false)
	GlobalDispatcher:dispatch(ArenaAgent.ClearChallengeCdRes, status)
end

function ArenaAgent:sendGainDailyTaskPrizeReq(index, handler, handlerObj, errHandler)
	local req = ArenaExtension_pb.GainDailyTaskPrizeReq()

	req.index = index

	self:sendMsg(req)
	self:addEventOnce(ArenaAgent.GainDailyTaskPrizeRes, handler, handlerObj, errHandler)
end

function ArenaAgent:handleGainDailyTaskPrizeRes(status, msg)
	self:dispatch(ArenaAgent.GainDailyTaskPrizeRes, status, msg)
end

function ArenaAgent:sendArenaSweepReq(seasonId, sweepTimes, handler, handlerObj, errHandler)
	local req = ArenaExtension_pb.ArenaSweepReq()

	req.seasonId = seasonId
	req.sweepTimes = sweepTimes

	self:sendMsg(req)
	self:addEventOnce(ArenaAgent.ArenaSweepRes, handler, handlerObj, errHandler)
end

function ArenaAgent:handleArenaSweepRes(status, msg)
	self:dispatch(ArenaAgent.ArenaSweepRes, status, msg)
end

function ArenaAgent:sendGetMyZoneInReq(handler, handlerObj, errHandler)
	local req = ArenaExtension_pb.GetMyZoneInReq()

	self:sendMsg(req)
	self:addEventOnce(ArenaAgent.GetMyZoneInRes, handler, handlerObj, errHandler)
end

function ArenaAgent:handleGetMyZoneInRes(status, msg)
	self:dispatch(ArenaAgent.GetMyZoneInRes, status, msg)
end

ArenaAgent.instance = ArenaAgent.New()

return ArenaAgent
