local var_0_0 = class("CourtYardBuffCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.timeTxt = arg_1_0._tf:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.icon = arg_1_0._tf:GetComponent(typeof(Image))

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1)
	arg_2_0.buff = arg_2_1
	arg_2_0.icon.sprite = LoadSprite(arg_2_1:getConfig("icon") .. "_backyard") or LoadSprite(arg_2_1:getConfig("icon"))

	arg_2_0:RemoveTimer()

	arg_2_0.using = true

	if arg_2_1:isActivate() then
		arg_2_0:StartTimer(arg_2_1)
	end

	return
end

function var_0_0.StartTimer(arg_3_0, arg_3_1)
	setActive(arg_3_0._tf, true)

	arg_3_0.timer = Timer.New(function()
		local var_4_0 = arg_3_1:getLeftTime()

		if var_4_0 > 0 then
			local var_4_1 = pg.TimeMgr.GetInstance():DescCDTime(var_4_0)

			arg_3_0.timeTxt.text = var_4_0 <= 600 and setColorStr(var_4_1, COLOR_RED) or setColorStr(var_4_1, "#FFFFFFFF")
		else
			arg_3_0:RemoveTimer()
		end

		return
	end, 1, -1)

	arg_3_0.timer:Start()
	arg_3_0.timer.func()

	return
end

function var_0_0.RemoveTimer(arg_5_0)
	arg_5_0.using = false

	setActive(arg_5_0._tf, false)

	if arg_5_0.timer then
		arg_5_0.timer:Stop()

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
