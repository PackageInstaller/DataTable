class = var_0_10000

local var_0_0 = "EquipDestoryConfirmWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "DestoryConfirmWindow"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "window/top/btnBack")
	setActive = var_1

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.Find(var_2_1, "window/top/bg/infomation/title_en")

	PLATFORM_CODE = var_2_1
	PLATFORM_US = var_4

	var_1(var_2_2, var_2_1 ~= var_4)

	setText = var_1

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "window/top/bg/infomation/title")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("title_info"))

	local var_2_5 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_5, "window/cancel_btn")

	local var_2_6 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_6, "window/confirm_btn")
	setText = var_1
	findTF = var_2_6

	local var_2_7 = var_2_6(arg_2_0.confirmBtn, "pic")

	i18n = var_3

	var_1(var_2_7, var_3("destroy_confirm_access"))

	setText = var_1
	findTF = var_2_7

	local var_2_8 = var_2_7(arg_2_0.cancelBtn, "pic")

	i18n = var_3

	var_1(var_2_8, var_3("destroy_confirm_cancel"))

	local var_2_9 = arg_2_0._tf

	arg_2_0.title = var_1.Find(var_2_9, "window/content/Text")

	local var_2_10 = arg_2_0._tf

	arg_2_0.label = var_1.Find(var_2_10, "window/content/desc/label")
	setText = var_1

	local var_2_11 = arg_2_0.label

	i18n = var_3

	var_1(var_2_11, var_3("destory_ship_before_tip"))

	local var_2_12 = arg_2_0._tf

	arg_2_0.urLabel = var_1.Find(var_2_12, "window/content/desc/label1")

	local var_2_13 = arg_2_0._tf

	arg_2_0.urInput = var_1.Find(var_2_13, "window/content/desc/InputField")

	local var_2_14 = arg_2_0._tf

	arg_2_0.urOverflowLabel = var_1.Find(var_2_14, "window/content/desc/label2")
	setText = var_1

	local var_2_15 = arg_2_0.urOverflowLabel

	i18n = var_3

	var_1(var_2_15, var_3("destory_ur_pt_overflowa"))

	local var_2_16 = arg_2_0.urInput
	local var_2_17

	var_2_17, setText = var_1.Find(var_2_16, "Placeholder"), var_2_16
	i18n = var_4

	var_2_16(var_2_17, var_4("box_ship_del_click"))

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
	local var_3_4 = arg_3_0.confirmBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Confirm(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf
	local var_3_8 = var_3.Find(var_3_7, "bg")

	local function var_3_9()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_6, var_3_8, var_3_9, var_5)

	onButton = var_1_10001

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.closeBtn

	local function var_3_12()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_10, var_3_11, var_3_12, var_5)

	return
end

function var_0_1.SetCallBack(arg_8_0, arg_8_1)
	arg_8_0.callback = arg_8_1

	return
end

function var_0_1.Confirm(arg_9_0)
	if arg_9_0.key then
		getInputText = var_1

		local var_9_0 = var_1(arg_9_0.urInput)
		local var_9_1 = arg_9_0.key

		tonumber = var_1_10003

		if var_9_1 ~= var_1_10003(var_9_0) then
			pg = var_9_1

			local var_9_2 = var_9_1.TipsMgr.GetInstance()
			local var_9_3 = var_2.ShowTips

			i18n = var_4

			var_9_3(var_9_2, var_4("destory_ship_input_erro"))

			return
		end

		local var_9_4 = arg_9_0.callback

		arg_9_0:Hide()

		existCall = var_3

		var_3(var_9_4)
	else
		local var_9_5 = arg_9_0.callback

		arg_9_0:Hide()

		existCall = var_2

		var_2(var_9_5)
	end

	return
end

function var_0_1.Show(arg_10_0, arg_10_1, arg_10_2)
	var_0_1.super.Show(arg_10_0)

	pg = var_3

	local var_10_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_10_0, arg_10_0._tf)

	arg_10_0.key = nil
	arg_10_0.equips = arg_10_1

	arg_10_0:SetCallBack(arg_10_2)
	arg_10_0:Updatelayout()
	arg_10_0:UpdateEquips()

	return
end

function var_0_1.Updatelayout(arg_11_0)
	local var_11_0 = {}

	underscore = var_1_10002

	local var_11_1

	if var_1_10002.any(arg_11_0.equips, function(arg_12_0)
		return arg_12_0:getConfig("rarity") >= 4
	end) then
		table = var_11_1
		var_11_1 = var_11_1.insert

		local var_11_2 = var_11_0

		i18n = var_4

		var_11_1(var_11_2, var_4("destroy_high_rarity_tip"))
	end

	underscore = var_11_1

	if var_11_1.any(arg_11_0.equips, function(arg_13_0)
		return arg_13_0:getConfig("level") > 1
	end) then
		table = var_2

		local var_11_3 = var_2.insert
		local var_11_4 = var_11_0

		i18n = var_4

		var_11_3(var_11_4, var_4("destroy_high_intensify_tip", ""))
	end

	local var_11_5

	if #var_11_0 == 0 then
		table = var_11_5
		var_11_5 = var_11_5.insert

		local var_11_6 = var_11_0

		i18n = var_4

		var_11_5(var_11_6, var_4("destroy_importantequipment_tip"))
	end

	setText = var_11_5

	local var_11_7 = arg_11_0.title

	i18n = var_4

	local var_11_8 = "destroy_eliteequipment_tip"

	table = var_1_10006

	var_11_5(var_11_7, var_4(var_11_8, var_1_10006.concat(var_11_0, ",")))

	underscore = var_11_5

	if var_11_5.any(arg_11_0.equips, function(arg_14_0)
		return arg_14_0:isImportance()
	end) and not arg_11_0.key then
		math = var_3
		arg_11_0.key = var_3.random(100000, 999999)
		setText = var_3

		local var_11_9 = arg_11_0.urLabel

		i18n = var_5

		var_3(var_11_9, var_5("destroy_equip_rarity_tip", arg_11_0.key))
	else
		setText = var_3

		var_3(arg_11_0.urLabel, "")
	end

	setActive = var_3

	var_3(arg_11_0.urOverflowLabel, false)

	setActive = var_3

	var_3(arg_11_0.urLabel, var_2)

	setActive = var_3

	var_3(arg_11_0.urInput, var_2)

	return
end

function var_0_1.UpdateEquips(arg_15_0)
	mergeSort = var_1_10001

	local var_15_0 = arg_15_0.equips

	CompareFuncs = var_1_10003

	var_1_10001(var_15_0, var_1_10003({
		function(arg_16_0)
			return -arg_16_0:getConfig("rarity")
		end,
		function(arg_17_0)
			return -arg_17_0:getConfig("level")
		end
	}, true))

	if #arg_15_0.equips > 5 then
		setActive = var_1

		local var_15_1 = arg_15_0._tf

		var_1(var_2.Find(var_15_1, "window/content/ships"), true)

		setActive = var_1

		local var_15_2 = arg_15_0._tf

		var_1(var_2.Find(var_15_2, "window/content/ships_single"), false)

		local var_15_3 = arg_15_0._tf
		local var_15_4 = var_1.Find(var_15_3, "window/content/ships/content")
		local var_15_5 = var_1.GetComponent(var_15_4, "LScrollRect")

		function var_15_5.onUpdateItem(arg_18_0, arg_18_1)
			updateEquipment = var_2_10002
			tf = var_2_10003

			var_2_10002(var_2_10003(arg_18_1), arg_15_0.equips[arg_18_0 + 1])

			return
		end

		onNextTick = var_3

		var_3(function()
			local var_19_0 = var_15_5

			var_0.SetTotalCount(var_19_0, #arg_15_0.equips)

			return
		end)
	else
		local var_15_6 = arg_15_0._tf
		local var_15_7 = var_1.Find(var_15_6, "window/content/ships_single")

		UIItemList = var_15_6

		local var_15_8 = var_15_6.New(var_15_7, var_15_7:Find("IconTpl"))

		setActive = var_3

		local var_15_9 = arg_15_0._tf

		var_3(var_4.Find(var_15_9, "window/content/ships"), false)

		setActive = var_3

		local var_15_10 = arg_15_0._tf

		var_3(var_4.Find(var_15_10, "window/content/ships_single"), true)
		var_15_8:make(function(arg_20_0, arg_20_1, arg_20_2)
			UIItemList = var_2_10003

			if arg_20_0 == var_2_10003.EventUpdate then
				updateEquipment = var_3

				var_3(arg_20_2, arg_15_0.equips[arg_20_1 + 1])
			end

			return
		end)
		var_15_8:align(#arg_15_0.equips)
	end

	return
end

function var_0_1.Hide(arg_21_0)
	var_0_1.super.Hide(arg_21_0)

	pg = var_1

	local var_21_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_0, arg_21_0._tf, arg_21_0._parentTf)

	arg_21_0.key = nil
	arg_21_0.callback = nil
	setInputText = var_1

	var_1(arg_21_0.urInput, "")

	return
end

function var_0_1.OnDestroy(arg_22_0)
	if arg_22_0:isShowing() then
		arg_22_0:Hide()
	end

	return
end

return var_0_1
