local TeleportSystem = class("TeleportSystem", import("view.dorm3d.Extra.BaseExtraSystem"))

TeleportSystem.MAX_DISTANCE = 1.5

function TeleportSystem:OnInit()
	local var_1_0 = self:GetRoom().id

	warning("TeleportSystem Init for room:", var_1_0)

	self.configs = pg.dorm3d_teleport.get_id_list_by_room_id[var_1_0] or {}

	self:BindClickFunc()

	return
end

function TeleportSystem:BindClickFunc()
	_.each(self.configs, function(arg_3_0)
		warning(pg.dorm3d_teleport[arg_3_0])

		local var_3_0 = self:GetSceneItem(pg.dorm3d_teleport[arg_3_0].item_path)

		if not var_3_0 then
			return
		end

		local var_3_1 = pg.dorm3d_zone_template[pg.dorm3d_teleport[arg_3_0].teleport_zone]

		if pg.dorm3d_zone_template[pg.dorm3d_teleport[arg_3_0].teleport_zone] then
			var_3_1 = pg.dorm3d_zone_template[pg.dorm3d_teleport[arg_3_0].teleport_zone].watch_camera
		end

		assert(var_3_1, "invalid zone:" .. tostring(pg.dorm3d_teleport[arg_3_0].teleport_zone))
		GetOrAddComponent(var_3_0, typeof(EventTriggerListener)):AddPointClickFunc(function(arg_4_0, arg_4_1)
			if self:Get("isInFurnitureSelect") then
				return
			end

			local var_4_0 = CameraMgr.instance:Raycast(self:Get("sceneRaycaster"), arg_4_1.position):ToTable()

			if #var_4_0 > 0 then
				if var_4_0[1].gameObject.transform ~= var_3_0.transform then
					return
				end

				if Vector3.Distance(self:Get("player").transform.position, var_3_0.transform.position) > TeleportSystem.MAX_DISTANCE then
					return
				end

				self:Emit(Dorm3dRoomTemplateScene.SHIFT_ZONE_SAFE, var_3_1)
			end

			return
		end)

		return
	end)

	return
end

function TeleportSystem:RegisterEvents()
	return
end

function TeleportSystem:OnHandleNotification(arg_6_1, arg_6_2)
	return
end

function TeleportSystem.GetInterests()
	return {}
end

function TeleportSystem:OnDispose()
	return
end

return TeleportSystem
