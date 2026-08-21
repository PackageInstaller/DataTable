local var_0_0 = class("TeleportSystem", import("view.dorm3d.Extra.BaseExtraSystem"))

var_0_0.MAX_DISTANCE = 1.5

function var_0_0.OnInit(arg_1_0)
	local var_1_0 = arg_1_0:GetRoom().id

	warning("TeleportSystem Init for room:", var_1_0)

	arg_1_0.configs = pg.dorm3d_teleport.get_id_list_by_room_id[var_1_0] or {}

	arg_1_0:BindClickFunc()

	return
end

function var_0_0.BindClickFunc(arg_2_0)
	_.each(arg_2_0.configs, function(arg_3_0)
		warning(pg.dorm3d_teleport[arg_3_0])

		local var_3_0 = arg_2_0:GetSceneItem(pg.dorm3d_teleport[arg_3_0].item_path)

		if not var_3_0 then
			return
		end

		local var_3_1 = pg.dorm3d_zone_template[pg.dorm3d_teleport[arg_3_0].teleport_zone]

		if pg.dorm3d_zone_template[pg.dorm3d_teleport[arg_3_0].teleport_zone] then
			var_3_1 = pg.dorm3d_zone_template[pg.dorm3d_teleport[arg_3_0].teleport_zone].watch_camera
		end

		assert(var_3_1, "invalid zone:" .. tostring(pg.dorm3d_teleport[arg_3_0].teleport_zone))
		GetOrAddComponent(var_3_0, typeof(EventTriggerListener)):AddPointClickFunc(function(arg_4_0, arg_4_1)
			if arg_2_0:Get("isInFurnitureSelect") then
				return
			end

			local var_4_0 = CameraMgr.instance:Raycast(arg_2_0:Get("sceneRaycaster"), arg_4_1.position):ToTable()

			if #var_4_0 > 0 then
				if var_4_0[1].gameObject.transform ~= var_3_0.transform then
					return
				end

				local var_4_1 = Vector3.Distance(arg_2_0:Get("player").transform.position, var_3_0.transform.position)

				if var_4_1 > var_0_0.MAX_DISTANCE then
					return
				end

				arg_2_0:Emit(Dorm3dRoomTemplateScene.SHIFT_ZONE_SAFE, var_3_1)
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.RegisterEvents(arg_5_0)
	return
end

function var_0_0.OnHandleNotification(arg_6_0, arg_6_1, arg_6_2)
	return
end

function var_0_0.GetInterests()
	return {}
end

function var_0_0.OnDispose(arg_8_0)
	return
end

return var_0_0
