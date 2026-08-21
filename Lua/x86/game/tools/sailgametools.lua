local var_0_0 = {}
local var_0_1
local var_0_2
local var_0_3
local var_0_4

function var_0_0.LoadScene(arg_1_0)
	var_0_4 = false
	var_0_1 = arg_1_0

	local var_1_0 = SceneManager.GetSceneByName("X222")

	if var_1_0 and var_1_0.isLoaded == true then
		var_0_4 = true

		if var_0_1 then
			var_0_1()

			var_0_1 = nil
		end

		return
	end

	if var_0_2 then
		return
	end

	var_0_2 = Asset.LoadLevelAsync("Levels/X222", true)

	if var_0_3 then
		var_0_3:Stop()

		var_0_3 = nil
	end

	var_0_3 = FrameTimer.New(var_0_0.Process, 1, -1)

	var_0_3:Start()
end

function var_0_0.Process()
	if var_0_2:IsDone() then
		if var_0_1 then
			var_0_1()

			var_0_1 = nil
		end

		var_0_2 = nil
		var_0_4 = true

		if var_0_3 then
			var_0_3:Stop()

			var_0_3 = nil
		end
	end
end

function var_0_0.UnLoadScene()
	if var_0_2 or not var_0_4 then
		return
	end

	var_0_2 = nil

	local var_3_0 = SceneManager.GetSceneByName("X222")

	if var_3_0 and var_3_0.isLoaded == true then
		SceneManager.UnloadSceneAsync("X222")
	end

	var_0_4 = false

	manager.audio:Pause("effect", false)
end

function var_0_0.GoToGameView(arg_4_0)
	if not isNil(SailGameManager.Instance) and SailGameManager.Instance:IsRunning() then
		JumpTools.OpenPageByJump("/sailGame", {
			activityID = arg_4_0
		})
	else
		var_0_0.LoadScene(function()
			local var_5_0 = SailGameData:GetCurGameData(arg_4_0)
			local var_5_1 = GameSetting.activity_skadi_sea_total_time.value[1]
			local var_5_2 = 0
			local var_5_3 = GameSetting.activity_skadi_sea_event_time.value
			local var_5_4 = var_5_0.curStageIndex

			if var_5_4 - 1 > 0 then
				var_5_2 = var_5_3[var_5_4 - 1]
			end

			local var_5_5 = SailGameDataForExchange.New()

			var_5_5.curStageIndex = var_5_4 - 1
			var_5_5.startTime = var_5_2
			var_5_5.maxTime = GameSetting.activity_skadi_sea_total_time.value[1]

			local var_5_6 = {}
			local var_5_7 = SailGameConst.STAGE_TIME[arg_4_0]

			for iter_5_0, iter_5_1 in pairs(var_5_7) do
				var_5_6[iter_5_1] = iter_5_0
			end

			var_5_5.eventTimeList = var_5_6

			local var_5_8 = {}
			local var_5_9 = SailGameConst.GAME_TIME_TIPS

			for iter_5_2, iter_5_3 in pairs(var_5_9) do
				var_5_8[#var_5_8 + 1] = iter_5_2
			end

			var_5_5.tipsTimeList = var_5_8

			SailGameManager.Instance:SetExchangeData(var_5_5)
			JumpTools.OpenPageByJump("/sailGame", {
				activityID = arg_4_0
			})
		end)
	end
end

function var_0_0.ShutDown()
	if var_0_4 == true then
		if not isNil(SailGameManager.Instance) then
			SailGameManager.Instance:ShutDown()
		end

		var_0_0.UnLoadScene()
	end
end

function var_0_0.GetBuildingTotalReward(arg_7_0, arg_7_1)
	local var_7_0 = SailGameData:GetBuildingLastReceiveTimeList(arg_7_0)[arg_7_1]

	if not var_7_0 then
		return 0
	end

	local var_7_1 = manager.time:GetServerTime() - var_7_0
	local var_7_2 = var_0_0.GetBuildingTimePerReward()
	local var_7_3 = math.floor(var_7_1 / var_7_2)

	return SailGameBuildingCfg[arg_7_1].token_get[1][2] * var_7_3
end

function var_0_0.GetNextRecoverTimeStep(arg_8_0)
	local var_8_0 = SailGameData:GetSailCount(arg_8_0)
	local var_8_1 = GameSetting.activity_skadi_sea_be_out_num_max.value[1]
	local var_8_2 = -1

	if var_8_0 < var_8_1 then
		local var_8_3 = var_0_0.GetSailRecoverTime()
		local var_8_4 = SailGameData:GetFullRecoverTimeStep(arg_8_0)
		local var_8_5 = var_8_4 - manager.time:GetServerTime()
		local var_8_6 = var_8_1 - var_8_0

		if var_8_6 == 1 then
			var_8_2 = var_8_4 + 1
		else
			var_8_2 = manager.time:GetServerTime() + (var_8_5 - var_8_3 * (var_8_6 - 1) + 1)
		end
	end

	return var_8_2
end

function var_0_0.GetBuildingTimePerReward()
	if not var_0_0.cacheBuildingTime_ then
		var_0_0.cacheBuildingTime_ = GameSetting.activity_skadi_sea_building_calculate_time.value[1] * 60
	end

	return var_0_0.cacheBuildingTime_
end

function var_0_0.GetSailRecoverTime()
	if not var_0_0.cacheSailRecoverTime_ then
		var_0_0.cacheSailRecoverTime_ = GameSetting.activity_skadi_sea_be_out_num_recover_time.value[1] * 3600
	end

	return var_0_0.cacheSailRecoverTime_
end

return var_0_0
