local var_0_0 = class("PacGameVo")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._gameId = arg_1_1
	arg_1_0._hubId = pg.mini_game[arg_1_0._gameId].hub_id
	arg_1_0._drop = pg.mini_game[arg_1_0._gameId].simple_config_data.drop_ids
	arg_1_0._totalTimes = pg.mini_game_hub[arg_1_0._hubId].reward_need
	arg_1_0._mgData = getProxy(MiniGameProxy):GetMiniGameData(arg_1_0._gameId)
	arg_1_0._mgHubData = getProxy(MiniGameProxy):GetHubByHubId(arg_1_0._hubId)

	return
end

function var_0_0.GetGameId(arg_2_0)
	return arg_2_0._gameId
end

function var_0_0.SetEditor(arg_3_0, arg_3_1)
	arg_3_0._editorFlag = arg_3_1

	return
end

function var_0_0.GetEditor(arg_4_0, arg_4_1)
	return arg_4_0._editorFlag
end

function var_0_0.GetGameRound(arg_5_0)
	if arg_5_0._editorFlag then
		return PacGameConst.editor_chapter
	end

	if arg_5_0.selectRound ~= nil then
		return arg_5_0.selectRound
	end

	local var_5_0 = arg_5_0:GetGameUseTimes()
	local var_5_1 = arg_5_0:GetGameTimes()

	if var_5_1 and var_5_1 > 0 then
		return var_5_0 + 1
	end

	if var_5_0 and var_5_0 > 0 then
		return var_5_0
	end

	return 1
end

function var_0_0.GetGameTimes(arg_6_0)
	if arg_6_0._mgHubData then
		return arg_6_0._mgHubData.count or 0
	end

	return 0
end

function var_0_0.GetGameUseTimes(arg_7_0)
	if arg_7_0._mgHubData then
		return arg_7_0._mgHubData.usedtime or 0
	end

	return 0
end

function var_0_0.GetUltimate(arg_8_0)
	if arg_8_0._mgHubData then
		return arg_8_0._mgHubData.ultimate
	end

	return nil
end

function var_0_0.GetTotalTimes(arg_9_0)
	return arg_9_0._totalTimes
end

function var_0_0.GetHubId(arg_10_0)
	return arg_10_0._mgHubData.id
end

function var_0_0.Prepare(arg_11_0)
	arg_11_0._gameTime = PacGameConst.game_time
	arg_11_0._gameTimeInteger = math.floor(arg_11_0._gameTime)
	arg_11_0._gameStepTime = 0
	arg_11_0._deltaTime = 0
	arg_11_0._scoreNum = 0
	arg_11_0._settlementFlag = false
	arg_11_0._joyStickData = nil

	return
end

function var_0_0.Step(arg_12_0, arg_12_1)
	arg_12_0._gameTime = arg_12_0._gameTime - arg_12_1
	arg_12_0._gameTimeInteger = math.floor(arg_12_0._gameTime)
	arg_12_0._gameStepTime = arg_12_0._gameStepTime + arg_12_1
	arg_12_0._gameStepTimeInteger = math.floor(arg_12_0._gameStepTime)
	arg_12_0._deltaTime = arg_12_1

	return
end

function var_0_0.AddScore(arg_13_0, arg_13_1)
	arg_13_0._scoreNum = arg_13_0._scoreNum + arg_13_1

	return
end

function var_0_0.GetScore(arg_14_0)
	return arg_14_0._scoreNum
end

function var_0_0.SetSettlement(arg_15_0, arg_15_1)
	arg_15_0._settlementFlag = arg_15_1

	return
end

function var_0_0.IsSettlement(arg_16_0)
	return arg_16_0._settlementFlag
end

function var_0_0.GetTime(arg_17_0)
	return arg_17_0._gameTime
end

function var_0_0.GetTimeInteger(arg_18_0)
	return arg_18_0._gameTimeInteger
end

function var_0_0.GetStepTimeInteger(arg_19_0)
	return arg_19_0._gameStepTimeInteger
end

function var_0_0.GetDrop(arg_20_0)
	return arg_20_0._drop
end

function var_0_0.GetConfig(arg_21_0, arg_21_1)
	return arg_21_0._mgData:getConfig(arg_21_1)
end

function var_0_0.GetDeltaTime(arg_22_0)
	return arg_22_0._deltaTime
end

function var_0_0.SetJoyStickData(arg_23_0, arg_23_1)
	arg_23_0._joyStickData = arg_23_1

	return
end

function var_0_0.GetJoyStickData(arg_24_0)
	return arg_24_0._joyStickData
end

function var_0_0.Clear(arg_25_0)
	arg_25_0._drop = {}
	arg_25_0._totalTimes = 0
	arg_25_0._mgData = nil
	arg_25_0._mgHubData = nil

	return
end

return var_0_0
