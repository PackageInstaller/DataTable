local var_0_0 = class("Dorm3dInsRoom")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.roomConfigs = pg.dorm3d_rooms[arg_1_1]

	return
end

function var_0_0.GetType(arg_2_0)
	return arg_2_0:GetConfig("type")
end

function var_0_0.GetInMap(arg_3_0)
	return arg_3_0:GetConfig("in_map")
end

function var_0_0.GetConfig(arg_4_0, arg_4_1)
	return arg_4_0.roomConfigs[arg_4_1]
end

function var_0_0.GetIcon(arg_5_0)
	return string.format("dorm3dselect/room_icon_%s", string.lower(arg_5_0:GetConfig("assets_prefix")))
end

function var_0_0.IsDownloaded(arg_6_0)
	local var_6_0 = getProxy(ApartmentProxy):getRoom(arg_6_0.id)

	if not var_6_0 then
		return false
	end

	return not var_6_0:needDownload()
end

function var_0_0.GetCard(arg_7_0)
	return
end

function var_0_0.IsCare(arg_8_0)
	return
end

function var_0_0.ShouldTip(arg_9_0)
	return
end

return var_0_0
