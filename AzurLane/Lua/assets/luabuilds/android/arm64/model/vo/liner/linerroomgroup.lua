local var_0_0 = class("LinerRoomGroup", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.rooms = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0:GetIds()) do
		arg_1_0.rooms[iter_1_1] = LinerRoom.New(iter_1_1)
	end

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_liner_room_group
end

function var_0_0.GetRoom(arg_3_0, arg_3_1)
	return arg_3_0.rooms[arg_3_1]
end

function var_0_0.GetRooms(arg_4_0, arg_4_1)
	return arg_4_0.rooms
end

function var_0_0.GetIds(arg_5_0)
	return arg_5_0:getConfig("ids")
end

function var_0_0.GetRoomList(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.rooms) do
		table.insert({}, iter_6_1)
	end

	return {}
end

function var_0_0.GetDrop(arg_7_0)
	return Drop.Create(arg_7_0:getConfig("drop_display"))
end

return var_0_0
