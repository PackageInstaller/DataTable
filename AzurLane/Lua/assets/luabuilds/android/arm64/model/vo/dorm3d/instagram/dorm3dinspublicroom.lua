local var_0_0 = class("Dorm3dInsPublicRoom", import(".Dorm3dInsRoom"))

function var_0_0.GetWelcomeCharList(arg_1_0)
	local var_1_0 = _.map(arg_1_0:GetConfig("character_welcome"), function(arg_2_0)
		return arg_2_0[1]
	end)
	local var_1_1 = getProxy(ApartmentProxy):getRoom(arg_1_0.id) and _.select(var_1_0, function(arg_3_0)
		return var_0.unlockCharacter[arg_3_0]
	end) or {}

	return var_1_0, var_1_1, (_.map(var_1_0, function(arg_4_0)
		return _.detect(pg.dorm3d_rooms.all, function(arg_5_0)
			return pg.dorm3d_rooms[arg_5_0].type == 2 and pg.dorm3d_rooms[arg_5_0].character[1] == arg_4_0
		end)
	end))
end

function var_0_0.GetFurnitureNum(arg_6_0)
	return
end

function var_0_0.GetCard(arg_7_0)
	return string.format("dorm3dselect/room_ins_%s", string.lower(arg_7_0:GetConfig("assets_prefix")))
end

function var_0_0.IsCare(arg_8_0)
	return false
end

function var_0_0.GetDesc(arg_9_0)
	return arg_9_0:GetConfig("room_des")
end

function var_0_0.ShouldTip(arg_10_0)
	return false
end

return var_0_0
