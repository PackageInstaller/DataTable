class = var_0_10000

local var_0_0 = "UrShipRefetchWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "UrShipReFetchWindow"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.shipTpl = var_1.Find(var_2_0, "window/content/ships/itemtpl")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "window/content/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.contentTxt = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "window/content/count")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.cntTxt = var_2_6(var_2_5, var_4(var_1_10006))

	local var_2_7 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_7, "window/confirm_btn")
	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_3.Find(var_2_8, "window/top/bg/infomation/title")

	i18n = var_4

	var_1(var_2_9, var_4("title_info"))

	setText = var_1

	local var_2_10 = arg_2_0.confirmBtn
	local var_2_11 = var_3.Find(var_2_10, "pic")

	i18n = var_4

	var_1(var_2_11, var_4("word_take"))

	return
end

function var_0_1.Show(arg_3_0, arg_3_1)
	var_0_1.super.Show(arg_3_0)
	arg_3_0:UpdateUrShipAndContent(arg_3_1)
	arg_3_0:RegisterEvent(arg_3_1)

	pg = var_2

	local var_3_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

local function var_0_2(arg_4_0)
	local var_4_0 = arg_4_0:getConfig("config_id")

	pg = var_1_10002

	local var_4_1 = var_1_10002.ship_data_create_exchange[var_4_0].exchange_request
	local var_4_2 = var_2.exchange_available_times
	local var_4_3 = var_2.exchange_ship_id[1]
	local var_4_4 = arg_4_0.data1
	local var_4_5 = arg_4_0.data2

	math = var_1_10008

	local var_4_6 = var_1_10008.min(var_4_2, var_4_5 + 1) * var_4_1

	return var_4_4, var_4_6, var_4_3
end

local function var_0_3(arg_5_0)
	local var_5_0 = arg_5_0.stopTime

	pg = var_1_10002

	local var_5_1 = var_1_10002.TimeMgr.GetInstance()

	return var_5_0 - var_2.GetServerTime(var_5_1)
end

function var_0_1.UpdateUrShipAndContent(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_6_0 = var_1_10002(var_1_10004)
	local var_6_1 = var_2.getActivityById(var_6_0, arg_6_1)
	local var_6_2, var_6_3, var_6_4 = var_0_2(var_6_1)

	updateDrop = var_1_10007

	local var_6_5 = arg_6_0.shipTpl
	local var_6_6 = {}

	DROP_TYPE_SHIP = var_1_10011
	var_6_6.type = var_1_10011
	var_6_6.id = var_6_4

	var_1_10007(var_6_5, var_6_6)

	local var_6_7 = arg_6_0.contentTxt

	i18n = var_1_10008
	var_6_7.text = var_1_10008("urdraw_tip")

	arg_6_0:AddTimer(var_6_1, var_6_2, var_6_3)

	return
end

function var_0_1.AddTimer(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:RemoveTimer()

	Timer = var_4
	arg_7_0.timer = var_4.New(function()
		local var_8_0 = var_0_3(arg_7_1)
		local var_8_1 = arg_7_0

		var_1.UpdateTimeTxt(var_8_1, var_8_0, arg_7_2, arg_7_3)

		return
	end, 1, -1)

	local var_7_0 = arg_7_0.timer

	var_4.Start(var_7_0)
	arg_7_0.timer.func()

	return
end

function var_0_1.UpdateTimeTxt(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 == 0 then
		pg = var_1_10004

		local var_9_0 = var_1_10004.m02

		var_1_10004 = var_1_10004.sendNotification
		MainUrShipReFetchSequence = var_1_10007

		var_1_10004(var_9_0, var_1_10007.ON_TIME_UP)

		return
	end

	pg = var_1_10004

	local var_9_1 = var_1_10004.TimeMgr.GetInstance()
	local var_9_2, var_9_3, var_9_4, var_9_5 = var_4.parseTimeFrom(var_9_1, arg_9_1)

	if var_9_2 == 0 and var_9_3 == 0 and var_9_4 == 0 and 0 < var_9_5 then
		var_1_10008 = var_9_5
		i18n = var_1_10009

		if not (var_1_10008 .. var_1_10009("word_second")) then
			var_1_10008 = var_9_2
			i18n = var_1_10009

			local var_9_6 = var_1_10009("word_date")

			var_1_10010 = var_9_3
			i18n = var_11

			local var_9_7 = var_11("word_hour")
			local var_9_8 = var_9_4

			i18n = var_13
			var_1_10008 = var_1_10008 .. var_9_6 .. var_1_10010 .. var_9_7 .. var_9_8 .. var_13("word_minute")
		end

		local var_9_9 = arg_9_0.cntTxt

		i18n = var_1_10010
		var_9_9.text = var_1_10010("urdraw_complement", arg_9_2 .. "/" .. arg_9_3, var_1_10008)

		return
	end
end

function var_0_1.RemoveTimer(arg_10_0)
	if arg_10_0.timer then
		local var_10_0 = arg_10_0.timer

		var_1.Stop(var_10_0)

		arg_10_0.timer = nil
	end

	return
end

function var_0_1.RegisterEvent(arg_11_0, arg_11_1)
	onButton = var_1_10002

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.confirmBtn

	local function var_11_2()
		pg = var_2_10000

		local var_12_0 = var_2_10000.m02
		local var_12_1 = var_0.sendNotification

		GAME = var_2_10003

		var_12_1(var_12_0, var_2_10003.GRAFTING_ACT_OP, {
			cmd = 2,
			id = arg_11_1
		})

		return
	end

	SFX_CONFIRM = var_1_10007

	var_1_10002(var_11_0, var_11_1, var_11_2, var_1_10007)

	return
end

function var_0_1.Hide(arg_13_0)
	var_0_1.super.Hide(arg_13_0)

	pg = var_1

	local var_13_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0._tf, arg_13_0._parentTf)

	removeOnButton = var_1

	var_1(arg_13_0.confirmBtn)
	arg_13_0:RemoveTimer()

	return
end

function var_0_1.OnDestroy(arg_14_0)
	if arg_14_0:isShowing() then
		arg_14_0:Hide()
	end

	return
end

return var_0_1
