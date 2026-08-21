local var_0_0 = class("Dorm3dCameraZone", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.dorm3d_camera_zone_template
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	var_0_0.super.Ctor(arg_2_0, arg_2_1)

	arg_2_0.regulaShipAnimsdDic = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0:GetRegularAnimIDList()) do
		arg_2_0.regulaShipAnimsdDic[iter_2_1[1]] = _.map(iter_2_1[2], function(arg_3_0)
			return Dorm3dCameraAnim.New({
				configId = arg_3_0
			})
		end)
	end

	arg_2_0.specialFurnitureDic = {}
	arg_2_0.specialAnims = _.map(arg_2_0:GetSpecialFurnitureIDList(), function(arg_4_0)
		arg_2_0.specialFurnitureDic[arg_4_0[1]] = true

		return {
			furnitureId = arg_4_0[1],
			slotId = arg_4_0[2],
			anims = _.map(arg_2_0:GetSpecialAnimIDListByFurnitureID(arg_4_0[1]), function(arg_5_0)
				return Dorm3dCameraAnim.New({
					configId = arg_5_0
				})
			end)
		}
	end)

	return
end

function var_0_0.GetName(arg_6_0)
	return arg_6_0:getConfig("name")
end

function var_0_0.GetWatchCameraName(arg_7_0)
	return arg_7_0:getConfig("watch_camera")
end

function var_0_0.GetRegularAnimIDList(arg_8_0)
	return arg_8_0:getConfig("regular_anim") or {}
end

function var_0_0.GetRegularAnimsByShipId(arg_9_0, arg_9_1)
	return arg_9_0.regulaShipAnimsdDic[arg_9_1] or {}
end

function var_0_0.GetSpecialFurnitureIDList(arg_10_0)
	return arg_10_0:getConfig("special_furniture") or {}
end

function var_0_0.GetAllSpecialList(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(pg.dorm3d_camera_anim_template.get_id_list_by_furniture_id) do
		if iter_11_0 ~= 0 and (function(arg_12_0)
			if pg.dorm3d_furniture_template[arg_12_0].room_id == arg_11_1 then
				return true
			end

			return false
		end)(iter_11_0) and not arg_11_0.specialFurnitureDic[iter_11_0] then
			for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
				table.insert({}, Dorm3dCameraAnim.New({
					configId = iter_11_3
				}))
			end

			table.insert({}, {
				furnitureId = iter_11_0,
				anims = {}
			})
		end
	end

	if arg_11_0.specialAnims then
		for iter_11_4, iter_11_5 in ipairs(arg_11_0.specialAnims) do
			table.insert({}, iter_11_4, iter_11_5)
		end
	end

	return {}
end

function var_0_0.CheckFurnitureIdInZone(arg_13_0, arg_13_1)
	return arg_13_0.specialFurnitureDic[arg_13_1]
end

function var_0_0.GetSpecialAnimIDListByFurnitureID(arg_14_0, arg_14_1)
	return pg.dorm3d_camera_anim_template.get_id_list_by_furniture_id[arg_14_1] or {}
end

function var_0_0.GetSpecialAnims(arg_15_0)
	return arg_15_0.specialAnims
end

function var_0_0.GetAnimSpeeds(arg_16_0)
	return arg_16_0:getConfig("anim_speeds")
end

function var_0_0.GetRecordTime(arg_17_0)
	return arg_17_0:getConfig("record_time")
end

function var_0_0.GetFocusDistanceRange(arg_18_0)
	return arg_18_0:getConfig("focus_distance")
end

function var_0_0.GetDepthOfFieldBlurRange(arg_19_0)
	return arg_19_0:getConfig("blur_strength")
end

function var_0_0.GetExposureRange(arg_20_0)
	return arg_20_0:getConfig("exposure")
end

function var_0_0.GetContrastRange(arg_21_0)
	return arg_21_0:getConfig("contrast")
end

function var_0_0.GetSaturationRange(arg_22_0)
	return arg_22_0:getConfig("saturation")
end

return var_0_0
