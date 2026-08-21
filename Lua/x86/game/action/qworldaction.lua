local var_0_0 = {}

local function var_0_1()
	local var_1_0 = SandPlayMapCfg.all

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_1 = SandPlayMapCfg[iter_1_1].activity_id
		local var_1_2 = ActivityCfg[var_1_1].sub_activity_list
		local var_1_3 = {}

		for iter_1_2, iter_1_3 in ipairs(var_1_2) do
			table.insert(var_1_3, ActivityTools.GetRedPointKey(iter_1_3) .. iter_1_3)
			manager.redPoint:appendGroup(ActivityTools.GetRedPointKey(var_1_1) .. var_1_1, ActivityTools.GetRedPointKey(iter_1_3) .. iter_1_3, true)
		end
	end
end

manager.net:Bind(79601, function(arg_2_0)
	QWorldData:InitData(arg_2_0)
end)
manager.net:Bind(28837, function(arg_3_0)
	QWorldData:InitUnlockFunction(arg_3_0)
end)

function var_0_0.InitRedPoint(arg_4_0)
	local var_4_0 = ActivityCfg[arg_4_0]
	local var_4_1 = string.format("%s%s", ActivityTools.GetRedPointKey(arg_4_0), arg_4_0)
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0.sub_activity_list) do
		local var_4_3 = string.format("%s%s", ActivityTools.GetRedPointKey(iter_4_1), iter_4_1)

		manager.redPoint:appendGroup(var_4_1, var_4_3, true)
		table.insert(var_4_2, var_4_3)
	end
end

function var_0_0.SavePlayerData(arg_5_0)
	local var_5_0 = QWorldData:GetCurMapId()

	if var_5_0 == 0 then
		return
	end

	local var_5_1

	for iter_5_0, iter_5_1 in ipairs(SandPlayMapCfg.all) do
		local var_5_2 = SandPlayMapCfg[iter_5_1]

		if var_5_2.id == var_5_0 then
			var_5_1 = var_5_2.activity_id

			break
		end
	end

	if not var_5_1 then
		return
	end

	local var_5_3 = QWorldLuaBridge.GetPlayer()
	local var_5_4 = QWorldData:GetQWorldContext()

	if var_5_4 and var_5_4.position == var_5_3.transform.position and var_5_4.rotation == var_5_3.transform.rotation then
		return
	end

	if QWorldMgr:GetQWorldPerformMgr():IsInPerform() then
		return
	end

	QWorldData:SetQWorldContext({
		position = var_5_3.transform.position,
		rotation = var_5_3.transform.rotation
	})

	local var_5_5 = QWorldData:GetQWorldContext()
	local var_5_6 = {
		map_status = 0,
		stage_id = var_5_0,
		position_x = var_5_5.position.x,
		position_y = var_5_5.position.y,
		position_z = var_5_5.position.z,
		rotation_x = var_5_5.rotation.x,
		rotation_y = var_5_5.rotation.y,
		rotation_z = var_5_5.rotation.z,
		rotation_w = var_5_5.rotation.w
	}
	local var_5_7 = {
		activity_id = var_5_1,
		stage_list = {
			var_5_6
		}
	}

	manager.net:SendWithLoadingNew(79602, var_5_7, 79603, function(arg_6_0, arg_6_1)
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
		local var_8_2 = SandPlayMapCfg[iter_8_1]

		if var_8_2.id == var_8_0 then
			var_8_1 = var_8_2.activity_id

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
