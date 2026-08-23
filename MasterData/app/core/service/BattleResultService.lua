local BattleResultService = class("BattleResultService")

function BattleResultService:ctor()
	self._curBattleResult = {}
	self._responseMsg = {}

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_REQUEST_START, self._onNetRequestStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_REQUEST_CANCEL, self._onNetRequestCancel, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_REQUEST_RESPONSE, self._onNetRequestResponse, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_DISCONNECTED, self._onNetDisconnected, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_TIMEOUT, self._onNetTimeout, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARENA_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_FAKE_PVP_BATTLE_RESULT, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_EXECUTEMISSIONBATTLE, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_ATTACKCAMPAIGNFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_BOSS_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CONTEND_TREASURE_ROBFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CONTEND_TREASURE_AVENGEFINISH, self._onContendTreasureBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_REBEL_ATTACKFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DAILY_DUNGEON_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEMON_BOSS_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_ATTACKDEFENDERFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_CHALLENGEBOSSFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_ROBUSERFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEMON_AUTO_BOSS_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_DEMON_BOSS_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_ATTACKUSERFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WREST_ATTACKUSERFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORE_TREASURE_BATTLEEVENT_FINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPACE_TIME_DUNGEON_BATTLEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PEAK_ARENA_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_BATTLE_FINISHCHALLENGE, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_DUNGEON_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_CHALLENGESTAGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_PRACTICE, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TURN_CARD_RESULT, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELIMINATE_RESULT, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINI_GAME_GUESS_RESULT, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_CHALLENGE_RESULT, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUZZLE_RESULT, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDCHALLENGEBEGIN, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_CHALLENGEBOSSBEGIN, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_EXECUTEMISSIONBATTLE, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_BATTLEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHIEF_ARENA_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_CHALLENGEGUARDFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_CHALLENGEMONSTERFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_CHALLENGEBOSSFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHI_BI_CHECKBATTLE, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHI_BI_CHECKBATTLEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_MONSTER_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_ELITE_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_POSCHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_ROBFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_CHALLENGEMONSTERFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRE_STAGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRE_BOSSFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_CHALLENGEFINISH, self._onBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DOMAIN_CHALLENGEFINISH, self._onBattleResult, self)
end

function BattleResultService:_onNetRequestStart(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_4 then
		self._responseMsg[arg_2_4] = self._responseMsg[arg_2_4] or 0
		self._responseMsg[arg_2_4] = self._responseMsg[arg_2_4] + 1
	end
end

function BattleResultService:_onNetRequestCancel(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_4 and self._responseMsg[arg_3_4] then
		self._responseMsg[arg_3_4] = self._responseMsg[arg_3_4] - 1

		if self._responseMsg[arg_3_4] == 0 then
			self._responseMsg[arg_3_4] = nil
		end
	end
end

function BattleResultService:_onNetDisconnected()
	self._responseMsg = {}
end

function BattleResultService:_onNetTimeout()
	self._responseMsg = {}
end

function BattleResultService:_onNetRequestResponse(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_2 and self._responseMsg[arg_6_2] then
		self._responseMsg[arg_6_2] = self._responseMsg[arg_6_2] - 1

		if self._responseMsg[arg_6_2] == 0 then
			self._responseMsg[arg_6_2] = nil
		end
	end

	if next(self._responseMsg) then
		return
	end

	if next(self._curBattleResult) then
		for iter_6_0, iter_6_1 in pairs(self._curBattleResult) do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BATTLE_RESULT, false, iter_6_0, unpack(iter_6_1))
		end

		self._curBattleResult = {}
	end
end

function BattleResultService:_onBattleResult(arg_7_1, arg_7_2, arg_7_3)
	if not next(self._responseMsg) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BATTLE_RESULT, false, arg_7_1, arg_7_2, arg_7_3)
	else
		self._curBattleResult[arg_7_1] = {
			arg_7_2,
			arg_7_3
		}
	end
end

function BattleResultService:_onContendTreasureBattleResult(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3 and arg_8_3.skip_battle then
		-- block empty
	else
		self._curBattleResult[arg_8_1] = {
			arg_8_2,
			arg_8_3
		}
	end
end

return BattleResultService
