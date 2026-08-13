class = var_0_10000

local var_0_0 = "Dorm3dCameraZone"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_camera_zone_template
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	var_0_1.super.Ctor(arg_2_0, arg_2_1)

	arg_2_0.regulaShipAnimsdDic = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_0:GetRegularAnimIDList()) do
		local var_2_0 = arg_2_0.regulaShipAnimsdDic
		local var_2_1 = iter_2_1[1]

		_ = var_1_10009
		var_2_0[var_2_1] = var_1_10009.map(iter_2_1[2], function(arg_3_0)
			Dorm3dCameraAnim = var_2_10001

			return var_2_10001.New({
				configId = arg_3_0
			})
		end)
	end

	arg_2_0.specialFurnitureDic = {}
	_ = var_2
	arg_2_0.specialAnims = var_2.map(arg_2_0:GetSpecialFurnitureIDList(), function(arg_4_0)
		local var_4_0 = arg_4_0[1]

		arg_2_0.specialFurnitureDic[var_4_0] = true

		local var_4_1 = {
			furnitureId = var_4_0,
			slotId = arg_4_0[2]
		}

		_ = var_3

		local var_4_2 = var_3.map
		local var_4_3 = arg_2_0

		var_4_1.anims = var_4_2(var_4.GetSpecialAnimIDListByFurnitureID(var_4_3, var_4_0), function(arg_5_0)
			Dorm3dCameraAnim = var_3_10001

			return var_3_10001.New({
				configId = arg_5_0
			})
		end)

		return var_4_1
	end)

	return
end

function var_0_1.GetName(arg_6_0)
	return arg_6_0:getConfig("name")
end

function var_0_1.GetWatchCameraName(arg_7_0)
	return arg_7_0:getConfig("watch_camera")
end

function var_0_1.GetRegularAnimIDList(arg_8_0)
	local var_8_0

	if not arg_8_0:getConfig("regular_anim") then
		var_8_0 = {}
	end

	return var_8_0
end

function var_0_1.GetRegularAnimsByShipId(arg_9_0, arg_9_1)
	local var_9_0

	if not arg_9_0.regulaShipAnimsdDic[arg_9_1] then
		var_9_0 = {}
	end

	return var_9_0
end

function var_0_1.GetSpecialFurnitureIDList(arg_10_0)
	local var_10_0

	if not arg_10_0:getConfig("special_furniture") then
		var_10_0 = {}
	end

	return var_10_0
end

function var_0_1.GetAllSpecialList(arg_11_0, arg_11_1)
	local var_11_0 = {}

	pairs = var_1_10003
	pg = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10003(var_1_10004.dorm3d_camera_anim_template.get_id_list_by_furniture_id) do
		function var_1_10008(arg_12_0)
			pg = var_2_10001

			if var_2_10001.dorm3d_furniture_template[arg_12_0].room_id == arg_11_1 then
				return true
			end

			return false
		end

		if iter_11_0 ~= 0 and var_1_10008(iter_11_0) and not arg_11_0.specialFurnitureDic[iter_11_0] then
			local var_11_1 = {}

			ipairs = var_10

			for iter_11_2, iter_11_3 in var_10(iter_11_1) do
				table = var_1_10015
				var_1_10015 = var_1_10015.insert

				local var_11_2 = var_11_1

				Dorm3dCameraAnim = var_1_10017

				var_1_10015(var_11_2, var_1_10017.New({
					configId = iter_11_3
				}))
			end

			table = var_10

			var_10.insert(var_11_0, {
				furnitureId = iter_11_0,
				anims = var_11_1
			})
		end
	end

	if arg_11_0.specialAnims then
		ipairs = var_3

		for iter_11_4, iter_11_5 in var_3(arg_11_0.specialAnims) do
			table = var_1_10008

			var_1_10008.insert(var_11_0, iter_11_4, iter_11_5)
		end
	end

	return var_11_0
end

function var_0_1.CheckFurnitureIdInZone(arg_13_0, arg_13_1)
	return arg_13_0.specialFurnitureDic[arg_13_1]
end

function var_0_1.GetSpecialAnimIDListByFurnitureID(arg_14_0, arg_14_1)
	pg = var_1_10002

	local var_14_0

	if not var_1_10002.dorm3d_camera_anim_template.get_id_list_by_furniture_id[arg_14_1] then
		var_14_0 = {}
	end

	return var_14_0
end

function var_0_1.GetSpecialAnims(arg_15_0)
	return arg_15_0.specialAnims
end

function var_0_1.GetAnimSpeeds(arg_16_0)
	return arg_16_0:getConfig("anim_speeds")
end

function var_0_1.GetRecordTime(arg_17_0)
	return arg_17_0:getConfig("record_time")
end

function var_0_1.GetFocusDistanceRange(arg_18_0)
	return arg_18_0:getConfig("focus_distance")
end

function var_0_1.GetDepthOfFieldBlurRange(arg_19_0)
	return arg_19_0:getConfig("blur_strength")
end

function var_0_1.GetExposureRange(arg_20_0)
	return arg_20_0:getConfig("exposure")
end

function var_0_1.GetContrastRange(arg_21_0)
	return arg_21_0:getConfig("contrast")
end

function var_0_1.GetSaturationRange(arg_22_0)
	return arg_22_0:getConfig("saturation")
end

return var_0_1
