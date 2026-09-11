local GameListener = class("GameListener")
local SettingTools = import("game.tools.SettingTools")
local LvTools = import("game.tools.LvTools")

function GameListener:StartListen()
	self:AddEventListeners()
	self:AddTaskListeners()
end

function GameListener:AddEventListeners()
	manager.notify:RegistListener(PLAYER_LEVEL_UP, handler(self, self.LevelUp))
end

function GameListener:LevelUp(arg_3_1, arg_3_2)
	PlayerAction.ChangeLevel(arg_3_1, arg_3_2)
	NeedGameUserInfo()
	GameToSDK.UpUserInfo(PlayerTools.PackUserData("LevelUp"))
end

function GameListener:AddTaskListeners()
	local var_4_0 = self:GetNextTime()

	if var_4_0 ~= 0 then
		if not self.timer_ then
			self.timer_ = Timer.New(function()
				if var_4_0 <= manager.time:GetServerTime() then
					TaskRedPoint:UpdatePassportTaskRedTip()

					var_4_0 = self:GetNextTime()

					if var_4_0 <= 0 then
						self.timer_:Stop()
					end
				end
			end, 1, -1)

			self.timer_:Start()
		end
	elseif self.timer_ then
		self.timer_:Stop()
	end
end

function GameListener:GetNextTime()
	local var_6_0 = manager.time:GetServerTime()
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs({
		TaskConst.TASK_TYPE.PASSPORT_DAILY,
		TaskConst.TASK_TYPE.PASSPORT_WEEKLY,
		TaskConst.TASK_TYPE.PASSPORT_CHALLENGE
	}) do
		for iter_6_2, iter_6_3 in ipairs((TaskData2:GetTaskIDListByType(iter_6_1))) do
			local var_6_3 = TaskData2:GetTask(iter_6_2)

			if var_6_3.expired_timestamp > 0 and var_6_0 <= var_6_3.expired_timestamp then
				var_6_1 = var_6_1 == 0 and var_6_3.expired_timestamp or math.min(var_6_1, var_6_3.expired_timestamp)
			end
		end
	end

	return var_6_1
end

function GameListener:StopListen()
	manager.notify:RemoveListener(PLAYER_LEVEL_UP, handler(self, self.LevelUp))

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return GameListener
