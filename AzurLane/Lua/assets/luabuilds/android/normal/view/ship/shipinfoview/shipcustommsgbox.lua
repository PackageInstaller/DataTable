class = var_0_10000

local var_0_0 = "ShipCustomMsgBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ShipCustomMsgBox"
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

	local var_2_9 = arg_2_0.customMsgbox

	arg_2_0.msgBoxTitle = var_1.Find(var_2_9, "frame/top/title_list/infomation/title")

	local var_2_10 = arg_2_0.customMsgbox

	arg_2_0.msgBoxTitleEn = var_1.Find(var_2_10, "frame/top/title_list/infomation/title_en")
	SetActive = var_1

	var_1(arg_2_0.customMsgbox, false)

	arg_2_0.settings = {}
	onButton = var_1

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.msgBoxConfirmBtn

	local function var_2_13()
		if arg_2_0.settings.onYes then
			arg_2_0.settings.onYes()
		else
			local var_3_0 = arg_2_0

			var_0.hideCustomMsgBox(var_3_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_11, var_2_12, var_2_13, var_1_10005)

	SetActive = var_1

	local var_2_14 = arg_2_0.msgBoxCancelBtn

	defaultValue = var_2_12

	var_1(var_2_14, not var_2_12(arg_2_0.settings.hideNO, false))

	onButton = var_1

	local var_2_15 = arg_2_0
	local var_2_16 = arg_2_0.msgBoxCancelBtn

	local function var_2_17()
		if arg_2_0.settings.onCancel then
			arg_2_0.settings.onCancel()
		else
			local var_4_0 = arg_2_0

			var_0.hideCustomMsgBox(var_4_0)
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_15, var_2_16, var_2_17, var_5)

	onButton = var_1

	local var_2_18 = arg_2_0
	local var_2_19 = arg_2_0.customMsgbox

	local function var_2_20()
		local var_5_0 = arg_2_0

		var_0.hideCustomMsgBox(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_18, var_2_19, var_2_20, var_5)

	onButton = var_1

	local var_2_21 = arg_2_0
	local var_2_22 = arg_2_0.msgBtnBack

	local function var_2_23()
		local var_6_0 = arg_2_0

		var_0.hideCustomMsgBox(var_6_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_2_21, var_2_22, var_2_23, var_5)

	return
end

function var_0_1.SetShareData(arg_7_0, arg_7_1)
	arg_7_0.shareData = arg_7_1

	return
end

function var_0_1.showCustomMsgBox(arg_8_0, arg_8_1)
	arg_8_0.isShowCustomMsgBox = true
	arg_8_0.settings = arg_8_1
	setActive = var_2

	var_2(arg_8_0.customMsgbox, true)

	pg = var_2

	local var_8_0 = var_2.UIMgr.GetInstance()

	var_2.OverlayPanel(var_8_0, arg_8_0.customMsgbox)

	local var_8_2

	if arg_8_1.items then
		local var_8_1 = #arg_8_1.items

		var_8_2 = 0 < var_8_1
	end

	setActive = var_8_0

	var_8_0(arg_8_0.msgBoxItemPanel, var_8_2)

	setActive = var_8_0

	var_8_0(arg_8_0.msgBoxContent, not var_8_2)

	local var_8_16

	if var_8_2 then
		var_8_0 = arg_8_1.items

		for iter_8_0 = arg_8_0.msgboxItemContains.childCount + 1, #var_8_0 do
			cloneTplTo = var_1_10009

			var_1_10009(arg_8_0.msgBoxItemTpl, arg_8_0.msgboxItemContains)
		end

		local var_8_3 = arg_8_0.msgboxItemContains.childCount

		for iter_8_1 = 1, var_8_3 do
			local var_8_4 = arg_8_0.msgboxItemContains
			local var_8_5 = var_9.GetChild(var_8_4, iter_8_1 - 1)

			SetActive = var_8_4

			var_8_4(var_8_5, iter_8_1 <= #var_8_0)

			if iter_8_1 <= #var_8_0 then
				local var_8_6 = var_8_0[iter_8_1]

				updateDrop = var_11

				var_11(var_8_5, var_8_6)

				local var_8_7 = 0
				local var_8_8 = var_8_6.type

				DROP_TYPE_RESOURCE = var_8_9

				local var_8_9

				if var_8_8 == var_8_9 then
					var_8_9 = arg_8_0.shareData.player
					var_8_7 = var_12.getResById(var_8_9, var_8_6.id)
				else
					local var_8_10 = var_8_6.type

					DROP_TYPE_ITEM = var_8_9

					if var_8_10 == var_8_9 then
						getProxy = var_8_10
						BagProxy = var_8_9
						var_8_9 = var_8_10(var_8_9)
						var_8_7 = var_12.getItemCountById(var_8_9, var_8_6.id)
					end
				end

				var_8_7 = var_8_7 < var_8_6.count and "<color=#D6341DFF>" .. var_8_7 .. "</color>" or "<color=#A9F548FF>" .. var_8_7 .. "</color>"
				setText = var_8_9

				var_8_9(var_8_5:Find("icon_bg/count"), var_8_7 .. "/" .. var_12)
			end
		end

		setText = var_8_16

		local var_8_11 = arg_8_0.msgBoxItemContent
		local var_8_12

		if not arg_8_1.content then
			var_8_12 = ""
		end

		var_8_16(var_8_11, var_8_12)

		setText = var_8_16

		local var_8_13 = arg_8_0.msgBoxItemContent1
		local var_8_14

		if not arg_8_1.content1 then
			var_8_14 = ""
		end

		var_8_16(var_8_13, var_8_14)
	else
		setText = var_8_0

		local var_8_15 = arg_8_0.msgBoxContent

		if not arg_8_1.content then
			var_8_16 = ""
		end

		var_8_0(var_8_15, var_8_16)
	end

	if arg_8_1.title then
		local var_8_17 = arg_8_1.title.title
		local var_8_18 = arg_8_1.title.titleEn

		setText = var_8_16

		var_8_16(arg_8_0.msgBoxTitle, var_8_17)

		setText = var_8_16

		var_8_16(arg_8_0.msgBoxTitleEn, var_8_18 or "")
	end

	return
end

function var_0_1.hideCustomMsgBox(arg_9_0)
	arg_9_0.isShowCustomMsgBox = nil
	pg = var_1

	local var_9_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0.customMsgbox, arg_9_0._tf)

	SetActive = var_1

	var_1(arg_9_0.customMsgbox, false)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0.customMsgbox, arg_10_0._tf)

	arg_10_0.shareData = nil

	return
end

return var_0_1
