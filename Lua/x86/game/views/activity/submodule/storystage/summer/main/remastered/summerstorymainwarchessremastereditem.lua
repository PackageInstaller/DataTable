SummerStoryMainWarchessItem = import("game.views.activity.Submodule.storyStage.summer.main.SummerStoryMainWarchessItem")

local var_0_0 = class("SummerStoryMainWarchessRemasteredItem", SummerStoryMainWarchessItem)

function var_0_0.OnEnter(arg_1_0)
	arg_1_0:RefreshUI()
	manager.redPoint:bindUIandKey(arg_1_0.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, ChessConst.SUBPLOT_TAG.ISLAND, arg_1_0.chapterID_))
	arg_1_0:RefreshState()
end

function var_0_0.OnExit(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, ChessConst.SUBPLOT_TAG.ISLAND, arg_2_0.chapterID_))
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		if arg_3_0:IsPrestageLock() then
			local var_4_0 = arg_3_0.chapterID_
			local var_4_1 = WarchessLevelCfg[var_4_0]
			local var_4_2 = var_4_1.unlock_level

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(GetTips("CHESS_NAME_" .. var_4_1.tag)), WarchessLevelCfg[var_4_2].name_level))

			return
		end

		if arg_3_0:IsLock() then
			local var_4_3 = WarchessLevelCfg[arg_3_0.chapterID_].unlock_condition

			if var_4_3[1] == 1 then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ActivityStoryChapterCfg[var_4_3[2][1]].name), BattleActivityStoryStageCfg[var_4_3[2][2]].name))
			elseif var_4_3[1] == 2 then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ChapterCfg[var_4_3[2][1]].subhead), BattleActivityStoryStageCfg[var_4_3[2][2]].name))
			end

			return
		end

		ChessTools.EnterChessMap(arg_3_0.chapterID_, true)
	end)
end

function var_0_0.IsLock(arg_5_0)
	local var_5_0 = arg_5_0.chapterID_
	local var_5_1 = WarchessLevelCfg[var_5_0].unlock_condition

	if var_5_1 ~= "" then
		if var_5_1[1] == 1 then
			local var_5_2 = StoryStageActivityData:GetStageData(var_5_1[2][1])[var_5_1[2][2]]

			if var_5_2 and var_5_2.clear_times >= 1 then
				-- block empty
			else
				return true
			end
		elseif var_5_1[1] == 2 then
			return not ChapterTools.IsClearStage(var_5_1[2][2])
		end
	end

	return false
end

function var_0_0.RefreshState(arg_6_0)
	local var_6_0 = WarchessLevelCfg[arg_6_0.chapterID_].type
	local var_6_1 = WarChessData:GetCurrentChapter(var_6_0)

	if arg_6_0:IsPrestageLock() or arg_6_0:IsLock() then
		arg_6_0.controller_:SetSelectedState("open")

		return
	end

	if var_6_1 == arg_6_0.chapterID_ then
		arg_6_0.controller_:SetSelectedState("challenge")
	else
		arg_6_0.controller_:SetSelectedState("normal")
	end
end

return var_0_0
