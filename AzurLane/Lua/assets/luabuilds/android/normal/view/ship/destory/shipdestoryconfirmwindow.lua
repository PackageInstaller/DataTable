class = var_0_10000

local var_0_0 = "ShipDestoryConfirmWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

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

function var_0_1.ShowOneShipProtect(arg_10_0, arg_10_1, arg_10_2)
	var_0_1.super.Show(arg_10_0)

	pg = var_3

	local var_10_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_10_0, arg_10_0._tf)

	arg_10_0.key = nil
	arg_10_0.ships = arg_10_1

	arg_10_0:SetCallBack(arg_10_2)

	setText = var_3

	local var_10_1 = arg_10_0.title

	i18n = var_5

	var_3(var_10_1, var_5("unique_ship_tip1"))

	math = var_3
	arg_10_0.key = var_3.random(100000, 999999)
	setText = var_3

	local var_10_2 = arg_10_0.urLabel

	i18n = var_5

	var_3(var_10_2, var_5("unique_ship_tip2", arg_10_0.key))

	setActive = var_3

	var_3(arg_10_0.urLabel, true)

	setActive = var_3

	var_3(arg_10_0.urInput, true)

	setActive = var_3

	var_3(arg_10_0.urOverflowLabel, false)

	mergeSort = var_3

	local var_10_3 = arg_10_0.ships

	CompareFuncs = var_5

	var_3(var_10_3, var_5({
		function(arg_11_0)
			return -arg_11_0.level
		end,
		function(arg_12_0)
			return -arg_12_0:getRarity()
		end
	}, true))

	if #arg_10_0.ships > 5 then
		setActive = var_3

		local var_10_4 = arg_10_0._tf

		var_3(var_4.Find(var_10_4, "window/content/ships"), true)

		setActive = var_3

		local var_10_5 = arg_10_0._tf

		var_3(var_4.Find(var_10_5, "window/content/ships_single"), false)

		local var_10_6 = arg_10_0._tf
		local var_10_7 = var_3.Find(var_10_6, "window/content/ships/content")
		local var_10_8 = var_3.GetComponent(var_10_7, "LScrollRect")

		function var_10_8.onUpdateItem(arg_13_0, arg_13_1)
			updateShip = var_2_10002
			tf = var_2_10003

			var_2_10002(var_2_10003(arg_13_1), arg_10_0.ships[arg_13_0 + 1])

			return
		end

		onNextTick = var_5

		var_5(function()
			local var_14_0 = var_10_8

			var_0.SetTotalCount(var_14_0, #arg_10_0.ships)

			return
		end)
	else
		setActive = var_3

		local var_10_9 = arg_10_0._tf

		var_3(var_4.Find(var_10_9, "window/content/ships"), false)

		setActive = var_3

		local var_10_10 = arg_10_0._tf

		var_3(var_4.Find(var_10_10, "window/content/ships_single"), true)

		local var_10_11 = arg_10_0._tf
		local var_10_12 = var_3.Find(var_10_11, "window/content/ships_single")

		UIItemList = var_10_11

		local var_10_13 = var_10_11.New(var_10_12, var_10_12:Find("IconTpl"))

		var_4.make(var_10_13, function(arg_15_0, arg_15_1, arg_15_2)
			UIItemList = var_2_10003

			if arg_15_0 == var_2_10003.EventUpdate then
				updateShip = var_3

				var_3(arg_15_2, arg_10_0.ships[arg_15_1 + 1])
			end

			return
		end)
		var_4:align(#arg_10_0.ships)
	end

	return
end

function var_0_1.Show(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	var_0_1.super.Show(arg_16_0)

	pg = var_5

	local var_16_0 = var_5.UIMgr.GetInstance()

	var_5.BlurPanel(var_16_0, arg_16_0._tf)

	arg_16_0.key = nil
	arg_16_0.eliteShips = arg_16_1
	arg_16_0.highLevelShips = arg_16_2
	arg_16_0.overflow = arg_16_3

	arg_16_0:SetCallBack(arg_16_4)
	arg_16_0:Updatelayout()
	arg_16_0:UpdateShips()

	return
end

function var_0_1.ShowEliteTag(arg_17_0, arg_17_1, arg_17_2)
	var_0_1.super.Show(arg_17_0)

	pg = var_3

	local var_17_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_17_0, arg_17_0._tf)
	arg_17_0:SetCallBack(arg_17_2)

	setText = var_3

	local var_17_1 = arg_17_0.title

	i18n = var_5

	local var_17_2 = "destroy_eliteship_tip"

	i18n = var_1_10007

	var_3(var_17_1, var_5(var_17_2, var_1_10007("destroy_inHardFormation_tip")))

	setActive = var_3

	var_3(arg_17_0.urOverflowLabel, false)

	setActive = var_3

	var_3(arg_17_0.urLabel, false)

	setActive = var_3

	var_3(arg_17_0.urInput, false)

	arg_17_0.ships = arg_17_1

	if #arg_17_0.ships > 5 then
		setActive = var_3

		local var_17_3 = arg_17_0._tf

		var_3(var_4.Find(var_17_3, "window/content/ships"), true)

		setActive = var_3

		local var_17_4 = arg_17_0._tf

		var_3(var_4.Find(var_17_4, "window/content/ships_single"), false)

		local var_17_5 = arg_17_0._tf
		local var_17_6 = var_3.Find(var_17_5, "window/content/ships/content")
		local var_17_7 = var_3.GetComponent(var_17_6, "LScrollRect")

		function var_17_7.onUpdateItem(arg_18_0, arg_18_1)
			updateShip = var_2_10002
			tf = var_2_10003

			var_2_10002(var_2_10003(arg_18_1), arg_17_0.ships[arg_18_0 + 1])

			return
		end

		onNextTick = var_5

		var_5(function()
			local var_19_0 = var_17_7

			var_0.SetTotalCount(var_19_0, #arg_17_0.ships)

			return
		end)
	else
		setActive = var_3

		local var_17_8 = arg_17_0._tf

		var_3(var_4.Find(var_17_8, "window/content/ships"), false)

		setActive = var_3

		local var_17_9 = arg_17_0._tf

		var_3(var_4.Find(var_17_9, "window/content/ships_single"), true)

		local var_17_10 = arg_17_0._tf
		local var_17_11 = var_3.Find(var_17_10, "window/content/ships_single")

		UIItemList = var_17_10

		local var_17_12 = var_17_10.New(var_17_11, var_17_11:Find("IconTpl"))

		var_4.make(var_17_12, function(arg_20_0, arg_20_1, arg_20_2)
			UIItemList = var_2_10003

			if arg_20_0 == var_2_10003.EventUpdate then
				updateShip = var_3

				var_3(arg_20_2, arg_17_0.ships[arg_20_1 + 1])
			end

			return
		end)
		var_4:align(#arg_17_0.ships)
	end

	return
end

function var_0_1.Updatelayout(arg_21_0)
	local var_21_0 = arg_21_0.eliteShips
	local var_21_1 = arg_21_0.highLevelShips
	local var_21_2 = {}

	if #var_21_0 > 0 then
		table = var_4

		local var_21_3 = var_4.insert
		local var_21_4 = var_21_2

		i18n = var_1_10006

		var_21_3(var_21_4, var_1_10006("destroy_high_rarity_tip"))
	end

	local var_21_5

	if #var_21_1 > 0 then
		table = var_21_5
		var_21_5 = var_21_5.insert

		local var_21_6 = var_21_2

		i18n = var_1_10006

		var_21_5(var_21_6, var_1_10006("destroy_high_level_tip", ""))
	end

	setText = var_21_5

	local var_21_7 = arg_21_0.title

	i18n = var_1_10006

	local var_21_8 = "destroy_eliteship_tip"

	table = var_1_10008

	var_21_5(var_21_7, var_1_10006(var_21_8, var_1_10008.concat(var_21_2, "、")))

	_ = var_21_5

	local var_21_9

	if var_21_5.any(var_21_0, function(arg_22_0)
		local var_22_0 = arg_22_0
		local var_22_1 = arg_22_0.getConfig(var_22_0, "rarity")

		ShipRarity = var_22_0

		return var_22_1 >= var_22_0.SSR
	end) and not arg_21_0.key then
		math = var_5
		arg_21_0.key = var_5.random(100000, 999999)
		setText = var_5
		var_21_9 = arg_21_0.urLabel
		i18n = var_7

		var_5(var_21_9, var_7("destroy_ur_rarity_tip", arg_21_0.key))
	else
		setText = var_5

		var_5(arg_21_0.urLabel, "")
	end

	local var_21_10 = var_4 and arg_21_0.overflow

	setActive = var_21_9

	var_21_9(arg_21_0.urOverflowLabel, var_21_10)

	setActive = var_21_9

	var_21_9(arg_21_0.urLabel, var_4)

	setActive = var_21_9

	var_21_9(arg_21_0.urInput, var_4)

	return
end

function var_0_1.UpdateShips(arg_23_0)
	local var_23_0 = arg_23_0.eliteShips
	local var_23_1 = arg_23_0.highLevelShips

	table = var_1_10003

	local var_23_2 = var_1_10003.mergeArray(var_23_1, var_23_0)

	mergeSort = var_4

	local var_23_3 = var_23_2

	CompareFuncs = var_1_10006

	var_4(var_23_3, var_1_10006({
		function(arg_24_0)
			return -arg_24_0.level
		end,
		function(arg_25_0)
			return -arg_25_0:getRarity()
		end
	}, true))

	arg_23_0.ships = var_23_2

	if #arg_23_0.ships > 5 then
		setActive = var_4

		local var_23_4 = arg_23_0._tf

		var_4(var_5.Find(var_23_4, "window/content/ships"), true)

		setActive = var_4

		local var_23_5 = arg_23_0._tf

		var_4(var_5.Find(var_23_5, "window/content/ships_single"), false)

		local var_23_6 = arg_23_0._tf
		local var_23_7 = var_4.Find(var_23_6, "window/content/ships/content")
		local var_23_8 = var_4.GetComponent(var_23_7, "LScrollRect")

		function var_23_8.onUpdateItem(arg_26_0, arg_26_1)
			updateShip = var_2_10002
			tf = var_2_10003

			var_2_10002(var_2_10003(arg_26_1), arg_23_0.ships[arg_26_0 + 1])

			return
		end

		onNextTick = var_6

		var_6(function()
			local var_27_0 = var_23_8

			var_0.SetTotalCount(var_27_0, #arg_23_0.ships)

			return
		end)
	else
		setActive = var_4

		local var_23_9 = arg_23_0._tf

		var_4(var_5.Find(var_23_9, "window/content/ships"), false)

		setActive = var_4

		local var_23_10 = arg_23_0._tf

		var_4(var_5.Find(var_23_10, "window/content/ships_single"), true)

		local var_23_11 = arg_23_0._tf
		local var_23_12 = var_4.Find(var_23_11, "window/content/ships_single")

		UIItemList = var_23_11

		local var_23_13 = var_23_11.New(var_23_12, var_23_12:Find("IconTpl"))

		var_5.make(var_23_13, function(arg_28_0, arg_28_1, arg_28_2)
			UIItemList = var_2_10003

			if arg_28_0 == var_2_10003.EventUpdate then
				updateShip = var_3

				var_3(arg_28_2, arg_23_0.ships[arg_28_1 + 1])
			end

			return
		end)
		var_5:align(#arg_23_0.ships)
	end

	return
end

function var_0_1.Hide(arg_29_0)
	var_0_1.super.Hide(arg_29_0)

	pg = var_1

	local var_29_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_29_0, arg_29_0._tf, arg_29_0._parentTf)

	arg_29_0.key = nil
	arg_29_0.callback = nil
	setInputText = var_1

	var_1(arg_29_0.urInput, "")

	return
end

function var_0_1.OnDestroy(arg_30_0)
	if arg_30_0:isShowing() then
		arg_30_0:Hide()
	end

	return
end

return var_0_1
