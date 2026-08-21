local var_0_0 = class("Dorm3dFurniture", import("model.vo.BaseVO"))

var_0_0.TYPE = {
	SPECIAL = 99,
	FLOOR = 2,
	DECORATION = 3,
	BED = 4,
	TABLE = 6,
	COUCH = 5,
	WALLPAPER = 1
}
var_0_0.TYPE2NAME = {
	[0] = "dorm3d_furnitrue_type_floor",
	"dorm3d_furnitrue_type_decoration",
	"dorm3d_furnitrue_type_bed",
	"dorm3d_furnitrue_type_couch",
	"dorm3d_furnitrue_type_table",
	99,
	"dorm3d_furnitrue_type_special",
	[nil] = "dorm3d_furnitrue_type_wallpaper"
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.dorm3d_furniture_template
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	var_0_0.super.Ctor(arg_2_0, arg_2_1)

	arg_2_0.slotId = arg_2_0.slotId or 0

	return
end

function var_0_0.GetSlotID(arg_3_0)
	return arg_3_0.slotId
end

function var_0_0.SetSlotID(arg_4_0, arg_4_1)
	arg_4_0.slotId = arg_4_1

	return
end

function var_0_0.GetName(arg_5_0)
	return arg_5_0:getConfig("name")
end

function var_0_0.GetType(arg_6_0)
	return arg_6_0:getConfig("type")
end

function var_0_0.GetRarity(arg_7_0)
	return arg_7_0:getConfig("rarity")
end

function var_0_0.GetTargetSlots(arg_8_0)
	return arg_8_0:getConfig("target_slots")
end

function var_0_0.GetTargetSlotID(arg_9_0)
	local var_9_0 = arg_9_0:GetTargetSlots()[1]

	assert(var_9_0, "Missing Target Slot Dorm3dFurniture ID: " .. arg_9_0:GetConfigID())

	return var_9_0
end

function var_0_0.GetIcon(arg_10_0)
	return arg_10_0:getConfig("icon")
end

function var_0_0.GetModel(arg_11_0)
	return arg_11_0:getConfig("model")
end

function var_0_0.GetAcesses(arg_12_0)
	local var_12_0 = arg_12_0:getConfig("acesses")

	if var_12_0 == nil or var_12_0 == "" then
		return {}
	end

	return var_12_0
end

function var_0_0.GetShopID(arg_13_0)
	return arg_13_0:getConfig("shop_id")[1] or 0
end

function var_0_0.IsValuable(arg_14_0)
	return arg_14_0:getConfig("is_exclusive") == 1
end

function var_0_0.IsSpecial(arg_15_0)
	return arg_15_0:getConfig("is_special") == 1
end

function var_0_0.InShopTime(arg_16_0)
	local var_16_0 = arg_16_0:GetShopID()

	if var_16_0 == 0 then
		return true
	end

	return pg.TimeMgr.GetInstance():inTime(pg.shop_template[var_16_0].time)
end

function var_0_0.GetEndTime(arg_17_0)
	local var_17_0 = arg_17_0:GetShopID()

	if var_17_0 == 0 then
		return 0
	end

	local var_17_1 = pg.shop_template[var_17_0]

	assert(pg.shop_template[var_17_0], "Missing shopCfg " .. (var_17_0 or "NIL"))

	if var_17_1.time == "always" or var_17_1.time == "stop" then
		return 0
	end

	local var_17_2 = pg.TimeMgr.GetInstance()

	return (var_17_2:parseTimeFromConfig(var_17_1.time[2]))
end

function var_0_0.NeedViewTip(arg_18_0)
	if arg_18_0 then
		local var_18_0 = {}

		var_18_0[1] = getProxy(ApartmentProxy):getRoom(arg_18_0)
		var_18_0 = var_18_0 or underscore.values(getProxy(ApartmentProxy).roomData)

		return underscore.any(var_18_0, function(arg_19_0)
			return underscore.any(arg_19_0:GetFurnitures(), function(arg_20_0)
				return Dorm3dFurniture.GetViewedFlag(arg_20_0:GetConfigID()) == 0
			end)
		end)
	end
end

function var_0_0.NeedViewTipByFurnitureId(arg_21_0)
	return Dorm3dFurniture.GetViewedFlag(arg_21_0) == 0 and not (function(arg_22_0)
		local var_22_0 = getProxy(ApartmentProxy):getRoom(pg.dorm3d_furniture_template[arg_22_0].room_id)

		return var_22_0 and var_22_0:HasFurniture(arg_22_0)
	end)(arg_21_0)
end

function var_0_0.GetViewedFlag(arg_23_0)
	return PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dFurnitureViewed_" .. arg_23_0, 0)
end

function var_0_0.SetViewedFlag(arg_24_0)
	if var_0_0.GetViewedFlag(arg_24_0) > 0 then
		return
	end

	local var_24_0 = getProxy(PlayerProxy)

	PlayerPrefs.SetInt(var_24_0:getRawData().id .. "_dorm3dFurnitureViewed_" .. arg_24_0, 1)
	PlayerPrefs.Save()

	return true
end

function var_0_0.IsTimelimitShopTip(arg_25_0)
	if arg_25_0 then
		local var_25_0 = {}

		var_25_0[1] = getProxy(ApartmentProxy):getRoom(arg_25_0)
		var_25_0 = var_25_0 or underscore.values(getProxy(ApartmentProxy).roomData)

		return underscore.any(var_25_0, function(arg_26_0)
			local var_26_0 = pg.dorm3d_furniture_template.get_id_list_by_room_id[arg_26_0:GetConfigID()] or {}

			return _.any(var_26_0, function(arg_27_0)
				local var_27_0 = Dorm3dFurniture.New({
					configId = arg_27_0
				})

				return var_27_0:GetEndTime() > 0 and var_27_0:InShopTime() and Dorm3dFurniture.GetViewedFlag(arg_27_0) == 0
			end)
		end)
	end
end

function var_0_0.RecordLastTimelimitShopFurniture()
	local var_28_0 = getProxy(PlayerProxy):getRawData().id
	local var_28_1 = PlayerPrefs.GetInt(var_28_0 .. "_dorm3dTimelimitFurniture", 0)
	local var_28_2 = var_28_1

	underscore.each(underscore.values(getProxy(ApartmentProxy).roomData), function(arg_29_0)
		local var_29_0 = pg.dorm3d_furniture_template.get_id_list_by_room_id[arg_29_0:GetConfigID()] or {}

		_.each(var_29_0, function(arg_30_0)
			local var_30_0 = Dorm3dFurniture.New({
				configId = arg_30_0
			})

			if var_30_0:GetEndTime() > 0 and var_30_0:InShopTime() then
				var_28_2 = math.max(var_28_2, arg_30_0)
			end

			return
		end)

		return
	end)

	if var_28_1 <= var_28_1 then
		return
	end

	PlayerPrefs.SetInt(var_28_0 .. "_dorm3dTimelimitFurniture", var_28_1)
	PlayerPrefs.Save()

	return
end

function var_0_0.IsOnceTimelimitShopTip()
	local var_31_0 = PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dTimelimitFurniture", 0)

	return underscore.any(underscore.values(getProxy(ApartmentProxy).roomData), function(arg_32_0)
		local var_32_0 = arg_32_0:GetFurnitures()
		local var_32_1 = pg.dorm3d_furniture_template.get_id_list_by_room_id[arg_32_0:GetConfigID()] or {}

		return _.any(var_32_1, function(arg_33_0)
			if arg_33_0 <= var_31_0 then
				return
			end

			local var_33_0 = Dorm3dFurniture.New({
				configId = arg_33_0
			})

			return var_33_0:GetEndTime() > 0 and var_33_0:InShopTime() and not _.detect(var_32_0, function(arg_34_0)
				return arg_34_0:GetConfigID() == arg_33_0
			end)
		end)
	end)
end

return var_0_0
