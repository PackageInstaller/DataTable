local var_0_0 = class("MoonBoRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/VolumeRewardPreview"
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

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, MoonBoRewardItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_1, arg_5_0.params_.activityId)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.scrollHelper_:StartScroll(#MoonBoCfg.get_id_list_by_activity_id[arg_9_0.params_.activityId])
end

function var_0_0.OnExit(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.scrollHelper_:GetItemList()) do
		iter_10_1:OnExit()
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	arg_11_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
