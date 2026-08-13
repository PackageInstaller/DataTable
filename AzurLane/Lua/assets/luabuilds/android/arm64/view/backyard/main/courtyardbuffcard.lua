class = var_0_10000

local var_0_0 = var_0_10000("CourtYardBuffCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "Text")
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.timeTxt = var_1_2(var_1_1, var_5(var_1_10007))

	local var_1_3 = arg_1_0._tf
	local var_1_4 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.icon = var_1_4(var_1_3, var_5(var_1_10007))

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1)
	arg_2_0.buff = arg_2_1

	local var_2_0 = arg_2_0.icon

	LoadSprite = var_1_10003

	local var_2_1

	if not var_1_10003(arg_2_1:getConfig("icon") .. "_backyard") then
		LoadSprite = var_2_1
		var_2_1 = var_2_1(arg_2_1:getConfig("icon"))
	end

	var_2_0.sprite = var_2_1

	arg_2_0:RemoveTimer()

	arg_2_0.using = true

	if arg_2_1:isActivate() then
		arg_2_0:StartTimer(arg_2_1)
	end

	return
end

function var_0_0.StartTimer(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0._tf, true)

	Timer = var_1_10002
	arg_3_0.timer = var_1_10002.New(function()
		local var_4_0 = arg_3_1
		local var_4_1 = var_0.getLeftTime(var_4_0)

		if 0 < var_4_1 then
			pg = var_1

			local var_4_2 = var_1.TimeMgr.GetInstance()
			local var_4_3 = var_1.DescCDTime(var_4_2, var_4_1)

			if var_4_1 <= 600 then
				setColorStr = var_4_5

				local var_4_4 = var_4_3

				COLOR_RED = var_2_10005

				local var_4_5

				if not var_4_5(var_4_4, var_2_10005) then
					setColorStr = var_4_5
					var_4_5 = var_4_5(var_4_3, "#FFFFFFFF")
				end

				arg_3_0.timeTxt.text = var_4_5

				if false then
					local var_4_6 = arg_3_0

					var_1.RemoveTimer(var_4_6)
				end

				return
			end
		end
	end, 1, -1)

	local var_3_0 = arg_3_0.timer

	var_2.Start(var_3_0)
	arg_3_0.timer.func()

	return
end

function var_0_0.RemoveTimer(arg_5_0)
	arg_5_0.using = false
	setActive = var_1

	var_1(arg_5_0._tf, false)

	if arg_5_0.timer then
		local var_5_0 = arg_5_0.timer

		var_1.Stop(var_5_0)

		arg_5_0.timer = nil
	end

	return
end

function var_0_0.IsUsing(arg_6_0)
	return arg_6_0.using
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveTimer()

	return
end

return var_0_0
