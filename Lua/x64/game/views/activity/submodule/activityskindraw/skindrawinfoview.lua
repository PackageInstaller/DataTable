local var_0_0 = class("SkinDrawInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	if arg_1_0.params_.isOath then
		return OathDrawTools.GetDrawInfoUIName(arg_1_0.params_.activityID)
	else
		return ActivitySkinDrawTools.GetDrawInfoUIName(arg_1_0.params_.activityID)
	end
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.poolList_ = {}
	arg_4_0.poolItems_ = {}
	arg_4_0.stateCon_ = arg_4_0.transCon_:GetController("state")
	arg_4_0.tabCon_ = arg_4_0.transCon_:GetController("tab")
	arg_4_0.tipsCon_ = arg_4_0.transCon_:GetController("tips")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgMask_, nil, function()
		arg_5_0.stateCon_:SetSelectedState("info")
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnInfo_, nil, function()
		arg_5_0.stateCon_:SetSelectedState("info")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnMessage_, nil, function()
		arg_5_0.stateCon_:SetSelectedState("message")
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.poolID_ = arg_9_0.params_.poolID
	arg_9_0.activityID_ = arg_9_0.params_.poolActivityID

	arg_9_0.stateCon_:SetSelectedState("info")
	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.tabCon_:SetSelectedState("hide")
	arg_10_0:RefreshDes()
	arg_10_0:RefreshData()
	arg_10_0:RefreshPool()
end

function var_0_0.RefreshDes(arg_11_0)
	local var_11_0 = ActivityLimitedDrawPoolListCfg[arg_11_0.poolID_]

	arg_11_0.infoTxt_.text = var_11_0.detail_note
end

function var_0_0.IsNeedMainRewardShow(arg_12_0)
	local var_12_0 = true

	if arg_12_0.params_.isOath then
		var_12_0 = false
	end

	return var_12_0
end

function var_0_0.RefreshData(arg_13_0)
	if arg_13_0.poolList_[arg_13_0.poolID_] then
		arg_13_0.curPoolData_ = arg_13_0.poolList_[arg_13_0.poolID_]

		return
	end

	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = {}
	local var_13_4 = ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[arg_13_0.poolID_]

	if arg_13_0:IsNeedMainRewardShow() then
		for iter_13_0, iter_13_1 in ipairs(ActivityLimitedDrawPoolListCfg[arg_13_0.poolID_].main_icon_info) do
			table.insert(var_13_1, iter_13_1[1])
		end
	end

	for iter_13_2, iter_13_3 in ipairs(var_13_4) do
		local var_13_5 = ActivityLimitedDrawPoolCfg[iter_13_3].minimum_guarantee

		if var_13_5 == 1 then
			table.insert(var_13_3, iter_13_3)
		elseif var_13_5 == 2 and not table.indexof(var_13_1, iter_13_3) then
			table.insert(var_13_2, iter_13_3)
		end
	end

	local var_13_6 = {
		name = GetTips("Least_Reward"),
		list = var_13_2
	}
	local var_13_7 = {
		name = GetTips("Other_Reward"),
		list = var_13_3
	}

	if arg_13_0:IsNeedMainRewardShow() then
		local var_13_8 = {
			name = GetTips("Main_Reward"),
			list = var_13_1
		}

		table.insert(var_13_0, var_13_8)
	end

	table.insert(var_13_0, var_13_6)
	table.insert(var_13_0, var_13_7)

	arg_13_0.curPoolData_ = var_13_0
	arg_13_0.poolList_[arg_13_0.poolID_] = var_13_0
end

function var_0_0.RefreshPool(arg_14_0)
	local var_14_0 = not string.isNullOrEmpty(arg_14_0.params_.isShowTips)

	arg_14_0.tipsCon_:SetSelectedState(var_14_0 and "on" or "off")

	if var_14_0 then
		arg_14_0.tipsText_.text = arg_14_0.params_.isShowTips
	end

	if arg_14_0.params_.tabText_1 then
		arg_14_0.txtSelectTab1_.text = arg_14_0.params_.tabText_1
		arg_14_0.txtTab1_.text = arg_14_0.params_.tabText_1
	end

	for iter_14_0 = 1, #arg_14_0.curPoolData_ do
		if not arg_14_0.poolItems_[iter_14_0] then
			local var_14_1 = Object.Instantiate(arg_14_0.msgItem_, arg_14_0.contentTrs_)

			arg_14_0.poolItems_[iter_14_0] = SkinDrawInfoContentItem.New(var_14_1)
		end

		local var_14_2 = {
			isOath = arg_14_0.params_.isOath,
			checkPoolStage = arg_14_0.params_.checkPoolStage,
			poolID = arg_14_0.poolID_
		}

		arg_14_0.poolItems_[iter_14_0]:RefreshData(arg_14_0.curPoolData_[iter_14_0], arg_14_0.activityID_, iter_14_0 == #arg_14_0.curPoolData_, var_14_2)
	end

	for iter_14_1 = #arg_14_0.curPoolData_ + 1, #arg_14_0.poolItems_ do
		arg_14_0.poolItems_[iter_14_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.layout_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.layout_4)
end

function var_0_0.OnExit(arg_15_0)
	for iter_15_0 = 1, #arg_15_0.poolItems_ do
		arg_15_0.poolItems_[iter_15_0]:OnExit()
	end
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:RemoveAllListeners()

	for iter_16_0 = 1, #arg_16_0.poolItems_ do
		arg_16_0.poolItems_[iter_16_0]:Dispose()
	end

	arg_16_0.super.Dispose(arg_16_0)
end

return var_0_0
