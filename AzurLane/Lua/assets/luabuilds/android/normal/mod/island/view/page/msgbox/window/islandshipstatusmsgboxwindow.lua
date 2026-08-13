class = var_0_10000

local var_0_0 = "IslandShipStatusMsgboxWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShipStatusMsgboxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.buffDesc = var_2_2(var_2_1, var_3(var_1_10004))

	return
end

function var_0_1.OnShow(arg_3_0)
	var_0_1.super.OnShow(arg_3_0)
	arg_3_0:FlushBuff()

	return
end

function var_0_1.FlushBuff(arg_4_0)
	if not arg_4_0.settings.buff then
		return
	end

	arg_4_0.buffDesc.text = ""

	arg_4_0:AddTimer(var_1)

	return
end

function var_0_1.AddTimer(arg_5_0, arg_5_1)
	arg_5_0:RemoveTimer()

	if arg_5_1:GetEndTime() <= 0 then
		return
	end

	Timer = var_3
	arg_5_0.timer = var_3.New(function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.TimeMgr.GetInstance()
		local var_6_1 = var_0.GetServerTime(var_6_0)
		local var_6_3

		if var_0 - var_6_1 <= 0 then
			local var_6_2 = arg_5_0

			var_6_3.RemoveTimer(var_6_2)

			var_6_3 = arg_5_0.buffDesc
			var_6_3.text = ""
		else
			pg = var_6_3

			local var_6_4 = var_6_3.TimeMgr.GetInstance()
			local var_6_5 = var_2.DescCDTime(var_6_4, var_1)
			local var_6_6 = arg_5_0.buffDesc
			local var_6_7 = arg_5_1

			var_6_6.text = var_4.GetName(var_6_7) .. ":" .. var_6_5
		end

		return
	end, 1, -1)

	local var_5_0 = arg_5_0.timer

	var_3.Start(var_5_0)
	arg_5_0.timer.func()

	return
end

function var_0_1.RemoveTimer(arg_7_0)
	if arg_7_0.timer then
		local var_7_0 = arg_7_0.timer

		var_1.Stop(var_7_0)

		arg_7_0.timer = nil
	end

	return
end

function var_0_1.OnHide(arg_8_0)
	var_0_1.super.OnHide(arg_8_0)
	arg_8_0:RemoveTimer()

	return
end

return var_0_1
