local var_0_0 = class("IslandTradeProductListPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandTradeProductListUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.uiitemList = UIItemList.New(arg_2_0._tf:Find("shopView/Viewport/Content"), arg_2_0._tf:Find("shopView/Viewport/Content/tpl"))

	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	var_0_0.super.Show(arg_3_0)

	arg_3_0.island = arg_3_1

	arg_3_0:UpdateProductList()

	return
end

function var_0_0.GetDisplays(arg_4_0)
	return {
		IslandItem.New({
			num = 1,
			id = IslandItem.PEARL_ID
		})
	}
end

function var_0_0.UpdateProductList(arg_5_0)
	local var_5_0 = arg_5_0:GetDisplays()

	arg_5_0.uiitemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			arg_5_0:UpdateItem(arg_6_2, var_5_0[arg_6_1 + 1])
		end

		return
	end)
	arg_5_0.uiitemList:align(#arg_5_0:GetDisplays())

	return
end

function var_0_0.GetPrice(arg_7_0)
	return (arg_7_0.island:GetTradeAgency():GetTodayPrice())
end

function var_0_0.UpdateItem(arg_8_0, arg_8_1, arg_8_2)
	setText(arg_8_1:Find("name"), arg_8_2:getConfig("name"))
	updateCustomDrop(arg_8_1:Find("item"), Drop.New({
		count = 0,
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_8_2.id
	}))
	setText(arg_8_1:Find("name"), arg_8_2:getConfig("name"))
	setText(arg_8_1:Find("cost/num"), arg_8_0:GetPrice())
	onButton(arg_8_0, arg_8_1, function()
		arg_8_0:OnClick()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnClick(arg_10_0)
	arg_10_0:emit(IslandTradePage.OPEN_CONFIRM_PAGE, IslandConst.TRADE_PURCHASE)

	return
end

return var_0_0
