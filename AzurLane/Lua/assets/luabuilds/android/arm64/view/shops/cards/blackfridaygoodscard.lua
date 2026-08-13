class = var_0_10000

local var_0_0 = "BlackFridayGoodsCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewServerGoodsCard"))

function var_0_1.Flush(arg_1_0)
	local var_1_0 = arg_1_0.cntTxt
	local var_1_1 = arg_1_0.commodity
	local var_1_2 = var_2.GetCanPurchaseCnt(var_1_1)
	local var_1_3 = "/"
	local var_1_4 = arg_1_0.commodity

	var_1_0.text = var_1_2 .. var_1_3 .. var_4.GetCanPurchaseMaxCnt(var_1_4)
	setActive = var_1_0

	local var_1_5 = arg_1_0.sellOutMaskTF
	local var_1_6 = arg_1_0.commodity

	var_1_0(var_1_5, not var_4.CanPurchase(var_1_6))

	setActive = var_1_0

	local var_1_7 = arg_1_0.discountTF
	local var_1_8 = arg_1_0.commodity
	local var_1_10

	if var_4.GetDiscount(var_1_8) ~= 0 then
		local var_1_9 = arg_1_0.commodity

		var_1_10 = var_4.CanPurchase(var_1_9)
	else
		var_1_10 = false
	end

	if false then
		var_1_10 = true
	end

	var_1_0(var_1_7, var_1_10)

	return
end

function var_0_1.Init(arg_2_0)
	var_0_1.super.Init(arg_2_0)

	setActive = var_1

	var_1(arg_2_0.discountTF, false)

	local var_2_0 = arg_2_0.commodity

	if var_1.GetDiscount(var_2_0) ~= 0 then
		local var_2_1 = arg_2_0.commodity

		if var_1.CanPurchase(var_2_1) then
			setActive = var_1

			var_1(arg_2_0.discountTF, true)

			local var_2_2 = arg_2_0.consumeTxtTF
			local var_2_3 = arg_2_0.commodity

			var_2_2.text = var_2.GetSalesPrice(var_2_3)
			setText = var_2_2

			local var_2_4 = arg_2_0.discountTF
			local var_2_5 = var_3.Find(var_2_4, "Text")
			local var_2_6 = arg_2_0.commodity

			var_2_2(var_2_5, var_4.GetOffPercent(var_2_6) .. "%")
		end
	end

	return
end

return var_0_1
