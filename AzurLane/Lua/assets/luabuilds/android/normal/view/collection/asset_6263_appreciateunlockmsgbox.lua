class = var_0_10000

local var_0_0 = "AppreciateUnlockMsgBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "AppreciateUnlockMsgBox"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0.customMsgbox = arg_2_0._tf

	local var_2_0 = arg_2_0.customMsgbox

	arg_2_0.msgBoxItemPanel = var_1.Find(var_2_0, "frame/bg/item_panel")

	local var_2_1 = arg_2_0.customMsgbox

	arg_2_0.msgboxItemContains = var_1.Find(var_2_1, "frame/bg/item_panel/items")

	local var_2_2 = arg_2_0.msgboxItemContains

	arg_2_0.msgBoxItemTpl = var_1.Find(var_2_2, "equipmenttpl")

	local var_2_3 = arg_2_0.customMsgbox

	arg_2_0.msgBoxItemContent = var_1.Find(var_2_3, "frame/bg/item_panel/content")

	local var_2_4 = arg_2_0.customMsgbox

	arg_2_0.msgBoxItemContent1 = var_1.Find(var_2_4, "frame/bg/item_panel/content_num")

	local var_2_5 = arg_2_0.customMsgbox

	arg_2_0.msgBoxCancelBtn = var_1.Find(var_2_5, "frame/btns/cancel_btn")

	local var_2_6 = arg_2_0.customMsgbox

	arg_2_0.msgBoxConfirmBtn = var_1.Find(var_2_6, "frame/btns/confirm_btn")

	local var_2_7 = arg_2_0.customMsgbox

	arg_2_0.msgBoxContent = var_1.Find(var_2_7, "frame/bg/content")

	local var_2_8 = arg_2_0.customMsgbox

	arg_2_0.msgBtnBack = var_1.Find(var_2_8, "frame/top/btnBack")
	SetActive = var_1

	var_1(arg_2_0.customMsgbox, false)

	arg_2_0.settings = {}
	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.msgBoxConfirmBtn

	local function var_2_11()
		if arg_2_0.settings.onYes then
			arg_2_0.settings.onYes()
		else
			local var_3_0 = arg_2_0

			var_0.hideCustomMsgBox(var_3_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_9, var_2_10, var_2_11, var_1_10005)

	SetActive = var_1

	local var_2_12 = arg_2_0.msgBoxCancelBtn

	defaultValue = var_2_10

	var_1(var_2_12, not var_2_10(arg_2_0.settings.hideNO, false))

	onButton = var_1

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.msgBoxCancelBtn

	local function var_2_15()
		if arg_2_0.settings.onCancel then
			arg_2_0.settings.onCancel()
		else
			local var_4_0 = arg_2_0

			var_0.hideCustomMsgBox(var_4_0)
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_13, var_2_14, var_2_15, var_5)

	onButton = var_1

	local var_2_16 = arg_2_0
	local var_2_17 = arg_2_0.customMsgbox

	local function var_2_18()
		local var_5_0 = arg_2_0

		var_0.hideCustomMsgBox(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_16, var_2_17, var_2_18, var_5)

	onButton = var_1

	local var_2_19 = arg_2_0
	local var_2_20 = arg_2_0.msgBtnBack

	local function var_2_21()
		local var_6_0 = arg_2_0

		var_0.hideCustomMsgBox(var_6_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_19, var_2_20, var_2_21, var_5)

	return
end

function var_0_1.showCustomMsgBox(arg_7_0, arg_7_1)
	arg_7_0.isShowCustomMsgBox = true
	arg_7_0.settings = arg_7_1
	setActive = var_2

	var_2(arg_7_0.customMsgbox, true)

	pg = var_2

	local var_7_0 = var_2.UIMgr.GetInstance()

	var_2.OverlayPanel(var_7_0, arg_7_0.customMsgbox)

	local var_7_2

	if arg_7_1.items then
		local var_7_1 = #arg_7_1.items

		var_7_2 = 0 < var_7_1
	end

	setActive = var_7_0

	var_7_0(arg_7_0.msgBoxItemPanel, var_7_2)

	setActive = var_7_0

	var_7_0(arg_7_0.msgBoxContent, not var_7_2)

	getProxy = var_7_0
	PlayerProxy = var_4

	local var_7_3 = var_7_0(var_4)
	local var_7_4 = var_3.getData(var_7_3)

	if var_7_2 then
		var_7_3 = arg_7_1.items

		for iter_7_0 = arg_7_0.msgboxItemContains.childCount + 1, #var_7_3 do
			cloneTplTo = var_1_10010

			var_1_10010(arg_7_0.msgBoxItemTpl, arg_7_0.msgboxItemContains)
		end

		local var_7_5 = arg_7_0.msgboxItemContains.childCount

		for iter_7_1 = 1, var_7_5 do
			local var_7_6 = arg_7_0.msgboxItemContains
			local var_7_7 = var_10.GetChild(var_7_6, iter_7_1 - 1)

			SetActive = var_7_6

			var_7_6(var_7_7, iter_7_1 <= #var_7_3)

			if iter_7_1 <= #var_7_3 then
				local var_7_8 = var_7_3[iter_7_1]

				updateDrop = var_12

				var_12(var_7_7, var_7_8)

				local var_7_9 = 0
				local var_7_10 = var_7_8.type

				DROP_TYPE_RESOURCE = var_7_11

				local var_7_11

				if var_7_10 == var_7_11 then
					var_7_11 = var_7_4
					var_7_9 = var_7_4.getResById(var_7_11, var_7_8.id)
				else
					local var_7_12 = var_7_8.type

					DROP_TYPE_ITEM = var_7_11

					if var_7_12 == var_7_11 then
						getProxy = var_7_12
						BagProxy = var_7_11
						var_7_11 = var_7_12(var_7_11)
						var_7_9 = var_13.getItemCountById(var_7_11, var_7_8.id)
					end
				end

				local var_7_13

				if not (var_7_9 < var_7_8.count) or not ("<color=#D6341DFF>" .. var_7_8.count .. "</color>") then
					var_7_13 = "<color=#A9F548FF>" .. var_7_8.count .. "</color>"
				end

				setText = var_7_11

				var_7_11(var_7_7:Find("icon_bg/count"), var_7_9 .. "/" .. var_7_13)
			end
		end

		setText = var_6

		local var_7_14 = arg_7_0.msgBoxItemContent
		local var_7_15

		if not arg_7_1.content then
			var_7_15 = ""
		end

		var_6(var_7_14, var_7_15)

		setText = var_6

		local var_7_16 = arg_7_0.msgBoxItemContent1
		local var_7_17

		if not arg_7_1.content1 then
			var_7_17 = ""
		end

		var_6(var_7_16, var_7_17)
	else
		setText = var_7_3

		local var_7_18 = arg_7_0.msgBoxContent
		local var_7_19

		if not arg_7_1.content then
			var_7_19 = ""
		end

		var_7_3(var_7_18, var_7_19)
	end

	return
end

function var_0_1.hideCustomMsgBox(arg_8_0)
	arg_8_0.isShowCustomMsgBox = nil
	SetActive = var_1

	var_1(arg_8_0.customMsgbox, false)
	arg_8_0:Destroy()

	return
end

function var_0_1.OnDestroy(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0.customMsgbox, arg_9_0._tf)

	return
end

return var_0_1
