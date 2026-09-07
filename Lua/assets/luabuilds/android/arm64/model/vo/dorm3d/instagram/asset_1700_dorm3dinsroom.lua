local Dorm3dInsRoom = class("Dorm3dInsRoom")

function Dorm3dInsRoom:Ctor(arg_1_1)
	self.id = arg_1_1
	self.roomConfigs = pg.dorm3d_rooms[arg_1_1]

	return
end

function Dorm3dInsRoom:GetType()
	return self:GetConfig("type")
end

function Dorm3dInsRoom:GetInMap()
	return self:GetConfig("in_map")
end

function Dorm3dInsRoom:GetConfig(arg_4_1)
	return self.roomConfigs[arg_4_1]
end

function Dorm3dInsRoom:GetIcon()
	return string.format("dorm3dselect/room_icon_%s", string.lower(self:GetConfig("assets_prefix")))
end

function Dorm3dInsRoom:IsDownloaded()
	local var_6_0 = getProxy(ApartmentProxy):getRoom(self.id)

	if not var_6_0 then
		return false
	end

	return not var_6_0:needDownload()
end

function Dorm3dInsRoom:GetCard()
	return
end

function Dorm3dInsRoom:IsCare()
	return
end

function Dorm3dInsRoom:ShouldTip()
	return
end

return Dorm3dInsRoom
