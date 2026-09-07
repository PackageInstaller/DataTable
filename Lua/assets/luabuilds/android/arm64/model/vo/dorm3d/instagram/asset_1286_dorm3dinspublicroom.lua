local Dorm3dInsPublicRoom = class("Dorm3dInsPublicRoom", import(".Dorm3dInsRoom"))

function Dorm3dInsPublicRoom:GetWelcomeCharList()
	local var_1_0 = _.map(self:GetConfig("character_welcome"), function(arg_2_0)
		return arg_2_0[1]
	end)
	local var_1_1 = getProxy(ApartmentProxy):getRoom(self.id)

	return var_1_0, var_1_1 and _.select(var_1_0, function(arg_3_0)
		return var_1_1.unlockCharacter[arg_3_0]
	end) or {}, (_.map(var_1_0, function(arg_4_0)
		return _.detect(pg.dorm3d_rooms.all, function(arg_5_0)
			return pg.dorm3d_rooms[arg_5_0].type == 2 and pg.dorm3d_rooms[arg_5_0].character[1] == arg_4_0
		end)
	end))
end

function Dorm3dInsPublicRoom:GetFurnitureNum()
	return
end

function Dorm3dInsPublicRoom:GetCard()
	return string.format("dorm3dselect/room_ins_%s", string.lower(self:GetConfig("assets_prefix")))
end

function Dorm3dInsPublicRoom:IsCare()
	return false
end

function Dorm3dInsPublicRoom:GetDesc()
	return self:GetConfig("room_des")
end

function Dorm3dInsPublicRoom:ShouldTip()
	return false
end

return Dorm3dInsPublicRoom
