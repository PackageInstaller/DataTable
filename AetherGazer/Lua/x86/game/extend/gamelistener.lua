local var_0_0 = class("GameListener")
local var_0_1 = import("game.tools.SettingTools")
local var_0_2 = import("game.tools.LvTools")

function var_0_0.StartListen(arg_1_0)
	arg_1_0:AddEventListeners()
	arg_1_0:AddTaskListeners()
end

function var_0_0.AddEventListeners(arg_2_0)
	manager.notify:RegistListener(PLAYER_LEVEL_UP, handler(arg_2_0, arg_2_0.LevelUp))
end

function var_0_0.LevelUp(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = 0

	PlayerAction.ChangeLevel(arg_3_1, arg_3_2)
	NeedGameUserInfo()
	GameToSDK.UpUserInfo(PlayerTools.PackUserData("LevelUp"))
end

function var_0_0.AddTaskListeners(arg_4_0)
	local var_4_0 = arg_4_0:GetNextTime()

	if var_4_0 ~= 0 then
		if not arg_4_0.timer_ then
			arg_4_0.timer_ = Timer.New(function()
				if var_4_0 <= manager.time:GetServerTime() then
					TaskRedPoint:UpdatePassportTaskRedTip()

					var_4_0 = arg_4_0:GetNextTime()

					if var_4_0 <= 0 then
						arg_4_0.timer_:Stop()
					end
				end
			end, 1, -1)

			arg_4_0.timer_:Start()
		end
	elseif arg_4_0.timer_ then
		arg_4_0.timer_:Stop()
	end
end

function var_0_0.GetNextTime(arg_6_0)
	local var_6_0 = {
		TaskConst.TASK_TYPE.PASSPORT_DAILY,
		TaskConst.TASK_TYPE.PASSPORT_WEEKLY,
		TaskConst.TASK_TYPE.PASSPORT_CHALLENGE
	}
	local var_6_1 = manager.time:GetServerTime()
	local var_6_2 = 0
	local var_6_3 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_4 = TaskData2:GetTaskIDListByType(iter_6_1)

		for iter_6_2, iter_6_3 in ipairs(var_6_4) do
			local var_6_5 = TaskData2:GetTask(iter_6_2)

			if var_6_5.expired_timestamp > 0 and var_6_1 <= var_6_5.expired_timestamp then
				var_6_2 = var_6_2 == 0 and var_6_5.expired_timestamp or math.min(var_6_2, var_6_5.expired_timestamp)
			end
		end
	end

	return var_6_2
end

function var_0_0.StopListen(arg_7_0)
	manager.notify:RemoveListener(PLAYER_LEVEL_UP, handler(arg_7_0, arg_7_0.LevelUp))

	if arg_7_0.timer_ then
		arg_7_0.timer_:Stop()

		arg_7_0.timer_ = nil
	end
end

return var_0_0
