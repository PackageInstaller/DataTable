local LinerRoomGroup = class("LinerRoomGroup", import("model.vo.BaseVO"))

function LinerRoomGroup:Ctor(arg_1_1)
	self.id = arg_1_1
	self.configId = self.id
	self.rooms = {}

	for iter_1_0, iter_1_1 in ipairs(self:GetIds()) do
		self.rooms[iter_1_1] = LinerRoom.New(iter_1_1)
	end

	return
end

function LinerRoomGroup:bindConfigTable()
	return pg.activity_liner_room_group
end

function LinerRoomGroup:GetRoom(arg_3_1)
	return self.rooms[arg_3_1]
end

function LinerRoomGroup:GetRooms(arg_4_1)
	return self.rooms
end

function LinerRoomGroup:GetIds()
	return self:getConfig("ids")
end

function LinerRoomGroup:GetRoomList()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self.rooms) do
		table.insert(var_6_0, iter_6_1)
	end

	return var_6_0
end

function LinerRoomGroup:GetDrop()
	return Drop.Create(self:getConfig("drop_display"))
end

return LinerRoomGroup
