local var_0_0 = class("FishingReceivePageView", ReduxView)

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

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uiListGo_, FishingReceiveItemView)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_0.receiveDataList_[arg_4_1])
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.AddEventListeners(arg_6_0)
	arg_6_0:RegistEventListener(RECEIVE_FISH_CHANGE, function()
		arg_6_0.receiveDataList_ = FishingData:GetFishReceiveInfo()

		arg_6_0:UpdateView()
	end)
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_9_0)
	return
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:AddEventListeners()
	FishingAction.GetReceiveInfo(ActivityConst.SUMMER_FISHING, function()
		arg_10_0.receiveDataList_ = FishingData:GetFishReceiveInfo()

		arg_10_0:UpdateView()
	end)
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.UpdateView(arg_13_0)
	arg_13_0.uiList_:StartScroll(#arg_13_0.receiveDataList_)
end

function var_0_0.OnMainHomeViewTop(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.uiList_ then
		arg_15_0.uiList_:Dispose()

		arg_15_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
