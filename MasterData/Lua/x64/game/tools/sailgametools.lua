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
			local var_5_1 = 0
			local var_5_2 = SailGameData:GetCurGameData(arg_4_0).curStageIndex

			if var_5_2 - 1 > 0 then
				var_5_1 = GameSetting.activity_skadi_sea_event_time.value[var_5_2 - 1]
			end

			local var_5_3 = SailGameDataForExchange.New()

			var_5_3.curStageIndex = var_5_2 - 1
			var_5_3.startTime = var_5_1
			var_5_3.maxTime = GameSetting.activity_skadi_sea_total_time.value[1]

			local var_5_4 = {}

			for iter_5_0, iter_5_1 in pairs(SailGameConst.STAGE_TIME[arg_4_0]) do
				var_5_4[iter_5_1] = iter_5_0
			end

			var_5_3.eventTimeList = var_5_4

			local var_5_5 = {}

			for iter_5_2, iter_5_3 in pairs(SailGameConst.GAME_TIME_TIPS) do
				var_5_5[#var_5_5 + 1] = iter_5_2
			end

			var_5_3.tipsTimeList = var_5_5

			SailGameManager.Instance:SetExchangeData(var_5_3)
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

	return SailGameBuildingCfg[arg_7_1].token_get[1][2] * math.floor((manager.time:GetServerTime() - var_7_0) / var_0_0.GetBuildingTimePerReward())
end

function var_0_0.GetNextRecoverTimeStep(arg_8_0)
	local var_8_0 = SailGameData:GetSailCount(arg_8_0)
	local var_8_1 = -1

	if var_8_0 < GameSetting.activity_skadi_sea_be_out_num_max.value[1] then
		local var_8_2 = SailGameData:GetFullRecoverTimeStep(arg_8_0)

		var_8_1 = GameSetting.activity_skadi_sea_be_out_num_max.value[1] - var_8_0 == 1 and var_8_2 + 1 or manager.time:GetServerTime() + (var_8_2 - manager.time:GetServerTime() - var_0_0.GetSailRecoverTime() * (GameSetting.activity_skadi_sea_be_out_num_max.value[1] - var_8_0 - 1) + 1)
	end

	return var_8_1
end

function var_0_0.GetBuildingTimePerReward()
	var_0_0.cacheBuildingTime_ = var_0_0.cacheBuildingTime_ or GameSetting.activity_skadi_sea_building_calculate_time.value[1] * 60

	return var_0_0.cacheBuildingTime_
end

function var_0_0.GetSailRecoverTime()
	var_0_0.cacheSailRecoverTime_ = var_0_0.cacheSailRecoverTime_ or GameSetting.activity_skadi_sea_be_out_num_recover_time.value[1] * 3600

	return var_0_0.cacheSailRecoverTime_
end

return var_0_0
