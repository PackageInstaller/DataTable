local var_0_0 = singletonClass("QWorldSystemData")

QWORLD_SYSTEM_ROOT_TYPE = {
	VERSION = 2,
	COMMON = 1
}

local var_0_1 = false

function var_0_0.Init(arg_1_0)
	arg_1_0.systemContext = {}
	arg_1_0.waitActiveSystem = {}
	arg_1_0.waitTaskSystem = {}

	arg_1_0:InitMap()

	if not var_0_1 then
		var_0_1 = true
		arg_1_0.activityUpdateHandle_ = handler(arg_1_0, arg_1_0.OnActivityChange)

		manager.notify:RegistListener(ACTIVITY_UPDATE, arg_1_0.activityUpdateHandle_)

		arg_1_0.questUpdateHandle_ = handler(arg_1_0, arg_1_0.OnQuestFinish)

		manager.notify:RegistListener(QWORLD_SUB_QUEST_FINISH, arg_1_0.questUpdateHandle_)
	end
end

function var_0_0.InitMap(arg_2_0)
	arg_2_0.ActivityMap = {}

	for iter_2_0, iter_2_1 in ipairs(SandPlayMapCfg.all) do
		local var_2_0 = SandPlayMapCfg[iter_2_1]
		local var_2_1 = SandPlayMapCfg[iter_2_1].activity_id

		arg_2_0.ActivityMap[var_2_1] = arg_2_0:BuildMapSystemCtx(var_2_1, var_2_0)
	end
end

function var_0_0.BuildMapSystemCtx(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {
		id = arg_3_2.id,
		system = {},
		entrace = {}
	}

	var_3_0.isOpen = false

	for iter_3_0, iter_3_1 in ipairs(arg_3_2.system_list) do
		var_3_0.system[iter_3_1] = true

		local var_3_1 = SandPlaySystemCfg[iter_3_1].activity_id
		local var_3_2 = SandPlaySystemCfg[iter_3_1].task_id

		if SandPlaySystemCfg[iter_3_1].is_entrance == 1 then
			table.insert(var_3_0.entrace, iter_3_1)
		end
	end

	return var_3_0
end

function var_0_0.GetSystemRootType(arg_4_0, arg_4_1)
	local var_4_0 = SandPlaySystemCfg[arg_4_1]

	if var_4_0.type >= 1 and var_4_0.type <= 100 then
		return QWORLD_SYSTEM_ROOT_TYPE.COMMON
	else
		return QWORLD_SYSTEM_ROOT_TYPE.VERSION
	end
end

function var_0_0.OnMapOpen(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.ActivityMap[arg_5_1]

	if var_5_0 then
		for iter_5_0, iter_5_1 in pairs(var_5_0.system) do
			if not arg_5_0.systemContext[iter_5_0] then
				arg_5_0.systemContext[iter_5_0] = {
					isOpen = false
				}
			end

			local var_5_1 = SandPlaySystemCfg[iter_5_0]

			if var_5_1.activity_id ~= 0 then
				if not arg_5_0.waitActiveSystem[var_5_1.activity_id] then
					arg_5_0.waitActiveSystem[var_5_1.activity_id] = {}
				end

				arg_5_0.waitActiveSystem[var_5_1.activity_id][iter_5_0] = true
			end

			if var_5_1.task_id ~= 0 then
				if not arg_5_0.waitTaskSystem[var_5_1.task_id] then
					arg_5_0.waitTaskSystem[var_5_1.task_id] = {}
				end

				arg_5_0.waitTaskSystem[var_5_1.task_id][iter_5_0] = true
			end

			if not arg_5_0.systemContext[iter_5_0].isOpen then
				if arg_5_0:IsSystemOpened(iter_5_0) then
					arg_5_0.systemContext[iter_5_0].isOpen = true

					manager.notify:Invoke(QWORLD_SYSTEM_OPEN, iter_5_0)
				end
			elseif not arg_5_0:IsSystemOpened(iter_5_0) then
				arg_5_0.systemContext[iter_5_0].isOpen = false

				manager.notify:Invoke(QWORLD_SYSTEM_CLOSE, iter_5_0)
			end
		end
	end
end

function var_0_0.OnMapClose(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.ActivityMap[arg_6_1]

	if var_6_0 then
		for iter_6_0, iter_6_1 in pairs(var_6_0.system) do
			if arg_6_0:GetSystemRootType(iter_6_0) ~= QWORLD_SYSTEM_ROOT_TYPE.COMMON then
				arg_6_0.systemContext[iter_6_0].isOpen = false

				manager.notify:Invoke(QWORLD_SYSTEM_CLOSE, iter_6_0)
			end
		end
	end
end

function var_0_0.OnActivityChange(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.ActivityMap[arg_7_1]

	if var_7_0 then
		local var_7_1 = ActivityData:GetActivityIsOpen(arg_7_1)

		if var_7_0.isOpen ~= var_7_1 then
			var_7_0.isOpen = var_7_1

			if var_7_1 then
				arg_7_0:OnMapOpen(arg_7_1)
			else
				arg_7_0:OnMapClose(arg_7_1)
			end
		end
	end

	if arg_7_0.waitActiveSystem[arg_7_1] then
		local var_7_2 = arg_7_0.waitActiveSystem[arg_7_1]

		for iter_7_0, iter_7_1 in pairs(var_7_2) do
			local var_7_3 = arg_7_0.systemContext[iter_7_0].isOpen
			local var_7_4 = arg_7_0:IsSystemOpened(iter_7_0)

			if var_7_3 and var_7_3 ~= var_7_4 then
				arg_7_0.systemContext[iter_7_0].isOpen = var_7_4

				if var_7_4 then
					manager.notify:Invoke(QWORLD_SYSTEM_OPEN, iter_7_0)
				else
					manager.notify:Invoke(QWORLD_SYSTEM_CLOSE, iter_7_0)
				end
			end
		end
	end
end

function var_0_0.OnQuestFinish(arg_8_0, arg_8_1)
	if arg_8_0.waitTaskSystem[arg_8_1] then
		local var_8_0 = arg_8_0.waitTaskSystem[arg_8_1]

		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			local var_8_1 = arg_8_0.systemContext[iter_8_0].isOpen
			local var_8_2 = arg_8_0:IsSystemOpened(iter_8_0)

			if var_8_1 and var_8_1 ~= var_8_2 then
				arg_8_0.systemContext[iter_8_0].isOpen = var_8_2

				if var_8_2 then
					manager.notify:Invoke(QWORLD_SYSTEM_OPEN, iter_8_0)
				else
					manager.notify:Invoke(QWORLD_SYSTEM_CLOSE, iter_8_0)
				end
			end
		end
	end
end

function var_0_0.IsSystemOpened(arg_9_0, arg_9_1)
	local var_9_0 = SandPlaySystemCfg[arg_9_1]

	if var_9_0 then
		if var_9_0.task_id ~= 0 and not QWorldQuestTool.IsSubQuestFinish(var_9_0.task_id) then
			return false
		end

		if var_9_0.activity_id ~= 0 and not ActivityData:GetActivityIsOpen(var_9_0.activity_id) then
			return false
		end

		return true
	end

	return false
end

return var_0_0
