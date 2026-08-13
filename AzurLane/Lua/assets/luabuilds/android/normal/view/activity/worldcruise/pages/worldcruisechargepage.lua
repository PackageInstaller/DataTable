class = var_0_10000

local var_0_0 = "WorldCruiseChargePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "WorldCruiseChargePage"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.buyWindow = var_1.Find(var_3_0, "buy_window")

	local var_3_1 = arg_3_0.buyWindow

	arg_3_0.cancelBtn = var_1.Find(var_3_1, "button_container/button_cancel")
	setText = var_1

	local var_3_2 = arg_3_0.cancelBtn
	local var_3_3 = var_2.Find(var_3_2, "Image")

	i18n = var_3_2

	var_1(var_3_3, var_3_2("text_cancel"))

	local var_3_4 = arg_3_0.buyWindow

	arg_3_0.confirmBtn = var_1.Find(var_3_4, "button_container/button_ok")

	local var_3_5 = arg_3_0.confirmBtn

	arg_3_0.priceTF = var_1.Find(var_3_5, "Image")
	setText = var_1

	local var_3_6 = arg_3_0.buyWindow
	local var_3_7 = var_2.Find(var_3_6, "left/got/desc")

	i18n = var_3_6

	var_1(var_3_7, var_3_6("battlepass_pay_acquire"))

	local var_3_8 = arg_3_0.buyWindow
	local var_3_9 = var_1.Find(var_3_8, "right/items/scrollview/list")

	UIItemList = var_3_8
	arg_3_0.uiItemList = var_3_8.New(var_3_9, var_3_9:Find("tpl"))

	local var_3_10 = arg_3_0.uiItemList

	var_2.make(var_3_10, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_0.itemList[arg_4_1]

			updateDrop = var_2_10004

			var_2_10004(arg_4_2, var_4_0)

			setText = var_2_10004

			local var_4_1 = arg_4_2
			local var_4_2 = arg_4_2.Find(var_4_1, "name")

			shortenString = var_4_1

			var_2_10004(var_4_2, var_4_1(var_4_0:getConfig("name"), 4))

			onButton = var_2_10004

			local var_4_3 = arg_3_0
			local var_4_4 = arg_4_2

			local function var_4_5()
				local var_5_0 = arg_3_0
				local var_5_1 = var_0.emit

				BaseUI = var_3_10002

				var_5_1(var_5_0, var_3_10002.ON_NEW_STYLE_DROP, {
					drop = var_4_0
				})

				return
			end

			SFX_CONFIRM = var_8

			var_2_10004(var_4_3, var_4_4, var_4_5, var_8)
		end

		return
	end)

	local var_3_11 = arg_3_0._tf

	arg_3_0.unlcokWindow = var_2.Find(var_3_11, "unlock_window")
	setText = var_2

	local var_3_12 = arg_3_0.unlcokWindow
	local var_3_13 = var_3.Find(var_3_12, "tip")

	i18n = var_3_12

	var_2(var_3_13, var_3_12("word_click_to_close"))

	local var_3_14 = arg_3_0.unlcokWindow

	arg_3_0.unlockItem = var_2.Find(var_3_14, "IconTpl")
	onButton = var_2

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0._tf
	local var_3_17 = var_4.Find(var_3_16, "bg")

	local function var_3_18()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_3_15, var_3_17, var_3_18, var_6)

	onButton = var_2

	local var_3_19 = arg_3_0
	local var_3_20 = arg_3_0.cancelBtn

	local function var_3_21()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_3_19, var_3_20, var_3_21, var_6)

	onButton = var_2

	local var_3_22 = arg_3_0
	local var_3_23 = arg_3_0.confirmBtn

	local function var_3_24()
		ChargeConst = var_2_10000

		local var_8_1

		if var_2_10000.isNeedSetBirth() then
			local var_8_0 = arg_3_0

			var_8_1 = var_8_1.emit
			WorldCruiseMediator = var_2_10002

			var_8_1(var_8_0, var_2_10002.EVENT_OPEN_BIRTHDAY)
		else
			pg = var_8_1

			local var_8_2 = var_8_1.m02
			local var_8_3 = var_0.sendNotification

			GAME = var_2_10002

			var_8_3(var_8_2, var_2_10002.CHARGE_OPERATION, {
				shopId = arg_3_0.passId
			})
		end

		return
	end

	SFX_PANEL = var_6

	var_2(var_3_22, var_3_23, var_3_24, var_6)

	return
end

function var_0_1.ShowBuyWindow(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.buyWindow, true)

	setActive = var_1_10001

	var_1_10001(arg_9_0.unlcokWindow, false)
	arg_9_0:Show()

	local var_9_0 = var_0_1.GetPassID()

	if arg_9_0.passId and arg_9_0.passId == var_9_0 then
		return
	end

	arg_9_0.passId = var_0_1.GetPassID()
	Goods = var_2

	local var_9_1 = var_2.Create
	local var_9_2 = {
		shop_id = arg_9_0.passId
	}

	Goods = var_4

	local var_9_3 = var_9_1(var_9_2, var_4.TYPE_CHARGE)

	Drop = var_9_2

	local var_9_4 = var_9_2.Create(var_9_3:getConfig("display")[1])

	LoadImageSpriteAtlasAsync = var_4

	local var_9_5 = var_9_4:getIcon()
	local var_9_6 = ""
	local var_9_7 = arg_9_0.buyWindow

	var_4(var_9_5, var_9_6, var_7.Find(var_9_7, "left/got/award/icon"))

	setText = var_4

	local var_9_8 = arg_9_0.buyWindow

	var_4(var_5.Find(var_9_8, "left/got/award/count"), "x" .. var_9_4.count)

	setText = var_4

	local var_9_9 = arg_9_0.buyWindow

	var_4(var_5.Find(var_9_9, "right/tip"), var_9_3:getConfig("descrip_extra"))

	local var_9_10 = var_9_3
	local var_9_11 = var_9_3.getConfig(var_9_10, "money")

	PLATFORM_CODE = var_9_10
	PLATFORM_CHT = var_6

	if var_9_10 == var_6 and var_9_3:IsLocalPrice() then
		-- block empty
	else
		GetMoneySymbol = var_9_10
		var_9_11 = var_9_10() .. var_9_11
	end

	setText = var_9_10

	var_9_10(arg_9_0.priceTF, var_9_11)

	arg_9_0.itemList = var_9_3:GetExtraServiceItem()

	local var_9_12 = arg_9_0.uiItemList

	var_5.align(var_9_12, #arg_9_0.itemList)

	return
end

function var_0_1.GetPassID()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_10_0 = var_1_10000(var_1_10001)
	local var_10_1 = var_0.getAliveActivityByType

	ActivityConst = var_1_10003

	if var_10_1(var_10_0, var_1_10003.ACTIVITY_TYPE_PT_CRUSING) then
		local var_10_2 = var_1

		if not var_1.isEnd(var_10_2) then
			ipairs = var_2
			pg = var_10_2

			for iter_10_0, iter_10_1 in var_2(var_10_2.pay_data_display.all) do
				pg = var_1_10007

				if var_1_10007.pay_data_display[iter_10_1].sub_display then
					type = var_8

					if var_8(var_1_10007.sub_display) == "table" and var_1_10007.sub_display[1] == var_1.id then
						return iter_10_1
					end
				end
			end
		end
	end

	return
end

function var_0_1.ShowUnlockWindow(arg_11_0, arg_11_1)
	setActive = var_1_10002

	var_1_10002(arg_11_0.buyWindow, false)

	setActive = var_1_10002

	var_1_10002(arg_11_0.unlcokWindow, true)
	arg_11_0:Show()

	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_1.getConfig(var_11_0, "display")

	Drop = var_11_0

	local var_11_2 = var_11_0.Create(var_11_1[1])

	updateDrop = var_4

	var_4(arg_11_0.unlockItem, var_11_2)

	onButton = var_4

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.unlockItem

	local function var_11_5()
		local var_12_0 = arg_11_0
		local var_12_1 = var_0.emit

		BaseUI = var_2_10002

		var_12_1(var_12_0, var_2_10002.ON_NEW_STYLE_DROP, {
			drop = var_11_2
		})

		return
	end

	SFX_CONFIRM = var_1_10008

	var_4(var_11_3, var_11_4, var_11_5, var_1_10008)

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
