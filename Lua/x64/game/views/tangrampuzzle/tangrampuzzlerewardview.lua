local var_0_0 = class("TangramPuzzleRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return TangramPuzzleTools.GetRewardViewUIName(arg_1_0.params_.activityID)
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
	if arg_7_0.activityID_ ~= arg_7_0.params_.activityID then
		arg_7_0:DispawnRegion()
		arg_7_0:SpawnRegion(arg_7_0.params_.activityID)
	end

	arg_7_0.activityID_ = arg_7_0.params_.activityID

	arg_7_0:RefreshUI()
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:DispawnRegion()
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = TangramPuzzleCfg[arg_9_0.activityID_]

	for iter_9_0, iter_9_1 in pairs(arg_9_0.regionList_) do
		iter_9_1:SetData(arg_9_0.activityID_, iter_9_0)
	end

	arg_9_0.completeImg_.sprite = pureGetSpriteWithoutAtlas(var_9_0.path .. var_9_0.album_id)
end

function var_0_0.SpawnRegion(arg_10_0, arg_10_1)
	local var_10_0 = TangramPuzzleCfg[arg_10_1].reward_area_list

	arg_10_0.regionList_ = arg_10_0.regionList_ or {}

	local var_10_1 = arg_10_0.regionContentTrans_.childCount

	for iter_10_0 = 1, var_10_1 do
		local var_10_2 = arg_10_0.regionContentTrans_:GetChild(iter_10_0 - 1)
		local var_10_3 = var_10_0[iter_10_0][1]

		if not arg_10_0.regionList_[var_10_3] then
			arg_10_0.regionList_[var_10_3] = TangramRegionRewardItem.New(var_10_2)
		end
	end
end

function var_0_0.DispawnRegion(arg_11_0)
	if arg_11_0.regionList_ then
		for iter_11_0, iter_11_1 in pairs(arg_11_0.regionList_) do
			iter_11_1:Dispose()
		end

		arg_11_0.regionList_ = nil
	end

	arg_11_0.maskList_ = nil
end

function var_0_0.OnExitInput(arg_12_0)
	arg_12_0:Back()

	return true
end

return var_0_0
