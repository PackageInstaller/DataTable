class = var_0_10000

local var_0_0 = "Furniture"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

var_0_1.TYPE_WALLPAPER = 1
var_0_1.TYPE_FURNITURE = 2
var_0_1.TYPE_DECORATE = 3
var_0_1.TYPE_FLOORPAPER = 4
var_0_1.TYPE_MAT = 5
var_0_1.TYPE_WALL = 6
var_0_1.TYPE_COLLECTION = 7
var_0_1.TYPE_STAGE = 8
var_0_1.TYPE_ARCH = 9
var_0_1.TYPE_WALL_MAT = 10
var_0_1.TYPE_MOVEABLE = 11
var_0_1.TYPE_TRANSPORT = 12
var_0_1.TYPE_RANDOM_CONTROLLER = 13
var_0_1.TYPE_FOLLOWER = 14
var_0_1.TYPE_LUTE = 15
var_0_1.TYPE_RANDOM_SLOT = 16
var_0_1.INDEX_TO_COMFORTABLE_TYPE = {
	var_0_1.TYPE_WALLPAPER,
	var_0_1.TYPE_FURNITURE,
	var_0_1.TYPE_DECORATE,
	var_0_1.TYPE_FLOORPAPER,
	var_0_1.TYPE_MAT,
	var_0_1.TYPE_WALL,
	var_0_1.TYPE_COLLECTION,
	var_0_1.TYPE_FURNITURE,
	var_0_1.TYPE_FURNITURE,
	var_0_1.TYPE_WALL,
	var_0_1.TYPE_FURNITURE,
	var_0_1.TYPE_FURNITURE,
	var_0_1.TYPE_FURNITURE,
	var_0_1.TYPE_FURNITURE,
	var_0_1.TYPE_FURNITURE,
	var_0_1.TYPE_FURNITURE
}
var_0_1.INDEX_TO_SHOP_TYPE = {
	{
		var_0_1.TYPE_WALLPAPER
	},
	{
		var_0_1.TYPE_FLOORPAPER
	},
	{
		var_0_1.TYPE_FURNITURE,
		var_0_1.TYPE_MAT,
		var_0_1.TYPE_COLLECTION,
		var_0_1.TYPE_STAGE,
		var_0_1.TYPE_ARCH,
		var_0_1.TYPE_MOVEABLE,
		var_0_1.TYPE_TRANSPORT,
		var_0_1.TYPE_RANDOM_CONTROLLER,
		var_0_1.TYPE_FOLLOWER,
		var_0_1.TYPE_LUTE,
		var_0_1.TYPE_RANDOM_SLOT
	},
	{},
	{
		var_0_1.TYPE_DECORATE
	},
	{
		var_0_1.TYPE_WALL,
		var_0_1.TYPE_WALL_MAT
	}
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	tonumber = var_1_10002
	arg_1_0.id = var_1_10002(arg_1_1.id)

	local var_1_0

	if not arg_1_1.configId then
		tonumber = var_1_0
		var_1_0 = var_1_0(arg_1_1.id)
	end

	arg_1_0.configId = var_1_0

	local var_1_1

	if not arg_1_1.count then
		var_1_1 = 0
	end

	arg_1_0.count = var_1_1

	local var_1_2

	if not arg_1_1.get_time and not arg_1_1.date then
		var_1_2 = 0
	end

	arg_1_0.date = var_1_2
	arg_1_0.newFlag = false

	return
end

function var_0_1.MarkNew(arg_2_0)
	arg_2_0.newFlag = true

	return
end

function var_0_1.ClearNewFlag(arg_3_0)
	arg_3_0.newFlag = false

	return
end

function var_0_1.getDate(arg_4_0)
	if arg_4_0.date > 0 then
		pg = var_1

		local var_4_0 = var_1.TimeMgr.GetInstance()

		return var_1.STimeDescS(var_4_0, arg_4_0.date, "%Y/%m/%d")
	end

	return
end

function var_0_1.GetOwnCnt(arg_5_0)
	return arg_5_0.count
end

function var_0_1.setCount(arg_6_0, arg_6_1)
	arg_6_0.count = arg_6_1

	return
end

function var_0_1.isNotForSale(arg_7_0)
	return arg_7_0:getConfig("not_for_sale") == 1
end

function var_0_1.isForActivity(arg_8_0)
	return arg_8_0:getConfig("not_for_sale") == 2
end

function var_0_1.addFurnitrueCount(arg_9_0, arg_9_1)
	arg_9_0.count = arg_9_0.count + arg_9_1

	return
end

function var_0_1.canPurchase(arg_10_0)
	return arg_10_0.count < arg_10_0:getConfig("count")
end

function var_0_1.bindConfigTable(arg_11_0)
	pg = var_1_10001

	return var_1_10001.furniture_data_template
end

function var_0_1.bindShopConfigTable(arg_12_0)
	pg = var_1_10001

	return var_1_10001.furniture_shop_template
end

function var_0_1.isFurniture(arg_13_0)
	return arg_13_0:getConfig("type") ~= 0
end

function var_0_1.IsNew(arg_14_0)
	return arg_14_0:getConfig("new") ~= 0
end

function var_0_1.getConfig(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:bindConfigTable()[arg_15_0.configId]

	assert = var_1_10004

	var_1_10004(var_15_0, arg_15_0.configId)

	if var_15_0[arg_15_1] then
		return var_15_0[arg_15_1]
	elseif arg_15_0:bindShopConfigTable()[arg_15_0.configId] then
		return var_5[arg_15_1]
	end

	return
end

function var_0_1.getTypeForComfortable(arg_16_0)
	local var_16_0 = arg_16_0:getConfig("type")

	return var_0_1.INDEX_TO_COMFORTABLE_TYPE[var_16_0] and var_2 or var_0_1.TYPE_FURNITURE
end

function var_0_1.getDeblocking(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.getConfig(var_17_0, "themeId")

	pg = var_17_0

	local var_17_2 = var_17_0.backyard_theme_template[var_17_1]

	assert = var_3

	var_3(var_17_2, "pg.backyard_theme_template>>> id" .. var_17_1)

	return var_17_2.deblocking
end

function var_0_1.inTheme(arg_18_0)
	local var_18_0 = arg_18_0

	if arg_18_0.getConfig(var_18_0, "themeId") == 0 then
		return false
	end

	pg = var_18_0

	local var_18_1 = var_18_0.backyard_theme_template[var_1]

	assert = var_3

	var_3(var_18_1, "pg.backyard_theme_template>>id" .. var_1)

	table = var_3

	return var_3.contains(var_18_1.ids, arg_18_0.id)
end

function var_0_1.isLock(arg_19_0, arg_19_1)
	local var_19_0

	if arg_19_0:inTheme() then
		var_19_0 = arg_19_1 < arg_19_0:getDeblocking()
	end

	return var_19_0
end

function var_0_1.isPaper(arg_20_0)
	return arg_20_0:getConfig("type") == 4 or var_1 == 1
end

function var_0_1.GetThemeName(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.getConfig(var_21_0, "themeId")

	pg = var_21_0

	if var_21_0.backyard_theme_template[var_21_1] then
		return var_2.name
	end

	return ""
end

function var_0_1.inTime(arg_22_0)
	local var_22_0 = arg_22_0:getConfig("time")
	local var_22_1 = arg_22_0

	if arg_22_0.getConfig(var_22_1, "collaboration_furniture_time") ~= "" and var_2 ~= var_22_0 then
		return false
	end

	pg = var_22_1

	local var_22_2 = var_22_1.TimeMgr.GetInstance()

	return var_3.inTime(var_22_2, var_22_0)
end

function var_0_1.isTimeLimit(arg_23_0)
	local var_23_0 = arg_23_0

	if arg_23_0.getConfig(var_23_0, "time") then
		::label_23_0::

		type = var_23_0
		var_23_0 = var_23_0(var_1) == "table"
	end

	return var_23_0
end

function var_0_1.isRecordTime(arg_24_0)
	return arg_24_0:getConfig("is_get_time_note") == 1
end

function var_0_1.isDisCount(arg_25_0)
	local var_25_0

	if not arg_25_0:getConfig("discount") then
		var_25_0 = 0
	end

	local var_25_2

	if 0 < var_25_0 then
		pg = var_2

		local var_25_1 = var_2.TimeMgr.GetInstance()

		var_25_2 = var_2.inTime(var_25_1, arg_25_0:getConfig("discount_time"))
	else
		var_25_2 = false
	end

	if false then
		var_25_2 = true
	end

	return var_25_2
end

function var_0_1.sortSizeFunc(arg_26_0)
	local var_26_0

	if not arg_26_0:getConfig("size")[1] then
		var_26_0 = 0
	end

	local var_26_1

	if not var_1[2] then
		var_26_1 = 0
	end

	return var_26_0 * var_26_1
end

function var_0_1.getPrice(arg_27_0, arg_27_1)
	local var_27_0

	if not arg_27_0:isDisCount() or not arg_27_0:getConfig("discount") then
		var_27_0 = 0
	end

	local var_27_1 = (100 - var_27_0) / 100

	if arg_27_1 == 4 then
		var_1_10005 = arg_27_0

		local var_27_2

		if not arg_27_0.getConfig(var_1_10005, "gem_price") then
			if arg_27_1 == 6 then
				var_1_10005 = arg_27_0
				var_27_2 = arg_27_0.getConfig(var_1_10005, "dorm_icon_price")
			else
				var_27_2 = false
			end

			if false then
				var_27_2 = true
			end
		end

		if var_27_2 then
			math = var_1_10005

			local var_27_3 = var_1_10005.floor(var_27_2 * var_27_1)

			return var_27_2 > 0 and var_27_3 == 0 and 1 or var_27_3
		end

		return
	end
end

function var_0_1.canPurchaseByGem(arg_28_0)
	return arg_28_0:getPrice(4) and var_1 ~= 0
end

function var_0_1.canPurchaseByDormMoeny(arg_29_0)
	return arg_29_0:getPrice(6) and var_1 ~= 0
end

function var_0_1.getSortCurrency(arg_30_0)
	local var_30_0 = 0

	if arg_30_0:canPurchaseByGem() then
		var_30_0 = var_30_0 + 2
	elseif arg_30_0:canPurchaseByDormMoeny() then
		var_30_0 = var_30_0 + 1
	end

	return var_30_0
end

function var_0_1.sortPriceFunc(arg_31_0)
	local var_31_0

	if not arg_31_0:getConfig("gem_price") then
		var_31_0 = 0
	end

	local var_31_1

	if not arg_31_0:getConfig("dorm_icon_price") then
		var_31_1 = 0
	end

	if var_31_0 > 0 then
		return var_31_0 + 1000000
	else
		return var_31_1
	end

	return
end

function var_0_1.isMatchSearchKey(arg_32_0, arg_32_1)
	if arg_32_1 == "" or not arg_32_1 then
		return true
	end

	local var_32_0 = arg_32_0:getConfig("name")
	local var_32_1 = arg_32_0
	local var_32_2 = arg_32_0.getConfig(var_32_1, "describe")

	string = var_32_1
	arg_32_1 = var_32_1.lower(arg_32_1)
	string = var_4

	local var_32_3 = var_4.lower(var_32_0)

	string = var_4

	local var_32_4 = var_4.lower(var_32_2)

	string = var_4

	if not var_4.find(var_32_3, arg_32_1) then
		string = var_4

		if var_4.find(var_32_3, arg_32_1) then
			return true
		end

		return false
	end
end

function var_0_1.IsShopType(arg_33_0)
	return arg_33_0:bindShopConfigTable()[arg_33_0.configId] ~= nil
end

return var_0_1
