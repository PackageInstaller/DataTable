class = var_0_10000

local var_0_0 = "Dorm3dInsPublicRoom"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".Dorm3dInsRoom"))

function var_0_1.GetWelcomeCharList(arg_1_0)
	_ = var_1_10001

	local var_1_0 = var_1_10001.map(arg_1_0:GetConfig("character_welcome"), function(arg_2_0)
		return arg_2_0[1]
	end)

	getProxy = var_2
	ApartmentProxy = var_3

	local var_1_1 = var_2(var_3)

	if var_2.getRoom(var_1_1, arg_1_0.id) then
		_ = var_1_1

		local var_1_2

		if not var_1_1.select(var_1_0, function(arg_3_0)
			return var_0.unlockCharacter[arg_3_0]
		end) then
			var_1_2 = {}
		end

		_ = var_4

		local var_1_3 = var_4.map(var_1_0, function(arg_4_0)
			_ = var_2_10001

			local var_4_0 = var_2_10001.detect

			pg = var_2_10002

			return var_4_0(var_2_10002.dorm3d_rooms.all, function(arg_5_0)
				pg = var_3_10001

				if var_3_10001.dorm3d_rooms[arg_5_0].type == 2 then
					pg = var_1

					local var_5_0

					if var_1.dorm3d_rooms[arg_5_0].character[1] ~= arg_4_0 then
						var_5_0 = false
					else
						var_5_0 = true
					end

					return var_5_0
				end
			end)
		end)

		return var_1_0, var_1_2, var_1_3
	end
end

function var_0_1.GetFurnitureNum(arg_6_0)
	return
end

function var_0_1.GetCard(arg_7_0)
	string = var_1_10001

	local var_7_0 = var_1_10001.format
	local var_7_1 = "dorm3dselect/room_ins_%s"

	string = var_1_10003

	return var_7_0(var_7_1, var_1_10003.lower(arg_7_0:GetConfig("assets_prefix")))
end

function var_0_1.IsCare(arg_8_0)
	return false
end

function var_0_1.GetDesc(arg_9_0)
	return arg_9_0:GetConfig("room_des")
end

function var_0_1.ShouldTip(arg_10_0)
	return false
end

return var_0_1
