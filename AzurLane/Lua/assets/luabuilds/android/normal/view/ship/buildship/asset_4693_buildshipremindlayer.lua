class = var_0_10000

local var_0_0 = "BuildShipRemindLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BuildShipRemindUI"
end

function var_0_1.setShips(arg_2_0, arg_2_1)
	arg_2_0.ships = arg_2_1

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "window")

	setText = var_3_0

	local var_3_2 = var_3_1
	local var_3_3 = var_3_1.Find(var_3_2, "top/bg/infomation/title")

	i18n = var_3_2

	var_3_0(var_3_3, var_3_2("title_info"))

	arg_3_0.btnBack = var_3_1:Find("top/btnBack")
	arg_3_0.btnConfirm = var_3_1:Find("button_container/confirm")
	setText = var_2

	local var_3_4 = arg_3_0.btnConfirm
	local var_3_5 = var_3.Find(var_3_4, "pic")

	i18n = var_3_4

	var_2(var_3_5, var_3_4("text_confirm"))

	local var_3_6 = var_3_1
	local var_3_7 = var_3_1.Find(var_3_6, "item_panel")

	setText = var_3_6

	local var_3_8 = var_3_7
	local var_3_9 = var_3_7.Find(var_3_8, "word/Text")

	i18n = var_3_8

	var_3_6(var_3_9, var_3_8("last_building_not_shown"))

	arg_3_0.toggleLock = var_3_7:Find("lock_toggle")

	local var_3_10 = var_3_7
	local var_3_11 = var_3_7.Find(var_3_10, "scrollview")

	UIItemList = var_3_10
	arg_3_0.shipItemList = var_3_10.New(var_3_11, var_3_11:Find("item_tpl"))

	local var_3_12 = arg_3_0.shipItemList

	var_4.make(var_3_12, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_0.ships[arg_4_1]
			local var_4_1 = {
				count = 1
			}

			DROP_TYPE_SHIP = var_2_10005
			var_4_1.type = var_2_10005
			var_4_1.id = var_4_0.configId
			var_4_1.virgin = var_4_0.virgin
			updateDrop = var_5

			var_5(arg_4_2:Find("IconTpl"), var_4_1)

			onButton = var_5

			local var_4_2 = arg_3_0
			local var_4_3 = arg_4_2

			local function var_4_4()
				local var_5_0 = arg_3_0

				var_0.emit(var_5_0, var_0_1.ON_DROP, var_4_1)

				return
			end

			SFX_PANEL = var_2_10009

			var_5(var_4_2, var_4_3, var_4_4, var_2_10009)

			onLongPressTrigger = var_5

			local var_4_5 = arg_3_0
			local var_4_6 = arg_4_2

			local function var_4_7()
				local var_6_0 = arg_3_0
				local var_6_1 = var_0.emit

				BuildShipRemindMediator = var_3_10002

				var_6_1(var_6_0, var_3_10002.SHOW_NEW_SHIP, var_4_0)

				return
			end

			SFX_PANEL = var_2_10009

			var_5(var_4_5, var_4_6, var_4_7, var_2_10009)
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_7_0, arg_7_0._tf)

	onButton = var_1

	local var_7_1 = arg_7_0
	local var_7_2 = arg_7_0.btnBack

	local function var_7_3()
		local var_8_0 = arg_7_0

		var_0.exitCheck(var_8_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_7_1, var_7_2, var_7_3, var_1_10005)

	onButton = var_1

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.btnConfirm

	local function var_7_6()
		local var_9_0 = arg_7_0

		var_0.exitCheck(var_9_0)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_7_4, var_7_5, var_7_6, var_1_10005)

	onToggle = var_1

	local var_7_7 = arg_7_0
	local var_7_8 = arg_7_0.toggleLock

	local function var_7_9(arg_10_0)
		arg_7_0.isLockNew = arg_10_0

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_7, var_7_8, var_7_9, var_1_10005)

	triggerToggle = var_1

	var_1(arg_7_0.toggleLock, false)

	local var_7_10 = arg_7_0.shipItemList

	var_1.align(var_7_10, #arg_7_0.ships)

	return
end

function var_0_1.exitCheck(arg_11_0)
	local var_11_0 = {}

	if arg_11_0.isLockNew then
		underscore = var_2

		local var_11_1 = var_2(arg_11_0.ships)
		local var_11_2 = var_2.chain(var_11_1)
		local var_11_3 = var_2.filter(var_11_2, function(arg_12_0)
			return arg_12_0.virgin
		end)
		local var_11_4 = var_2.map(var_11_3, function(arg_13_0)
			return arg_13_0.id
		end)

		if #var_2.value(var_11_4) > 0 then
			table = var_3

			var_3.insert(var_11_0, function(arg_14_0)
				local var_14_0 = arg_11_0
				local var_14_1 = var_1.emit

				BuildShipRemindMediator = var_2_10003

				local var_14_2 = var_2_10003.ON_LOCK
				local var_14_3 = var_0

				Ship = var_2_10005

				var_14_1(var_14_0, var_14_2, var_14_3, var_2_10005.LOCK_STATE_LOCK, arg_14_0)

				return
			end)
		end
	end

	seriesAsync = var_2

	var_2(var_11_0, function()
		local var_15_0 = arg_11_0

		var_0.closeView(var_15_0)

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_16_0)
	return
end

function var_0_1.willExit(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_17_0, arg_17_0._tf)

	return
end

return var_0_1
