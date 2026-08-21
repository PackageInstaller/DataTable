local var_0_0 = class("FishingRequirePageView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.requireList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexRequireItem), arg_3_0.requireListGo_, FishIcon)
	arg_3_0.currentList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexCurrentItem), arg_3_0.currentListGo_, FishIcon)
end

function var_0_0.indexRequireItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RegisterClickListener(function(arg_5_0)
		arg_4_0:SwitchSelect(arg_5_0)
	end)

	local var_4_0 = RareFishCfg.all[arg_4_1]

	arg_4_2:SetId(var_4_0)

	if table.indexof(arg_4_0.currentRequireDataList_, var_4_0) then
		arg_4_2:SetSelected(true)
	else
		arg_4_2:SetSelected(false)
	end
end

function var_0_0.SwitchSelect(arg_6_0, arg_6_1)
	local var_6_0 = table.indexof(arg_6_0.currentRequireDataList_, arg_6_1)

	if var_6_0 then
		table.remove(arg_6_0.currentRequireDataList_, var_6_0)
	else
		if #arg_6_0.currentRequireDataList_ >= 3 then
			return
		end

		table.insert(arg_6_0.currentRequireDataList_, arg_6_1)
	end

	arg_6_0.requireList_:Refresh()
end

function var_0_0.indexCurrentItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetId(arg_7_0.currentRequireDataList_[arg_7_1])
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.setBtn_, nil, function()
		FishingAction.UpdateRequest(ActivityConst.SUMMER_FISHING, arg_8_0.currentRequireDataList_)
	end)
end

function var_0_0.AddEventListeners(arg_10_0)
	arg_10_0:RegistEventListener(FISHING_REQUEST_CHANGE, function()
		arg_10_0.currentRequireDataList_ = FishingData:GetActivityData().request_infos

		arg_10_0.requireList_:StartScroll(#RareFishCfg.all)
		arg_10_0.currentList_:StartScroll(#arg_10_0.currentRequireDataList_)
	end)
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_13_0)
	return
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:AddEventListeners()

	arg_14_0.currentRequireDataList_ = FishingData:GetActivityData().request_infos

	arg_14_0.requireList_:StartScroll(#RareFishCfg.all)
	arg_14_0.currentList_:StartScroll(#arg_14_0.currentRequireDataList_)
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.requireList_ then
		arg_17_0.requireList_:Dispose()

		arg_17_0.requireList_ = nil
	end

	if arg_17_0.currentList_ then
		arg_17_0.currentList_:Dispose()

		arg_17_0.currentList_ = nil
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
