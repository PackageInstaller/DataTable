return {
	EnterCaptureGame = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		local var_1_0 = Capture.Runtime.CaptureGameDataForExchange.New()

		var_1_0.stageId = arg_1_2
		var_1_0.mainStageId = arg_1_1
		var_1_0.stageConfigName = ActivitySwimSkinSubSectionCfg[arg_1_2].scene_name
		var_1_0.isFreeCapture = arg_1_3

		local var_1_1 = ActivitySwimSkinSectionCfg[arg_1_1]

		if var_1_1.mode == CaptureGameConst.CaptureGameMode.Single then
			var_1_0.singleModeRoleId = var_1_1.scene_hero_list[1]
		else
			var_1_0.singleModeRoleId = -1
		end

		CaptureGameData:RegisterSectionData(arg_1_1, arg_1_2, arg_1_3)
		StartCaptureGameMode(var_1_0)
	end,
	GetActivityListByMode = function(arg_2_0, arg_2_1)
		if not arg_2_0.gameModeList then
			arg_2_0.gameModeList = {}

			for iter_2_0, iter_2_1 in ipairs(ActivitySwimSkinSectionCfg.all) do
				local var_2_0 = ActivitySwimSkinSectionCfg[iter_2_1]

				arg_2_0.gameModeList[var_2_0.mode] = arg_2_0.gameModeList[var_2_0.mode] or {}

				table.insert(arg_2_0.gameModeList[var_2_0.mode], var_2_0)
			end
		end

		return arg_2_0.gameModeList[arg_2_1] or {}
	end,
	GetCaptureHeroList = function(arg_3_0, arg_3_1)
		return ActivitySwimSkinSectionCfg[arg_3_1].scene_hero_list
	end,
	GetLensPath = function(arg_4_0, arg_4_1)
		local var_4_0 = ActivitySwimSkinLensCfg[arg_4_1]

		return "TextureBg/CaptureGameLens/" .. var_4_0.imgPath
	end,
	IsFreeActivity = function(arg_5_0, arg_5_1)
		if arg_5_1 == CaptureGameConst.ModeMainActivity.MultiFree or arg_5_1 == CaptureGameConst.ModeMainActivity.SingleFree then
			return true
		end

		return false
	end,
	SendResultSdk = function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
		local var_6_0 = {
			hitNum = 1,
			activity_id = arg_6_1,
			stage_id = arg_6_2,
			sequence_id = arg_6_3,
			result = arg_6_4,
			hero_list = arg_6_5,
			condition_id_list = arg_6_6,
			use_seconds = arg_6_7
		}

		SDKTools.SendMessageToSDK("activity_combat_over", var_6_0)
	end,
	SendShareSdk = function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = ""
		local var_7_1 = {
			"",
			"",
			","
		}
		local var_7_2 = CaptureGameMgr:GetCurUsingHeroList()
		local var_7_3 = 1
		local var_7_4 = #var_7_2

		for iter_7_0, iter_7_1 in ipairs(var_7_2) do
			var_7_1[1] = var_7_0
			var_7_1[2] = iter_7_1

			if var_7_3 == var_7_4 then
				var_7_1[3] = ""
			else
				var_7_1[3] = ","
			end

			var_7_3 = var_7_3 + 1
			var_7_0 = table.concat(var_7_1)
		end

		local var_7_5 = ""
		local var_7_6 = CaptureGameMgr:GetCurUsingHeroPoseList()
		local var_7_7 = 1
		local var_7_8 = #var_7_6

		for iter_7_2, iter_7_3 in ipairs(var_7_6) do
			var_7_1[1] = var_7_5
			var_7_1[2] = iter_7_3

			if var_7_7 == var_7_8 then
				var_7_1[3] = ""
			else
				var_7_1[3] = ","
			end

			var_7_7 = var_7_7 + 1
			var_7_5 = table.concat(var_7_1)
		end

		local var_7_9 = {
			activity_id = CaptureGameMgr:GetMainActivityId(),
			hero_list = var_7_0,
			share_channel = arg_7_1,
			screenshot_oper = arg_7_2,
			posture_list = var_7_5
		}

		SDKTools.SendMessageToSDK("screenshot", var_7_9)
	end,
	CaptureGameCanOpen = function(arg_8_0, arg_8_1)
		if not arg_8_0.cacheGameOrder then
			arg_8_0.cacheGameOrder = {
				[CaptureGameConst.CaptureGameMode.Single] = {},
				[CaptureGameConst.CaptureGameMode.Multiple] = {}
			}

			for iter_8_0, iter_8_1 in ipairs(ActivitySwimSkinSectionCfg.all) do
				local var_8_0 = ActivitySwimSkinSectionCfg[iter_8_1]

				if arg_8_0.cacheGameOrder[var_8_0.mode] then
					table.insert(arg_8_0.cacheGameOrder[var_8_0.mode], iter_8_1)
				end
			end
		end

		local var_8_1 = ActivitySwimSkinSectionCfg[arg_8_1]

		if var_8_1 and arg_8_0.cacheGameOrder[var_8_1.mode] then
			local var_8_2 = table.indexof(arg_8_0.cacheGameOrder[var_8_1.mode], arg_8_1)

			if var_8_2 == 1 then
				return true
			end

			if CaptureGameData:GetReachActivityCountByMode(var_8_1.mode) >= var_8_2 - 1 then
				return true
			end
		else
			return false
		end

		return false
	end
}
