class = var_0_10000

local var_0_0 = var_0_10000("Dorm3dInsRoom")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	pg = var_1_10002
	arg_1_0.roomConfigs = var_1_10002.dorm3d_rooms[arg_1_1]

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
	string = var_1_10001

	local var_5_0 = var_1_10001.format
	local var_5_1 = "dorm3dselect/room_icon_%s"

	string = var_1_10003

	return var_5_0(var_5_1, var_1_10003.lower(arg_5_0:GetConfig("assets_prefix")))
end

function var_0_0.IsDownloaded(arg_6_0)
	getProxy = var_1_10001
	ApartmentProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)

	if not var_1.getRoom(var_6_0, arg_6_0.id) then
		return false
	end

	return not var_1:needDownload()
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
