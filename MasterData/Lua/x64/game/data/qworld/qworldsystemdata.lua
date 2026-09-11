local var_0_0 = singletonClass("QWorldSystemData")

QWORLD_SYSTEM_ROOT_TYPE = {
	VERSION = 2,
	COMMON = 1
}

local var_0_1 = false

function var_0_0:Init()
	self.systemContext = {}
	self.waitActiveSystem = {}
	self.waitTaskSystem = {}

	self:InitMap()

	if not var_0_1 then
		var_0_1 = true
		self.activityUpdateHandle_ = handler(self, self.OnActivityChange)

		manager.notify:RegistListener(ACTIVITY_UPDATE, self.activityUpdateHandle_)

		self.questUpdateHandle_ = handler(self, self.OnQuestFinish)

		manager.notify:RegistListener(QWORLD_SUB_QUEST_FINISH, self.questUpdateHandle_)
	end
end

function var_0_0:InitMap()
	self.ActivityMap = {}

	for iter_2_0, iter_2_1 in ipairs(SandPlayMapCfg.all) do
		self.ActivityMap[SandPlayMapCfg[iter_2_1].activity_id] = self:BuildMapSystemCtx(SandPlayMapCfg[iter_2_1].activity_id, SandPlayMapCfg[iter_2_1])
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

		if SandPlaySystemCfg[iter_3_1].is_entrance == 1 then
			table.insert(var_3_0.entrace, iter_3_1)
		end
	end

	return var_3_0
end

function var_0_0.GetSystemRootType(arg_4_0, arg_4_1)
	if SandPlaySystemCfg[arg_4_1].type >= 1 and SandPlaySystemCfg[arg_4_1].type <= 100 then
		return QWORLD_SYSTEM_ROOT_TYPE.COMMON
	else
		return QWORLD_SYSTEM_ROOT_TYPE.VERSION
	end
end

function var_0_0:OnMapOpen(arg_5_1)
	if self.ActivityMap[arg_5_1] then
		for iter_5_0, iter_5_1 in pairs(self.ActivityMap[arg_5_1].system) do
			self.systemContext[iter_5_0] = self.systemContext[iter_5_0] or {
				isOpen = false
			}

			local var_5_0 = SandPlaySystemCfg[iter_5_0]

			if SandPlaySystemCfg[iter_5_0].activity_id ~= 0 then
				self.waitActiveSystem[var_5_0.activity_id] = self.waitActiveSystem[var_5_0.activity_id] or {}
				self.waitActiveSystem[var_5_0.activity_id][iter_5_0] = true
			end

			if var_5_0.task_id ~= 0 then
				self.waitTaskSystem[var_5_0.task_id] = self.waitTaskSystem[var_5_0.task_id] or {}
				self.waitTaskSystem[var_5_0.task_id][iter_5_0] = true
			end

			if not self.systemContext[iter_5_0].isOpen then
				if self:IsSystemOpened(iter_5_0) then
					self.systemContext[iter_5_0].isOpen = true

					manager.notify:Invoke(QWORLD_SYSTEM_OPEN, iter_5_0)
				end
			elseif not self:IsSystemOpened(iter_5_0) then
				self.systemContext[iter_5_0].isOpen = false

				manager.notify:Invoke(QWORLD_SYSTEM_CLOSE, iter_5_0)
			end
		end
	end
end

function var_0_0:OnMapClose(arg_6_1)
	if self.ActivityMap[arg_6_1] then
		for iter_6_0, iter_6_1 in pairs(self.ActivityMap[arg_6_1].system) do
			if self:GetSystemRootType(iter_6_0) ~= QWORLD_SYSTEM_ROOT_TYPE.COMMON then
				self.systemContext[iter_6_0].isOpen = false

				manager.notify:Invoke(QWORLD_SYSTEM_CLOSE, iter_6_0)
			end
		end
	end
end

function var_0_0:OnActivityChange(arg_7_1)
	if self.ActivityMap[arg_7_1] then
		local var_7_0 = ActivityData:GetActivityIsOpen(arg_7_1)

		if self.ActivityMap[arg_7_1].isOpen ~= var_7_0 then
			self.ActivityMap[arg_7_1].isOpen = var_7_0

			if var_7_0 then
				self:OnMapOpen(arg_7_1)
			else
				self:OnMapClose(arg_7_1)
			end
		end
	end

	if self.waitActiveSystem[arg_7_1] then
		for iter_7_0, iter_7_1 in pairs(self.waitActiveSystem[arg_7_1]) do
			local var_7_1 = self:IsSystemOpened(iter_7_0)

			if self.systemContext[iter_7_0].isOpen and self.systemContext[iter_7_0].isOpen ~= var_7_1 then
				self.systemContext[iter_7_0].isOpen = var_7_1

				if var_7_1 then
					manager.notify:Invoke(QWORLD_SYSTEM_OPEN, iter_7_0)
				else
					manager.notify:Invoke(QWORLD_SYSTEM_CLOSE, iter_7_0)
				end
			end
		end
	end
end

function var_0_0:OnQuestFinish(arg_8_1)
	if self.waitTaskSystem[arg_8_1] then
		for iter_8_0, iter_8_1 in pairs(self.waitTaskSystem[arg_8_1]) do
			local var_8_0 = self:IsSystemOpened(iter_8_0)

			if self.systemContext[iter_8_0].isOpen and self.systemContext[iter_8_0].isOpen ~= var_8_0 then
				self.systemContext[iter_8_0].isOpen = var_8_0

				if var_8_0 then
					manager.notify:Invoke(QWORLD_SYSTEM_OPEN, iter_8_0)
				else
					manager.notify:Invoke(QWORLD_SYSTEM_CLOSE, iter_8_0)
				end
			end
		end
	end
end

function var_0_0.IsSystemOpened(arg_9_0, arg_9_1)
	if SandPlaySystemCfg[arg_9_1] then
		if SandPlaySystemCfg[arg_9_1].task_id ~= 0 and not QWorldQuestTool.IsSubQuestFinish(SandPlaySystemCfg[arg_9_1].task_id) then
			return false
		end

		if SandPlaySystemCfg[arg_9_1].activity_id ~= 0 and not ActivityData:GetActivityIsOpen(SandPlaySystemCfg[arg_9_1].activity_id) then
			return false
		end

		return true
	end

	return false
end

return var_0_0
