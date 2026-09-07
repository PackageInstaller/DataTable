local Dorm3dCameraAnim = class("Dorm3dCameraAnim", import("model.vo.BaseVO"))

function Dorm3dCameraAnim:bindConfigTable()
	return pg.dorm3d_camera_anim_template
end

function Dorm3dCameraAnim:GetName()
	return self:getConfig("desc")
end

function Dorm3dCameraAnim:GetStateName()
	return self:getConfig("state")
end

function Dorm3dCameraAnim:GetAnimTime()
	return self:getConfig("anim_time")
end

function Dorm3dCameraAnim:GetPreAnimID()
	return self:getConfig("pre_anim")
end

function Dorm3dCameraAnim:GetFinishAnimID()
	return self:getConfig("finish_anim")
end

function Dorm3dCameraAnim:GetUnlockRequirment()
	return self:getConfig("unlock")
end

function Dorm3dCameraAnim:GetFurnitureID()
	return self:getConfig("furniture_id")
end

function Dorm3dCameraAnim:GetZoneName()
	return pg.dorm3d_camera_zone_template[tonumber(self:getConfig("zone"))].name
end

function Dorm3dCameraAnim:GetZoneIcon()
	return self:getConfig("icon")
end

function Dorm3dCameraAnim:GetStartPoint()
	return self:getConfig("staypoint")
end

function Dorm3dCameraAnim:GetEnterSceneAnim()
	local var_12_0 = self:getConfig("enter_scene_anim")

	if var_12_0 and var_12_0 ~= "" and #var_12_0 > 0 then
		return var_12_0
	else
		return {}
	end

	return
end

function Dorm3dCameraAnim:GetEnterExtraItem()
	local var_13_0 = self:getConfig("enter_extra_item")

	if var_13_0 and var_13_0 ~= "" and #var_13_0 > 0 then
		return var_13_0
	else
		return {}
	end

	return
end

function Dorm3dCameraAnim:GetHideSceneItem()
	local var_14_0 = self:getConfig("hide_scene_item")

	if var_14_0 and var_14_0 ~= "" and #var_14_0 > 0 then
		return var_14_0
	else
		return {}
	end

	return
end

return Dorm3dCameraAnim
