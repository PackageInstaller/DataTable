class = var_0_10000

local var_0_0 = "PrayPoolSuccessView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "PrayPoolSuccessView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateUI()
	arg_2_0:Show()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	local var_3_0 = arg_3_0.buildMsgBox

	var_1.hide(var_3_0)

	return
end

function var_0_1.OnBackPress(arg_4_0)
	if arg_4_0:GetLoaded() then
		isActive = var_1

		if var_1(arg_4_0.boxTF) then
			local var_4_0 = arg_4_0.buildMsgBox

			var_1.hide(var_4_0)

			return true
		end
	end

	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	PrayProxy = var_1_10002
	arg_5_0.prayProxy = var_1_10001(var_1_10002)

	local var_5_0 = arg_5_0.prayProxy

	arg_5_0.poolType = var_1.getSelectedPoolType(var_5_0)
	getProxy = var_1
	PlayerProxy = var_5_0
	arg_5_0.playerProxy = var_1(var_5_0)
	getProxy = var_1
	BagProxy = var_5_0
	arg_5_0.bagProxy = var_1(var_5_0)
	pg = var_1
	arg_5_0.useItem = var_1.ship_data_create_material[1].use_item
	print = var_1

	var_1("useitem " .. arg_5_0.useItem)

	getProxy = var_1
	BuildShipProxy = var_2
	arg_5_0.buildShipProxy = var_1(var_2)

	return
end

function var_0_1.initUI(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = arg_6_0._tf

	var_6_0[1] = var_2.Find(var_6_1, "Ship1")

	local var_6_2 = arg_6_0._tf

	var_6_0[2] = var_2.Find(var_6_2, "Ship2")
	arg_6_0.shipTF = var_6_0

	local var_6_3 = {}
	local var_6_4 = arg_6_0._tf

	var_6_3[1] = var_2.Find(var_6_4, "Rarity1")

	local var_6_5 = arg_6_0._tf

	var_6_3[2] = var_2.Find(var_6_5, "Rarity2")
	arg_6_0.shipRarityTF = var_6_3

	local var_6_6 = arg_6_0._tf

	arg_6_0.boxTF = var_1.Find(var_6_6, "build_msg")
	arg_6_0.buildMsgBox = var_0_1.MsgBox(arg_6_0.boxTF)

	local var_6_7 = arg_6_0._tf

	arg_6_0.buildBtn = var_1.Find(var_6_7, "BuildBtn")

	local var_6_8 = arg_6_0._tf

	arg_6_0.buildCubeNumText = var_1.Find(var_6_8, "BuildInfo/CubeNum")

	local var_6_9 = arg_6_0._tf

	arg_6_0.buildGoldNumText = var_1.Find(var_6_9, "BuildInfo/GoldNum")

	local var_6_10 = arg_6_0._tf

	arg_6_0.curCubeNumText = var_1.Find(var_6_10, "CubeImg/NumText")

	local var_6_11 = arg_6_0._tf

	arg_6_0.material1 = var_1.Find(var_6_11, "material1")

	local var_6_12 = arg_6_0._tf

	arg_6_0.material2 = var_1.Find(var_6_12, "material2")
	arg_6_0.ratioSpriteMap = {}

	local var_6_13 = arg_6_0._tf
	local var_6_14 = var_1.Find(var_6_13, "Ratio")

	for iter_6_0 = 2, 6 do
		getImageSprite = var_1_10006

		local var_6_15 = var_6_14
		local var_6_16 = var_6_14.Find

		tostring = var_1_10009
		var_1_10006 = var_1_10006(var_6_16(var_6_15, var_1_10009(iter_6_0)))
		arg_6_0.ratioSpriteMap[iter_6_0] = var_1_10006
	end

	local var_6_17 = {}
	local var_6_18 = {}

	getImageSprite = var_4

	local var_6_19 = arg_6_0._tf

	var_6_18.Light1 = var_4(var_5.Find(var_6_19, "Light/Normal/Light1"))
	getImageSprite = var_4

	local var_6_20 = arg_6_0._tf

	var_6_18.Light2 = var_4(var_5.Find(var_6_20, "Light/Normal/Light2"))
	getImageSprite = var_4

	local var_6_21 = arg_6_0._tf

	var_6_18.Light2_2 = var_4(var_5.Find(var_6_21, "Light/Normal/Light2_2"))
	getImageSprite = var_4

	local var_6_22 = arg_6_0._tf

	var_6_18.Light3 = var_4(var_5.Find(var_6_22, "Light/Normal/Light3"))
	getImageSprite = var_4

	local var_6_23 = arg_6_0._tf

	var_6_18.RarityBG = var_4(var_5.Find(var_6_23, "RarityBG/Normal"))
	var_6_17.Normal = var_6_18

	local var_6_24 = {}

	getImageSprite = var_4

	local var_6_25 = arg_6_0._tf

	var_6_24.Light1 = var_4(var_5.Find(var_6_25, "Light/UR/Light1"))
	getImageSprite = var_4

	local var_6_26 = arg_6_0._tf

	var_6_24.Light2 = var_4(var_5.Find(var_6_26, "Light/UR/Light2"))
	getImageSprite = var_4

	local var_6_27 = arg_6_0._tf

	var_6_24.Light2_2 = var_4(var_5.Find(var_6_27, "Light/UR/Light2_2"))
	getImageSprite = var_4

	local var_6_28 = arg_6_0._tf

	var_6_24.Light3 = var_4(var_5.Find(var_6_28, "Light/UR/Light3"))
	getImageSprite = var_4

	local var_6_29 = arg_6_0._tf

	var_6_24.RarityBG = var_4(var_5.Find(var_6_29, "RarityBG/UR"))
	var_6_17.UR = var_6_24
	arg_6_0.raritySpriteMap = var_6_17
	onButton = var_6_17

	local var_6_30 = arg_6_0
	local var_6_31 = arg_6_0.buildBtn

	local function var_6_32()
		pg = var_2_10000

		local var_7_0 = var_2_10000.ship_data_create_material

		pg = var_2_10001

		local var_7_1 = var_7_0[var_2_10001.activity_ship_create[arg_6_0.poolType].create_id]
		local var_7_2 = arg_6_0.playerProxy
		local var_7_3 = var_3.getData(var_7_2)
		local var_7_4 = arg_6_0.bagProxy
		local var_7_5 = var_4.getItemCountById(var_7_4, arg_6_0.useItem)
		local var_7_6 = arg_6_0.buildShipProxy
		local var_7_7 = var_5.getRawData(var_7_6)

		table = var_7_6

		local var_7_8 = var_7_6.getCount(var_7_7)

		_ = var_7

		local var_7_9 = var_7.min
		local var_7_10 = {}

		math = var_2_10009
		var_7_10[1] = var_2_10009.floor(var_7_3.gold / var_7_1.use_gold)
		math = var_9
		var_7_10[2] = var_9.floor(var_7_5 / var_7_1.number_1)
		MAX_BUILD_WORK_COUNT = var_9
		var_7_10[3] = var_9 - var_7_8

		local var_7_11 = var_7_9(var_7_10)

		math = var_7_10

		local var_7_12 = var_7_10.max(1, var_7_11)

		local function var_7_13(arg_8_0)
			if arg_8_0 > var_7_12 or var_7_3.gold < arg_8_0 * var_7_1.use_gold or var_7_5 < arg_8_0 * var_7_1.number_1 then
				return false
			end

			return true
		end

		local var_7_14 = arg_6_0.buildMsgBox

		var_9.show(var_7_14, var_7_12, var_7_13, function(arg_9_0)
			local var_9_0 = arg_6_0
			local var_9_1 = var_1.emit

			PrayPoolConst = var_3_10003

			var_9_1(var_9_0, var_3_10003.START_BUILD_SHIP_EVENT, var_7_1.id, arg_9_0, 0)

			return
		end, function(arg_10_0)
			local var_10_0 = arg_10_0 * var_7_1.use_gold
			local var_10_1 = arg_10_0 * var_7_1.number_1

			if var_7_13(arg_10_0) then
				COLOR_GREEN = var_3

				if not var_3 then
					COLOR_RED = var_3
				end

				i18n = var_4

				return var_4("build_ship_tip", arg_10_0, var_7_1.name, var_10_0, var_10_1, var_3)
			end
		end)

		return
	end

	SFX_UI_BUILDING_STARTBUILDING = var_6_29

	var_6_17(var_6_30, var_6_31, var_6_32, var_6_29)

	return
end

function var_0_1.updateUI(arg_11_0)
	local var_11_0 = arg_11_0.prayProxy
	local var_11_1 = var_1.getSelectedShipIDList(var_11_0)

	arg_11_0:updatePaint(var_11_1)

	local var_11_2
	local var_11_3 = arg_11_0.bagProxy
	local var_11_4

	if not var_3.getItemById(var_11_3, arg_11_0.useItem) then
		var_11_4 = {
			count = 0
		}
	end

	setText = var_3

	var_3(arg_11_0.curCubeNumText, var_11_4.count)

	pg = var_3

	local var_11_5 = var_3.ship_data_create_material

	pg = var_4

	local var_11_6 = var_11_5[var_4.activity_ship_create[arg_11_0.poolType].create_id]

	setText = var_1_10006

	var_1_10006(arg_11_0.buildCubeNumText, var_11_6.number_1)

	setText = var_1_10006

	var_1_10006(arg_11_0.buildGoldNumText, var_11_6.use_gold)

	return
end

function var_0_1.updatePaint(arg_12_0, arg_12_1)
	for iter_12_0 = 1, 2 do
		local var_12_0 = arg_12_1[iter_12_0]

		pg = var_1_10007
		var_1_10007 = var_1_10007.ship_data_statistics[var_12_0].name
		pg = var_1_10008
		var_1_10008 = var_1_10008.ship_data_statistics[var_12_0].english_name
		pg = var_1_10009
		var_1_10009 = var_1_10009.ship_data_statistics[var_12_0].rarity
		ShipRarity = var_1_10010
		var_1_10010 = var_1_10009 == var_1_10010.SSR

		local var_12_1 = arg_12_0.shipTF[iter_12_0]
		local var_12_2 = var_11.Find(var_12_1, "Mask/Paint")

		local function var_12_3()
			local var_13_0 = var_12_2
			local var_13_1 = var_0.Find(var_13_0, "fitter")
			local var_13_2 = var_0.GetChild(var_13_1, 0)

			GetComponent = var_13_1

			local var_13_3 = var_13_1(var_13_2, "MeshImage")
			local var_13_4

			if iter_12_0 ~= 2 or not arg_12_0.material2 then
				var_13_4 = arg_12_0.material1
			end

			local var_13_5 = var_13_4
			local var_13_6 = var_13_4.GetComponent

			typeof = var_2_10006
			Image = var_2_10007

			local var_13_7 = var_13_6(var_13_5, var_2_10006(var_2_10007)).material

			var_4.SetFloat(var_13_7, "_Range", iter_12_0 == 2 and 0.9 or -0.57)
			var_4:SetFloat("_Degree", iter_12_0 == 2 and -50 or 50)

			var_13_3.material = var_4

			return
		end

		setPaintingPrefabAsync = var_14

		local var_12_4 = var_12_2

		Ship = var_1_10016

		var_14(var_12_4, var_1_10016.getPaintingName(var_12_0), "build", var_12_3)

		local var_12_5 = var_11:Find("Light1")

		var_1_10016 = var_11

		local var_12_6 = var_11.Find(var_1_10016, "Light2")

		var_1_10016 = var_15.Find(var_12_6, "Light2_2")

		local var_12_7 = var_11
		local var_12_8 = var_11.Find(var_12_7, "Light3")

		if not var_1_10010 then
			setImageSprite = var_12_7

			var_12_7(var_12_5, arg_12_0.raritySpriteMap.Normal.Light1)

			setImageSprite = var_12_7

			var_12_7(var_15, arg_12_0.raritySpriteMap.Normal.Light2)

			setImageSprite = var_12_7

			var_12_7(var_1_10016, arg_12_0.raritySpriteMap.Normal.Light2_2)

			setImageSprite = var_12_7

			var_12_7(var_12_8, arg_12_0.raritySpriteMap.Normal.Light3)

			setImageColor = var_12_7

			var_12_7(var_12_5, var_0_1.Rarity_To_Light_Color_1[var_1_10009])

			setImageColor = var_12_7

			var_12_7(var_15, var_0_1.Rarity_To_Light_Color_1[var_1_10009])

			setImageColor = var_12_7

			var_12_7(var_1_10016, var_0_1.Rarity_To_Light_Color_1[var_1_10009])

			setImageColor = var_12_7

			var_12_7(var_12_8, var_0_1.Rarity_To_Light_Color_2[var_1_10009])
		else
			setImageSprite = var_12_7

			var_12_7(var_12_5, arg_12_0.raritySpriteMap.UR.Light1)

			setImageSprite = var_12_7

			var_12_7(var_15, arg_12_0.raritySpriteMap.UR.Light2)

			setImageSprite = var_12_7

			var_12_7(var_1_10016, arg_12_0.raritySpriteMap.UR.Light2_2)

			setImageSprite = var_12_7

			var_12_7(var_12_8, arg_12_0.raritySpriteMap.UR.Light3)
		end

		local var_12_9 = arg_12_0.shipRarityTF[iter_12_0]
		local var_12_10

		if not var_1_10010 or not arg_12_0.raritySpriteMap.UR.RarityBG then
			var_12_10 = arg_12_0.raritySpriteMap.Normal.RarityBG
		end

		setImageSprite = var_1_10020

		var_1_10020(var_12_9, var_12_10)

		local var_12_11 = var_11

		var_1_10020 = var_11.Find(var_12_11, "NameText")
		setText = var_12_11

		var_12_11(var_1_10020, var_1_10007)

		local var_12_12 = var_11
		local var_12_13 = var_11.Find(var_12_12, "NameEngText")

		setText = var_12_12

		var_12_12(var_12_13, var_1_10008)

		local var_12_14 = var_12_9
		local var_12_15 = var_12_9.Find(var_12_14, "NumImg")

		setImageSprite = var_12_14

		var_12_14(var_12_15, arg_12_0.ratioSpriteMap[var_1_10009], true)
	end

	return
end

function var_0_1.MsgBox(arg_14_0)
	local var_14_0 = {
		_go = arg_14_0
	}

	var_14_0.__cname = "buildmsgbox"
	tf = var_2
	var_14_0._tf = var_2(arg_14_0)
	var_14_0.inited = false
	findTF = var_2
	var_14_0.cancenlBtn = var_2(var_14_0._go, "window/btns/cancel_btn")
	findTF = var_2
	var_14_0.confirmBtn = var_2(var_14_0._go, "window/btns/confirm_btn")
	findTF = var_2
	var_14_0.closeBtn = var_2(var_14_0._go, "window/close_btn")
	var_14_0.count = 1
	findTF = var_2
	var_14_0.minusBtn = var_2(var_14_0._go, "window/content/calc_panel/minus")
	findTF = var_2
	var_14_0.addBtn = var_2(var_14_0._go, "window/content/calc_panel/add")
	findTF = var_2
	var_14_0.maxBtn = var_2(var_14_0._go, "window/content/max")
	findTF = var_2

	local var_14_1 = var_2(var_14_0._go, "window/content/calc_panel/Text")
	local var_14_2 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	var_14_0.valueTxt = var_14_2(var_14_1, var_4(var_1_10005))
	findTF = var_2

	local var_14_3 = var_2(var_14_0._go, "window/content/Text")
	local var_14_4 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	var_14_0.text = var_14_4(var_14_3, var_4(var_1_10005))
	var_14_0.buildUI = arg_14_0.parent
	var_14_0.active = false
	pg = var_2

	var_2.DelegateInfo.New(var_14_0)

	setText = var_2
	findTF = var_3

	local var_14_5 = var_3(var_14_0.cancenlBtn, "Image/Image (1)")

	i18n = var_4

	var_2(var_14_5, var_4("text_cancel"))

	setText = var_2
	findTF = var_14_5

	local var_14_6 = var_14_5(var_14_0.confirmBtn, "Image/Image (1)")

	i18n = var_4

	var_2(var_14_6, var_4("text_confirm"))

	local function var_14_7(arg_15_0, arg_15_1)
		var_14_0.valueTxt.text = arg_15_0

		if arg_15_1 then
			local var_15_0 = arg_15_1(arg_15_0)

			var_14_0.text.text = var_15_0
		else
			var_14_0.text.text = ""
		end

		return
	end

	function var_14_0.init(arg_16_0)
		arg_16_0.inited = true
		onButton = var_1

		local var_16_0 = arg_16_0
		local var_16_1 = arg_16_0._tf

		local function var_16_2()
			local var_17_0 = arg_16_0

			var_0.hide(var_17_0)

			return
		end

		SFX_PANEL = var_2_10005

		var_1(var_16_0, var_16_1, var_16_2, var_2_10005)

		onButton = var_1

		local var_16_3 = arg_16_0
		local var_16_4 = arg_16_0.cancenlBtn

		local function var_16_5()
			local var_18_0 = arg_16_0

			var_0.hide(var_18_0)

			return
		end

		SFX_PANEL = var_2_10005

		var_1(var_16_3, var_16_4, var_16_5, var_2_10005)

		onButton = var_1

		local var_16_6 = arg_16_0
		local var_16_7 = arg_16_0.confirmBtn

		local function var_16_8()
			if arg_16_0.onConfirm then
				arg_16_0.onConfirm(arg_16_0.count)
			end

			local var_19_0 = arg_16_0

			var_0.hide(var_19_0)

			return
		end

		SFX_PANEL = var_2_10005

		var_1(var_16_6, var_16_7, var_16_8, var_2_10005)

		onButton = var_1

		local var_16_9 = arg_16_0
		local var_16_10 = arg_16_0.closeBtn

		local function var_16_11()
			local var_20_0 = arg_16_0

			var_0.hide(var_20_0)

			return
		end

		SFX_PANEL = var_2_10005

		var_1(var_16_9, var_16_10, var_16_11, var_2_10005)

		onButton = var_1

		local var_16_12 = arg_16_0
		local var_16_13 = arg_16_0.minusBtn

		local function var_16_14()
			local var_21_0 = arg_16_0

			if var_0.verifyCount(var_21_0, arg_16_0.count - 1) then
				local var_21_1 = arg_16_0

				math = var_21_0
				var_21_1.count = var_21_0.max(arg_16_0.count - 1, 1)

				var_14_7(arg_16_0.count, arg_16_0.updateText)
			end

			return
		end

		SFX_PANEL = var_2_10005

		var_1(var_16_12, var_16_13, var_16_14, var_2_10005)

		onButton = var_1

		local var_16_15 = arg_16_0
		local var_16_16 = arg_16_0.addBtn

		local function var_16_17()
			local var_22_0 = arg_16_0

			if var_0.verifyCount(var_22_0, arg_16_0.count + 1) then
				local var_22_1 = arg_16_0

				math = var_22_0
				var_22_1.count = var_22_0.min(arg_16_0.count + 1, arg_16_0.max)

				var_14_7(arg_16_0.count, arg_16_0.updateText)
			end

			return
		end

		SFX_PANEL = var_2_10005

		var_1(var_16_15, var_16_16, var_16_17, var_2_10005)

		onButton = var_1

		local var_16_18 = arg_16_0
		local var_16_19 = arg_16_0.maxBtn

		local function var_16_20()
			local var_23_0 = arg_16_0

			if var_0.verifyCount(var_23_0, arg_16_0.max) then
				arg_16_0.count = arg_16_0.max

				var_14_7(arg_16_0.count, arg_16_0.updateText)
			end

			return
		end

		SFX_PANEL = var_2_10005

		var_1(var_16_18, var_16_19, var_16_20, var_2_10005)

		return
	end

	function var_14_0.verifyCount(arg_24_0, arg_24_1)
		if arg_24_0.verify then
			return arg_24_0.verify(arg_24_1)
		end

		return true
	end

	function var_14_0.isActive(arg_25_0)
		return arg_25_0.active
	end

	function var_14_0.show(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		arg_26_0.verify = arg_26_2
		arg_26_0.onConfirm = arg_26_3
		arg_26_0.active = true
		arg_26_0.max = arg_26_1 or 1
		arg_26_0.count = 1
		arg_26_0.updateText = arg_26_4

		var_14_7(arg_26_0.count, arg_26_4)

		setActive = var_5

		var_5(var_14_0._go, true)

		if not arg_26_0.inited then
			arg_26_0:init()
		end

		pg = var_5

		local var_26_0 = var_5.UIMgr.GetInstance()

		var_5.BlurPanel(var_26_0, arg_26_0._tf)

		return
	end

	function var_14_0.hide(arg_27_0)
		if arg_27_0:isActive() then
			arg_27_0.onConfirm = nil
			arg_27_0.active = false
			arg_27_0.updateText = nil
			arg_27_0.count = 1
			arg_27_0.max = 1
			arg_27_0.verify = nil
			setActive = var_1

			var_1(var_14_0._go, false)

			pg = var_1

			local var_27_0 = var_1.UIMgr.GetInstance()

			var_1.UnOverlayPanel(var_27_0, arg_27_0._tf, arg_27_0.buildUI)
		end

		return
	end

	function var_14_0.close(arg_28_0)
		arg_28_0:hide()

		pg = var_1

		var_1.DelegateInfo.Dispose(arg_28_0)

		return
	end

	return var_14_0
end

local var_0_2 = {}

Color = var_2
var_0_2[2] = var_2(0.5568627450980392, 0.5568627450980392, 0.5568627450980392, 1)
Color = var_2
var_0_2[3] = var_2(0.1568627450980392, 0.26666666666666666, 0.615686274509804, 1)
Color = var_2
var_0_2[4] = var_2(0.32941176470588235, 0.1568627450980392, 0.615686274509804, 1)
Color = var_2
var_0_2[5] = var_2(1, 0.8313725490196079, 0.3137254901960784, 1)
var_0_1.Rarity_To_Light_Color_1 = var_0_2

local var_0_3 = {}

Color = var_2
var_0_3[2] = var_2(0.6235294117647059, 0.6549019607843137, 0.7411764705882353, 1)
Color = var_2
var_0_3[3] = var_2(0.34901960784313724, 0.5294117647058824, 0.996078431372549, 1)
Color = var_2
var_0_3[4] = var_2(0.9058823529411765, 0.615686274509804, 0.996078431372549, 1)
Color = var_2
var_0_3[5] = var_2(0.996078431372549, 0.8705882352941177, 0.3215686274509804, 1)
var_0_1.Rarity_To_Light_Color_2 = var_0_3

return var_0_1
