local var_0_0 = class("SkinDrawInfoViewOld", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivitySkinDrawToolsOld.GetDrawInfoUIName(arg_1_0.params_.activityID)
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
	arg_4_0.stateCon_ = arg_4_0.transform_:GetComponent("ControllerExCollection"):GetController("state")
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
	arg_10_0:RefreshDes()
	arg_10_0:RefreshData()
	arg_10_0:RefreshPool()
end

function var_0_0.RefreshDes(arg_11_0)
	local var_11_0 = ActivityLimitedDrawPoolListCfg[arg_11_0.poolID_]

	arg_11_0.infoTxt_.text = var_11_0.detail_note
end

function var_0_0.RefreshData(arg_12_0)
	if arg_12_0.poolList_[arg_12_0.poolID_] then
		arg_12_0.curPoolData_ = arg_12_0.poolList_[arg_12_0.poolID_]

		return
	end

	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}
	local var_12_3 = {}
	local var_12_4 = ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[arg_12_0.poolID_]

	for iter_12_0, iter_12_1 in ipairs(ActivityLimitedDrawPoolListCfg[arg_12_0.poolID_].main_icon_info) do
		table.insert(var_12_1, iter_12_1[1])
	end

	for iter_12_2, iter_12_3 in ipairs(var_12_4) do
		local var_12_5 = ActivityLimitedDrawPoolCfg[iter_12_3].minimum_guarantee

		if var_12_5 == 1 then
			table.insert(var_12_3, iter_12_3)
		elseif var_12_5 == 2 and not table.indexof(var_12_1, iter_12_3) then
			table.insert(var_12_2, iter_12_3)
		end
	end

	local var_12_6 = {
		name = GetTips("Main_Reward"),
		list = var_12_1
	}
	local var_12_7 = {
		name = GetTips("Least_Reward"),
		list = var_12_2
	}
	local var_12_8 = {
		name = GetTips("Other_Reward"),
		list = var_12_3
	}

	table.insert(var_12_0, var_12_6)
	table.insert(var_12_0, var_12_7)
	table.insert(var_12_0, var_12_8)

	arg_12_0.curPoolData_ = var_12_0
	arg_12_0.poolList_[arg_12_0.poolID_] = var_12_0
end

function var_0_0.RefreshPool(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.curPoolData_ do
		if not arg_13_0.poolItems_[iter_13_0] then
			local var_13_0 = Object.Instantiate(arg_13_0.msgItem_, arg_13_0.contentTrs_)

			arg_13_0.poolItems_[iter_13_0] = SkinDrawInfoContentItemOld.New(var_13_0)
		end

		arg_13_0.poolItems_[iter_13_0]:RefreshData(arg_13_0.curPoolData_[iter_13_0], arg_13_0.activityID_)
	end

	for iter_13_1 = #arg_13_0.curPoolData_ + 1, #arg_13_0.poolItems_ do
		arg_13_0.poolItems_[iter_13_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.layout_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.layout_4)
end

function var_0_0.OnExit(arg_14_0)
	for iter_14_0 = 1, #arg_14_0.poolItems_ do
		arg_14_0.poolItems_[iter_14_0]:OnExit()
	end
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()

	for iter_15_0 = 1, #arg_15_0.poolItems_ do
		arg_15_0.poolItems_[iter_15_0]:Dispose()
	end

	arg_15_0.super.Dispose(arg_15_0)
end

return var_0_0
