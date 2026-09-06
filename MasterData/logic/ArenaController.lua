-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/controller/ArenaController.lua

module("logic.extensions.arena.controller.ArenaController", package.seeall)

local ArenaController = class("ArenaController", BaseController)

ArenaController.RefreshChallengeTimes = "RefreshChallengeTimes"

function ArenaController:getZoneInfos()
	return
end

function ArenaController:onInit()
	GlobalDispatcher:addListener("openArenaSafe", self.openArenaSafe, self)
end

function ArenaController:onReset()
	GlobalDispatcher:removeListener(ArenaAgent.ClearChallengeCdRes, self._clearChallengeCdRes, self)
	GlobalDispatcher:removeListener(ArenaAgent.BuyChallengeTimesRes, self._buyChallengeTimesRes, self)
end

function ArenaController:getArenaInfos()
	local function resFunc(msg)
		self:openArenaRes(msg)
	end

	ArenaAgent.instance:sendOpenArenaReq(resFunc, nil, nil)
end

function ArenaController:sendOpenArenaReq(handler, handlerObj, errHandler)
	ArenaAgent.instance:sendOpenArenaReq(handler, handlerObj, errHandler)
end

function ArenaController:openArenaSafe()
	local function resFunc(msg)
		self:openArenaRes(msg)
		self:openArena()
	end

	self:sendOpenArenaReq(resFunc)
end

function ArenaController:openArena()
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	UIStateManager.instance:push(ViewName.ArenaMainView)
end

function ArenaController:refreshTargets()
	ArenaAgent.instance:sendRefreshChallengeTargetsReq(ArenaModel.instance:getSeasonId())
end

function ArenaController:openArenaRes(msg)
	ArenaModel.instance:setSeasonId(msg.seasonId)
	ArenaModel.instance:initArenaMO(msg.zoneInfo)
	self:localNotify("RefreshArenaInfo")
end

function ArenaController:startArenaFight(challengerPos, isFake)
	if not isFake then
		-- block empty
	end

	local leftTime = ArenaModel.instance:getLeftChallengeTimes()

	if leftTime <= 0 then
		local buyTimes = ArenaModel.instance:getChallengeBuyTime()
		local totalCanBuyTimes = VipModel.instance:getAbleToBuyTimesOfArena()
		local leftBuyCnt = totalCanBuyTimes - buyTimes
		local notPass = true

		if leftBuyCnt > 0 then
			local cost = ArenaConfig.instance:getBuyTimeCost(buyTimes + 1)
			local list = string.split(cost, ":")

			if list and #list >= 3 then
				notPass = false

				local function sureFunc()
					GlobalDispatcher:addListener(ArenaAgent.BuyChallengeTimesRes, self._buyChallengeTimesRes, self)
					ArenaController.instance:addClg(1)
				end

				local function cancelFunc()
					GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
				end

				local matType, matId, num = tonumber(list[1]), tonumber(list[2]), tonumber(list[3])

				TipsFacade.instance:openPopupCostDiamondView(num, string.format("确定花费<color=#d44c28>%d钻石</color>购买挑战次数吗？\n<size=20>每天最多可购买%d次，还能购买%d次</size>", num, totalCanBuyTimes, leftBuyCnt), sureFunc, nil, nil, nil, cancelFunc)
			end
		else
			FloatWordMgr.instance:show("可购买挑战次数不足")
		end

		if notPass then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
		end
	else
		local cdTime = ArenaModel.instance:getChallengeCdEndTime() - ServerTime.now()

		if cdTime > 0 then
			local min = ArenaConfig.instance:getValue("CLEAR_CHALLENGE_CD_UNIT") or 0
			local cost = math.ceil(cdTime / (min * 60))

			local function cancelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
			end

			TipsFacade.instance:openPopupCostDiamondView(cost, string.format("确定花费<color=#d44c28>%d钻石</color>清除冷却时间吗？", cost), function()
				cdTime = ArenaModel.instance:getChallengeCdEndTime() - ServerTime.now()

				if cdTime > 0 then
					cost = math.ceil(cdTime / (min * 60))
					self.waiting_clear_time = true

					GlobalDispatcher:addListener(ArenaAgent.ClearChallengeCdRes, self._clearChallengeCdRes, self)
					ArenaController.instance:clearCD(cost)
				else
					self.waiting_clear_time = false

					GlobalDispatcher:removeListener(ArenaAgent.ClearChallengeCdRes, self._clearChallengeCdRes, self)
					ArenaController.instance:startArenaFight(ArenaModel.instance:getCurChallengerPos())
				end
			end, nil, nil, nil, cancelFunc)

			return
		end

		local curChallengerUserId = ArenaModel.instance:getCurChallengerUserId()
		local isRobot = checknumber(curChallengerUserId) <= 0

		if isRobot then
			local tipsContent = lang("您所挑战的玩家为守卫，确认消耗一次挑战次数，且立即获胜并刷新排名")

			local function okFunc()
				ArenaAgent.instance:sendArenaChallengeReq(ArenaModel.instance:getSeasonId(), challengerPos, true)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")

			return
		else
			ArenaAgent.instance:sendArenaChallengeReq(ArenaModel.instance:getSeasonId(), challengerPos)
		end
	end
end

function ArenaController:_buyChallengeTimesRes(status)
	GlobalDispatcher:removeListener(ArenaAgent.BuyChallengeTimesRes, self._buyChallengeTimesRes, self)

	if status == 0 then
		ArenaController.instance:startArenaFight(ArenaModel.instance:getCurChallengerPos())
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function ArenaController:_clearChallengeCdRes(status)
	GlobalDispatcher:removeListener(ArenaAgent.ClearChallengeCdRes, self._clearChallengeCdRes, self)

	if status == 0 then
		ArenaController.instance:startArenaFight(ArenaModel.instance:getCurChallengerPos())
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function ArenaController:clearCD(cnt)
	ArenaAgent.instance:sendClearChallengeCdReq(ArenaModel.instance:getSeasonId(), cnt)
end

function ArenaController:showBuyCD()
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	if self:GetWaitingClearTime() then
		return
	end

	local cost = 0
	local leftTime = ArenaModel.instance:getChallengeCdEndTime() - ServerTime.now()
	local min = ArenaConfig.instance:getValue("CLEAR_CHALLENGE_CD_UNIT") or 0

	cost = math.ceil(leftTime / (min * 60))

	TipsFacade.instance:openPopupCostDiamondView(cost, string.format("确定花费<color=#d44c28>%d钻石</color>清除冷却时间吗？", cost), function()
		leftTime = ArenaModel.instance:getChallengeCdEndTime() - ServerTime.now()

		if leftTime > 0 then
			cost = math.ceil(leftTime / (min * 60))
			self.waiting_clear_time = true

			ArenaController.instance:clearCD(cost)
		else
			self.waiting_clear_time = false
		end
	end)
end

function ArenaController:addClg(time)
	ArenaAgent.instance:sendBuyChallengeTimesReq(ArenaModel.instance:getSeasonId(), time)
end

function ArenaController:SetWaitingClearTime(tag)
	if not tag then
		settimer(3, function()
			self.waiting_clear_time = tag
		end, self, false)
	else
		self.waiting_clear_time = tag
	end
end

function ArenaController:GetWaitingClearTime()
	return self.waiting_clear_time
end

function ArenaController:sendArenaSweepReq(seasonId, sweepTimes, handler, handlerObj, errHandler)
	ArenaAgent.instance:sendArenaSweepReq(seasonId, sweepTimes, handler, handlerObj, errHandler)
end

function ArenaController:sendGainDailyTaskPrizeReq(index, handler, handlerObj, errHandler)
	local currMs = ServerTime.nowMs()

	if not self.lastGetTaskPrizeTime or currMs - self.lastGetTaskPrizeTime > 200 then
		self.lastGetTaskPrizeTime = currMs

		ArenaAgent.instance:sendGainDailyTaskPrizeReq(index, handler, handlerObj, errHandler)
	end
end

function ArenaController:sendGetMyZoneInReq(handler, handlerObj, errHandler)
	ArenaAgent.instance:sendGetMyZoneInReq(handler, handlerObj, errHandler)
end

function ArenaController:trySweepInSelectView(time)
	local canClgCount = ArenaModel.instance:getLeftChallengeTimes()

	if canClgCount < 1 then
		FloatWordMgr.instance:show("今天剩余的挑战次数不足以扫荡1次")

		return
	end

	time = time or canClgCount

	local function insertTolist(list, input, delimiter)
		local arr = string.split(input, "#")

		for i, str in ipairs(arr) do
			if string.trim(str) ~= "" then
				table.insert(list, str)
			end
		end
	end

	local function resFunc(msg)
		local newList = {}
		local items = msg.items

		for i, v in ipairs(items) do
			local list = {}

			insertTolist(list, v, "#")

			local data = {
				times = i,
				list = list
			}

			table.insert(newList, data)
		end

		local function resOpenMsg(msg)
			ArenaController.instance:openArenaRes(msg)
			self:_openMopup(newList)
			UIStateManager.instance:popByName(ViewName.ArenaSweepSelectView)
		end

		ArenaController.instance:sendOpenArenaReq(resOpenMsg)
	end

	local seasonId = ArenaModel.instance:getSeasonId()

	ArenaController.instance:sendArenaSweepReq(seasonId, time, resFunc)
end

function ArenaController:_openMopup(rewardList)
	local seasonId = ArenaModel.instance:getSeasonId()

	local function getOneCostCallBack()
		return 0
	end

	local function getConditionCallBack()
		local canClgCount = ArenaModel.instance:getLeftChallengeTimes()
		local totalCnt = ArenaModel.instance:getChallengeMaxTimes()

		return "挑战次数：" .. canClgCount .. "/" .. totalCnt, "  "
	end

	local function getAutoDataCallBack()
		return false
	end

	local function insertTolist(list, input, delimiter)
		local arr = string.split(input, "#")

		for i, str in ipairs(arr) do
			if string.trim(str) ~= "" then
				table.insert(list, str)
			end
		end
	end

	local function clickStarCallBack(type, param)
		local leftTime = ArenaModel.instance:getLeftChallengeTimes()

		if leftTime <= 0 then
			local buyTimes = ArenaModel.instance:getChallengeBuyTime()
			local totalCanBuyTimes = VipModel.instance:getAbleToBuyTimesOfArena()
			local leftBuyCnt = totalCanBuyTimes - buyTimes

			if leftBuyCnt > 0 then
				ArenaController.instance:buyClgTime()

				return
			end

			FloatWordMgr.instance:show("剩余挑战次数不足1次")

			return
		end

		local function resFunc(msg)
			local newList = {}
			local items = msg.items

			for i, v in ipairs(items) do
				local list = {}

				insertTolist(list, v, "#")

				local data = {
					times = i,
					list = list
				}

				table.insert(newList, data)
			end

			local function resOpenMsg(msg)
				ArenaController.instance:openArenaRes(msg)
				GlobalDispatcher:dispatch(GlobalNotify.RefreshSweepView)

				if param.func then
					param.func(newList)
				end
			end

			ArenaController.instance:sendOpenArenaReq(resOpenMsg)
		end

		ArenaController.instance:sendArenaSweepReq(seasonId, param.times > 1 and 5 or 1, resFunc)
	end

	local function getChallengeLeftTimeCallBack()
		return ArenaModel.instance:getLeftChallengeTimes()
	end

	MopupModel.instance:setSweepType(GameEnum.SweepType.Arena)
	UIStateManager.instance:open(ViewName.MopupMainView, clickStarCallBack, getChallengeCallBack, getOneCostCallBack, getConditionCallBack, nil, getAutoDataCallBack, getChallengeLeftTimeCallBack, rewardList)
end

function ArenaController:buyClgTime()
	local buyTimes = ArenaModel.instance:getChallengeBuyTime()
	local totalCanBuyTimes = VipModel.instance:getAbleToBuyTimesOfArena()
	local leftBuyCnt = totalCanBuyTimes - buyTimes
	local cost = ArenaConfig.instance:getBuyTimeCost(buyTimes + 1)
	local list = string.split(cost, ":")

	if list and #list >= 3 then
		local matType, matId, num = tonumber(list[1]), tonumber(list[2]), tonumber(list[3])
		local centent = string.format("确定花费<color=#d44c28>%d钻石</color>购买1次挑战次数吗？\n<size=24>每天最多可购买%d次，还能购买%d次</size>", num, totalCanBuyTimes, leftBuyCnt)

		TipsFacade.instance:openPopupCostAdjustBySingleNumView(matType, matId, num, 1, centent, function(time)
			ArenaController.instance:addClg(time)
		end, leftBuyCnt, UnityEngine.TextAnchor.MiddleCenter, function(type, selectTime)
			if type == TipsFacade.STATE_NUM_CHANGE then
				local totalCost = 0

				for i = buyTimes + 1, buyTimes + selectTime do
					local buyCostCfg = ArenaConfig.instance:getBuyTimeCost(i)
					local _, _, curNum = MaterialMgr.getMatParams(buyCostCfg)

					totalCost = totalCost + curNum
				end

				return (string.format("确定花费<color=#d44c28>%d钻石</color>购买%d次挑战次数吗？\n<size=24>每天最多可购买%d次，还能购买%d次</size>", totalCost, selectTime, totalCanBuyTimes, leftBuyCnt))
			end

			return nil
		end, function(selectTime)
			local totalCost = 0

			for i = buyTimes + 1, buyTimes + selectTime do
				local buyCostCfg = ArenaConfig.instance:getBuyTimeCost(i)
				local _, _, curNum = MaterialMgr.getMatParams(buyCostCfg)

				totalCost = totalCost + curNum
			end

			return totalCost
		end)
	end
end

ArenaController.instance = ArenaController.New()

return ArenaController
