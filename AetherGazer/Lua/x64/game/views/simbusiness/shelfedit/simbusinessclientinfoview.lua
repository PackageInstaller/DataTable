local var_0_0 = class("SimBusinessClientInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.heroScroll = LuaList.New(handler(arg_2_0, arg_2_0.indexItem), arg_2_0.uilistGo_, SimBusinessGuestInfoItem)
	arg_2_0.clientInfoPage = SimBusinessClientPage.New(arg_2_0.clientGo)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.clientList = SimBusinessGuestCfg.all
	arg_4_0.selectID = arg_4_0.selectID or arg_4_0.clientList[1]

	arg_4_0.heroScroll:StartScroll(#arg_4_0.clientList)
	arg_4_0.clientInfoPage:RefreshView(arg_4_0.selectID)
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshData({
		id = arg_5_0.clientList[arg_5_1]
	}, arg_5_1, arg_5_0.selectID == arg_5_0.clientList[arg_5_1], false)
	arg_5_2:RegisterClickFunc(handler(arg_5_0, arg_5_0.clickClient))
end

function var_0_0.OnTop(arg_6_0)
	return
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.clickClient(arg_8_0, arg_8_1)
	arg_8_0.selectID = arg_8_1.guestID

	arg_8_0.heroScroll:Refresh()
	arg_8_0.clientInfoPage:RefreshView(arg_8_0.selectID)
end

function var_0_0.OnEventRefreshView(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.heroScroll:Dispose()
	arg_10_0.clientInfoPage:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.RegisterEvents(arg_11_0)
	return
end

return var_0_0
