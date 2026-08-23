local HLTrainConst = require("app.view.module.homeLandTrain.const.HLTrainConst")
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.model.User.hlTrainData
local var_0_3 = g.core.model.User.shopData
local var_0_4 = g.core.model.User
local var_0_5 = g.core.model.User.resourceData
local var_0_6 = g.core.model.User.rebelData
local var_0_7 = g.core.model.User.friendData
local var_0_9 = g.core.config.daily_dungeon_info
local var_0_10 = g.core.config.daily_dungeon_stage_info
local var_0_11 = g.core.model.User.crossServerArenaData
local var_0_12 = g.core.const.ConstMgr.CrossServerArenaConst
local var_0_13 = g.core.model.User.furnitureData
local var_0_14 = g.core.network.GameNetProxy
local DebugOneKeyDailyComp = class("DebugOneKeyDailyComp", require("app.fairyGUI.debug.UI_DebugOneKeyDailyComp"))

function DebugOneKeyDailyComp:ctor()
	self._knightPosList = {}
	self._getFormation = false
	self._getCsArenaGetInfo = false
	self._isAutoIng = false

	self:_init()
end

function DebugOneKeyDailyComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_CHALLENGEBEGIN, self._onRcvBattleBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_CHALLENGEFINISH, self._onRcvBattleEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_REBEL_INFO, self.doRebelBattle, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_REBEL_ONEKEYATTACKBEGIN, self.doRebelBattle, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARENA_GETMAININFO, self.doArenaBattle, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARENA_CHALLENGEBEGIN, self._onRcvArenaBattleBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_SWEEP, self._onFriendClear, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_GETINFO, self._doWorkingDispatch, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCH, self._doWorkingDispatch, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_GETINFO, self._onGetCsArenaInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GET, self._onGetFormation, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_CHALLENGEBEGIN, self._onChiefArenaChallengeBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_CHALLENGEFINISH, self._onChiefArenaChallengeFinish, self)
end

function DebugOneKeyDailyComp:_init()
	self.m_dailyDungeon:addClickListener(handler(self, self._onClickDailyDungeon))
	self.m_rebelBtn:addClickListener(handler(self, self._onClickRebelBtn))
	self.m_arenaBtn:addClickListener(handler(self, self._onClickArenaBtn))
	self.m_friendBtn:addClickListener(handler(self, self._onClickFriendBtn))
	self.m_workBtn:addClickListener(handler(self, self._onClickWork))
	self.m_csArenaBtn:addClickListener(handler(self, self._onClickCsArena))
end

function DebugOneKeyDailyComp:_onClickDailyDungeon()
	if self._isAutoIng then
		return
	end

	g.core.battle.BattleShowResult:disableAll()

	self._isAutoIng = true

	self:doDailyDungeon()
end

function DebugOneKeyDailyComp:_onClickRebelBtn()
	if self._isAutoIng then
		return
	end

	g.core.battle.BattleShowResult:disableAll()

	self._isAutoIng = true

	g.core.network.GameNetProxy:send_C2S_Rebel_Info({})
end

function DebugOneKeyDailyComp:_onClickArenaBtn()
	if self._isAutoIng then
		return
	end

	g.core.battle.BattleShowResult:disableAll()

	self._isAutoIng = true

	g.core.network.GameNetProxy:send_C2S_Arena_GetMainInfo({})
end

function DebugOneKeyDailyComp:_onClickFriendBtn()
	local var_7_0 = true
	local var_7_1 = var_0_7:getCurTabList(0)

	if table.nums(var_7_1) == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(102509))
		self:showLog(g.core.lang:get(102509))

		return
	else
		for iter_7_0, iter_7_1 in pairs(var_7_1) do
			if not iter_7_1:isGifted() then
				var_7_0 = false

				break
			end
		end
	end

	if var_7_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(102510))
		self:showLog(g.core.lang:get(102510))
	else
		g.core.network.GameNetProxy:send_C2S_Friend_SendGift({
			id = 0
		})
	end

	local var_7_2 = var_0_7:getGiftList()

	if #var_7_2 > 1 then
		local var_7_3 = {}

		for iter_7_2, iter_7_3 in pairs(var_7_2) do
			if not iter_7_3:isReceived() then
				table.insert(var_7_3, iter_7_3:getFriendId())
			end
		end

		if math.max(0, g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.FRIEND_GIFT_LIMIT).parameter - var_0_7:getGiftedNum()) > 0 then
			g.core.network.GameNetProxy:send_C2S_Friend_ReceiveGift({
				id = var_7_3
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(102508))
			self:showLog(g.core.lang:get(102508))
		end
	end

	local var_7_4 = var_0_13:getCurSweepTime()

	if var_7_4 > 0 then
		for iter_7_4, iter_7_5 in pairs(var_7_1) do
			if var_0_13:isCanCleanFurnitureByUserId(iter_7_5:getFriendId()) then
				g.core.network.GameNetProxy:send_C2S_FurnitureRoom_Sweep({
					num = 1,
					friend_id = iter_7_5:getFriendId()
				})

				var_7_4 = var_7_4 - 1

				if var_7_4 <= 0 then
					break
				end
			end
		end
	end
end

function DebugOneKeyDailyComp:_onClickWork()
	g.core.network.GameNetProxy:send_C2S_HomeLandTrain_GetInfo({})
end

function DebugOneKeyDailyComp:doRebelBattle(arg_9_1, arg_9_2, arg_9_3)
	if not self._isAutoIng then
		return
	end

	if arg_9_3 and arg_9_3.ret ~= 1 then
		self:showLog("净化素体挑战异常，请手打")

		self._isAutoIng = false

		self:newScheduleOnce(function()
			g.core.battle.BattleShowResult:enableAll()
		end, 0.1)

		return
	end

	local var_9_0 = var_0_5:getRebelAttack()
	local var_9_1 = var_0_6:isHotTime()

	if var_9_0 >= 2 or var_9_1 and var_9_0 >= 1 then
		local var_9_2 = var_0_6:getRebelArr()
		local var_9_3, var_9_4 = var_0_6:getRebelDefault()
		local var_9_5 = {}

		if var_9_3:isInValidTime() then
			table.insert(var_9_5, var_9_3)
		end

		if var_9_4:isInValidTime() then
			table.insert(var_9_5, var_9_4)
		end

		for iter_9_0, iter_9_1 in ipairs(var_9_2) do
			if iter_9_0 > 5 then
				break
			end

			table.insert(var_9_5, iter_9_1)
		end

		for iter_9_2, iter_9_3 in pairs(var_9_5) do
			if iter_9_3:isInValidTime() then
				g.core.network.GameNetProxy:send_C2S_Rebel_OneKeyAttackBegin({
					use_item = false,
					attack_type = 2,
					id = iter_9_3:getRebelPkg().id,
					count = var_9_1 and var_9_0 or math.floor(var_9_0 / 2)
				})

				return
			end
		end
	end

	self._isAutoIng = false

	self:showLog("净化素体挑战完成")
	g.core.battle.BattleShowResult:enableAll()
end

function DebugOneKeyDailyComp:doDailyDungeon()
	for iter_11_0, iter_11_1 in ipairs({
		6,
		7,
		8,
		9
	}) do
		if var_0_4.dailyDungeonData:checkChapterOpenState(iter_11_0) == 0 and var_0_3:getLeftCount(var_0_9.get(iter_11_0).dungeon_num) > 0 then
			local var_11_0

			for iter_11_2, iter_11_3 in var_0_10.ipairs() do
				if iter_11_3.daily_dungeon_type == iter_11_0 and var_0_4.dailyDungeonData:checkStageOpenState(iter_11_3.id) == 4 then
					var_11_0 = iter_11_3
				end
			end

			if var_11_0 then
				g.core.network.GameNetProxy:send_C2S_DailyDungeon_ChallengeBegin({
					id = var_11_0.id
				})
				self:showLog("挑战中，请等待")

				return
			end
		end
	end

	self._isAutoIng = false

	self:showLog("扫荡完成,实际情况请自己查看")
	g.core.battle.BattleShowResult:enableAll()
end

function DebugOneKeyDailyComp:_onRcvBattleBegin(arg_12_1, arg_12_2, arg_12_3)
	g.core.battle.BattleProxy:fastBattle(arg_12_3.battle_id)
end

function DebugOneKeyDailyComp:_onRcvBattleEnd(arg_13_1, arg_13_2, arg_13_3)
	if arg_13_3.is_win then
		self:newScheduleOnce(function()
			self:doDailyDungeon()
		end, 1)
	else
		self._isAutoIng = false

		self:showLog("战斗失败")
		self:newScheduleOnce(function()
			g.core.battle.BattleShowResult:enableAll()
		end, 0.5)
	end
end

function DebugOneKeyDailyComp:doArenaBattle(arg_16_1, arg_16_2, arg_16_3)
	if arg_16_3.challenge_count <= 0 then
		self._isAutoIng = false

		self:showLog("挑战结束，剩余次数不足")
		self:newScheduleOnce(function()
			g.core.battle.BattleShowResult:enableAll()
		end, 0.2)

		return
	end

	local var_16_0 = clone(arg_16_3.arena_units)

	table.sort(var_16_0, function(arg_18_0, arg_18_1)
		return arg_18_0.user.fight_value < arg_18_1.user.fight_value
	end)

	local var_16_1 = g.core.model.User:getFightValue()
	local var_16_2 = 0

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		if arg_16_3.rank ~= iter_16_1.rank then
			if var_16_1 < iter_16_1.user.fight_value then
				break
			else
				var_16_2 = iter_16_1.rank
			end
		end
	end

	if var_16_2 == 0 then
		var_16_2 = var_16_0[2].rank
	end

	g.core.network.GameNetProxy:send_C2S_Arena_ChallengeBegin({
		rank = var_16_2
	})
end

function DebugOneKeyDailyComp:_onRcvArenaBattleBegin(arg_19_1, arg_19_2, arg_19_3)
	self:newScheduleOnce(function()
		g.core.network.GameNetProxy:send_C2S_Arena_GetMainInfo({})
	end, 0.1)
end

function DebugOneKeyDailyComp:_onFriendClear()
	self:showLog("剩余打扫次数 " .. var_0_13:getCurSweepTime())
end

function DebugOneKeyDailyComp:_doWorkingDispatch()
	for iter_22_0, iter_22_1 in pairs((var_0_2:getUnlockedRoomStructArr())) do
		if not iter_22_1:isWorking() then
			g.core.network.GameNetProxy:send_C2S_HomeLandTrain_Dispatch({
				dispatch = self:getRecommendKnightIdDict(iter_22_1)
			})

			return
		end
	end

	self:showLog("所有未工作的房间 派遣完成")
end

function DebugOneKeyDailyComp:getRecommendKnightIdDict(arg_23_1)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in ipairs(arg_23_1.knightIdArr) do
		if var_0_1:getKnightById(iter_23_1):getMobilityVal() > 0 then
			var_23_0 = var_23_0 + 1
		end
	end

	local var_23_1 = math.min(HLTrainConst.ROOM_MAX_DISPATCH_NUM, arg_23_1.refCfgInfo.limit_dispatch) - var_23_0
	local var_23_2

	if var_23_1 < 1 then
		do return {} end

		var_23_2 = {}
	end

	for iter_23_2, iter_23_3 in ipairs((var_0_1:getSpList(function(arg_24_0)
		return arg_24_0:isCanBeDispatched()
	end))) do
		local var_23_3 = iter_23_3:getServerId()

		if not var_0_13:isKnightCheckIn(var_23_3) and not var_0_2:isKnightDispatched(var_23_3) and iter_23_3:getMobilityVal() > iter_23_3:getMaxMobility() * 0.35 then
			table.insert(var_23_2, iter_23_3)
		end
	end

	local var_23_4 = {}

	if var_23_1 < #var_23_2 then
		for iter_23_4 = 1, var_23_1 do
			var_23_4[var_23_2[iter_23_4]:getServerId()] = true
		end
	else
		for iter_23_5, iter_23_6 in ipairs(var_23_2) do
			var_23_4[iter_23_6:getServerId()] = true
		end
	end

	return {
		{
			adv_id = arg_23_1.advanceId,
			knight_ids = table.keys(var_23_4)
		}
	}
end

function DebugOneKeyDailyComp:showLog(arg_25_1)
	self.m_challenge_log:setText(arg_25_1)
end

function DebugOneKeyDailyComp:_onClickCsArena()
	if self._isAutoIng then
		self:showLog("请等待其他自动完成")

		return
	end

	local var_26_0 = var_0_11:getSeasonStatus()

	if var_26_0 ~= var_0_12.CTRL_ON_SEASON and var_26_0 ~= var_0_12.CTRL_OFF_SEASON then
		self:showLog(g.core.lang:get(411014))

		return
	end

	self._isAutoIng = true

	var_0_14:send_C2S_Formation_Get({
		tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.CROSS_SERVER_ARENA
	})
	var_0_14:send_C2S_ChiefArena_GetInfo({})
end

function DebugOneKeyDailyComp:_onGetFormation()
	self._getFormation = true

	if self._getCsArenaGetInfo then
		self:doCsArenaAutoBattle()
	end
end

function DebugOneKeyDailyComp:_onGetCsArenaInfo()
	self._getCsArenaGetInfo = true

	if self._getFormation then
		self:doCsArenaAutoBattle()
	end
end

function DebugOneKeyDailyComp:doCsArenaAutoBattle()
	if not var_0_11:isFormationValid() then
		self:showLog(g.core.lang:get(411038))

		self._isAutoIng = false

		return
	elseif var_0_4.shopData:getLeftCount(var_0_12.BUY_TIMES_ID) == 0 then
		self:showLog("挑战次数不足")

		self._isAutoIng = false

		return
	elseif var_0_11:getSeasonStatus() ~= var_0_12.CTRL_ON_SEASON then
		g.core.module.ModuleManager:tip(g.core.lang:get(411016))

		self._isAutoIng = false

		return
	end

	local var_29_0 = var_0_11:getChallengeList()
	local var_29_1
	local var_29_2
	local var_29_3 = g.core.model.User:getFightValue() * 2.5

	for iter_29_0 = 1, var_29_0:getLength() do
		local var_29_4 = var_29_0:at(iter_29_0)

		if var_29_4.user.id ~= var_0_4:getId() then
			if var_29_3 >= var_29_4.user.fight_value and (not var_29_1 or var_29_1.rank < var_29_4.rank) then
				var_29_1 = var_29_4
			end

			if not var_29_2 or var_29_4.user.fight_value <= var_29_2.user.fight_value then
				var_29_2 = var_29_4
			end
		end
	end

	var_29_1 = var_29_1 or var_29_2

	if not var_29_1 then
		self:showLog("异常，建议手动打一下")

		self._isAutoIng = false

		return
	end

	g.core.network.GameNetProxy:send_C2S_ChiefArena_ChallengeBegin({
		rank = var_29_1.rank,
		id = (var_29_1.robotId or nil) and (var_29_1.robotId or var_29_1.user.id)
	})
end

function DebugOneKeyDailyComp:_onChiefArenaChallengeBegin(arg_30_1, arg_30_2, arg_30_3)
	return
end

function DebugOneKeyDailyComp:_onChiefArenaChallengeFinish(arg_31_1, arg_31_2, arg_31_3)
	self:showLog("剩余次数：" .. var_0_4.shopData:getLeftCount(var_0_12.BUY_TIMES_ID))
	self:newScheduleOnce(function()
		var_0_14:send_C2S_ChiefArena_GetInfo({})
	end, 0.3)
end

return DebugOneKeyDailyComp
