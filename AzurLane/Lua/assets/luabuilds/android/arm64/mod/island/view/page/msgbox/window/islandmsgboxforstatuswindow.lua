class = var_0_10000

local var_0_0 = "IslandMsgBoxForStatusWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForStatus"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	UIItemList = var_1

	local var_2_0 = var_1.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "scrollrect/list")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_0(var_2_2, var_4.Find(var_2_3, "scrollrect/list/tpl"))
	arg_2_0.timers = {}

	return
end

function var_0_1.OnShow(arg_3_0)
	var_0_1.super.OnShow(arg_3_0)
	arg_3_0:FlushItems(arg_3_0.settings)

	return
end

function var_0_1.FlushBtn(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0.cancelBtn, false)

	return
end

function var_0_1.FlushItems(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.statusList

	assert = var_1_10003

	var_1_10003(var_5_0)

	local var_5_1 = arg_5_0.uiItemList

	var_3.make(var_5_1, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = var_5_0[arg_6_1 + 1]
			local var_6_1 = "#303a3c"

			if var_6_0:IsRed() then
				var_6_1 = "#ff7e7e"
			elseif var_6_0:IsBlue() then
				var_6_1 = "#5dcbff"
			end

			setText = var_5

			local var_6_2 = arg_6_2:Find("label/Text")

			setColorStr = var_2_10008

			var_5(var_6_2, var_2_10008(var_6_0:GetName(), var_6_1))

			setText = var_5

			var_5(arg_6_2:Find("Text"), var_6_0:GetDesc())

			local var_6_3 = arg_5_0

			var_5.AddTimer(var_6_3, var_6_0:GetEndTime(), arg_6_2:Find("time/Text"), var_6_0.id)
		end

		return
	end)

	local var_5_2 = arg_5_0.uiItemList

	var_3.align(var_5_2, #var_5_0)

	return
end

function var_0_1.AddTimer(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:RemoveTimer(arg_7_3)

	pg = var_4

	local var_7_0 = var_4.TimeMgr.GetInstance()

	if arg_7_1 - var_4.GetServerTime(var_7_0) <= 0 then
		setText = var_5

		local var_7_1 = arg_7_2

		i18n = var_1_10008

		local var_7_2 = "island_buff_lasttime"

		pg = var_1_10011

		local var_7_3 = var_1_10011.TimeMgr.GetInstance()

		var_5(var_7_1, var_1_10008(var_7_2, var_11.DescCDTime(var_7_3, 0)))

		return
	end

	local var_7_4 = arg_7_0.timers

	Timer = var_7_0
	var_7_4[arg_7_3] = var_7_0.New(function()
		local var_8_0 = arg_7_1

		pg = var_2_10001

		local var_8_1 = var_2_10001.TimeMgr.GetInstance()
		local var_8_2 = var_8_0 - var_1.GetServerTime(var_8_1)

		if 0 < var_8_2 then
			setText = var_1

			local var_8_3 = arg_7_2

			i18n = var_2_10004

			local var_8_4 = "island_buff_lasttime"

			pg = var_2_10007

			local var_8_5 = var_2_10007.TimeMgr.GetInstance()

			var_1(var_8_3, var_2_10004(var_8_4, var_2_10007.DescCDTime(var_8_5, var_8_2)))
		else
			local var_8_6 = arg_7_0

			var_1.RemoveTimer(var_8_6, arg_7_3)

			setText = var_1

			local var_8_7 = arg_7_2

			i18n = var_4

			local var_8_8 = "island_buff_lasttime"

			pg = var_2_10007

			local var_8_9 = var_2_10007.TimeMgr.GetInstance()

			var_1(var_8_7, var_4(var_8_8, var_7.DescCDTime(var_8_9, 0)))
		end

		return
	end, 1, -1)

	local var_7_5 = arg_7_0.timers[arg_7_3]

	var_5.Start(var_7_5)
	arg_7_0.timers[arg_7_3].func()

	return
end

function var_0_1.RemoveTimer(arg_9_0, arg_9_1)
	if arg_9_0.timers[arg_9_1] then
		local var_9_0 = arg_9_0.timers[arg_9_1]

		var_2.Stop(var_9_0)

		arg_9_0.timers[arg_9_1] = nil
	end

	return
end

function var_0_1.RemoveTimers(arg_10_0)
	pairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0.timers) do
		iter_10_1:Stop()
	end

	arg_10_0.timers = {}

	return
end

function var_0_1.OnHide(arg_11_0)
	var_0_1.super.OnHide(arg_11_0)
	arg_11_0:RemoveTimers()

	return
end

function var_0_1.OnDestroy(arg_12_0)
	arg_12_0:RemoveTimers()

	return
end

return var_0_1
