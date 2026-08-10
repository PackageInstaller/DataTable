local var_0_0 = class("PolyhedronShopItem", PolyhedronRewardItem)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)
	arg_1_0.shopControlle:SetSelectedIndex(1)
end

function var_0_0.AddUIListener(arg_2_0)
	var_0_0.super.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_shopBtn, nil, function()
		if arg_2_0.polyhedronInfo:GetCoinCount() < arg_2_0.priceNum then
			ShowTips("LACK_CURRENCY")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_SHOP_BUY_CONFIRM"),
			OkCallback = function()
				PolyhedronAction.QueryBuyShopItem(arg_2_0.shop_index)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	var_0_0.super.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)

	arg_6_0.shop_index = arg_6_2.shop_index
	arg_6_0.polyhedronInfo = arg_6_1
	arg_6_0.priceNum = arg_6_2.price

	local var_6_0 = arg_6_1:GetShopOriginalPrice(arg_6_2.class)

	arg_6_0.m_shopCost.text = arg_6_2.price

	if var_6_0 ~= arg_6_2.price then
		arg_6_0.m_discountLab.text = var_6_0

		arg_6_0.shopDiscountControlle:SetSelectedIndex(1)
	else
		arg_6_0.shopDiscountControlle:SetSelectedIndex(0)
	end

	arg_6_0.coinId = arg_6_1:GetPolyhedronCoinId()
	arg_6_0.m_shopIcon.sprite = ItemTools.getItemLittleSprite(arg_6_0.coinId)
end

return var_0_0
