local var_0_0 = {}

manager.net:Bind(79601, function(arg_2_0)
	QWorldData:InitData(arg_2_0)
end)
manager.net:Bind(28837, function(arg_3_0)
	QWorldData:InitUnlockFunction(arg_3_0)
end)

function var_0_0.InitRedPoint(arg_4_0)
	local var_4_0 = string.format("%s%s", ActivityTools.GetRedPointKey(arg_4_0), arg_4_0)
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(ActivityCfg[arg_4_0].sub_activity_list) do
		local var_4_2 = string.format("%s%s", ActivityTools.GetRedPointKey(iter_4_1), iter_4_1)

		manager.redPoint:appendGroup(var_4_0, var_4_2, true)
		table.insert(var_4_1, var_4_2)
	end
end

function var_0_0.SavePlayerData(arg_5_0)
	local var_5_0 = QWorldData:GetCurMapId()

	if var_5_0 == 0 then
		return
	end

	local var_5_1

	for iter_5_0, iter_5_1 in ipairs(SandPlayMapCfg.all) do
		if SandPlayMapCfg[iter_5_1].id == var_5_0 then
			var_5_1 = SandPlayMapCfg[iter_5_1].activity_id

			break
		end
	end

	if not var_5_1 then
		return
	end

	local var_5_2 = QWorldLuaBridge.GetPlayer()
	local var_5_3 = QWorldData:GetQWorldContext()

	if var_5_3 and var_5_3.position == var_5_2.transform.position and var_5_3.rotation == var_5_2.transform.rotation then
		return
	end

	if QWorldMgr:GetQWorldPerformMgr():IsInPerform() then
		return
	end

	QWorldData:SetQWorldContext({
		position = var_5_2.transform.position,
		rotation = var_5_2.transform.rotation
	})

	local var_5_4 = QWorldData:GetQWorldContext()

	manager.net:SendWithLoadingNew(79602, {
		activity_id = var_5_1,
		stage_list = {
			{
				map_status = 0,
				stage_id = var_5_0,
				position_x = var_5_4.position.x,
				position_y = var_5_4.position.y,
				position_z = var_5_4.position.z,
				rotation_x = var_5_4.rotation.x,
				rotation_y = var_5_4.rotation.y,
				rotation_z = var_5_4.rotation.z,
				rotation_w = var_5_4.rotation.w
			}
		}
	}, 79603, function(arg_6_0, arg_6_1)
		if isSuccess(arg_6_0.result) then
			if arg_5_0 then
				arg_5_0(arg_6_0, arg_6_1)
			end
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

function var_0_0.UnlockFunction(arg_7_0)
	if QWorldData:IsUnlockFunction(arg_7_0) then
		return
	end

	QWorldData:AddUnlockFunction(arg_7_0)
	manager.net:Push(28834, {
		sys_id = arg_7_0
	})
end

function var_0_0.SendUpdateThingTrackToSDK(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = QWorldData:GetCurMapId()

	if var_8_0 == 0 then
		return
	end

	local var_8_1

	for iter_8_0, iter_8_1 in ipairs(SandPlayMapCfg.all) do
		if SandPlayMapCfg[iter_8_1].id == var_8_0 then
			var_8_1 = SandPlayMapCfg[iter_8_1].activity_id

			break
		end
	end

	if not var_8_1 then
		return
	end

	SDKTools.SendMessageToSDK("task_accept", {
		type = 2,
		activity_id = var_8_1,
		stage_id = var_8_0,
		task_id = arg_8_0,
		task_type = arg_8_2 or 1,
		opt = arg_8_1
	})
end

return var_0_0
