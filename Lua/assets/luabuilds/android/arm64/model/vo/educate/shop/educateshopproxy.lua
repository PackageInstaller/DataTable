local var_0_0 = class("EducateShopProxy")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.binder = arg_1_1
	arg_1_0.data = {}

	return
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.shops or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		({})[iter_2_1.shop_id] = iter_2_1.goods
	end

	arg_2_0.data = {}

	for iter_2_2, iter_2_3 in ipairs(pg.child_shop.all) do
		local var_2_2 = ({})[iter_2_3]

		if not ({})[iter_2_3] then
			var_2_2 = {}
		end

		arg_2_0.data[iter_2_3] = EducateShop.New(iter_2_3, var_2_2)
	end

	arg_2_0.discountData = {}

	local var_2_3 = arg_2_1.discountEventIds or {}

	for iter_2_4, iter_2_5 in ipairs(var_2_3) do
		arg_2_0:AddDiscountEventById(iter_2_5)
	end

	return
end

function var_0_0.GetShopWithId(arg_3_0, arg_3_1)
	return arg_3_0.data[arg_3_1]
end

function var_0_0.UpdateShop(arg_4_0, arg_4_1)
	arg_4_0.data[arg_4_1.id] = arg_4_1

	return
end

function var_0_0.GetDiscountData(arg_5_0)
	return arg_5_0.discountData
end

function var_0_0.IsDiscountById(arg_6_0, arg_6_1)
	return arg_6_0.discountData[arg_6_1]
end

function var_0_0.GetDiscountById(arg_7_0, arg_7_1)
	return arg_7_0.discountData[arg_7_1] and arg_7_0.discountData[arg_7_1]:GetDiscountRatio() or 0
end

function var_0_0.AddDiscountEventById(arg_8_0, arg_8_1)
	local var_8_0 = EducateSpecialEvent.New(arg_8_1)

	arg_8_0.discountData[var_8_0:GetDiscountShopId()] = var_8_0

	return
end

function var_0_0.OnNewWeek(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.data) do
		if iter_9_1:IsRefreshShop(arg_9_1) then
			table.insert({}, function(arg_10_0)
				arg_9_0.binder:sendNotification(GAME.EDUCATE_REQUEST_SHOP_DATA, {
					shopId = iter_9_1.id,
					callback = arg_10_0
				})

				return
			end)
		end
	end

	seriesAsync({}, function()
		return
	end)

	for iter_9_2, iter_9_3 in pairs(arg_9_0.discountData) do
		if not iter_9_3:InDiscountTime(arg_9_1) then
			arg_9_0.discountData[iter_9_2] = nil
		end
	end

	return
end

return var_0_0
