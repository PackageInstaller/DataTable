local var_0_0 = class("SubPlotExtraStoryBtn", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.OnEnter(arg_2_0)
	local var_2_0 = getChapterClientCfgByChapterID(arg_2_0.chapterID_)

	manager.redPoint:bindUIandKey(arg_2_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, var_2_0.id))
end

function var_0_0.OnExit(arg_3_0)
	local var_3_0 = getChapterClientCfgByChapterID(arg_3_0.chapterID_)

	manager.redPoint:unbindUIandKey(arg_3_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, var_3_0.id))
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		local var_6_0 = getChapterClientCfgByChapterID(arg_5_0.chapterID_)

		if var_6_0.extra_story_unlock_condition ~= "" then
			for iter_6_0, iter_6_1 in ipairs(var_6_0.extra_story_unlock_condition) do
				if not isMeetCondition(iter_6_1) then
					ShowTips(getConditionText(iter_6_1))

					return
				end
			end
		end

		BattleStageAction.ClickSubPlotExtraStory(var_6_0.id)

		if type(var_6_0.extra_strory_system) == "table" then
			JumpTools.JumpToPage2(var_6_0.extra_strory_system)
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.chapterID_ = arg_7_1

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = getChapterClientCfgByChapterID(arg_8_0.chapterID_)

	if type(var_8_0.extra_strory_system) == "table" then
		SetActive(arg_8_0.gameObject_, true)
	else
		SetActive(arg_8_0.gameObject_, false)
	end
end

return var_0_0
