class = var_0_10000

local var_0_0 = "BackyardFeedExtendPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BackYardFeedExtendPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/tip/icon")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.icon = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/tip/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.consume = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/desc")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.desc = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf

	arg_2_0.addBtn = var_1.Find(var_2_9, "frame/confirm")

	local var_2_10 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_10, "frame/cancel")

	local var_2_11 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_11, "frame/close")
	arg_2_0._parentTF = arg_2_0._tf.parent
	setText = var_1

	local var_2_12 = arg_2_0.cancelBtn
	local var_2_13 = var_2.Find(var_2_12, "Text")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("word_cancel"))

	setText = var_1

	local var_2_14 = arg_2_0.addBtn
	local var_2_15 = var_2.Find(var_2_14, "Text")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("word_ok"))

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_2.Find(var_2_16, "frame/tip")

	i18n = var_2_16

	var_1(var_2_17, var_2_16("backyard_food_shop_tip"))

	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_2.Find(var_2_18, "frame/title")

	i18n = var_2_18

	var_1(var_2_19, var_2_18("words_information"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.cancelBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1, arg_7_2)
	var_0_1.super.Show(arg_7_0)

	pg = var_3

	local var_7_0 = var_3.shop_template[arg_7_1].resource_type
	local var_7_1 = var_3.resource_num

	LoadSpriteAtlasAsync = var_1_10006

	local var_7_2 = "props/"

	id2res = var_1_10008

	var_1_10006(var_7_2 .. var_1_10008(var_7_0), "", function(arg_8_0)
		local var_8_0 = arg_7_0.icon

		var_8_0.sprite = arg_8_0
		tf = var_8_0

		local var_8_1 = var_8_0(arg_7_0.icon.gameObject)

		Vector2 = var_2
		var_8_1.sizeDelta = var_2(50, 50)

		return
	end)

	arg_7_0.consume.text = var_7_1

	local var_7_3 = arg_7_0.desc

	i18n = var_7
	var_7_3.text = var_7("backyard_backyardGranaryLayer_foodMaxIncreaseNotice", arg_7_2, arg_7_2 + var_3.num)
	onButton = var_7_3

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.addBtn

	local function var_7_6()
		local var_9_0 = arg_7_0

		var_0.Extend(var_9_0, {
			resType = var_7_0,
			resCount = var_7_1,
			shopId = arg_7_1
		})

		return
	end

	SFX_CONFIRM = var_10

	var_7_3(var_7_4, var_7_5, var_7_6, var_10)

	return
end

function var_0_1.Extend(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_10_0 = var_1_10002(var_1_10003)
	local var_10_1 = var_2.getRawData(var_10_0)

	id2res = var_10_0

	if var_10_1[var_10_0(arg_10_1.resType)] < arg_10_1.resCount then
		if arg_10_1.resType == 4 then
			GoShoppingMsgBox = var_3
			i18n = var_4
			var_1_10005 = "switch_to_shop_tip_3"
			i18n = var_1_10006

			local var_10_2 = var_4(var_1_10005, var_1_10006("word_gem"))

			ChargeScene = var_1_10005

			var_3(var_10_2, var_1_10005.TYPE_DIAMOND)
		else
			pg = var_3

			local var_10_3 = var_3.TipsMgr.GetInstance()
			local var_10_4 = var_3.ShowTips

			i18n = var_1_10005

			var_10_4(var_10_3, var_1_10005("backyard_backyardGranaryLayer_error_entendFail"))
		end
	else
		local var_10_5 = arg_10_0
		local var_10_6 = arg_10_0.emit

		BackyardFeedMediator = var_1_10005

		var_10_6(var_10_5, var_1_10005.EXTEND, arg_10_1.shopId, 1)
	end

	arg_10_0:Hide()

	return
end

function var_0_1.Hide(arg_11_0)
	var_0_1.super.Hide(arg_11_0)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	arg_12_0:Hide()

	return
end

return var_0_1
