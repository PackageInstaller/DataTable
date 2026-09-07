local Dorm3dZone = class("Dorm3dZone", import("model.vo.BaseVO"))

function Dorm3dZone:bindConfigTable()
	return pg.dorm3d_zone_template
end

function Dorm3dZone:GetName()
	return self:getConfig("name")
end

function Dorm3dZone:IsGlobal()
	return self:getConfig("is_global") == 1
end

function Dorm3dZone:GetWatchCameraName()
	return self:getConfig("watch_camera")
end

function Dorm3dZone:GetSlotIDList()
	return pg.dorm3d_furniture_slot_template.get_id_list_by_zone_id[self.configId] or {}
end

function Dorm3dZone:SetSlots(arg_6_1)
	self.slots = arg_6_1

	return
end

function Dorm3dZone:GetSlots()
	return self.slots or {}
end

function Dorm3dZone:GetTypePriorities()
	local var_8_0 = self:getConfig("type_prioritys")

	if var_8_0 == nil or var_8_0 == "" then
		return {}
	end

	return var_8_0
end

function Dorm3dZone:SortTypes(arg_9_1)
	local var_9_0 = self:GetTypePriorities()

	table.sort(arg_9_1, CompareFuncs({
		function(arg_10_0)
			return table.indexof(var_9_0, arg_10_0) or 99
		end,
		function(arg_11_0)
			return -arg_11_0
		end
	}))

	return
end

return Dorm3dZone
