class = var_0_10000

local var_0_0 = "IslandAgoraUpgradeMsgboxWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandCommonMsgboxEXWindow"))

function var_0_1.OnLoaded(arg_1_0)
	var_0_1.super.OnLoaded(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.Find(var_1_0, "cancel/Text")

	i18n = var_1_10004

	var_1(var_1_1, var_1_10004("island_label_furniture_exit"))

	setText = var_1

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_3.Find(var_1_2, "confirm/Text")

	i18n = var_4

	var_1(var_1_3, var_4("island_label_furniture_save"))

	return
end

function var_0_1.OnShow(arg_2_0)
	var_0_1.super.OnShow(arg_2_0)

	local var_2_0 = arg_2_0.settings

	arg_2_0:AddTimer(var_2_0.duetime)

	return
end

function var_0_1.AddTimer(arg_3_0, arg_3_1)
	arg_3_0:RemoveTimer()

	pg = var_2

	local var_3_0 = var_2.TimeMgr.GetInstance()

	if arg_3_1 - var_2.GetServerTime(var_3_0) <= 0 then
		arg_3_0:Hide()

		return
	end

	Timer = var_3
	arg_3_0.timer = var_3.New(function()
		pg = var_2_10000

		local var_4_0 = var_2_10000.TimeMgr.GetInstance()
		local var_4_1 = var_0.GetServerTime(var_4_0)

		if arg_3_1 - var_4_1 <= 0 then
			local var_4_2 = arg_3_0

			var_2.RemoveTimer(var_4_2)

			local var_4_3 = arg_3_0

			var_2.Hide(var_4_3)
		else
			local var_4_4 = arg_3_0.contentTxt

			i18n = var_2_10003

			local var_4_5 = "island_label_furniture_save_tip"

			pg = var_2_10006

			local var_4_6 = var_2_10006.TimeMgr.GetInstance()

			var_4_4.text = var_2_10003(var_4_5, var_6.DescCDTime(var_4_6, arg_3_1 - var_4_1))
		end

		return
	end, 1, -1)

	local var_3_1 = arg_3_0.timer

	var_3.Start(var_3_1)
	arg_3_0.timer.func()

	return
end

function var_0_1.RemoveTimer(arg_5_0)
	if arg_5_0.timer then
		local var_5_0 = arg_5_0.timer

		var_1.Stop(var_5_0)

		arg_5_0.timer = nil
	end

	return
end

function var_0_1.OnHide(arg_6_0)
	var_0_1.super.OnHide(arg_6_0)
	arg_6_0:RemoveTimer()

	return
end

function var_0_1.FlushBtn(arg_7_0, arg_7_1)
	return
end

function var_0_1.OnDestroy(arg_8_0)
	arg_8_0:RemoveTimer()

	return
end

return var_0_1
