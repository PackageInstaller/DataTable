class = var_0_10000

local var_0_0 = "TeleportSystem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Extra.BaseExtraSystem"))

var_0_1.MAX_DISTANCE = 1.5

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0:GetRoom().id

	warning = var_1_10002

	var_1_10002("TeleportSystem Init for room:", var_1_0)

	pg = var_1_10002

	local var_1_1

	if not var_1_10002.dorm3d_teleport.get_id_list_by_room_id[var_1_0] then
		var_1_1 = {}
	end

	arg_1_0.configs = var_1_1

	arg_1_0:BindClickFunc()

	return
end

function var_0_1.BindClickFunc(arg_2_0)
	_ = var_1_10001

	var_1_10001.each(arg_2_0.configs, function(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.dorm3d_teleport[arg_3_0]

		warning = var_2_10002

		var_2_10002(var_3_0)

		local var_3_1 = arg_2_0

		if not var_2.GetSceneItem(var_3_1, var_3_0.item_path) then
			return
		end

		pg = var_2_10003

		local var_3_2

		if var_2_10003.dorm3d_zone_template[var_3_0.teleport_zone] then
			pg = var_3_2
			var_3_2 = var_3_2.dorm3d_zone_template[var_3_0.teleport_zone].watch_camera
		end

		assert = var_4

		local var_3_3 = var_3_2
		local var_3_4 = "invalid zone:"

		tostring = var_2_10008

		var_4(var_3_3, var_3_4 .. var_2_10008(var_3_0.teleport_zone))

		GetOrAddComponent = var_4

		local var_3_5 = var_2

		typeof = var_7
		EventTriggerListener = var_2_10009

		local var_3_6 = var_4(var_3_5, var_7(var_2_10009))

		var_4.AddPointClickFunc(var_3_6, function(arg_4_0, arg_4_1)
			local var_4_0 = arg_2_0

			if var_2.Get(var_4_0, "isInFurnitureSelect") then
				return
			end

			local var_4_1 = arg_4_1.position

			CameraMgr = var_3_10003

			local var_4_2 = var_3_10003.instance
			local var_4_3 = var_3.Raycast
			local var_4_4 = arg_2_0
			local var_4_5 = var_4_3(var_4_2, var_6.Get(var_4_4, "sceneRaycaster"), var_4_1)

			if #var_3.ToTable(var_4_5) > 0 then
				if var_3[1].gameObject.transform ~= var_0.transform then
					return
				end

				local var_4_6 = arg_2_0
				local var_4_7 = var_5.Get(var_4_6, "player")

				Vector3 = var_6

				if var_6.Distance(var_4_7.transform.position, var_0.transform.position) > var_0_1.MAX_DISTANCE then
					return
				end

				local var_4_8 = arg_2_0
				local var_4_9 = var_7.Emit

				Dorm3dRoomTemplateScene = var_3_10010

				var_4_9(var_4_8, var_3_10010.SHIFT_ZONE_SAFE, var_3_2)
			end

			return
		end)

		return
	end)

	return
end

function var_0_1.RegisterEvents(arg_5_0)
	return
end

function var_0_1.OnHandleNotification(arg_6_0, arg_6_1, arg_6_2)
	return
end

function var_0_1.GetInterests()
	return {}
end

function var_0_1.OnDispose(arg_8_0)
	return
end

return var_0_1
