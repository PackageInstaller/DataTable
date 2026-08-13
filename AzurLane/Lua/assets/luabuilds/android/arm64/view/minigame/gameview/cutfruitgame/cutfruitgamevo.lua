class = var_0_10000

local var_0_0 = var_0_10000("CutFruitGameVo")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._gameId = arg_1_1
	pg = var_1_10002
	arg_1_0._hubId = var_1_10002.mini_game[arg_1_0._gameId].hub_id
	pg = var_2
	arg_1_0._drop = var_2.mini_game[arg_1_0._gameId].simple_config_data.drop_ids
	pg = var_2
	arg_1_0._totalTimes = var_2.mini_game_hub[arg_1_0._hubId].reward_need
	getProxy = var_2
	MiniGameProxy = var_1_10004

	local var_1_0 = var_2(var_1_10004)

	arg_1_0._mgData = var_2.GetMiniGameData(var_1_0, arg_1_0._gameId)
	getProxy = var_2
	MiniGameProxy = var_1_0

	local var_1_1 = var_2(var_1_0)

	arg_1_0._mgHubData = var_2.GetHubByHubId(var_1_1, arg_1_0._hubId)

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
		CutFruitGameConst = var_1

		return var_1.editor_chapter
	end

	if arg_5_0.selectRound ~= nil then
		return arg_5_0.selectRound
	end

	local var_5_0 = arg_5_0:GetGameUseTimes()

	if arg_5_0:GetGameTimes() and var_2 > 0 then
		return var_5_0 + 1
	end

	if var_5_0 and var_5_0 > 0 then
		return var_5_0
	end

	return 1
end

function var_0_0.GetGameTimes(arg_6_0)
	if arg_6_0._mgHubData then
		local var_6_0

		if not arg_6_0._mgHubData.count then
			var_6_0 = 0
		end

		return var_6_0
	end

	return 0
end

function var_0_0.GetGameUseTimes(arg_7_0)
	if arg_7_0._mgHubData then
		local var_7_0

		if not arg_7_0._mgHubData.usedtime then
			var_7_0 = 0
		end

		return var_7_0
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
	CutFruitGameConst = var_1_10001
	arg_11_0._gameTime = var_1_10001.game_time
	math = var_1
	arg_11_0._gameTimeInteger = var_1.floor(arg_11_0._gameTime)
	arg_11_0._gameStepTime = 0
	arg_11_0._deltaTime = 0
	arg_11_0._scoreNum = 0
	arg_11_0._settlementFlag = false
	arg_11_0._joyStickData = nil
	arg_11_0._success = false
	arg_11_0._stopTimeStep = false

	return
end

function var_0_0.Step(arg_12_0, arg_12_1)
	arg_12_0._deltaTime = arg_12_1

	if arg_12_0._stopTimeStep then
		return
	end

	arg_12_0._gameTime = arg_12_0._gameTime - arg_12_1
	math = var_2
	arg_12_0._gameTimeInteger = var_2.floor(arg_12_0._gameTime)
	arg_12_0._gameStepTime = arg_12_0._gameStepTime + arg_12_1
	math = var_2
	arg_12_0._gameStepTimeInteger = var_2.floor(arg_12_0._gameStepTime)

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
	local var_21_0 = arg_21_0._mgData

	return var_2.getConfig(var_21_0, arg_21_1)
end

function var_0_0.GetDeltaTime(arg_22_0)
	return arg_22_0._deltaTime
end

function var_0_0.SetSuccess(arg_23_0, arg_23_1)
	arg_23_0._success = arg_23_1

	return
end

function var_0_0.GetSuccess(arg_24_0)
	return arg_24_0._success
end

function var_0_0.StopTimeStep(arg_25_0, arg_25_1)
	arg_25_0._stopTimeStep = arg_25_1

	return
end

function var_0_0.SetJoyStickData(arg_26_0, arg_26_1)
	arg_26_0._joyStickData = arg_26_1

	return
end

function var_0_0.GetJoyStickData(arg_27_0)
	return arg_27_0._joyStickData
end

function var_0_0.Clear(arg_28_0)
	arg_28_0._drop = {}
	arg_28_0._totalTimes = 0
	arg_28_0._mgData = nil
	arg_28_0._mgHubData = nil

	return
end

return var_0_0
