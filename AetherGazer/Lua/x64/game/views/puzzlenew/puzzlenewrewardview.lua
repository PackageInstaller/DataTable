local var_0_0 = class("PuzzleNewRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return PuzzleNewTools.GetRewardViewUIName(arg_1_0.params_.activityID)
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
	arg_9_0:RefreshRegionItem()
	arg_9_0:RefreshPuzzleMask()
	arg_9_0:RefreshPreviewImg()
end

function var_0_0.RefreshRegionItem(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.regionList_) do
		iter_10_1:SetData(arg_10_0.activityID_)
	end
end

function var_0_0.RefreshPuzzleMask(arg_11_0)
	local var_11_0 = PuzzleNewCfg[arg_11_0.activityID_]
	local var_11_1 = PuzzleNewData:GetCurPuzzleList(arg_11_0.activityID_)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.maskList_) do
		SetActive(iter_11_1, var_11_1[iter_11_0] == nil or var_11_1[iter_11_0] ~= var_11_0.correct_array[iter_11_0])
	end
end

function var_0_0.RefreshPreviewImg(arg_12_0)
	local var_12_0 = PuzzleNewCfg[arg_12_0.activityID_]

	if arg_12_0.previewImg_ then
		arg_12_0.previewImg_.sprite = pureGetSpriteWithoutAtlas(var_12_0.preview_album_id)
	end
end

function var_0_0.SpawnRegion(arg_13_0, arg_13_1)
	local var_13_0 = PuzzleNewCfg[arg_13_1]
	local var_13_1 = PuzzleNewTools.GetPuzzlePosDic(arg_13_1)
	local var_13_2 = PuzzleNewTools.GetRegionPosDic(arg_13_1)
	local var_13_3 = var_13_0.area_fragment_list
	local var_13_4 = var_13_0.reward_area_list

	arg_13_0.regionList_ = arg_13_0.regionList_ or {}

	local var_13_5 = arg_13_0.regionContentTrans_.childCount

	for iter_13_0 = 1, var_13_5 do
		local var_13_6 = arg_13_0.regionContentTrans_:GetChild(iter_13_0 - 1)
		local var_13_7 = tonumber(var_13_6.name)
		local var_13_8 = var_13_2[var_13_7]
		local var_13_9 = var_13_3[var_13_8]
		local var_13_10 = var_13_9[2]
		local var_13_11 = var_13_4[var_13_8][2]

		if not arg_13_0.regionList_[var_13_7] then
			arg_13_0.regionList_[var_13_7] = PuzzleNewRegionItem.New(var_13_6, var_13_9, var_13_1, var_13_11)
		end
	end

	arg_13_0.maskList_ = arg_13_0.maskList_ or {}

	local var_13_12 = arg_13_0.maskPanelTrans_.childCount

	for iter_13_1 = 1, var_13_12 do
		local var_13_13 = arg_13_0.maskPanelTrans_:GetChild(iter_13_1 - 1)

		arg_13_0.maskList_[iter_13_1] = var_13_13
	end
end

function var_0_0.DispawnRegion(arg_14_0)
	if arg_14_0.regionList_ then
		for iter_14_0, iter_14_1 in pairs(arg_14_0.regionList_) do
			iter_14_1:Dispose()
		end

		arg_14_0.regionList_ = nil
	end

	arg_14_0.maskList_ = nil
end

return var_0_0
