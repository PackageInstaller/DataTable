local var_0_0 = {
	_caches = {},
	clearProviderByKey = function(self, arg_1_1)
		if self._caches[arg_1_1] then
			self._caches[arg_1_1]:clear()
		end
	end,
	clearCache = function(self)
		for iter_2_0, iter_2_1 in pairs(self._caches) do
			self:clearProviderByKey(iter_2_0)
		end
	end,
	_getCacheByKey = function(self, arg_3_1)
		if self._caches[arg_3_1] then
			return self._caches[arg_3_1]
		end

		local var_3_0 = {
			clear = function(arg_4_0)
				arg_4_0._data = nil
			end,
			empty = function(self)
				return not checkbool(self._data)
			end,
			load = function(self)
				return self._data or {}
			end,
			save = function(arg_7_0, arg_7_1)
				arg_7_0._data = arg_7_1
			end
		}

		var_3_0:clear()

		self._caches[arg_3_1] = var_3_0

		return var_3_0
	end
}

local function var_0_1(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = g.core.network.proto.list[tostring(arg_8_0)]

	assert(var_8_0, "Invalid msg id: " .. tostring(arg_8_0))

	local var_8_1 = string.format("C2%s_%s", var_8_0[2], var_8_0[1])
	local var_8_2 = var_0_0:_getCacheByKey(var_8_1)
	local var_8_5 = 1

	return function(arg_9_0, arg_9_1, arg_9_2)
		var_8_5 = var_8_5 + 1

		local var_9_0 = type(arg_9_0)

		assert(not arg_9_0 or var_9_0 == "boolean" or var_9_0 == "function", "Invalid command type: " .. tostring(var_9_0))

		local var_9_1 = var_9_0 == "boolean" and arg_9_0 or false
		local var_9_2 = var_9_0 == "function" and arg_9_0 or nil

		if arg_8_3 and not arg_8_3() then
			if var_9_2 then
				var_9_2()
			end

			return
		end

		if var_9_1 or arg_9_1 then
			var_8_2:clear()
		end

		if not var_8_2:empty() then
			if var_9_2 then
				var_9_2(unpack(var_8_2:load()))
			else
				g.core.event.EventManager:dispatchEvent(arg_8_2, true, unpack(var_8_2:load()))
			end
		else
			g.core.service.ServiceManager:getServiceByName("LoopService"):forbidPushToWaitList()
			g.core.network.GameNetProxy:sendMsg(arg_8_0, arg_8_1)

			local var_9_3 = table.concat({
				var_8_1,
				"_",
				var_8_5
			})

			g.core.event.EventManager:addEventListener(arg_8_2, function(arg_10_0, arg_10_1)
				g.core.service.ServiceManager:getServiceByName("LoopService"):resumePushToWaitList()
				var_8_2:save({
					...
				})

				if var_9_2 then
					var_9_2()
				end

				g.core.event.EventManager:removeListenerWithTarget(var_9_3)
			end, var_9_3, 10000)

			if arg_9_2 then
				g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RET_MSG_ASYNC, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
					if arg_8_0 + 1 ~= arg_11_2 then
						return
					end

					g.core.service.ServiceManager:getServiceByName("LoopService"):resumePushToWaitList()
					arg_9_2()
					g.core.event.EventManager:removeListenerWithTarget(var_9_3)
				end, var_9_3)
			end
		end
	end
end

var_0_0.reqDailyTaskProto = var_0_1(g.core.network.proto.MSG_C2S_DailyTask_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_GETINFO)
var_0_0.reqPrimaryRecruitProto = var_0_1(g.core.network.proto.MSG_C2S_NewRecruit_Info, {}, g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO)
var_0_0.reqArenaProto = var_0_1(g.core.network.proto.MSG_C2S_Arena_GetMainInfo, {}, g.core.event.enum.EVENT_NET_S2C_ARENA_GETMAININFO)
var_0_0.reqAuctionGetInfo = var_0_1(g.core.network.proto.MSG_C2S_Auction_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_AUCTION_GETINFO)
var_0_0.reqAchievementGetInfo = var_0_1(g.core.network.proto.MSG_C2S_Achievement_Info, {}, g.core.event.enum.EVENT_NET_S2C_ACHIEVEMENT_INFO)
var_0_0.reqFogIdleGetInfo = var_0_1(g.core.network.proto.MSG_C2S_Fog_IdleInfo, {}, g.core.event.enum.EVENT_NET_S2C_FOG_IDLEINFO)
var_0_0.reqFogFloor = var_0_1(g.core.network.proto.MSG_C2S_Fog_NextFloor, {}, g.core.event.enum.EVENT_NET_S2C_FOG_NEXTFLOOR)
var_0_0.reqGveEnterMap = var_0_1(g.core.network.proto.MSG_C2S_GVE_WorldEnter, {}, g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDENTER)
var_0_0.reqWushTowerMap = var_0_1(g.core.network.proto.MSG_C2S_DeadTower_EnterInfo, {}, g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_ENTERINFO)
var_0_0.reqCompetitionMap = var_0_1(g.core.network.proto.MSG_C2S_HandbookCompetition_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_HANDBOOK_COMPETITION_GETINFO)
var_0_0.reqPushGiftMap = var_0_1(g.core.network.proto.MSG_C2S_PushGift_GetGmActInfo, {}, g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_GETGMACTINFO)
var_0_0.reqWishPool = var_0_1(g.core.network.proto.MSG_C2S_Wishpool_Flush, {}, g.core.event.enum.EVENT_NET_S2C_WISHPOOL_FLUSH)
var_0_0.reqLottery = var_0_1(g.core.network.proto.MSG_C2S_Lottery_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_LOTTERY_GETINFO)
var_0_0.reqWeeklyCompetition = var_0_1(g.core.network.proto.MSG_C2S_WeeklyCompetition_Info, {}, g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_INFO)
var_0_0.teamPvp = var_0_1(g.core.network.proto.MSG_C2S_GroupBattle_Enter, {}, g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_ENTER)
var_0_0.exploration = var_0_1(g.core.network.proto.MSG_C2S_Exploration_Info, {}, g.core.event.enum.EVENT_NET_S2C_EXPLORATION_INFO)
var_0_0.redCliff = var_0_1(g.core.network.proto.MSG_C2S_ChiBi_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_CHI_BI_GETINFO)
var_0_0.reqPreciousGetInfo = var_0_1(g.core.network.proto.MSG_C2S_Precious_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_PRECIOUS_GETINFO)
var_0_0.reqBountyInfo = var_0_1(g.core.network.proto.MSG_C2S_Bounty_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETINFO)
var_0_0.reqBountyRankInfo = var_0_1(g.core.network.proto.MSG_C2S_Bounty_GetGuildRank, {
	size = 5
}, g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETGUILDRANK)
var_0_0.reqThemePassCardParam = {
	activity_id = 0
}
var_0_0.reqThemePassCard = var_0_1(g.core.network.proto.MSG_C2S_ThemePasscard_GetInfo, var_0_0.reqThemePassCardParam, g.core.event.enum.EVENT_NET_S2C_THEME_PASSCARD_GETINFO)
var_0_0.reqReturnActivity = var_0_1(g.core.network.proto.MSG_C2S_Rerun_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_RERUN_GETINFO)
var_0_0.reqRetroActivity = var_0_1(g.core.network.proto.MSG_C2S_Retro_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_RETRO_GETINFO)
var_0_0.reqRichmanInfo = var_0_1(g.core.network.proto.MSG_C2S_RichMan_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_RICH_MAN_GETINFO)
var_0_0.reqTreeGetInfo = var_0_1(g.core.network.proto.MSG_C2S_Tree_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_TREE_GETINFO)
var_0_0.reqGuildGetInfo = var_0_1(g.core.network.proto.MSG_C2S_Guild_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_GUILD_GETINFO)
var_0_0.reqTeamBattleTeam = var_0_1(g.core.network.proto.MSG_C2S_TeamBattle_TeamInfo, {}, g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_TEAMINFO)
var_0_0.reqTeamBattleMap = var_0_1(g.core.network.proto.MSG_C2S_TeamBattleEnter, {}, g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_ENTER)
var_0_0.reqCrossPoint = var_0_1(g.core.network.proto.MSG_C2S_FlushRedPoint, {
	cross_modules = {
		171
	}
}, g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT)
var_0_0.reqPrimaryWedActivity = var_0_1(g.core.network.proto.MSG_C2S_WeddingActivity_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_WEDDING_ACTIVITY_GETINFO)
var_0_0.reqPubgMapEnter = var_0_1(g.core.network.proto.MSG_C2S_Pubg_Enter, {}, g.core.event.enum.EVENT_NET_S2C_PUBG_ENTER)
var_0_0.reqMonopolyMapEnter = var_0_1(g.core.network.proto.MSG_C2S_Monopoly_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_MONOPOLY_GETINFO)
var_0_0.reqSuccubaInfo = var_0_1(g.core.network.proto.MSG_C2S_Succuba_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_SUCCUBA_GETINFO)
var_0_0.reqOutpostInfo = var_0_1(g.core.network.proto.MSG_C2S_Outpost_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETINFO)
var_0_0.reqDomainGetInfo = var_0_1(g.core.network.proto.MSG_C2S_Domain_GetInfo, {}, g.core.event.enum.EVENT_NET_S2C_DOMAIN_GETINFO)

return var_0_0
