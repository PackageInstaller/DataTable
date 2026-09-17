local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:enter_flychess_get_conf(arg_1_1, arg_1_2)
	return self.activities[arg_1_1]:enter_flychess_get_conf(arg_1_2)
end

function activity_base_manager:dice_goto_next(arg_2_1, arg_2_2)
	return self.activities[arg_2_1]:dice_goto_next(arg_2_2)
end

function activity_base_manager:get_flychess_map_infos(arg_3_1, arg_3_2)
	return self.activities[arg_3_1]:get_flychess_map_infos(arg_3_2)
end

function activity_base_manager:getFlychessConf(arg_4_1)
	return self.activities[arg_4_1]:getFlychessConf()
end

function activity_base_manager:getFlychessAllInfo(arg_5_1)
	return self.activities[arg_5_1]:getFlychessAllInfo()
end

function activity_base_manager:initFlyChessFight(arg_6_1)
	return self.activities[arg_6_1]:initFlyChessFight()
end

function activity_base_manager:can_throw(arg_7_1)
	return self.activities[arg_7_1]:can_throw()
end

function activity_base_manager:user_handle_flychess_events(arg_8_1, arg_8_2)
	return self.activities[arg_8_1]:user_handle_flychess_events(arg_8_2)
end

function activity_base_manager:initFlyChessBossFight(arg_9_1)
	return self.activities[arg_9_1]:initFlyChessBossFight()
end

function activity_base_manager:get_flychess_rank_list(arg_10_1, arg_10_2)
	return self.activities[arg_10_1]:get_flychess_rank_list(arg_10_2)
end

function activity_base_manager:getFlyChessBossBattleScore(arg_11_1)
	return self.activities[arg_11_1]:getFlyChessBossBattleScore()
end

function activity_base_manager:getFlyChessTicket(arg_12_1)
	return self.activities[arg_12_1]:getFlyChessTicket()
end

function activity_base_manager:getFlyChessTicketShop(arg_13_1)
	return self.activities[arg_13_1]:getFlyChessTicketShop()
end

function activity_base_manager:getFlyChessShop(arg_14_1)
	return self.activities[arg_14_1]:getFlyChessShop()
end

function activity_base_manager:getBuffsAndScoreList(arg_15_1)
	return self.activities[arg_15_1]:getBuffsAndScoreList()
end

function activity_base_manager:getFlyChessLevelRewards(arg_16_1)
	return self.activities[arg_16_1]:getFlyChessLevelRewards()
end

function activity_base_manager:getFlyChessMaxLevel(arg_17_1)
	return self.activities[arg_17_1]:getFlyChessMaxLevel()
end

function activity_base_manager:getFlyChessBossInfo(arg_18_1)
	return self.activities[arg_18_1]:getFlyChessBossInfo()
end

function activity_base_manager:initFlyChessEnemyList(arg_19_1)
	arg_19_1 = arg_19_1 or self._flychessBattleId

	local var_19_0 = {}
	local activity_flychess_monster_data = require("data.activity_flychess_monster_data")
	local var_19_2 = require("data.leveldata.level_data_" .. string.split(arg_19_1, "-")[1])[arg_19_1].boss_team
	local var_19_3 = require("data.activity_flychess_monsterteam_data")[var_19_2]

	assert(var_19_3 ~= nil, "there is no data of team " .. var_19_2 .. " in monster team data!!!")

	while var_19_3["monster" .. 1] do
		var_19_0[#var_19_0 + 1] = {}
		var_19_0[#var_19_0 + 1].id = var_19_3["monster" .. 1]
		var_19_0[#var_19_0 + 1].majorlist = activity_flychess_monster_data[var_19_3["monster" .. 1]]
		var_19_0[#var_19_0 + 1].pos = var_19_3["pos" .. 1]
		var_19_0[#var_19_0 + 1].posy = var_19_3["posy" .. 1]
		var_19_0[#var_19_0 + 1].delaytime = var_19_3["delay" .. 1]
		var_19_0[#var_19_0 + 1].offset = var_19_3["offset" .. 1]
	end

	if var_19_3.boss then
		var_19_0.boss = {}
		var_19_0.boss.id = var_19_3.boss
		var_19_0.boss.majorlist = activity_flychess_monster_data[var_19_3.boss]
		var_19_0.boss.pos = var_19_3.posboss
		var_19_0.boss.posy = var_19_3.posyboss
		var_19_0.boss.delaytime = var_19_3.delayboss
		var_19_0.boss.offset = var_19_3.offsetboss
	end

	return var_19_0
end

function activity_base_manager:getFlyChessCurLevelData()
	return require("data.leveldata.level_data_" .. string.split(self._flychessBattleId, "-")[1])[self._flychessBattleId]
end

function activity_base_manager:getFlychessFightBuffs()
	return (self.activities[self._flychessActivityId]:getFlychessFightBuffs())
end

function activity_base_manager:getFlyChessBattleFieldStatus()
	return (self.activities[self._flychessActivityId]:getFlyChessBattleFieldStatus())
end

function activity_base_manager:flychessFightFail()
	return (self.activities[self._flychessActivityId]:flychessFightFail())
end

function activity_base_manager:flychessFightSuccess()
	return (self.activities[self._flychessActivityId]:flychessFightSuccess())
end

function activity_base_manager:dice_goto_next_test(arg_25_1, arg_25_2)
	return self.activities[722]:dice_goto_next_test(arg_25_2)
end
