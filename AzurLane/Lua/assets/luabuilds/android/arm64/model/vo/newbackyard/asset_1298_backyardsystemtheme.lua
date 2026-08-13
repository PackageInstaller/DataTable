class = var_0_10000

local var_0_0 = "BackYardSystemTheme"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BackYardSelfThemeTemplate"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.level = 1
	arg_1_0.order = arg_1_0:getConfig("order")

	return
end

function var_0_1.GetRawPutList(arg_2_0)
	local var_2_0 = arg_2_0

	arg_2_0.CheckLevel(var_2_0)

	getProxy = var_1
	DormProxy = var_2_0

	local var_2_1 = var_1(var_2_0)
	local var_2_2 = var_1.getRawData(var_2_1).level

	if not arg_2_0.putInfo then
		local var_2_3

		pcall = var_2_1

		var_2_1(function()
			require = var_2_10000
			var_2_3 = var_2_10000("GameCfg.backyardTheme.theme_" .. arg_2_0.id)

			return
		end)

		if not var_2_3 then
			require = var_2_1
			var_2_3 = var_2_1("GameCfg.backyardTheme.theme_empty")
		end

		local var_2_4

		if not var_2_3["furnitures_" .. var_2_2] then
			var_2_4 = {}
		end

		_ = var_4
		arg_2_0.putInfo = var_4.select(var_2_4, function(arg_4_0)
			pg = var_2_10001

			return var_2_10001.furniture_data_template[arg_4_0.id]
		end)
	end

	return arg_2_0.putInfo
end

function var_0_1.CheckLevel(arg_5_0)
	getProxy = var_1_10001
	DormProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1 = var_1.getRawData(var_5_0).level

	if arg_5_0.level ~= var_5_1 then
		arg_5_0.furnitruesByIds = nil
		arg_5_0.putInfo = nil
		arg_5_0.level = var_5_1
	end

	return
end

function var_0_1.GetAllFurniture(arg_6_0)
	arg_6_0:CheckLevel()

	local var_6_0 = not arg_6_0.furnitruesByIds

	var_0_1.super.GetAllFurniture(arg_6_0)

	if var_6_0 then
		arg_6_0:CheckData()
	end

	return arg_6_0.furnitruesByIds
end

function var_0_1.GetWarpFurnitures(arg_7_0)
	arg_7_0:CheckLevel()

	return var_0_1.super.GetWarpFurnitures(arg_7_0)
end

function var_0_1.CheckData(arg_8_0)
	getProxy = var_1_10001
	DormProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1 = var_1.getRawData(var_8_0)
	local var_8_2 = {}
	local var_8_3 = {}

	pairs = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10004(arg_8_0.furnitruesByIds) do
		if not var_8_1:IsPurchasedFurniture(iter_8_1.configId) then
			if iter_8_1.parent ~= 0 then
				table = var_9

				var_9.insert(var_8_3, {
					pid = iter_8_1.parent,
					id = iter_8_0
				})
			else
				table = var_9

				if var_9.getCount(iter_8_1.child) > 0 then
					pairs = var_9

					for iter_8_2, iter_8_3 in var_9(iter_8_1.child) do
						table = var_1_10014

						var_1_10014.insert(var_8_2, iter_8_2)
					end
				end
			end

			table = var_9

			var_9.insert(var_8_2, iter_8_0)
		end
	end

	local var_8_4 = #var_8_2
	local var_8_6

	if not (0 < var_8_4) then
		local var_8_5 = #var_8_3

		if not (0 < var_8_5) then
			var_8_6 = false

			goto label_8_0
		end
	end

	var_8_6 = true

	::label_8_0::

	ipairs = var_5

	for iter_8_4, iter_8_5 in var_5(var_8_2) do
		arg_8_0.furnitruesByIds[iter_8_5] = nil
	end

	pairs = var_5

	for iter_8_6, iter_8_7 in var_5(var_8_3) do
		if arg_8_0.furnitruesByIds[iter_8_7.pid] then
			pairs = var_11

			for iter_8_8, iter_8_9 in var_11(var_10.child) do
				if iter_8_8 == iter_8_7.id then
					var_10.child[iter_8_7.id] = nil

					break
				end
			end
		end
	end

	return var_8_6
end

function var_0_1.bindConfigTable(arg_9_0)
	pg = var_1_10001

	return var_1_10001.backyard_theme_template
end

function var_0_1.IsOverTime(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.furniture_shop_template
	local var_10_1 = arg_10_0:getConfig("ids")

	_ = var_1_10003

	return var_1_10003.all(var_10_1, function(arg_11_0)
		local var_11_1

		if var_10_0[arg_11_0] then
			pg = var_1

			local var_11_0 = var_1.TimeMgr.GetInstance()

			var_11_1 = not var_1.inTime(var_11_0, var_10_0[arg_11_0].time)

			if false then
				var_11_1 = false
			end
		else
			var_11_1 = true
		end

		return var_11_1
	end)
end

function var_0_1.GetFurnitures(arg_12_0)
	return arg_12_0:getConfig("ids")
end

function var_0_1.HasDiscount(arg_13_0)
	local var_13_0 = arg_13_0:GetFurnitures()

	_ = var_1_10002

	return var_1_10002.any(var_13_0, function(arg_14_0)
		Furniture = var_2_10001

		local var_14_0 = var_2_10001.New({
			id = arg_14_0
		})
		local var_14_1 = var_1.getConfig(var_14_0, "dorm_icon_price")
		local var_14_2 = var_1
		local var_14_3 = var_1.getPrice

		PlayerConst = var_2_10006

		return var_14_1 > var_14_3(var_14_2, var_2_10006.ResDormMoney)
	end)
end

function var_0_1.GetDiscount(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetFurnitures(var_15_0)

	_ = var_1_10002

	local var_15_2 = var_1_10002.map(var_15_1, function(arg_16_0)
		Furniture = var_2_10001

		return var_2_10001.New({
			id = arg_16_0
		})
	end)

	_ = var_15_0

	local var_15_3 = var_15_0.reduce(var_15_2, 0, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_1
		local var_17_1 = arg_17_1.getPrice

		PlayerConst = var_2_10005

		return arg_17_0 + var_17_1(var_17_0, var_2_10005.ResDormMoney)
	end)

	_ = var_4

	return (var_4.reduce(var_15_2, 0, function(arg_18_0, arg_18_1)
		return arg_18_0 + arg_18_1:getConfig("dorm_icon_price")
	end) - var_15_3) / var_4 * 100
end

function var_0_1.IsPurchased(arg_19_0, arg_19_1)
	ipairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0:getConfig("ids")) do
		if not arg_19_1[iter_19_1] then
			return false
		end
	end

	return true
end

function var_0_1.GetName(arg_20_0)
	return arg_20_0:getConfig("name")
end

function var_0_1.GetDesc(arg_21_0)
	return arg_21_0:getConfig("desc")
end

function var_0_1.IsSystem(arg_22_0)
	return true
end

function var_0_1.getName(arg_23_0)
	return arg_23_0:GetName()
end

function var_0_1.getIcon(arg_24_0)
	return arg_24_0:getConfig("icon")
end

function var_0_1.isUnLock(arg_25_0, arg_25_1)
	return arg_25_0:getConfig("deblocking") <= arg_25_1.level
end

return var_0_1
