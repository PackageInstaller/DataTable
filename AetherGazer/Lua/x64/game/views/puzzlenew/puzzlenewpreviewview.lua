local var_0_0 = class("PuzzleNewRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return PuzzleNewTools.GetPreviewUIName(arg_1_0.params_.activityID)
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

	arg_7_0.img_.sprite = pureGetSpriteWithoutAtlas(var_7_0.preview_album_id)
end

return var_0_0
