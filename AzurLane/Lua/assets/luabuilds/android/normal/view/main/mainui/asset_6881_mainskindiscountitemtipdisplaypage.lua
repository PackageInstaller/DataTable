class = var_0_10000

local var_0_0 = "MainSkinDiscountItemTipDisplayPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MainSkinDiscountItemTipUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "window/top/btnBack")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "window/btn_cancel")

	local var_2_2 = arg_2_0._tf

	arg_2_0.goBtn = var_1.Find(var_2_2, "window/btn_go")

	local var_2_3 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_3, "window/btn_help")

	local var_2_4 = arg_2_0._tf

	arg_2_0.remindBtn = var_1.Find(var_2_4, "window/stopRemind")
	UIItemList = var_1

	local var_2_5 = var_1.New
	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "window/item_panel/scrollview/list")
	local var_2_8 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_5(var_2_7, var_3.Find(var_2_8, "window/item_panel/scrollview/list/tpl"))
	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_2.Find(var_2_9, "window/item_panel/label/Text")

	i18n = var_2_9

	var_1(var_2_10, var_2_9("skin_discount_item_expired_tip"))

	setText = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_2.Find(var_2_11, "window/stopRemind/Label")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("skin_discount_item_repeat_remind_label"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.helpBtn

	local function var_3_2()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_4_2.type = var_2_10003
		pg = var_2_10003
		var_4_2.helps = var_2_10003.gametip.skin_discount_item_notice.tip

		var_4_1(var_4_0, var_4_2)

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
	local var_3_7 = arg_3_0.cancelBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.goBtn

	local function var_3_11()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_7_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_7_1(var_7_0, var_7_2, var_2_10003.EQUIPSCENE)

		local var_7_3 = arg_3_0

		var_0.Destroy(var_7_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	onToggle = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.remindBtn

	local function var_3_14(arg_8_0)
		if arg_8_0 then
			local var_8_0 = arg_3_0

			var_1.MarkRemind(var_8_0)
		else
			local var_8_1 = arg_3_0

			var_1.UnMarkRemind(var_8_1)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10005)

	triggerToggle = var_1_10001

	var_1_10001(arg_3_0.remindBtn, true)

	return
end

function var_0_1.MarkRemind(arg_9_0)
	GetZeroTime = var_1_10001

	local var_9_0 = var_1_10001() + 1

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_9_1 = var_1_10002(var_1_10003)
	local var_9_2 = var_2.getRawData(var_9_1).id

	PlayerPrefs = var_9_1

	var_9_1.SetString("SkinDiscountItemTip" .. var_9_2, var_9_0)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.UnMarkRemind(arg_10_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)
	local var_10_1 = var_1.getRawData(var_10_0).id

	PlayerPrefs = var_10_0

	var_10_0.DeleteKey("SkinDiscountItemTip" .. var_10_1)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.Show(arg_11_0, arg_11_1)
	arg_11_0:UpdateList(arg_11_1)

	pg = var_2

	local var_11_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_11_0, arg_11_0._tf)

	return
end

function var_0_1.UpdateList(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.uiItemList

	var_2.make(var_12_0, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = arg_12_0

			var_3.UpdateItem(var_13_0, arg_12_1[arg_13_1 + 1], arg_13_2)
		end

		return
	end)

	local var_12_1 = arg_12_0.uiItemList

	var_2.align(var_12_1, #arg_12_1)

	return
end

function var_0_1.UpdateItem(arg_14_0, arg_14_1, arg_14_2)
	Drop = var_1_10003

	local var_14_0 = var_1_10003.Create
	local var_14_1 = {}

	DROP_TYPE_ITEM = var_1_10005
	var_14_1[1] = var_1_10005
	var_14_1[2] = arg_14_1.id
	var_14_1[3] = arg_14_1.count

	local var_14_2 = var_14_0(var_14_1)

	updateDrop = var_14_1

	var_14_1(arg_14_2, var_14_2)

	setScrollText = var_14_1

	var_14_1(arg_14_2:Find("name_bg/Text"), var_14_2:getName())

	onButton = var_14_1

	local var_14_3 = arg_14_0
	local var_14_4 = arg_14_2

	local function var_14_5()
		pg = var_2_10000

		local var_15_0 = var_2_10000.m02
		local var_15_1 = var_0.sendNotification

		NewMainMediator = var_2_10002

		var_15_1(var_15_0, var_2_10002.ON_DROP, var_14_2)

		return
	end

	SFX_PANEL = var_1_10008

	var_14_1(var_14_3, var_14_4, var_14_5, var_1_10008)

	return
end

function var_0_1.OnDestroy(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.UIMgr.GetInstance()
	local var_16_1 = var_1.UnOverlayPanel
	local var_16_2 = arg_16_0._tf

	pg = var_1_10004

	var_16_1(var_16_0, var_16_2, var_1_10004.UIMgr.GetInstance()._normalUIMain)

	return
end

return var_0_1
