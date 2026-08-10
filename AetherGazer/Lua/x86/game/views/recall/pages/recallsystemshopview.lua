local var_0_0 = import("game.views.recall.pages.RecallPageBase")
local var_0_1 = class("RecallSystemShopView", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.list_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.listGo_, RecallSystemShopItem)

	arg_2_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_3_0, arg_3_1)
		arg_2_0:UpdateView(arg_3_0, arg_3_1)
	end)
	arg_2_0:RegistEventListener(MATERIAL_MODIFY, function(arg_4_0)
		arg_2_0:UpdateView()
	end)

	arg_2_0.shopID = ActivityRecallData:GetDataByPara("shopID")
end

function var_0_1.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.shopData[arg_5_1])
end

function var_0_1.OnTop(arg_6_0)
	return
end

function var_0_1.UpdateView(arg_7_0)
	ActivityRecallData:UpdateShopData()

	arg_7_0.shopID = ActivityRecallData:GetDataByPara("shopID")
	arg_7_0.shopData = ActivityRecallData:GetDataByPara("shopData")

	arg_7_0.list_:StartScroll(#arg_7_0.shopData)

	arg_7_0.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("shopTime")
end

function var_0_1.OnEnter(arg_8_0)
	arg_8_0:UpdateView()
	arg_8_0:OnTop()
end

function var_0_1.OnExit(arg_9_0)
	return
end

function var_0_1.Hide(arg_10_0)
	var_0_1.super.Hide(arg_10_0)
end

function var_0_1.Dispose(arg_11_0)
	if arg_11_0.list_ then
		arg_11_0.list_:Dispose()

		arg_11_0.list_ = nil
	end

	var_0_1.super.Dispose(arg_11_0)
end

return var_0_1
