class = var_0_10000

local var_0_0 = "JPSkirmishHeadFrameRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.FrameReTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_1, "GoBtn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_2, "GetBtn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_3, "GotBtn")

	local var_1_4 = arg_1_0.bg

	arg_1_0.bar = var_1.Find(var_1_4, "Progress")

	local var_1_5 = arg_1_0.bg

	arg_1_0.progress = var_1.Find(var_1_5, "ProgressText")

	local var_1_6 = arg_1_0.bg

	arg_1_0.frameGot = var_1.Find(var_1_6, "GotTag")

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity.data1

	var_2_0 = arg_2_0.avatarConfig.target < var_2_0 and var_2 or var_2_0

	local var_2_1 = var_2_0 / var_2

	setText = var_1_10004

	local var_2_2 = arg_2_0.progress

	if 1 <= var_2_1 then
		setColorStr = var_6

		local var_2_3 = var_2_0

		COLOR_GREEN = var_1_10008

		local var_2_4

		if not var_6(var_2_3, var_1_10008) then
			var_2_4 = var_2_0
		end

		var_1_10004(var_2_2, var_2_4 .. "/" .. var_2)

		setSlider = var_1_10004

		var_1_10004(arg_2_0.bar, 0, 1, var_2_1)

		local var_2_5 = var_2 <= var_2_0
		local var_2_6 = arg_2_0.activity.data2 >= 1
		local var_2_8

		if arg_2_0.avatarConfig.start_time == "stop" then
			arg_2_0.inTime = false
		else
			pg = var_2_8

			local var_2_7 = var_2_8.TimeMgr.GetInstance()

			var_2_8 = var_2_8.Table2ServerTime(var_2_7, {
				year = var_6[1][1],
				month = var_6[1][2],
				day = var_6[1][3],
				hour = var_6[2][1],
				min = var_6[2][2],
				sec = var_6[2][3]
			})
			pg = var_2_7

			local var_2_9 = var_2_7.TimeMgr.GetInstance()

			arg_2_0.inTime = var_8.GetServerTime(var_2_9) - var_2_8 > 0
		end

		setActive = var_2_8

		var_2_8(arg_2_0.battleBtn, arg_2_0.inTime and not var_2_5 or false)

		setActive = var_2_8

		var_2_8(arg_2_0.getBtn, not var_2_6 and var_2_5)

		setActive = var_2_8

		var_2_8(arg_2_0.gotBtn, var_2_6)

		setActive = var_2_8

		var_2_8(arg_2_0.frameGot, var_2_6)

		return
	end
end

return var_0_1
