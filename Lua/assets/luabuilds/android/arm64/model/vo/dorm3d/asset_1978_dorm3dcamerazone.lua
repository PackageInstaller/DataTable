local Dorm3dCameraZone = class("Dorm3dCameraZone", import("model.vo.BaseVO"))

function Dorm3dCameraZone:bindConfigTable()
	return pg.dorm3d_camera_zone_template
end

function Dorm3dCameraZone:Ctor(arg_2_1)
	Dorm3dCameraZone.super.Ctor(self, arg_2_1)

	self.regulaShipAnimsdDic = {}

	for iter_2_0, iter_2_1 in ipairs(self:GetRegularAnimIDList()) do
		self.regulaShipAnimsdDic[iter_2_1[1]] = _.map(iter_2_1[2], function(arg_3_0)
			return Dorm3dCameraAnim.New({
				configId = arg_3_0
			})
		end)
	end

	self.specialFurnitureDic = {}
	self.specialAnims = _.map(self:GetSpecialFurnitureIDList(), function(arg_4_0)
		self.specialFurnitureDic[arg_4_0[1]] = true

		return {
			furnitureId = arg_4_0[1],
			slotId = arg_4_0[2],
			anims = _.map(self:GetSpecialAnimIDListByFurnitureID(arg_4_0[1]), function(arg_5_0)
				return Dorm3dCameraAnim.New({
					configId = arg_5_0
				})
			end)
		}
	end)

	return
end

function Dorm3dCameraZone:GetName()
	return self:getConfig("name")
end

function Dorm3dCameraZone:GetWatchCameraName()
	return self:getConfig("watch_camera")
end

function Dorm3dCameraZone:GetRegularAnimIDList()
	return self:getConfig("regular_anim") or {}
end

function Dorm3dCameraZone:GetRegularAnimsByShipId(arg_9_1)
	return self.regulaShipAnimsdDic[arg_9_1] or {}
end

function Dorm3dCameraZone:GetSpecialFurnitureIDList()
	return self:getConfig("special_furniture") or {}
end

function Dorm3dCameraZone:GetAllSpecialList(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(pg.dorm3d_camera_anim_template.get_id_list_by_furniture_id) do
		if iter_11_0 ~= 0 and (function(arg_12_0)
			if pg.dorm3d_furniture_template[arg_12_0].room_id == arg_11_1 then
				return true
			end

			return false
		end)(iter_11_0) and not self.specialFurnitureDic[iter_11_0] then
			local var_11_1 = {}

			for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
				table.insert(var_11_1, Dorm3dCameraAnim.New({
					configId = iter_11_3
				}))
			end

			table.insert(var_11_0, {
				furnitureId = iter_11_0,
				anims = var_11_1
			})
		end
	end

	if self.specialAnims then
		for iter_11_4, iter_11_5 in ipairs(self.specialAnims) do
			table.insert(var_11_0, iter_11_4, iter_11_5)
		end
	end

	return var_11_0
end

function Dorm3dCameraZone:CheckFurnitureIdInZone(arg_13_1)
	return self.specialFurnitureDic[arg_13_1]
end

function Dorm3dCameraZone:GetSpecialAnimIDListByFurnitureID(arg_14_1)
	return pg.dorm3d_camera_anim_template.get_id_list_by_furniture_id[arg_14_1] or {}
end

function Dorm3dCameraZone:GetSpecialAnims()
	return self.specialAnims
end

function Dorm3dCameraZone:GetAnimSpeeds()
	return self:getConfig("anim_speeds")
end

function Dorm3dCameraZone:GetRecordTime()
	return self:getConfig("record_time")
end

function Dorm3dCameraZone:GetFocusDistanceRange()
	return self:getConfig("focus_distance")
end

function Dorm3dCameraZone:GetDepthOfFieldBlurRange()
	return self:getConfig("blur_strength")
end

function Dorm3dCameraZone:GetExposureRange()
	return self:getConfig("exposure")
end

function Dorm3dCameraZone:GetContrastRange()
	return self:getConfig("contrast")
end

function Dorm3dCameraZone:GetSaturationRange()
	return self:getConfig("saturation")
end

return Dorm3dCameraZone
