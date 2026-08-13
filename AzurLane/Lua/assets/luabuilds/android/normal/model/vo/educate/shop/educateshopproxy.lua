class = var_0_10000

local var_0_0 = var_0_10000("EducateShopProxy")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.binder = arg_1_1
	arg_1_0.data = {}

	return
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	local var_2_0 = {}

	ipairs = var_1_10003

	local var_2_1

	if not arg_2_1.shops then
		var_2_1 = {}
	end

	for iter_2_0, iter_2_1 in var_1_10003(var_2_1) do
		var_2_0[iter_2_1.shop_id] = iter_2_1.goods
	end

	arg_2_0.data = {}
	ipairs = var_3
	pg = var_4

	for iter_2_2, iter_2_3 in var_3(var_4.child_shop.all) do
		local var_2_2 = arg_2_0.data

		EducateShop = var_1_10009
		var_1_10009 = var_1_10009.New

		local var_2_3 = iter_2_3
		local var_2_4

		if not var_2_0[iter_2_3] then
			var_2_4 = {}
		end

		var_2_2[iter_2_3] = var_1_10009(var_2_3, var_2_4)
	end

	arg_2_0.discountData = {}
	ipairs = var_3

	local var_2_5

	if not arg_2_1.discountEventIds then
		var_2_5 = {}
	end

	for iter_2_4, iter_2_5 in var_3(var_2_5) do
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
	local var_7_0

	if not arg_7_0.discountData[arg_7_1] or not var_2:GetDiscountRatio() then
		var_7_0 = 0
	end

	return var_7_0
end

function var_0_0.AddDiscountEventById(arg_8_0, arg_8_1)
	EducateSpecialEvent = var_1_10002

	local var_8_0 = var_1_10002.New(arg_8_1)

	arg_8_0.discountData[var_8_0:GetDiscountShopId()] = var_8_0

	return
end

function var_0_0.OnNewWeek(arg_9_0, arg_9_1)
	local var_9_0 = {}

	pairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(arg_9_0.data) do
		if iter_9_1:IsRefreshShop(arg_9_1) then
			table = var_8

			var_8.insert(var_9_0, function(arg_10_0)
				local var_10_0 = arg_9_0.binder
				local var_10_1 = var_1.sendNotification

				GAME = var_2_10003

				var_10_1(var_10_0, var_2_10003.EDUCATE_REQUEST_SHOP_DATA, {
					shopId = iter_9_1.id,
					callback = arg_10_0
				})

				return
			end)
		end
	end

	seriesAsync = var_3

	var_3(var_9_0, function()
		return
	end)

	pairs = var_3

	for iter_9_2, iter_9_3 in var_3(arg_9_0.discountData) do
		if not iter_9_3:InDiscountTime(arg_9_1) then
			arg_9_0.discountData[iter_9_2] = nil
		end
	end

	return
end

return var_0_0
