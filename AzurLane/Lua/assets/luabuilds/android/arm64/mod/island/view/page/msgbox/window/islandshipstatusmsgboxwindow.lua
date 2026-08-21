local var_0_0 = class("IslandShipStatusMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShipStatusMsgboxUI"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.buffDesc = arg_2_0._tf:Find("Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.OnShow(arg_3_0)
	var_0_0.super.OnShow(arg_3_0)
	arg_3_0:FlushBuff()

	return
end

function var_0_0.FlushBuff(arg_4_0)
	if not arg_4_0.settings.buff then
		return
	end

	arg_4_0.buffDesc.text = ""

	arg_4_0:AddTimer(arg_4_0.settings.buff)

	return
end

function var_0_0.AddTimer(arg_5_0, arg_5_1)
	arg_5_0:RemoveTimer()

	if arg_5_1:GetEndTime() <= 0 then
		return
	end

	arg_5_0.timer = Timer.New(function()
		local var_6_0 = var_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_6_0 <= 0 then
			arg_5_0:RemoveTimer()

			arg_5_0.buffDesc.text = ""
		else
			local var_6_1 = pg.TimeMgr.GetInstance()

			arg_5_0.buffDesc.text = arg_5_1:GetName() .. ":" .. var_6_1:DescCDTime(var_6_0)
		end

		return
	end, 1, -1)

	arg_5_0.timer:Start()
	arg_5_0.timer.func()

	return
end

function var_0_0.RemoveTimer(arg_7_0)
	if arg_7_0.timer then
		arg_7_0.timer:Stop()

		arg_7_0.timer = nil
	end

	return
end

function var_0_0.OnHide(arg_8_0)
	var_0_0.super.OnHide(arg_8_0)
	arg_8_0:RemoveTimer()

	return
end

return var_0_0
