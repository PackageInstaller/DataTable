class = var_0_10000

local var_0_0 = "CryptolaliaPurchaseWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CryptolaliaPurchaseWindowui"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "window/cover/icon")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.icon = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "window/cover/signature")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.signature = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "window/cover/name")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.name = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "window/cover/shipname")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.shipname = var_2_11(var_2_10, var_3(var_1_10004))

	local var_2_12 = arg_2_0._tf

	arg_2_0.gemToggle = var_1.Find(var_2_12, "window/gem")

	local var_2_13 = arg_2_0._tf

	arg_2_0.ticketToggle = var_1.Find(var_2_13, "window/ticket")

	local var_2_14 = arg_2_0.gemToggle
	local var_2_15 = var_1.Find(var_2_14, "Text")
	local var_2_16 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.gemCntTxt = var_2_16(var_2_15, var_3(var_1_10004))

	local var_2_17 = arg_2_0.ticketToggle
	local var_2_18 = var_1.Find(var_2_17, "Text")
	local var_2_19 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.ticketCntTxt = var_2_19(var_2_18, var_3(var_1_10004))

	local var_2_20 = arg_2_0._tf

	arg_2_0.exchangeBtn = var_1.Find(var_2_20, "exchange")
	setText = var_1

	local var_2_21 = arg_2_0.gemToggle
	local var_2_22 = var_2.Find(var_2_21, "title")

	i18n = var_2_21

	var_1(var_2_22, var_2_21("cryptolalia_use_gem_title"))

	setText = var_1

	local var_2_23 = arg_2_0.ticketToggle
	local var_2_24 = var_2.Find(var_2_23, "title")

	i18n = var_2_23

	var_1(var_2_24, var_2_23("cryptolalia_use_ticket_title"))

	setText = var_1

	local var_2_25 = arg_2_0.exchangeBtn
	local var_2_26 = var_2.Find(var_2_25, "Text")

	i18n = var_2_25

	var_1(var_2_26, var_2_25("cryptolalia_exchange"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	Cryptolalia = var_1_10001
	arg_3_0.costType = var_1_10001.COST_TYPE_GEM
	onToggle = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.gemToggle

	local function var_3_5(arg_5_0)
		if arg_5_0 then
			local var_5_0 = arg_3_0

			Cryptolalia = var_2_10002
			var_5_0.costType = var_2_10002.COST_TYPE_GEM
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)

	onToggle = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.ticketToggle

	local function var_3_8(arg_6_0)
		if arg_6_0 then
			local var_6_0 = arg_3_0

			Cryptolalia = var_2_10002
			var_6_0.costType = var_2_10002.COST_TYPE_TICKET
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	pg = var_2

	local var_7_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_7_0, arg_7_0._tf)

	triggerToggle = var_2

	var_2(arg_7_0.gemToggle, true)

	arg_7_0.name.text = arg_7_1:GetName()
	arg_7_0.shipname.text = arg_7_1:GetShipName()

	local var_7_1 = arg_7_1
	local var_7_2 = arg_7_1.GetShipGroupId(var_7_1)

	LoadSpriteAtlasAsync = var_7_1

	var_7_1("CryptolaliaShip/" .. var_7_2, "cd", function(arg_8_0)
		if arg_7_0.exited then
			return
		end

		arg_7_0.icon.sprite = arg_8_0

		local var_8_0 = arg_7_0.icon

		var_1.SetNativeSize(var_8_0)

		return
	end)

	onButton = var_7_1

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.exchangeBtn

	local function var_7_5()
		if not arg_7_0.costType then
			return
		end

		local var_9_0 = arg_7_0
		local var_9_1 = var_0.emit

		CryptolaliaMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.UNLOCK, arg_7_1.id, arg_7_0.costType)

		return
	end

	SFX_PANEL = var_1_10007

	var_7_1(var_7_3, var_7_4, var_7_5, var_1_10007)

	local var_7_6 = arg_7_1
	local var_7_7 = arg_7_1.GetCost

	Cryptolalia = var_7_4

	local var_7_8 = var_7_7(var_7_6, var_7_4.COST_TYPE_GEM)

	getProxy = var_7_6
	PlayerProxy = var_5

	local var_7_9 = var_7_6(var_5)
	local var_7_10 = var_4.getRawData(var_7_9)

	if var_4.getResource(var_7_10, var_7_8.id) < var_7_8.count then
		COLOR_RED = var_6

		if not var_6 then
			COLOR_GREEN = var_6
		end

		local var_7_11 = arg_7_0.gemCntTxt

		setColorStr = var_1_10008

		local var_7_12 = var_1_10008(var_5, var_6)

		setColorStr = var_9
		var_7_11.text = var_7_12 .. var_9("/" .. var_7_8.count, "#AFAFAF")

		local var_7_13 = arg_7_1
		local var_7_14 = arg_7_1.GetCost

		Cryptolalia = var_9

		local var_7_15 = var_7_14(var_7_13, var_9.COST_TYPE_TICKET)

		if var_4:getResource(var_7_15.id) < var_7_15.count then
			COLOR_RED = var_9

			if not var_9 then
				COLOR_GREEN = var_9
			end

			local var_7_16 = arg_7_0.ticketCntTxt

			setColorStr = var_11

			local var_7_17 = var_11(var_8, var_9)

			setColorStr = var_12
			var_7_16.text = var_7_17 .. var_12("/" .. var_7_15.count, "#AFAFAF")
			triggerToggle = var_7_16

			var_7_16(arg_7_0.ticketToggle, true)

			return
		end
	end
end

function var_0_1.Hide(arg_10_0)
	var_0_1.super.Hide(arg_10_0)

	pg = var_1

	local var_10_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf, arg_10_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	arg_11_0.exited = true

	return
end

return var_0_1
