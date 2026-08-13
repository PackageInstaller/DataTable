class = var_0_10000

local var_0_0 = "IslandShipOrderLoadUpPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShipOrderLoadUpUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.mainTr = var_1.Find(var_2_0, "main")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "main/name/count")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.cntTxt = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf

	arg_2_0.submitBtn = var_1.Find(var_2_4, "main/btn/btn_1")

	local var_2_5 = arg_2_0._tf

	arg_2_0.noResBtn = var_1.Find(var_2_5, "main/btn/btn_2")

	local var_2_6 = arg_2_0._tf

	arg_2_0.disableBtn = var_1.Find(var_2_6, "main/btn/btn_3")

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "main/price/Text")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.awardCntTxt = var_2_9(var_2_8, var_3(var_1_10004))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "main/name")
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_12(var_2_11, var_3(var_1_10004))
	setText = var_1

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_2.Find(var_2_13, "main/title/Text")

	i18n = var_2_13

	var_1(var_2_14, var_2_13("island_order_ship_loadup_award"))

	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_2.Find(var_2_15, "main/btn/btn_2/Text")

	i18n = var_2_15

	var_1(var_2_16, var_2_15("island_order_ship_loadup_nores"))

	setText = var_1

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_2.Find(var_2_17, "main/btn/btn_1/Text")

	i18n = var_2_17

	var_1(var_2_18, var_2_17("island_order_ship_loadup"))

	setText = var_1

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_2.Find(var_2_19, "main/btn/btn_3/Text")

	i18n = var_2_19

	var_1(var_2_20, var_2_19("island_order_ship_finish_cnt_not_enough"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		IslandShipOrderPage = var_2_10002

		var_4_1(var_4_0, var_2_10002.EVENT_CLOSE_LOAD_UP)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.submitBtn

	local function var_3_5()
		if not arg_3_0.slot or not arg_3_0.index then
			return
		end

		local var_5_0 = arg_3_0.slot

		if not var_0.CanTransport(var_5_0) then
			return
		end

		local var_5_1 = arg_3_0
		local var_5_2 = var_0.emit

		IslandMediator = var_2_10002

		var_5_2(var_5_1, var_2_10002.SUBMIT_SHIP_ORDER_ITME, arg_3_0.slot.id, arg_3_0.index)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	var_0_1.super.Show(arg_6_0)

	arg_6_0.slot = arg_6_2
	arg_6_0.index = arg_6_3
	arg_6_0.mainTr.localPosition = arg_6_1

	local var_6_0 = arg_6_2:GetOrder()
	local var_6_1 = var_4.GetComsume(var_6_0, arg_6_3)

	Drop = var_6_0

	local var_6_2 = var_6_0.New(var_6_1)
	local var_6_3 = var_5.getOwnedCount(var_6_2)
	local var_6_4 = var_5.count <= var_6_3 and "#39beff" or "#f36c6e"
	local var_6_5 = arg_6_0.cntTxt

	setColorStr = var_1_10011
	var_6_5.text = var_1_10011(var_6_3 .. "/" .. var_7, var_6_4)
	arg_6_0.nameTxt.text = var_5:getName()

	local var_6_6 = arg_6_0.awardCntTxt
	local var_6_7 = "X"
	local var_6_8 = arg_6_2:GetOrder()

	var_6_6.text = var_6_7 .. var_12.GetConsumeAwards(var_6_8, arg_6_3)[1].count

	local var_6_9 = arg_6_0.slot
	local var_6_10 = var_10.CanTransport(var_6_9)

	setActive = var_6_9

	var_6_9(arg_6_0.submitBtn, var_8 and var_6_10)

	setActive = var_6_9

	var_6_9(arg_6_0.noResBtn, not var_8 and var_6_10)

	setActive = var_6_9

	var_6_9(arg_6_0.disableBtn, not var_6_10)

	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

return var_0_1
