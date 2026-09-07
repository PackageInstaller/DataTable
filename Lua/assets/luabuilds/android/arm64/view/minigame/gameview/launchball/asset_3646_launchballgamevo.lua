local LaunchBallGameVo = class("LaunchBallGameVo")

LaunchBallGameVo.game_id = nil
LaunchBallGameVo.hub_id = nil
LaunchBallGameVo.total_times = nil
LaunchBallGameVo.drop = nil
LaunchBallGameVo.game_bgm = "cw-story"
LaunchBallGameVo.game_time = 60000
LaunchBallGameVo.rule_tip = "launchball_minigame_help"
LaunchBallGameVo.frameRate = Application.targetFrameRate or 60
LaunchBallGameVo.ui_atlas = "ui/minigameui/launchballgameui_atlas"
LaunchBallGameVo.game_ui = "LaunchBallGameUI"
LaunchBallGameVo.game_room_ui = "GameRoomLaunchUI"
LaunchBallGameVo.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
LaunchBallGameVo.launchball_minigame_select = "launchball_minigame_select"
LaunchBallGameVo.launchball_minigame_un_select = "launchball_minigame_un_select"
LaunchBallGameVo.SFX_PRESS_SKILL = "ui-maoudamashii"
LaunchBallGameVo.SFX_FIRE = "ui-mini_throw"
LaunchBallGameVo.SFX_ENEMY_REMOVE = "ui-mini_pigu"
LaunchBallGameVo.enemyToEndRate = nil
LaunchBallGameVo.gameTime = 0
LaunchBallGameVo.gameStepTime = 0
LaunchBallGameVo.deltaTime = 0

function LaunchBallGameVo:Init(arg_1_1)
	LaunchBallGameVo.game_id = self
	LaunchBallGameVo.hub_id = arg_1_1
	LaunchBallGameVo.total_times = pg.mini_game_hub[LaunchBallGameVo.hub_id]
	LaunchBallGameVo.drop = pg.mini_game[LaunchBallGameVo.game_id].simple_config_data.drop_ids
	LaunchBallGameVo.total_times = pg.mini_game_hub[LaunchBallGameVo.hub_id].reward_need

	return
end

function LaunchBallGameVo:initRoundData(arg_2_1)
	for iter_2_0, iter_2_1 in pairs(LaunchBallGameConst.game_round) do
		if iter_2_1.type == self and iter_2_1.type_index == arg_2_1 then
			LaunchBallGameVo.gameRoundData = iter_2_1

			if iter_2_1.player_id then
				LaunchBallGameVo.SetPlayer(iter_2_1.player_id)
			end
		end
	end

	return
end

function LaunchBallGameVo:SetPlayer()
	LaunchBallGameVo.selectPlayer = self

	return
end

function LaunchBallGameVo.GetGameTimes()
	return LaunchBallGameVo.GetMiniGameHubData().count
end

function LaunchBallGameVo.GetGameUseTimes()
	return LaunchBallGameVo.GetMiniGameHubData().usedtime or 0
end

function LaunchBallGameVo.GetGameRound()
	local var_6_0 = LaunchBallGameVo.GetGameUseTimes()
	local var_6_1 = LaunchBallGameVo.GetGameTimes()

	if var_6_1 and var_6_1 > 0 then
		return var_6_0 + 1
	else
		return var_6_0
	end

	return
end

function LaunchBallGameVo.GetMiniGameData()
	return getProxy(MiniGameProxy):GetMiniGameData(LaunchBallGameVo.game_id)
end

function LaunchBallGameVo.GetMiniGameHubData()
	return getProxy(MiniGameProxy):GetHubByHubId(LaunchBallGameVo.hub_id)
end

LaunchBallGameVo.scoreNum = 0
LaunchBallGameVo.joyStickData = nil
LaunchBallGameVo.amulet = nil
LaunchBallGameVo.gameRoundData = nil
LaunchBallGameVo.selectPlayer = nil
LaunchBallGameVo.pressSkill = nil
LaunchBallGameVo.buffs = nil
LaunchBallGameVo.base_score = 10
LaunchBallGameVo.series_score = 10
LaunchBallGameVo.enemyColors = {}
LaunchBallGameVo.enemyStopTime = nil

function LaunchBallGameVo.Prepare()
	LaunchBallGameVo.gameTime = LaunchBallGameVo.game_time
	LaunchBallGameVo.gameStepTime = 0
	LaunchBallGameVo.scoreNum = 0
	LaunchBallGameVo.enemyStopTime = nil
	LaunchBallGameVo.gameResultData = {
		mix_count = 0,
		series_count = 0,
		use_pass_skill = 0,
		pass_skill_count = 0,
		double_pass_skill_time = 0,
		many_count = 0,
		round = 0,
		player = 0,
		double_skill_time = 0,
		skill_count = 0,
		use_skill = 0,
		split_count = 0,
		over_count = 0
	}

	return
end

LaunchBallGameVo.result_split_count = "split_count"
LaunchBallGameVo.result_round = "round"
LaunchBallGameVo.result_player = "player"
LaunchBallGameVo.result_series_count = "series_count"
LaunchBallGameVo.result_over_count = "over_count"
LaunchBallGameVo.result_many_count = "many_count"
LaunchBallGameVo.result_mix_count = "mix_count"
LaunchBallGameVo.result_use_skill = "use_skill"
LaunchBallGameVo.result_use_pass_skill = "use_pass_skill"
LaunchBallGameVo.result_skill_count = "skill_count"
LaunchBallGameVo.result_pass_skill_count = "pass_skill_count"
LaunchBallGameVo.reuslt_double_skill_time = "double_skill_time"
LaunchBallGameVo.reuslt_double_pass_skill_time = "double_pass_skill_time"

function LaunchBallGameVo:UpdateGameResultData(arg_10_1)
	print(self .. "  update count  = " .. arg_10_1)

	if self == LaunchBallGameVo.reuslt_double_skill_time then
		arg_10_1 = math.floor(arg_10_1)

		if LaunchBallGameVo.gameResultData[self] ~= 0 then
			if arg_10_1 < LaunchBallGameVo.gameResultData[self] then
				LaunchBallGameVo.gameResultData[self] = arg_10_1
			end
		else
			LaunchBallGameVo.gameResultData[self] = arg_10_1
		end
	elseif self == LaunchBallGameVo.result_skill_count then
		if LaunchBallGameVo.gameResultData[self] and arg_10_1 > LaunchBallGameVo.gameResultData[self] then
			LaunchBallGameVo.gameResultData[self] = arg_10_1
		end
	else
		LaunchBallGameVo.gameResultData[self] = arg_10_1
	end

	return
end

function LaunchBallGameVo:AddGameResultData(arg_11_1)
	LaunchBallGameVo.gameResultData[self] = LaunchBallGameVo.gameResultData[self] + arg_11_1

	return
end

function LaunchBallGameVo:GetBuff()
	if LaunchBallGameVo.buffs and #LaunchBallGameVo.buffs > 0 then
		for iter_12_0, iter_12_1 in ipairs(LaunchBallGameVo.buffs) do
			if iter_12_1.data.type == self then
				return iter_12_1
			end
		end
	end

	return nil
end

function LaunchBallGameVo:GetScore(arg_13_1, arg_13_2, arg_13_3)
	local var_13_1 = self * LaunchBallGameVo.base_score

	if arg_13_3 and arg_13_3 > 0 then
		var_13_1 = var_13_1 + arg_13_3 * LaunchBallGameVo.base_score
	end

	if arg_13_2 then
		var_13_1 = var_13_1 + LaunchBallGameVo.base_score
	end

	if self > 3 then
		var_13_1 = var_13_1 + (self - 3) * 10
	end

	if arg_13_1 > 1 then
		var_13_1 = var_13_1 + (arg_13_1 - 1) * LaunchBallGameVo.series_score
	end

	return var_13_1
end

function LaunchBallGameVo:Sign(arg_14_1, arg_14_2)
	return (self.x - arg_14_2.x) * (arg_14_1.y - arg_14_2.y) - (arg_14_1.x - arg_14_2.x) * (self.y - arg_14_2.y)
end

function LaunchBallGameVo:PointInRect(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_2 = LaunchBallGameVo.Sign(self, arg_15_2, arg_15_3)
	local var_15_3 = LaunchBallGameVo.Sign(self, arg_15_3, arg_15_4)
	local var_15_4 = LaunchBallGameVo.Sign(self, arg_15_4, arg_15_1)
	local var_15_5 = LaunchBallGameVo.Sign(self, arg_15_1, arg_15_2) > 0 or nil > 0 or nil > 0 or nil > 0

	return not (nil < 0 or nil < 0 or nil < 0 or nil < 0) or not nil
end

return LaunchBallGameVo
