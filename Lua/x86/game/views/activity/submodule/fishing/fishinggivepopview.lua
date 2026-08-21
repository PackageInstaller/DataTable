local var_0_0 = class("FishingGivePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Fishing/FishingGivePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0.curId_ = 0

	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.currentList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexCurrentItem), arg_5_0.currentListGo_, FishIcon)
	arg_5_0.requireList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexRequireItem), arg_5_0.requireListGo_, FishIcon)
end

function var_0_0.indexCurrentItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:RegisterClickListener(function(arg_7_0)
		arg_6_0:SwitchSelect(arg_7_0)
	end)

	if arg_6_0.curId_ == arg_6_0.fishDataList_[arg_6_1].id then
		arg_6_2:SetSelected(true)
	else
		arg_6_2:SetSelected(false)
	end

	arg_6_2:SetId(arg_6_0.fishDataList_[arg_6_1].id, arg_6_0.fishDataList_[arg_6_1].num)
end

function var_0_0.indexRequireItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetId(arg_8_0.params_.data.fishList[arg_8_1])
end

function var_0_0.SwitchSelect(arg_9_0, arg_9_1)
	arg_9_0.curId_ = arg_9_1

	arg_9_0.currentList_:Refresh()
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.giveBtn_, nil, function()
		if arg_10_0.curId_ ~= 0 then
			FishingAction.GiveRareFish(ActivityConst.SUMMER_FISHING, arg_10_0.curId_, arg_10_0.params_.data.friendId, function()
				arg_10_0:Back()
			end)
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.cancelBtn_, nil, function()
		arg_10_0:Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.closeBtn_, nil, function()
		arg_10_0:Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.bgBtn_, nil, function()
		arg_10_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_16_0)
	return
end

function var_0_0.OnTop(arg_17_0)
	arg_17_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_18_0)
	return
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0:AddEventListeners()

	arg_19_0.fishDataList_ = {}

	for iter_19_0, iter_19_1 in pairs(FishingData:GetActivityData().fish_infos) do
		if iter_19_1.num > 0 then
			table.insert(arg_19_0.fishDataList_, iter_19_1)
		end
	end

	arg_19_0:UpdateView()
end

function var_0_0.OnExit(arg_20_0)
	arg_20_0:RemoveAllEventListener()
end

function var_0_0.UpdateView(arg_21_0)
	arg_21_0.requireList_:StartScroll(#arg_21_0.params_.data.fishList)
	arg_21_0.currentList_:StartScroll(#arg_21_0.fishDataList_)
end

function var_0_0.OnMainHomeViewTop(arg_22_0)
	return
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.requireList_ then
		arg_23_0.requireList_:Dispose()

		arg_23_0.requireList_ = nil
	end

	if arg_23_0.currentList_ then
		arg_23_0.currentList_:Dispose()

		arg_23_0.currentList_ = nil
	end

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
