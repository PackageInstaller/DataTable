local var_0_0 = class("BlackFridayGoodsCard", import(".NewServerGoodsCard"))

function var_0_0.Flush(arg_1_0)
	arg_1_0.cntTxt.text = arg_1_0.commodity:GetCanPurchaseCnt() .. "/" .. arg_1_0.commodity:GetCanPurchaseMaxCnt()

	setActive(arg_1_0.sellOutMaskTF, not arg_1_0.commodity:CanPurchase())
	setActive(arg_1_0.discountTF, arg_1_0.commodity:GetDiscount() ~= 0 and arg_1_0.commodity:CanPurchase())

	return
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)
	setActive(arg_2_0.discountTF, false)

	if arg_2_0.commodity:GetDiscount() ~= 0 and arg_2_0.commodity:CanPurchase() then
		setActive(arg_2_0.discountTF, true)

		arg_2_0.consumeTxtTF.text = arg_2_0.commodity:GetSalesPrice()

		setText(arg_2_0.discountTF:Find("Text"), arg_2_0.commodity:GetOffPercent() .. "%")
	end

	return
end

return var_0_0
