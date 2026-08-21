local var_0_0 = class("UrShipRefetchWindow", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "UrShipReFetchWindow"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.shipTpl = arg_2_0._tf:Find("window/content/ships/itemtpl")
	arg_2_0.contentTxt = arg_2_0._tf:Find("window/content/Text"):GetComponent(typeof(Text))
	arg_2_0.cntTxt = arg_2_0._tf:Find("window/content/count"):GetComponent(typeof(Text))
	arg_2_0.confirmBtn = arg_2_0._tf:Find("window/confirm_btn")

	setText(arg_2_0._tf:Find("window/top/bg/infomation/title"), i18n("title_info"))
	setText(arg_2_0.confirmBtn:Find("pic"), i18n("word_take"))

	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	var_0_0.super.Show(arg_3_0)
	arg_3_0:UpdateUrShipAndContent(arg_3_1)
	arg_3_0:RegisterEvent(arg_3_1)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

local function var_0_1(arg_4_0)
	local var_4_0 = pg.ship_data_create_exchange[arg_4_0:getConfig("config_id")]

	return arg_4_0.data1, math.min(var_4_0.exchange_available_times, arg_4_0.data2 + 1) * var_4_0.exchange_request, var_4_0.exchange_ship_id[1]
end

local function var_0_2(arg_5_0)
	return arg_5_0.stopTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function var_0_0.UpdateUrShipAndContent(arg_6_0, arg_6_1)
	local var_6_0 = getProxy(ActivityProxy):getActivityById(arg_6_1)
	local var_6_1, var_6_2, var_6_3 = var_0_1(var_6_0)

	updateDrop(arg_6_0.shipTpl, {
		type = DROP_TYPE_SHIP,
		id = var_6_3
	})

	arg_6_0.contentTxt.text = i18n("urdraw_tip")

	arg_6_0:AddTimer(var_6_0, var_6_1, var_6_2)

	return
end

function var_0_0.AddTimer(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:RemoveTimer()

	arg_7_0.timer = Timer.New(function()
		arg_7_0:UpdateTimeTxt(var_0_2(arg_7_1), arg_7_2, arg_7_3)

		return
	end, 1, -1)

	arg_7_0.timer:Start()
	arg_7_0.timer.func()

	return
end

function var_0_0.UpdateTimeTxt(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 == 0 then
		pg.m02:sendNotification(MainUrShipReFetchSequence.ON_TIME_UP)

		return
	end

	local var_9_0, var_9_1, var_9_2, var_9_3 = pg.TimeMgr.GetInstance():parseTimeFrom(arg_9_1)
	local var_9_4 = var_9_0 == 0 and var_9_1 == 0 and var_9_2 == 0 and var_9_3 > 0 and var_9_3 .. i18n("word_second") or var_9_0 .. i18n("word_date") .. var_9_1 .. i18n("word_hour") .. var_9_2 .. i18n("word_minute")

	arg_9_0.cntTxt.text = i18n("urdraw_complement", arg_9_2 .. "/" .. arg_9_3, var_9_4)

	return
end

function var_0_0.RemoveTimer(arg_10_0)
	if arg_10_0.timer then
		arg_10_0.timer:Stop()

		arg_10_0.timer = nil
	end

	return
end

function var_0_0.RegisterEvent(arg_11_0, arg_11_1)
	onButton(arg_11_0, arg_11_0.confirmBtn, function()
		pg.m02:sendNotification(GAME.GRAFTING_ACT_OP, {
			cmd = 2,
			id = arg_11_1
		})

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.Hide(arg_13_0)
	var_0_0.super.Hide(arg_13_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_13_0._tf, arg_13_0._parentTf)
	removeOnButton(arg_13_0.confirmBtn)
	arg_13_0:RemoveTimer()

	return
end

function var_0_0.OnDestroy(arg_14_0)
	if arg_14_0:isShowing() then
		arg_14_0:Hide()
	end

	return
end

return var_0_0
