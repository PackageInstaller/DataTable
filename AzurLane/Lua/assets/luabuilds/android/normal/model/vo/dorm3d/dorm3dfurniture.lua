class = var_0_10000

local var_0_0 = "Dorm3dFurniture"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.TYPE = {
	SPECIAL = 99,
	FLOOR = 2,
	DECORATION = 3,
	BED = 4,
	TABLE = 6,
	COUCH = 5,
	WALLPAPER = 1
}
var_0_1.TYPE2NAME = {
	[0] = "dorm3d_furnitrue_type_floor",
	"dorm3d_furnitrue_type_decoration",
	"dorm3d_furnitrue_type_bed",
	"dorm3d_furnitrue_type_couch",
	"dorm3d_furnitrue_type_table",
	99,
	"dorm3d_furnitrue_type_special",
	[nil] = "dorm3d_furnitrue_type_wallpaper"
}

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_furniture_template
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	var_0_1.super.Ctor(arg_2_0, arg_2_1)

	local var_2_0

	if not arg_2_0.slotId then
		var_2_0 = 0
	end

	arg_2_0.slotId = var_2_0

	return
end

function var_0_1.GetSlotID(arg_3_0)
	return arg_3_0.slotId
end

function var_0_1.SetSlotID(arg_4_0, arg_4_1)
	arg_4_0.slotId = arg_4_1

	return
end

function var_0_1.GetName(arg_5_0)
	return arg_5_0:getConfig("name")
end

function var_0_1.GetType(arg_6_0)
	return arg_6_0:getConfig("type")
end

function var_0_1.GetRarity(arg_7_0)
	return arg_7_0:getConfig("rarity")
end

function var_0_1.GetTargetSlots(arg_8_0)
	return arg_8_0:getConfig("target_slots")
end

function var_0_1.GetTargetSlotID(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.GetTargetSlots(var_9_0)[1]

	assert = var_9_0

	var_9_0(var_9_1, "Missing Target Slot Dorm3dFurniture ID: " .. arg_9_0:GetConfigID())

	return var_9_1
end

function var_0_1.GetIcon(arg_10_0)
	return arg_10_0:getConfig("icon")
end

function var_0_1.GetModel(arg_11_0)
	return arg_11_0:getConfig("model")
end

function var_0_1.GetAcesses(arg_12_0)
	if arg_12_0:getConfig("acesses") == nil or var_1 == "" then
		return {}
	end

	return var_1
end

function var_0_1.GetShopID(arg_13_0)
	local var_13_0

	if not arg_13_0:getConfig("shop_id")[1] then
		var_13_0 = 0
	end

	return var_13_0
end

function var_0_1.IsValuable(arg_14_0)
	return arg_14_0:getConfig("is_exclusive") == 1
end

function var_0_1.IsSpecial(arg_15_0)
	return arg_15_0:getConfig("is_special") == 1
end

function var_0_1.InShopTime(arg_16_0)
	local var_16_0 = arg_16_0

	if arg_16_0.GetShopID(var_16_0) == 0 then
		return true
	end

	pg = var_16_0

	local var_16_1 = var_16_0.shop_template[var_1]

	pg = var_1_10003

	local var_16_2 = var_1_10003.TimeMgr.GetInstance()

	return var_3.inTime(var_16_2, var_16_1.time)
end

function var_0_1.GetEndTime(arg_17_0)
	local var_17_0 = arg_17_0

	if arg_17_0.GetShopID(var_17_0) == 0 then
		return 0
	end

	pg = var_17_0

	local var_17_1 = var_17_0.shop_template[var_1]

	assert = var_1_10003

	var_1_10003(var_17_1, "Missing shopCfg " .. (var_1 or "NIL"))

	if var_17_1.time == "always" or var_3 == "stop" then
		return 0
	end

	pg = var_4

	local var_17_2 = var_4.TimeMgr.GetInstance()

	return (var_4.parseTimeFromConfig(var_17_2, var_3[2]))
end

function var_0_1.NeedViewTip(arg_18_0)
	if arg_18_0 then
		var_1_10001 = {}
		getProxy = var_1_10002
		ApartmentProxy = var_1_10003
		var_1_10003 = var_1_10002(var_1_10003)
		var_1_10001[1] = var_1_10002.getRoom(var_1_10003, arg_18_0)

		if not var_1_10001 then
			underscore = var_1_10001
			var_1_10001 = var_1_10001.values
			getProxy = var_1_10002
			ApartmentProxy = var_1_10003
			var_1_10001 = var_1_10001(var_1_10002(var_1_10003).roomData)
		end

		underscore = var_1_10002

		return var_1_10002.any(var_1_10001, function(arg_19_0)
			underscore = var_2_10001

			return var_2_10001.any(arg_19_0:GetFurnitures(), function(arg_20_0)
				Dorm3dFurniture = var_3_10001

				return var_3_10001.GetViewedFlag(arg_20_0:GetConfigID()) == 0
			end)
		end)
	end
end

function var_0_1.NeedViewTipByFurnitureId(arg_21_0)
	local function var_21_0(arg_22_0)
		pg = var_2_10001

		local var_22_0 = var_2_10001.dorm3d_furniture_template[arg_22_0].room_id

		getProxy = var_2_10002
		ApartmentProxy = var_2_10003

		local var_22_1 = var_2_10002(var_2_10003)
		local var_22_2

		var_22_2 = var_2.getRoom(var_22_1, var_22_0) and var_2:HasFurniture(arg_22_0)

		return var_22_2
	end

	Dorm3dFurniture = var_1_10002

	return var_1_10002.GetViewedFlag(arg_21_0) == 0 and not var_21_0(arg_21_0)
end

function var_0_1.GetViewedFlag(arg_23_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_23_0 = var_1_10001(var_1_10002)
	local var_23_1 = var_1.getRawData(var_23_0).id

	PlayerPrefs = var_23_0

	return var_23_0.GetInt(var_23_1 .. "_dorm3dFurnitureViewed_" .. arg_23_0, 0)
end

function var_0_1.SetViewedFlag(arg_24_0)
	local var_24_0 = var_0_1.GetViewedFlag(arg_24_0)

	if 0 < var_24_0 then
		return
	end

	getProxy = var_24_0
	PlayerProxy = var_2

	local var_24_1 = var_24_0(var_2)
	local var_24_2 = var_1.getRawData(var_24_1).id

	PlayerPrefs = var_24_1

	var_24_1.SetInt(var_24_2 .. "_dorm3dFurnitureViewed_" .. arg_24_0, 1)

	PlayerPrefs = var_2

	var_2.Save()

	return true
end

function var_0_1.IsTimelimitShopTip(arg_25_0)
	if arg_25_0 then
		var_1_10001 = {}
		getProxy = var_1_10002
		ApartmentProxy = var_1_10003
		var_1_10003 = var_1_10002(var_1_10003)
		var_1_10001[1] = var_1_10002.getRoom(var_1_10003, arg_25_0)

		if not var_1_10001 then
			underscore = var_1_10001
			var_1_10001 = var_1_10001.values
			getProxy = var_1_10002
			ApartmentProxy = var_1_10003
			var_1_10001 = var_1_10001(var_1_10002(var_1_10003).roomData)
		end

		underscore = var_1_10002

		return var_1_10002.any(var_1_10001, function(arg_26_0)
			pg = var_2_10001

			local var_26_0

			if not var_2_10001.dorm3d_furniture_template.get_id_list_by_room_id[arg_26_0:GetConfigID()] then
				var_26_0 = {}
			end

			_ = var_2

			return var_2.any(var_26_0, function(arg_27_0)
				Dorm3dFurniture = var_3_10001

				local var_27_0 = var_3_10001.New({
					configId = arg_27_0
				})

				if var_1.GetEndTime(var_27_0) > 0 then
					local var_27_1

					if var_1:InShopTime() then
						Dorm3dFurniture = var_27_1

						if var_27_1.GetViewedFlag(arg_27_0) ~= 0 then
							var_27_1 = false
						else
							var_27_1 = true
						end
					end

					return var_27_1
				end
			end)
		end)
	end
end

function var_0_1.RecordLastTimelimitShopFurniture()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_28_0 = var_1_10000(var_1_10001)
	local var_28_1 = var_0.getRawData(var_28_0).id

	PlayerPrefs = var_28_0

	local var_28_2 = var_28_0.GetInt(var_28_1 .. "_dorm3dTimelimitFurniture", 0)

	underscore = var_3

	local var_28_3 = var_3.values

	getProxy = var_1_10004
	ApartmentProxy = var_1_10005

	local var_28_4 = var_28_3(var_1_10004(var_1_10005).roomData)

	underscore = var_4

	var_4.each(var_28_4, function(arg_29_0)
		pg = var_2_10001

		local var_29_0

		if not var_2_10001.dorm3d_furniture_template.get_id_list_by_room_id[arg_29_0:GetConfigID()] then
			var_29_0 = {}
		end

		_ = var_2

		var_2.each(var_29_0, function(arg_30_0)
			Dorm3dFurniture = var_3_10001

			local var_30_0 = var_3_10001.New({
				configId = arg_30_0
			})

			if var_1.GetEndTime(var_30_0) > 0 and var_1:InShopTime() then
				math = var_2
				var_28_2 = var_2.max(var_28_2, arg_30_0)
			end

			return
		end)

		return
	end)

	if var_28_2 <= var_1 then
		return
	end

	PlayerPrefs = var_4

	var_4.SetInt(var_28_1 .. "_dorm3dTimelimitFurniture", var_28_2)

	PlayerPrefs = var_4

	var_4.Save()

	return
end

function var_0_1.IsOnceTimelimitShopTip()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_31_0 = var_1_10000(var_1_10001)
	local var_31_1 = var_0.getRawData(var_31_0).id

	PlayerPrefs = var_31_0

	local var_31_2 = var_31_0.GetInt(var_31_1 .. "_dorm3dTimelimitFurniture", 0)

	underscore = var_2

	local var_31_3 = var_2.values

	getProxy = var_3
	ApartmentProxy = var_1_10004

	local var_31_4 = var_31_3(var_3(var_1_10004).roomData)

	underscore = var_3

	return var_3.any(var_31_4, function(arg_32_0)
		local var_32_0 = arg_32_0
		local var_32_1 = arg_32_0.GetFurnitures(var_32_0)

		pg = var_32_0

		local var_32_2

		if not var_32_0.dorm3d_furniture_template.get_id_list_by_room_id[arg_32_0:GetConfigID()] then
			var_32_2 = {}
		end

		_ = var_3

		return var_3.any(var_32_2, function(arg_33_0)
			if arg_33_0 <= var_31_2 then
				return
			end

			Dorm3dFurniture = var_1

			local var_33_0 = var_1.New({
				configId = arg_33_0
			})
			local var_33_1

			if var_1.GetEndTime(var_33_0) > 0 then
				if var_1:InShopTime() then
					_ = var_33_1
					var_33_1 = not var_33_1.detect(var_32_1, function(arg_34_0)
						return arg_34_0:GetConfigID() == arg_33_0
					end)
				end
			else
				var_33_1 = false
			end

			if false then
				var_33_1 = true
			end

			return var_33_1
		end)
	end)
end

return var_0_1
