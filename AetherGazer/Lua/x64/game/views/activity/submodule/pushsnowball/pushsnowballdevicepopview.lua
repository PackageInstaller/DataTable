local var_0_0 = class("PushSnowBallDevicePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballDevicePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.refreshHandler_ = handler(arg_3_0, function()
		arg_3_0:RefreshUI()
	end)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.deviceList_, PushSnowBallDeviceItem)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
	manager.notify:RegistListener(PUSH_SNOWBALL_EQUIP_DEVICE, arg_8_0.refreshHandler_)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.deviceDataList_ = PushSnowBallDeviceCfg.all

	arg_9_0.uiList_:StartScroll(#arg_9_0.deviceDataList_)
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, arg_10_0.deviceDataList_[arg_10_1])
end

function var_0_0.OnExit(arg_11_0)
	manager.notify:RemoveListener(PUSH_SNOWBALL_EQUIP_DEVICE, arg_11_0.refreshHandler_)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)

	if arg_12_0.uiList_ then
		arg_12_0.uiList_:Dispose()

		arg_12_0.uiList_ = nil
	end
end

return var_0_0
