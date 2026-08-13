class = var_0_10000

local var_0_0 = "PSSCruiseChargePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "PSSCruiseChargePage"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.initTplVar(arg_3_0)
	arg_3_0.descTip = "blackfriday_battlepass_pay_acquire"
	arg_3_0.payTip = "blackfriday_battlepass_pay_tip"
	arg_3_0.tplMaskName = nil

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0:initTplVar()

	local var_4_0 = arg_4_0._tf

	arg_4_0.buyWindow = var_1.Find(var_4_0, "buy_window")

	local var_4_1 = arg_4_0.buyWindow

	arg_4_0.cancelBtn = var_1.Find(var_4_1, "button_container/button_cancel")
	setText = var_1

	local var_4_2 = arg_4_0.cancelBtn
	local var_4_3 = var_3.Find(var_4_2, "Image")

	i18n = var_4

	var_1(var_4_3, var_4("text_cancel"))

	local var_4_4 = arg_4_0.buyWindow

	arg_4_0.confirmBtn = var_1.Find(var_4_4, "button_container/button_ok")

	local var_4_5 = arg_4_0.confirmBtn

	arg_4_0.priceTF = var_1.Find(var_4_5, "Image")
	setText = var_1

	local var_4_6 = arg_4_0.buyWindow
	local var_4_7 = var_3.Find(var_4_6, "left/got/desc")

	i18n = var_4

	var_1(var_4_7, var_4(arg_4_0.descTip))

	local var_4_8 = arg_4_0.buyWindow
	local var_4_9 = var_1.Find(var_4_8, "right/items/scrollview/list")

	setText = var_1_10002

	local var_4_10 = arg_4_0.buyWindow
	local var_4_11 = var_4.Find(var_4_10, "right/items/Text")

	i18n = var_4_6

	var_1_10002(var_4_11, var_4_6(arg_4_0.payTip))

	UIItemList = var_1_10002
	arg_4_0.uiItemList = var_1_10002.New(var_4_9, var_4_9:Find("tpl"))

	local var_4_12 = arg_4_0.uiItemList

	var_2.make(var_4_12, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_4_0.itemList[arg_5_1]

			if not arg_4_0.tplMaskName then
				updateDrop = var_4

				var_4(arg_5_2, var_5_0)
			else
				updateDrop = var_4

				var_4(arg_5_2:Find(arg_4_0.tplMaskName), var_5_0)
			end

			setText = var_4

			local var_5_1 = arg_5_2:Find("name")

			shortenString = var_2_10007

			var_4(var_5_1, var_2_10007(var_5_0:getConfig("name"), 4))

			onButton = var_4

			local var_5_2 = arg_4_0
			local var_5_3 = arg_5_2

			local function var_5_4()
				local var_6_0 = arg_4_0
				local var_6_1 = var_0.emit

				BaseUI = var_3_10003

				var_6_1(var_6_0, var_3_10003.ON_NEW_STYLE_DROP, {
					drop = var_5_0
				})

				return
			end

			SFX_CONFIRM = var_9

			var_4(var_5_2, var_5_3, var_5_4, var_9)
		end

		return
	end)

	onButton = var_2

	local var_4_13 = arg_4_0
	local var_4_14 = arg_4_0._tf
	local var_4_15 = var_5.Find(var_4_14, "bg")

	local function var_4_16()
		local var_7_0 = arg_4_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_4_14

	var_2(var_4_13, var_4_15, var_4_16, var_4_14)

	onButton = var_2

	local var_4_17 = arg_4_0
	local var_4_18 = arg_4_0.cancelBtn

	local function var_4_19()
		local var_8_0 = arg_4_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_4_14

	var_2(var_4_17, var_4_18, var_4_19, var_4_14)

	onButton = var_2

	local var_4_20 = arg_4_0
	local var_4_21 = arg_4_0.confirmBtn

	local function var_4_22()
		ChargeConst = var_2_10000

		local var_9_1

		if var_2_10000.isNeedSetBirth() then
			local var_9_0 = arg_4_0

			var_9_1 = var_9_1.emit
			PSSHei5Mediator = var_2_10003

			var_9_1(var_9_0, var_2_10003.EVENT_OPEN_BIRTHDAY)
		else
			pg = var_9_1

			local var_9_2 = var_9_1.m02
			local var_9_3 = var_0.sendNotification

			GAME = var_2_10003

			var_9_3(var_9_2, var_2_10003.CHARGE_OPERATION, {
				shopId = arg_4_0.passId
			})
		end

		return
	end

	SFX_PANEL = var_4_14

	var_2(var_4_20, var_4_21, var_4_22, var_4_14)

	return
end

function var_0_1.ShowBuyWindow(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.buyWindow, true)

	local var_10_0 = arg_10_0

	arg_10_0.Show(var_10_0)

	local var_10_1 = var_0_1.GetPassID()

	if arg_10_0.passId and arg_10_0.passId == var_10_1 then
		return
	end

	arg_10_0.passId = var_0_1.GetPassID()
	Goods = var_2

	local var_10_2 = var_2.Create
	local var_10_3 = {
		shop_id = arg_10_0.passId
	}

	Goods = var_5

	local var_10_4 = var_10_2(var_10_3, var_5.TYPE_CHARGE)

	Drop = var_10_0

	local var_10_5 = var_10_0.Create(var_10_4:getConfig("display")[1])

	LoadImageSpriteAtlasAsync = var_10_3

	local var_10_6 = var_10_5:getIcon()
	local var_10_7 = ""
	local var_10_8 = arg_10_0.buyWindow

	var_10_3(var_10_6, var_10_7, var_8.Find(var_10_8, "left/got/award/icon"))

	setText = var_10_3

	local var_10_9 = arg_10_0.buyWindow

	var_10_3(var_6.Find(var_10_9, "left/got/award/count"), "x" .. var_10_5.count)

	setText = var_10_3

	local var_10_10 = arg_10_0.buyWindow

	var_10_3(var_6.Find(var_10_10, "right/tip"), var_10_4:getConfig("descrip_extra"))

	local var_10_11 = var_10_4
	local var_10_12 = var_10_4.getConfig(var_10_11, "money")

	PLATFORM_CODE = var_5
	PLATFORM_CHT = var_10_11

	if var_5 == var_10_11 and var_10_4:IsLocalPrice() then
		-- block empty
	else
		GetMoneySymbol = var_5
		var_10_12 = var_5() .. var_10_12
	end

	setText = var_5

	var_5(arg_10_0.priceTF, var_10_12)

	arg_10_0.itemList = var_10_4:GetExtraServiceItem()

	local var_10_13 = arg_10_0.uiItemList

	var_5.align(var_10_13, #arg_10_0.itemList)

	return
end

function var_0_1.GetPassID()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_11_0 = var_1_10000(var_1_10002)
	local var_11_1 = var_0.getAliveActivityByType

	ActivityConst = var_1_10004

	if var_11_1(var_11_0, var_1_10004.ACTIVITY_TYPE_PT_HEI5) then
		local var_11_2 = var_1

		if not var_1.isEnd(var_11_2) then
			ipairs = var_2
			pg = var_11_2

			for iter_11_0, iter_11_1 in var_2(var_11_2.pay_data_display.all) do
				pg = var_1_10007

				if var_1_10007.pay_data_display[iter_11_1].sub_display then
					type = var_8

					if var_8(var_1_10007.sub_display) == "table" and var_1_10007.sub_display[1] == var_1.id then
						return iter_11_1
					end
				end
			end
		end
	end

	return
end

function var_0_1.ShowUnlockWindow(arg_12_0, arg_12_1)
	arg_12_0:Hide()

	return
end

function var_0_1.Show(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_13_0, arg_13_0._tf)
	var_0_1.super.Show(arg_13_0)

	return
end

function var_0_1.Hide(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_0, arg_14_0._tf)
	var_0_1.super.Hide(arg_14_0)

	return
end

function var_0_1.OnDestroy(arg_15_0)
	return
end

return var_0_1
