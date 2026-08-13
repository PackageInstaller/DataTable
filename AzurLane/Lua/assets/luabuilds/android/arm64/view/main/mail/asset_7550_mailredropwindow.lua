class = var_0_10000

local var_0_0 = "MailReDropWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MailReDropMsgboxUI"
end

function var_0_1.OnInit(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_4.Find(var_2_1, "bg")

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_2_1

	var_1_10001(var_2_0, var_2_2, var_2_3, var_2_1)

	local var_2_4 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_4, "adapt/window_redrop/top/btnBack")
	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.closeBtn

	local function var_2_7()
		local var_4_0 = arg_2_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_2_1

	var_1(var_2_5, var_2_6, var_2_7, var_2_1)

	local var_2_8 = arg_2_0._tf

	arg_2_0._window_redrop = var_1.Find(var_2_8, "adapt/window_redrop")

	local var_2_9 = arg_2_0._window_redrop

	arg_2_0.titleTips = var_1.Find(var_2_9, "top/bg/infomation/title")

	local var_2_10 = arg_2_0._window_redrop
	local var_2_11 = var_1.Find(var_2_10, "content")

	arg_2_0._itemConfireText = var_1.GetComponent(var_2_11, "RichText")

	local var_2_12 = arg_2_0._window_redrop

	arg_2_0._confireLabel = var_1.Find(var_2_12, "desc/label1")

	local var_2_13 = arg_2_0._window_redrop

	arg_2_0._confireInput = var_1.Find(var_2_13, "desc/InputField")

	local var_2_14 = arg_2_0._window_redrop

	arg_2_0._redroptitleTips = var_1.Find(var_2_14, "top/bg/infomation/title")

	local var_2_15 = arg_2_0._confireInput

	arg_2_0.PlaceholderText = var_1.Find(var_2_15, "Placeholder")

	local var_2_16 = arg_2_0._window_redrop

	arg_2_0._redropcancelButton = var_1.Find(var_2_16, "button_container/btn_not")

	local var_2_17 = arg_2_0._window_redrop

	arg_2_0._redropconfirmButton = var_1.Find(var_2_17, "button_container/btn_ok")

	local var_2_18 = arg_2_0._window_redrop

	arg_2_0.item = var_1.Find(var_2_18, "item")

	local var_2_19 = arg_2_0._window_redrop

	arg_2_0.items = var_1.Find(var_2_19, "items")
	UIItemList = var_1
	arg_2_0.itemList = var_1.New(arg_2_0.items, arg_2_0.item)
	arg_2_0.imgCache = {}
	arg_2_0.dropIdCache = {}
	setText = var_1

	local var_2_20 = arg_2_0._redropcancelButton
	local var_2_21 = var_3.Find(var_2_20, "Text")

	i18n = var_4

	var_1(var_2_21, var_4("mail_box_cancel"))

	setText = var_1

	local var_2_22 = arg_2_0._redropconfirmButton
	local var_2_23 = var_3.Find(var_2_22, "Text")

	i18n = var_4

	var_1(var_2_23, var_4("mail_box_confirm"))

	setText = var_1

	local var_2_24 = arg_2_0.titleTips

	i18n = var_4

	var_1(var_2_24, var_4("mail_boxtitle_information"))

	setText = var_1

	local var_2_25 = arg_2_0.PlaceholderText

	i18n = var_4

	var_1(var_2_25, var_4("mail_search"))

	return
end

function var_0_1.Updatelayout(arg_5_0)
	if not arg_5_0.key then
		math = var_1
		arg_5_0.key = var_1.random(100000, 999999)
		setText = var_1

		local var_5_0 = arg_5_0._confireLabel

		i18n = var_4

		var_1(var_5_0, var_4("mail_storeroom_max_2", arg_5_0.key))
	else
		setText = var_1

		var_1(arg_5_0._confireLabel, "")
	end

	return
end

function var_0_1.showConformMsgBox(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.dropList

	arg_6_0:refrshContent(var_6_0, arg_6_1.content)

	arg_6_0.key = nil

	arg_6_0:Updatelayout()

	onButton = var_3

	local var_6_1 = arg_6_0
	local var_6_2 = arg_6_0._redropcancelButton

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_6_1, var_6_2, var_6_3, var_1_10008)

	onButton = var_3

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0._redropconfirmButton

	local function var_6_6()
		if arg_6_0.key then
			getInputText = var_0

			local var_8_0 = var_0(arg_6_0._confireInput)
			local var_8_1 = arg_6_0.key

			tonumber = var_2

			if var_8_1 ~= var_2(var_8_0) then
				pg = var_8_1

				local var_8_2 = var_8_1.TipsMgr.GetInstance()
				local var_8_3 = var_1.ShowTips

				i18n = var_4

				var_8_3(var_8_2, var_4("mail_input_erro"))

				return
			end
		end

		local var_8_4 = arg_6_0

		var_0.Hide(var_8_4)

		if arg_6_1.onYes then
			arg_6_1.onYes()
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_6_4, var_6_5, var_6_6, var_1_10008)

	setActive = var_3

	var_3(arg_6_0.item, false)

	local var_6_7 = arg_6_0.itemList

	var_3.make(var_6_7, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_9_2:Find("IconTpl")
			local var_9_1 = var_6_0[arg_9_1 + 1]
			local var_9_2 = {
				type = var_9_1.type,
				id = var_9_1.id,
				count = var_9_1.count
			}
			local var_9_3 = arg_9_2:Find("name_bg/name")

			updateDrop = var_2_10007

			var_2_10007(var_9_0, var_9_2)

			setScrollText = var_2_10007

			var_2_10007(var_9_3, var_9_1:getName())
		end

		return
	end)

	local var_6_8 = arg_6_0.itemList

	var_3.align(var_6_8, #var_6_0)

	return
end

function var_0_1.refrshContent(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = 0
	local var_10_1 = ""

	ipairs = var_1_10005

	for iter_10_0, iter_10_1 in var_1_10005(arg_10_1) do
		local var_10_2 = iter_10_1.id
		local var_10_3 = iter_10_1.count

		if not arg_10_0.dropIdCache[var_10_2] then
			local var_10_4 = arg_10_0.dropIdCache

			var_1_10015 = arg_10_0
			var_10_4[var_10_2] = arg_10_0.GetRestoreNumByTargetId(var_1_10015, var_10_2)
		end

		local var_10_5

		if not arg_10_0.dropIdCache[var_10_2][1] then
			var_10_5 = 0
		end

		if arg_10_0.dropIdCache[var_10_2][2] and not arg_10_0.imgCache[var_13] then
			Item = var_14

			local var_10_6 = var_14.getConfigData(var_13).icon

			GetSpriteFromAtlas = var_1_10015
			var_1_10015 = var_1_10015(var_10_6, "")
			arg_10_0.imgCache[var_13] = var_10_6

			local var_10_7 = arg_10_0._itemConfireText

			var_16.AddSprite(var_10_7, var_10_6, var_1_10015)
		end

		var_10_1 = arg_10_0.imgCache[var_13]
		var_10_0 = var_10_5 * var_10_3 + var_10_0
	end

	i18n = var_5

	local var_10_8 = arg_10_2

	string = iter_10_0

	local var_10_9 = var_5(var_10_8, iter_10_0.format("<icon name=%s w=0.7 h=0.7/>%d", var_10_1, var_10_0))

	arg_10_0._itemConfireText.text = var_10_9

	return
end

function var_0_1.GetRestoreNumByTargetId(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.equip_data_limit[arg_11_1].restore_id

	pg = var_1_10003

	local var_11_1 = var_1_10003.drop_data_restore[var_11_0]

	return {
		var_11_1.resource_num,
		var_11_1.resource_type
	}
end

function var_0_1.Show(arg_12_0, arg_12_1)
	var_0_1.super.Show(arg_12_0)

	pg = var_2

	local var_12_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_12_0, arg_12_0._tf)
	arg_12_0:showConformMsgBox(arg_12_1)

	return
end

function var_0_1.Hide(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0._tf, arg_13_0._parentTf)
	var_0_1.super.Hide(arg_13_0)

	setInputText = var_1

	var_1(arg_13_0._confireInput, "")

	return
end

function var_0_1.OnDestroy(arg_14_0)
	arg_14_0.imgCache = nil

	if arg_14_0:isShowing() then
		arg_14_0:Hide()
	end

	return
end

return var_0_1
