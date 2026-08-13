class = var_0_10000

local var_0_0 = var_0_10000("GuildEventTimerView")

function var_0_0.Flush(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.text = arg_1_1

	arg_1_0:RemoveEndEventTimer()

	if arg_1_2:GetLeftTime() < 0 then
		Timer = var_4
		arg_1_0.timer = var_4.New(function()
			local var_2_0 = arg_1_2
			local var_2_1 = var_0.GetLeftTime(var_2_0)
			local var_2_2 = arg_1_0
			local var_2_3 = var_1.UpdateText
			local var_2_4 = "<size=31><color=#FF3838>"

			pg = var_2_10005

			local var_2_5 = var_2_10005.TimeMgr.GetInstance()

			var_2_3(var_2_2, var_2_4 .. var_5.DescCDTime(var_2_5, var_2_1) .. "</color></size>")

			if var_2_1 <= 0 then
				local var_2_6 = arg_1_0

				var_1.OnOver(var_2_6)
			end

			return
		end, 1, -1)

		arg_1_0.timer.func()
	else
		pg = var_4

		local var_1_0 = var_4.TimeMgr.GetInstance()
		local var_1_1, var_1_2, var_1_3, var_1_4 = var_4.parseTimeFrom(var_1_0, var_3)

		assert = var_1_10008

		var_1_10008(var_1_1 > 0)

		if var_1_2 <= 0 and (0 < var_1_3 or 0 < var_1_4) then
			var_1_2 = var_1_2 + 1
		end

		string = var_8

		local var_1_5 = var_8.format
		local var_1_6 = "%s"

		i18n = var_1_10011

		local var_1_7 = var_1_10011("word_date")
		local var_1_8 = "%s"

		i18n = var_13

		local var_1_9 = var_1_5(var_1_6 .. var_1_7 .. var_1_8 .. var_13("word_hour"), var_1_1, var_1_2)

		if var_1_1 < 7 then
			var_1_9 = "<size=31><color=#FF3838>" .. var_1_9 .. "</color></size>"
		end

		local var_1_10 = arg_1_0

		arg_1_0.UpdateText(var_1_10, var_1_9)

		local var_1_11

		if var_1_3 * 60 + var_1_4 <= 0 then
			var_1_11 = 3600
		end

		math = var_10

		local var_1_12 = var_10.min(var_3 - 0, var_1_11)

		Timer = var_1_10
		arg_1_0.timer = var_1_10.New(function()
			local var_3_0 = arg_1_0

			var_0.Flush(var_3_0, arg_1_1, arg_1_2)

			return
		end, var_1_12 + 2, 1)
	end

	local var_1_13 = arg_1_0.timer

	var_4.Start(var_1_13)

	return
end

function var_0_0.UpdateText(arg_4_0, arg_4_1)
	arg_4_0.text.text = arg_4_1

	return
end

function var_0_0.RemoveEndEventTimer(arg_5_0)
	if arg_5_0.timer then
		local var_5_0 = arg_5_0.timer

		var_1.Stop(var_5_0)

		arg_5_0.timer = nil
	end

	return
end

function var_0_0.OnOver(arg_6_0)
	arg_6_0:RemoveEndEventTimer()

	pg = var_1

	local var_6_0 = var_1.m02
	local var_6_1 = var_1.sendNotification

	GAME = var_1_10004

	var_6_1(var_6_0, var_1_10004.GUILD_GET_ACTIVATION_EVENT, {
		force = true
	})

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveEndEventTimer()

	return
end

return var_0_0
