local var_0_0 = {}

function var_0_0.EnterStage(arg_1_0, arg_1_1)
	local var_1_0, var_1_1 = var_0_0:CheckStageIsOpen(arg_1_1)

	if ActivityTangramGameStageCfg[arg_1_1] then
		if var_1_0 then
			JumpTools.OpenPageByJump("/tangramGameStageView", {
				stageID = arg_1_1
			})
		else
			ShowTips(var_1_1)
		end
	end
end

function var_0_0.ExitStage(arg_2_0)
	TangramGameBridge.DisposeStage()
end

function var_0_0.StartStage(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 then
		local var_3_0 = TangramDataExchange.New()

		var_3_0.finfishList = arg_3_3

		TangramGameBridge.InitGame(arg_3_2)
		TangramGameBridge.StartStage(var_3_0, arg_3_1)
	end
end

function var_0_0.CheckChapterIsOpen(arg_4_0, arg_4_1)
	if not ActivityData:GetActivityIsOpen(ActivityTangramGameChapterCfg[arg_4_1].activityID) then
		return false, "SOLO_NOT_OPEN"
	end

	if not ActivityTangramGameChapterCfg[arg_4_1] then
		print("不存在章节" .. arg_4_1)

		return false
	end

	for iter_4_0, iter_4_1 in ipairs(ActivityTangramGameChapterCfg[arg_4_1].unlock_condition_list) do
		if iter_4_1 > 0 and not IsConditionAchieved(iter_4_1) then
			return false
		end
	end

	if ActivityTangramGameChapterCfg[arg_4_1].pre_chapter and ActivityTangramGameChapterCfg[arg_4_1].pre_chapter > 0 and TangramGameData:GetChapterFinTotalProcess(ActivityTangramGameChapterCfg[arg_4_1].pre_chapter) then
		return false, "ACTIVITY_ZUMA_OPEN_FRONT"
	end

	return true
end

function var_0_0:CheckStageIsOpen(arg_5_1)
	local var_5_0 = true
	local var_5_1

	if ActivityTangramGameStageCfg[arg_5_1] then
		if ActivityTangramGameChapterCfg.get_id_list_by_puzzle_stage_list[arg_5_1] or ActivityTangramGameChapterCfg.get_id_list_by_inference_stage_list[arg_5_1] then
			var_5_0, var_5_1 = self:CheckChapterIsOpen(ActivityTangramGameChapterCfg.get_id_list_by_puzzle_stage_list[arg_5_1][1] or ActivityTangramGameChapterCfg.get_id_list_by_inference_stage_list[arg_5_1][1])

			if not var_5_0 then
				return var_5_0, var_5_1
			end
		end

		local var_5_3 = ActivityTangramGameStageCfg[arg_5_1].pre_stage

		if ActivityTangramGameStageCfg[arg_5_1].pre_stage and var_5_3 > 0 and not TangramGameData:CheckStageIsClear(var_5_3) then
			var_5_0 = false
			var_5_1 = "ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK"
		end
	else
		var_5_0 = false
	end

	return var_5_0, var_5_1
end

function var_0_0:UpdataGlobalRedPoint()
	self:UpdataNewStageRedPoint()
	self:UpdataDecodeStageRedPoint()
end

function var_0_0.UpdataNewStageRedPoint(arg_7_0, arg_7_1)
	if ActivityData:GetActivityIsOpen((TangramGameData:GetCurRunGameActivityID())) then
		for iter_7_0, iter_7_1 in ipairs(ActivityTangramGameChapterCfg.all) do
			if TangramGameTools:CheckChapterIsOpen(iter_7_1) then
				local var_7_0 = true

				for iter_7_2, iter_7_3 in pairs(ActivityTangramGameChapterCfg[iter_7_1].puzzle_stage_list) do
					if not TangramGameData:GetStageInfoByStageID(iter_7_3).isFin then
						if arg_7_1 then
							if arg_7_1 == iter_7_3 then
								manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_STAGE, tostring(iter_7_1)), 1)
							end
						else
							manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_STAGE, tostring(iter_7_1)), 1)
						end

						var_7_0 = false

						break
					end
				end

				if var_7_0 then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_STAGE, tostring(iter_7_1)), 0)
				end
			end
		end
	end
end

function var_0_0.UpdataDecodeStageRedPoint(arg_8_0)
	if ActivityData:GetActivityIsOpen((TangramGameData:GetCurRunGameActivityID())) then
		for iter_8_0, iter_8_1 in ipairs(ActivityTangramGameChapterCfg.all) do
			if TangramGameData:GetChapterFinProcess(iter_8_1) and not TangramGameData:GetChapterFinTotalProcess(iter_8_1) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_FULL_CLUE, tostring(iter_8_1)), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_FULL_CLUE, tostring(iter_8_1)), 0)
			end
		end
	end
end

return var_0_0
