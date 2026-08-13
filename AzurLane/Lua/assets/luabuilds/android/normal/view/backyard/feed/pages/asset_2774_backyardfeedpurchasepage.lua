class = var_0_10000

local var_0_0 = "BackyardFeedPurchasePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BackYardFeedShopPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.foodItem = var_1.Find(var_2_0, "frame")

	local var_2_1 = arg_2_0.foodItem

	arg_2_0.icon = var_1.Find(var_2_1, "icon_bg/icon")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "frame/name")
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.foodName = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "frame/desc")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.foodDesc = var_2_7(var_2_6, var_3(var_1_10004))

	local var_2_8 = arg_2_0._tf

	arg_2_0.calPanel = var_1.Find(var_2_8, "frame/cal_panel")

	local var_2_9 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_9, "frame/cancel_btn")

	local var_2_10 = arg_2_0.calPanel
	local var_2_11 = var_1.Find(var_2_10, "value/Text")
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.countValue = var_2_12(var_2_11, var_3(var_1_10004))

	local var_2_13 = arg_2_0.calPanel
	local var_2_14 = var_1.Find(var_2_13, "total/Text")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.total = var_2_15(var_2_14, var_3(var_1_10004))

	local var_2_16 = arg_2_0.calPanel
	local var_2_17 = var_1.Find(var_2_16, "total/icon")
	local var_2_18 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.totalIcon = var_2_18(var_2_17, var_3(var_1_10004))

	local var_2_19 = arg_2_0.calPanel

	arg_2_0.minusBtn = var_1.Find(var_2_19, "minus_btn")

	local var_2_20 = arg_2_0.calPanel

	arg_2_0.addBtn = var_1.Find(var_2_20, "add_btn")

	local var_2_21 = arg_2_0.calPanel

	arg_2_0.tenBtn = var_1.Find(var_2_21, "ten_btn")

	local var_2_22 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_22, "frame/ok_btn")

	local var_2_23 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_23, "frame/cancel_btn")

	local var_2_24 = arg_2_0._tf

	arg_2_0.closetBtn = var_1.Find(var_2_24, "frame/close")
	arg_2_0._parentTF = arg_2_0._tf.parent
	setText = var_1

	local var_2_25 = arg_2_0.cancelBtn
	local var_2_26 = var_2.Find(var_2_25, "text")

	i18n = var_2_25

	var_1(var_2_26, var_2_25("word_cancel"))

	setText = var_1

	local var_2_27 = arg_2_0.confirmBtn
	local var_2_28 = var_2.Find(var_2_27, "text")

	i18n = var_2_27

	var_1(var_2_28, var_2_27("word_ok"))

	setText = var_1

	local var_2_29 = arg_2_0._tf
	local var_2_30 = var_2.Find(var_2_29, "frame/title")

	i18n = var_2_29

	var_1(var_2_30, var_2_29("words_information"))

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

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.closetBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	local var_7_0 = arg_7_0

	arg_7_0.UpdateFood(var_7_0, arg_7_1)

	underscore = var_2

	local var_7_1 = var_2.detect

	getGameset = var_7_0

	local var_7_2 = var_7_1(var_7_0("food_shop_id")[2], function(arg_8_0)
		return arg_8_0[1] == arg_7_1
	end)[2]

	pg = var_3

	local var_7_3 = var_3.shop_template[var_7_2].resource_type
	local var_7_4 = var_3.resource_num
	local var_7_5 = 1
	local var_7_6 = arg_7_0.total

	var_7_6.text = var_7_4 * var_7_5
	LoadSpriteAtlasAsync = var_7_6

	local var_7_7 = "props/"

	id2res = var_1_10009

	var_7_6(var_7_7 .. var_1_10009(var_7_3), "", function(arg_9_0)
		local var_9_0 = arg_7_0.totalIcon

		var_9_0.sprite = arg_9_0
		tf = var_9_0

		local var_9_1 = var_9_0(arg_7_0.totalIcon.gameObject)

		Vector2 = var_2
		var_9_1.sizeDelta = var_2(50, 50)

		return
	end)

	local var_7_8 = arg_7_0.countValue

	var_7_8.text = var_7_5
	onButton = var_7_8

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.minusBtn

	local function var_7_11()
		if var_7_5 <= 1 then
			return
		end

		var_7_5 = var_7_5 - 1
		arg_7_0.countValue.text = var_7_5
		arg_7_0.total.text = var_7_4 * var_7_5

		return
	end

	SFX_PANEL = var_1_10011

	var_7_8(var_7_9, var_7_10, var_7_11, var_1_10011)

	onButton = var_7_8

	local var_7_12 = arg_7_0
	local var_7_13 = arg_7_0.addBtn

	local function var_7_14()
		if var_7_5 == 999 then
			pg = var_0

			local var_11_0 = var_0.TipsMgr.GetInstance()
			local var_11_1 = var_0.ShowTips

			i18n = var_2_10002

			var_11_1(var_11_0, var_2_10002("backyard_backyardGranaryLayer_buyCountLimit", var_7_5))

			return
		end

		var_7_5 = var_7_5 > 999 and 999 or var_7_5 + 1
		arg_7_0.countValue.text = var_7_5
		arg_7_0.total.text = var_7_4 * var_7_5

		return
	end

	SFX_PANEL = var_1_10011

	var_7_8(var_7_12, var_7_13, var_7_14, var_1_10011)

	onButton = var_7_8

	local var_7_15 = arg_7_0
	local var_7_16 = arg_7_0.tenBtn

	local function var_7_17()
		if var_7_5 == 999 then
			pg = var_0

			local var_12_0 = var_0.TipsMgr.GetInstance()
			local var_12_1 = var_0.ShowTips

			i18n = var_2_10002

			var_12_1(var_12_0, var_2_10002("backyard_backyardGranaryLayer_buyCountLimit", var_7_5))

			return
		end

		var_7_5 = var_7_5 + 10 >= 999 and 999 or var_7_5 + 10
		arg_7_0.countValue.text = var_7_5
		arg_7_0.total.text = var_7_4 * var_7_5

		return
	end

	SFX_PANEL = var_1_10011

	var_7_8(var_7_15, var_7_16, var_7_17, var_1_10011)

	onButton = var_7_8

	local var_7_18 = arg_7_0
	local var_7_19 = arg_7_0.confirmBtn

	local function var_7_20()
		local var_13_0 = arg_7_0

		var_0.Purchase(var_13_0, {
			count = var_7_5,
			resourceType = var_7_3,
			resourceNum = var_7_4,
			shopId = var_7_2
		})

		return
	end

	SFX_CONFIRM = var_1_10011

	var_7_8(var_7_18, var_7_19, var_7_20, var_1_10011)

	return
end

function var_0_1.Purchase(arg_14_0, arg_14_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_14_0 = var_1_10002(var_1_10003)
	local var_14_1 = var_2.getRawData(var_14_0)

	id2res = var_14_0

	local var_14_2

	if var_14_1[var_14_0(arg_14_1.resourceType)] < arg_14_1.resourceNum * arg_14_1.count then
		if arg_14_1.resourceType == 4 then
			GoShoppingMsgBox = var_3
			i18n = var_4
			var_14_2 = "switch_to_shop_tip_3"
			i18n = var_1_10006

			local var_14_3 = var_4(var_14_2, var_1_10006("word_gem"))

			ChargeScene = var_14_2

			var_3(var_14_3, var_14_2.TYPE_DIAMOND)
		else
			if arg_14_1.resourceType == 2 then
				ItemTipPanel = var_3

				if var_3.ShowOilBuyTip(arg_14_1.resourceNum * arg_14_1.count) then
					goto label_14_0
				end
			end

			Drop = var_3

			local var_14_4 = var_3.New
			local var_14_5 = {}

			DROP_TYPE_RESOURCE = var_14_2
			var_14_5.type = var_14_2
			var_14_5.id = arg_14_1.resourceType

			local var_14_6 = var_14_4(var_14_5)
			local var_14_7 = var_3.getName(var_14_6)

			pg = var_14_6
			var_14_2 = var_14_6.TipsMgr.GetInstance()

			local var_14_8 = var_4.ShowTips

			i18n = var_1_10006

			var_14_8(var_14_2, var_1_10006("backyard_backyardGranaryLayer_error_noResource", var_14_7))
		end

		::label_14_0::

		arg_14_0:Hide()

		return
	end

	local var_14_9 = arg_14_0
	local var_14_10 = arg_14_0.emit

	BackyardFeedMediator = var_14_2

	var_14_10(var_14_9, var_14_2.BUY_FOOD, arg_14_1.shopId, arg_14_1.count)
	arg_14_0:Hide()

	return
end

function var_0_1.UpdateFood(arg_15_0, arg_15_1)
	Item = var_1_10002

	local var_15_0 = var_1_10002.getConfigData(arg_15_1).name
	local var_15_1 = var_2.display

	updateItem = var_1_10005

	local var_15_2 = arg_15_0.foodItem

	Item = var_1_10007

	local var_15_3 = var_1_10007.New
	local var_15_4 = {
		id = arg_15_1
	}

	getProxy = var_1_10009
	BagProxy = var_1_10010

	local var_15_5 = var_1_10009(var_1_10010)

	var_15_4.cnt = var_9.getItemCountById(var_15_5, arg_15_1)

	var_1_10005(var_15_2, var_15_3(var_15_4))

	arg_15_0.foodName.text = var_15_0
	arg_15_0.foodDesc.text = var_15_1

	return
end

function var_0_1.Hide(arg_16_0)
	var_0_1.super.Hide(arg_16_0)

	return
end

function var_0_1.OnDestroy(arg_17_0)
	arg_17_0:Hide()

	return
end

return var_0_1
