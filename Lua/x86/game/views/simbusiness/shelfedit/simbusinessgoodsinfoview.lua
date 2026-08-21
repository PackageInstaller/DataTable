local var_0_0 = class("SimBusinessGoodsInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.itemList = LuaList.New(handler(arg_2_0, arg_2_0.indexItem), arg_2_0.uilistGo_, SimBusinessShowItem)
	arg_2_0.goodPage = SimBusinessGoodPage.New(arg_2_0.pageGo)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.goodList = SimBusinessGoodsCfg.all
	arg_4_0.selectID = arg_4_0.goodList[1]

	arg_4_0:RefreshItemList()
	arg_4_0:RefreshGoodInfo()
end

function var_0_0.OnTop(arg_5_0)
	return
end

function var_0_0.OnEventRefreshView(arg_6_0)
	arg_6_0:RefreshGoodInfo()
	arg_6_0.itemList:Refresh()
end

function var_0_0.RefreshItemList(arg_7_0)
	arg_7_0.itemList:StartScroll(#arg_7_0.goodList)
end

function var_0_0.indexItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:RefreshView(arg_8_0.goodList[arg_8_1], SimBusinessConst.ShowItmeType.good, arg_8_0.selectID, true, true)
	arg_8_2:RegisterClickItemFunc(handler(arg_8_0, arg_8_0.ClickItem))
end

function var_0_0.ClickItem(arg_9_0, arg_9_1)
	arg_9_0.selectID = arg_9_1

	arg_9_0.itemList:Refresh()
	arg_9_0:RefreshGoodInfo()
end

function var_0_0.RefreshGoodInfo(arg_10_0)
	if arg_10_0.selectID then
		arg_10_0.goodPage:RefreshView(arg_10_0.selectID)
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.itemList:Dispose()
	arg_12_0.goodPage:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.RegisterEvents(arg_13_0)
	return
end

return var_0_0
