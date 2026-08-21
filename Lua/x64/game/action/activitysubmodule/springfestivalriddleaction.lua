local var_0_0 = {}

manager.net:Bind(64061, function(arg_1_0)
	SpringFestivalRiddleData:InitData(arg_1_0)
	var_0_0.InitRedPoint(arg_1_0.activity_id)
end)

function var_0_0.ChoiceAnswer(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	manager.net:SendWithLoadingNew(64062, {
		activity_id = arg_2_0,
		quiz_id = arg_2_1,
		answer = arg_2_2
	}, 64063, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			-- block empty
		end

		arg_2_3(arg_3_0)
	end)
end

local var_0_1

function var_0_0.InitRedPoint(arg_4_0)
	local var_4_0 = ActivityData:GetActivityIsOpen(arg_4_0)

	var_0_0.StopTimer()

	if var_4_0 then
		local var_4_1 = SpringFestivalRiddleData:GetLastAnswerTime(arg_4_0)
		local var_4_2 = var_4_1 + GameSetting.activity_spring_festival_riddle_punish_time.value[1] * 60
		local var_4_3 = GameSetting.refresh_time1.value[1][1]
		local var_4_4 = manager.time:GetNextTime(var_4_3, 0, 0)

		if SpringFestivalRiddleData:CanAnswer(arg_4_0) then
			local var_4_5 = manager.time:GetServerTime()

			if ActivityData:GetActivityIsOpen(arg_4_0) and (var_4_2 <= var_4_5 or var_4_4 - var_4_1 > 86400) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, arg_4_0), 1)

				return
			end

			var_0_1 = Timer.New(function()
				var_4_4 = manager.time:GetNextTime(var_4_3, 0, 0)

				if ActivityData:GetActivityIsOpen(arg_4_0) and (var_4_2 <= manager.time:GetServerTime() or var_4_4 - var_4_1 > 86400) then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, arg_4_0), 1)
					var_0_0.StopTimer()

					return
				end
			end, 1, -1)

			var_0_1:Start()
		else
			var_0_1 = Timer.New(function()
				var_4_4 = manager.time:GetNextTime(var_4_3, 0, 0)

				if ActivityData:GetActivityIsOpen(arg_4_0) and var_4_4 - var_4_1 > 86400 then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, arg_4_0), 1)
					var_0_0.StopTimer()

					return
				end
			end, 1, -1)

			var_0_1:Start()
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, arg_4_0), 0)
end

function var_0_0.HideRedPoint(arg_7_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, arg_7_0), 0)
end

function var_0_0.RefreshRedPoint(arg_8_0)
	var_0_0.InitRedPoint(arg_8_0)
end

function var_0_0.StopTimer()
	if var_0_1 then
		var_0_1:Stop()

		var_0_1 = nil
	end
end

function var_0_0.Dispose()
	var_0_0.StopTimer()
end

return var_0_0
