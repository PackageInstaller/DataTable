local var_0_0 = class("IslandMsgBoxForStatusWindow", import(".IslandCommonMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForStatus"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.uiItemList = UIItemList.New(arg_2_0._tf:Find("scrollrect/list"), arg_2_0._tf:Find("scrollrect/list/tpl"))
	arg_2_0.timers = {}

	return
end

function var_0_0.OnShow(arg_3_0)
	var_0_0.super.OnShow(arg_3_0)
	arg_3_0:FlushItems(arg_3_0.settings)

	return
end

function var_0_0.FlushBtn(arg_4_0, arg_4_1)
	setActive(arg_4_0.cancelBtn, false)

	return
end

function var_0_0.FlushItems(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.statusList

	assert(arg_5_1.statusList)
	arg_5_0.uiItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = var_5_0[arg_6_1 + 1]
			local var_6_1 = "#303a3c"

			if var_5_0[arg_6_1 + 1]:IsRed() then
				var_6_1 = "#ff7e7e"
			elseif var_6_0:IsBlue() then
				var_6_1 = "#5dcbff"
			end

			setText(arg_6_2:Find("label/Text"), setColorStr(var_6_0:GetName(), var_6_1))
			setText(arg_6_2:Find("Text"), var_6_0:GetDesc())
			arg_5_0:AddTimer(var_6_0:GetEndTime(), arg_6_2:Find("time/Text"), var_6_0.id)
		end

		return
	end)
	arg_5_0.uiItemList:align(#arg_5_1.statusList)

	return
end

function var_0_0.AddTimer(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:RemoveTimer(arg_7_3)

	if arg_7_1 - pg.TimeMgr.GetInstance():GetServerTime() <= 0 then
		setText(arg_7_2, i18n("island_buff_lasttime", pg.TimeMgr.GetInstance():DescCDTime(0)))

		return
	end

	arg_7_0.timers[arg_7_3] = Timer.New(function()
		local var_8_0 = arg_7_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_8_0 > 0 then
			setText(arg_7_2, i18n("island_buff_lasttime", pg.TimeMgr.GetInstance():DescCDTime(var_8_0)))
		else
			arg_7_0:RemoveTimer(arg_7_3)
			setText(arg_7_2, i18n("island_buff_lasttime", pg.TimeMgr.GetInstance():DescCDTime(0)))
		end

		return
	end, 1, -1)

	arg_7_0.timers[arg_7_3]:Start()
	arg_7_0.timers[arg_7_3].func()

	return
end

function var_0_0.RemoveTimer(arg_9_0, arg_9_1)
	if arg_9_0.timers[arg_9_1] then
		arg_9_0.timers[arg_9_1]:Stop()

		arg_9_0.timers[arg_9_1] = nil
	end

	return
end

function var_0_0.RemoveTimers(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.timers) do
		iter_10_1:Stop()
	end

	arg_10_0.timers = {}

	return
end

function var_0_0.OnHide(arg_11_0)
	var_0_0.super.OnHide(arg_11_0)
	arg_11_0:RemoveTimers()

	return
end

function var_0_0.OnDestroy(arg_12_0)
	arg_12_0:RemoveTimers()

	return
end

return var_0_0
