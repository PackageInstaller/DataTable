local var_0_0 = class("PuzzleNewCheckPreviewView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return PuzzleNewTools.GetCheckPreviewUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backMask_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.activityID

	local var_7_0 = PuzzleNewCfg[arg_7_0.activityID_]

	arg_7_0.originImg_.sprite = pureGetSpriteWithoutAtlas(var_7_0.preview_album_id)
	arg_7_0.checkImg_.sprite = pureGetSpriteWithoutAtlas(var_7_0.album_id)

	local var_7_1 = #var_7_0.clue_id
	local var_7_2 = PuzzleNewData:GetCurCheckList(arg_7_0.activityID_)
	local var_7_3 = 0

	for iter_7_0, iter_7_1 in pairs(var_7_2) do
		var_7_3 = var_7_3 + 1
	end

	arg_7_0.progressText_.text = string.format("%d/%d", var_7_3, var_7_1)
	arg_7_0.checkGoalText_.text = string.format(GetTips("PUZZLE_CHECK_GOAL_TIP"), #var_7_0.clue_id)
end

return var_0_0
