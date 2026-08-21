local var_0_0 = class("IslandTicketCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.bgTF = arg_1_0._tf:Find("bg")
	arg_1_0.frameTF = arg_1_0._tf:Find("icon_bg")
	arg_1_0.iconTF = arg_1_0._tf:Find("icon_bg/icon")
	arg_1_0.nameTF = arg_1_0._tf:Find("name")
	arg_1_0.countTF = arg_1_0._tf:Find("icon_bg/count/Text")
	arg_1_0.timePanel = arg_1_0._tf:Find("time_panel")
	arg_1_0.validTimeTF = arg_1_0.timePanel:Find("valid")
	arg_1_0.validTimeTxt = arg_1_0.validTimeTF:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.expiredTF = arg_1_0.timePanel:Find("expired")

	setText(arg_1_0.expiredTF:Find("Text"), i18n("island_ticket_expired"))

	arg_1_0.willExpireTF = arg_1_0.timePanel:Find("will_expire")
	arg_1_0.willExpireTxt = arg_1_0.willExpireTF:Find("Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.ticket = arg_2_1

	setText(arg_2_0.nameTF, arg_2_0.ticket:getConfig("name"))
	setText(arg_2_0.countTF, arg_2_0.ticket:GetCount())
	GetImageSpriteFromAtlasAsync("island/islandframe", arg_2_0.ticket:GetFrameName(), arg_2_0.frameTF, true)
	GetImageSpriteFromAtlasAsync("ui/islandticketui_atlas", arg_2_0.ticket:GetBgName(), arg_2_0.bgTF, true)
	GetImageSpriteFromAtlasAsync(arg_2_0.ticket:GetIconName(), "", arg_2_0.iconTF, true)

	local var_2_0 = arg_2_0.ticket:IsForever()

	setActive(arg_2_0.timePanel, not var_2_0)
	arg_2_0:UpdateTimer()
	arg_2_0:StopTimer()

	if not var_2_0 then
		arg_2_0:StartTimer()
	end

	return
end

function var_0_0.StartTimer(arg_3_0)
	arg_3_0.timer = Timer.New(function()
		arg_3_0:UpdateTimer()

		return
	end, 1, -1)

	arg_3_0.timer:Start()

	return
end

function var_0_0.UpdateTimer(arg_5_0)
	local var_5_0 = arg_5_0.ticket:IsExpired()

	setActive(arg_5_0.expiredTF, var_5_0)
	setActive(arg_5_0.validTimeTF, not var_5_0)

	if not var_5_0 then
		local var_5_1 = arg_5_0.ticket:GetRemainTime()
		local var_5_2 = math.floor(var_5_1 / 0)

		if var_5_2 >= 1 then
			arg_5_0.validTimeTxt.text = i18n("island_ticket_expired_day", var_5_2)
		else
			local var_5_3 = arg_5_0.validTimeTxt

			var_5_3.text = pg.TimeMgr.GetInstance():DescCDTime(var_5_1)
		end
	end

	return
end

function var_0_0.StopTimer(arg_6_0)
	if arg_6_0.timer then
		arg_6_0.timer:Stop()

		arg_6_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:StopTimer()

	return
end

return var_0_0
