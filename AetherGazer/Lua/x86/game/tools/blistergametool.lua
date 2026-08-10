local var_0_0 = {
	ExitGame = function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end,
	GetSubActiveID = function(arg_2_0)
		return ActivityCfg[arg_2_0] and ActivityCfg[arg_2_0].sub_activity_list or nil
	end,
	ReStartGame = function(arg_3_0)
		BlisterGameLuaBridge.ReStartGame()
	end,
	NextStage = function(arg_4_0, arg_4_1)
		if arg_4_0 and arg_4_1 then
			BlisterGameData:SavePassId(arg_4_0)
			BlisterGameAction.PlayGame(arg_4_1.map)
		end
	end
}

function var_0_0.GetSessionIsLock(arg_5_0, arg_5_1)
	if arg_5_0 == ActivityConst.ACTIVITY_3_4_BLISTER_GAME or arg_5_0 == ActivityConst.SUMMER_CHESS_BOARD_BUBBLE then
		local var_5_0 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[arg_5_0]

		if var_5_0 then
			local var_5_1 = var_5_0[arg_5_1]

			return var_0_0.GetSessionIsLockByID(arg_5_0, var_5_1)
		end
	else
		return arg_5_1 ~= 1 and BlisterGameData:GetStageInfo(BlisterGameData:GetFirstPhaseLastStage()) == nil
	end
end

function var_0_0.GetSessionIsLockByID(arg_6_0, arg_6_1)
	if arg_6_0 == ActivityConst.ACTIVITY_3_4_BLISTER_GAME then
		local var_6_0 = ActivitySummerChessConditionCfg[arg_6_1]

		return not IsConditionAchieved(var_6_0 and var_6_0.condition or 0)
	else
		return false
	end
end

function var_0_0.GetSession(arg_7_0, arg_7_1)
	if arg_7_0 == ActivityConst.ACTIVITY_3_4_BLISTER_GAME or arg_7_0 == ActivityConst.SUMMER_CHESS_BOARD_BUBBLE then
		local var_7_0 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[arg_7_0]

		if var_7_0 then
			return var_7_0[arg_7_1]
		end

		return 0
	else
		return 0
	end
end

function var_0_0.GetIsFirstSession(arg_8_0)
	if BlisterGameData.activityID == ActivityConst.ACTIVITY_3_4_BLISTER_GAME then
		return arg_8_0 == ActivityConst.ACTIVITY_3_4_BLISTER_GAMEPOINT1
	else
		return arg_8_0 == ActivityConst.ACTIVITY_BLISTER_GAME_4_3_1
	end
end

function var_0_0.GoToBlisterBattleInfoView()
	if BlisterGameData.activityID == ActivityConst.ACTIVITY_3_4_BLISTER_GAME then
		JumpTools.OpenPageByJump("/blisterBattle")
	else
		JumpTools.OpenPageByJump("/blisterBattle_4_3")
	end
end

function var_0_0.GoToBlisterResultView(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if BlisterGameData.activityID == ActivityConst.ACTIVITY_3_4_BLISTER_GAME then
		JumpTools.OpenPageByJump("blisterResult", {
			id = arg_10_0,
			score = arg_10_1,
			star = arg_10_2,
			isWin = arg_10_3,
			forceQuit = arg_10_4
		})
	else
		JumpTools.OpenPageByJump("blisterResult_4_3", {
			id = arg_10_0,
			score = arg_10_1,
			star = arg_10_2,
			isWin = arg_10_3,
			forceQuit = arg_10_4
		})
	end
end

function var_0_0.GoToChapterSectionInfoView(arg_11_0)
	if BlisterGameData.activityID == ActivityConst.ACTIVITY_3_4_BLISTER_GAME then
		JumpTools.OpenPageByJump("blisterChapterSectionInfo", {
			id = arg_11_0
		})
	else
		JumpTools.OpenPageByJump("blisterChapterSectionInfo_4_3", {
			id = arg_11_0
		})
		manager.notify:Invoke(BLISTERGAME_STAGE_INFO)
	end
end

function var_0_0.GoToBlisterMessageView(arg_12_0, arg_12_1, arg_12_2)
	if BlisterGameData.activityID == ActivityConst.ACTIVITY_3_4_BLISTER_GAME then
		JumpTools.OpenPageByJump("/blisterMessage", {
			state = arg_12_0,
			OkCallback = arg_12_1,
			selfP = arg_12_2
		})
	else
		JumpTools.OpenPageByJump("/blisterMessage_4_3", {
			state = arg_12_0,
			OkCallback = arg_12_1,
			selfP = arg_12_2
		})
	end
end

return var_0_0
