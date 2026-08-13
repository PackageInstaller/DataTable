class = var_0_10000

local var_0_0 = "SkinDiscountItemExpireDisplayPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SkinDicountItemExpiredUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_0, "confirm_btn")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "title/label")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.tipTxt = var_2_3(var_2_2, var_4(var_1_10006))
	UIItemList = var_1

	local var_2_4 = var_1.New
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_3.Find(var_2_5, "left/scrollrect/list")
	local var_2_7 = arg_2_0._tf

	arg_2_0.leftList = var_2_4(var_2_6, var_4.Find(var_2_7, "left/scrollrect/list/tpl"))
	UIItemList = var_1

	local var_2_8 = var_1.New
	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "right/scrollrect/list")
	local var_2_11 = arg_2_0._tf

	arg_2_0.rightList = var_2_8(var_2_10, var_4.Find(var_2_11, "left/scrollrect/list/tpl"))
	setText = var_1

	local var_2_12 = arg_2_0.tipTxt

	i18n = var_4

	var_1(var_2_12, var_4("skin_discount_item_tran_tip"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	arg_5_0:InitLeftList(arg_5_1)
	arg_5_0:InitRightList(arg_5_1)

	pg = var_2

	local var_5_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_5_0, arg_5_0._tf)

	return
end

function var_0_1.InitLeftList(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	BagProxy = var_1_10004

	local var_6_0 = var_1_10002(var_1_10004)

	_ = var_1_10003

	local var_6_1 = var_1_10003.map(arg_6_1, function(arg_7_0)
		local var_7_0 = var_6_0
		local var_7_1 = var_1.getItemCountById(var_7_0, arg_7_0.id)
		local var_7_2 = {}

		DROP_TYPE_ITEM = var_7_0
		var_7_2[1] = var_7_0
		var_7_2[2] = arg_7_0.id
		var_7_2[3] = var_7_1

		return var_7_2
	end)
	local var_6_2 = arg_6_0.leftList

	var_4.make(var_6_2, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = var_6_1[arg_8_1 + 1]
			local var_8_1 = arg_6_0

			var_4.UpdateItem(var_8_1, var_8_0, arg_8_2)
		end

		return
	end)

	local var_6_3 = arg_6_0.leftList

	var_4.align(var_6_3, #var_6_1)

	return
end

function var_0_1.InitRightList(arg_9_0, arg_9_1)
	getProxy = var_1_10002
	BagProxy = var_1_10004

	local var_9_0 = var_1_10002(var_1_10004)
	local var_9_1 = var_2.GetSellingPrice(var_9_0, arg_9_1)
	local var_9_2 = arg_9_0.rightList

	var_4.make(var_9_2, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_9_0

			var_3.UpdateItem(var_10_0, var_9_1[arg_10_1 + 1], arg_10_2)
		end

		return
	end)

	local var_9_3 = arg_9_0.rightList

	var_4.align(var_9_3, #var_9_1)

	return
end

function var_0_1.UpdateItem(arg_11_0, arg_11_1, arg_11_2)
	Drop = var_1_10003

	local var_11_0 = var_1_10003.Create(arg_11_1)

	updateDrop = var_1_10004

	var_1_10004(arg_11_2, var_11_0)

	setScrollText = var_1_10004

	local var_11_1 = arg_11_2:Find("name_bg/Text")
	local var_11_2 = var_11_0

	var_1_10004(var_11_1, var_11_0.getName(var_11_2))

	onButton = var_1_10004

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_2

	local function var_11_5()
		pg = var_2_10000

		local var_12_0 = var_2_10000.m02
		local var_12_1 = var_0.sendNotification

		NewMainMediator = var_2_10003

		var_12_1(var_12_0, var_2_10003.ON_DROP, var_11_0)

		return
	end

	SFX_PANEL = var_11_2

	var_1_10004(var_11_3, var_11_4, var_11_5, var_11_2)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()
	local var_13_1 = var_1.UnOverlayPanel
	local var_13_2 = arg_13_0._tf

	pg = var_1_10005

	var_13_1(var_13_0, var_13_2, var_1_10005.UIMgr.GetInstance()._normalUIMain)

	return
end

return var_0_1
