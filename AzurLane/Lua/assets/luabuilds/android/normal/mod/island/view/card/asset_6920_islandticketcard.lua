class = var_0_10000

local var_0_0 = var_0_10000("IslandTicketCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.bgTF = var_2.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0._tf

	arg_1_0.frameTF = var_2.Find(var_1_1, "icon_bg")

	local var_1_2 = arg_1_0._tf

	arg_1_0.iconTF = var_2.Find(var_1_2, "icon_bg/icon")

	local var_1_3 = arg_1_0._tf

	arg_1_0.nameTF = var_2.Find(var_1_3, "name")

	local var_1_4 = arg_1_0._tf

	arg_1_0.countTF = var_2.Find(var_1_4, "icon_bg/count/Text")

	local var_1_5 = arg_1_0._tf

	arg_1_0.timePanel = var_2.Find(var_1_5, "time_panel")

	local var_1_6 = arg_1_0.timePanel

	arg_1_0.validTimeTF = var_2.Find(var_1_6, "valid")

	local var_1_7 = arg_1_0.validTimeTF
	local var_1_8 = var_2.Find(var_1_7, "Text")
	local var_1_9 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.validTimeTxt = var_1_9(var_1_8, var_4(var_1_10005))

	local var_1_10 = arg_1_0.timePanel

	arg_1_0.expiredTF = var_2.Find(var_1_10, "expired")
	setText = var_2

	local var_1_11 = arg_1_0.expiredTF
	local var_1_12 = var_3.Find(var_1_11, "Text")

	i18n = var_1_11

	var_2(var_1_12, var_1_11("island_ticket_expired"))

	local var_1_13 = arg_1_0.timePanel

	arg_1_0.willExpireTF = var_2.Find(var_1_13, "will_expire")

	local var_1_14 = arg_1_0.willExpireTF
	local var_1_15 = var_2.Find(var_1_14, "Text")
	local var_1_16 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_1_0.willExpireTxt = var_1_16(var_1_15, var_4(var_5))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.ticket = arg_2_1
	setText = var_1_10002

	local var_2_0 = arg_2_0.nameTF
	local var_2_1 = arg_2_0.ticket

	var_1_10002(var_2_0, var_4.getConfig(var_2_1, "name"))

	setText = var_1_10002

	local var_2_2 = arg_2_0.countTF
	local var_2_3 = arg_2_0.ticket

	var_1_10002(var_2_2, var_4.GetCount(var_2_3))

	GetImageSpriteFromAtlasAsync = var_1_10002

	local var_2_4 = "island/islandframe"
	local var_2_5 = arg_2_0.ticket

	var_1_10002(var_2_4, var_4.GetFrameName(var_2_5), arg_2_0.frameTF, true)

	GetImageSpriteFromAtlasAsync = var_1_10002

	local var_2_6 = "ui/islandticketui_atlas"
	local var_2_7 = arg_2_0.ticket

	var_1_10002(var_2_6, var_4.GetBgName(var_2_7), arg_2_0.bgTF, true)

	GetImageSpriteFromAtlasAsync = var_1_10002

	local var_2_8 = arg_2_0.ticket

	var_1_10002(var_3.GetIconName(var_2_8), "", arg_2_0.iconTF, true)

	local var_2_9 = arg_2_0.ticket
	local var_2_10 = var_2.IsForever(var_2_9)

	setActive = var_2_9

	var_2_9(arg_2_0.timePanel, not var_2_10)
	arg_2_0:UpdateTimer()
	arg_2_0:StopTimer()

	if not var_2_10 then
		arg_2_0:StartTimer()
	end

	return
end

function var_0_0.StartTimer(arg_3_0)
	Timer = var_1_10001
	arg_3_0.timer = var_1_10001.New(function()
		local var_4_0 = arg_3_0

		var_0.UpdateTimer(var_4_0)

		return
	end, 1, -1)

	local var_3_0 = arg_3_0.timer

	var_1.Start(var_3_0)

	return
end

function var_0_0.UpdateTimer(arg_5_0)
	local var_5_0 = arg_5_0.ticket
	local var_5_1 = var_1.IsExpired(var_5_0)

	setActive = var_5_0

	var_5_0(arg_5_0.expiredTF, var_5_1)

	setActive = var_5_0

	var_5_0(arg_5_0.validTimeTF, not var_5_1)

	if not var_5_1 then
		local var_5_2 = arg_5_0.ticket
		local var_5_3 = var_2.GetRemainTime(var_5_2)

		math = var_5_2

		if var_5_2.floor(var_5_3 / 0) >= 1 then
			local var_5_4 = arg_5_0.validTimeTxt

			i18n = var_1_10005
			var_5_4.text = var_1_10005("island_ticket_expired_day", var_3)
		else
			local var_5_5 = arg_5_0.validTimeTxt

			pg = var_1_10005

			local var_5_6 = var_1_10005.TimeMgr.GetInstance()

			var_5_5.text = var_5.DescCDTime(var_5_6, var_5_3)
		end
	end

	return
end

function var_0_0.StopTimer(arg_6_0)
	if arg_6_0.timer then
		local var_6_0 = arg_6_0.timer

		var_1.Stop(var_6_0)

		arg_6_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:StopTimer()

	return
end

return var_0_0
