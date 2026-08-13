class = var_0_10000

local var_0_0 = "ChargeBattleUISellLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChargeBattleUISellLayer"
end

function var_0_1.init(arg_2_0)
	AutoLoader = var_1_10001
	arg_2_0.loader = var_1_10001.New()

	arg_2_0:InitData()
	arg_2_0:InitUI()
	arg_2_0:updateGiftWindow()
	arg_2_0:InitBattleShow()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.willExit(arg_4_0)
	local var_4_0 = arg_4_0.loader

	var_1.Clear(var_4_0)

	UpdateBeat = var_1

	var_1:RemoveListener(arg_4_0.handle)
	arg_4_0:ClearPreviewer()

	pg = var_1

	local var_4_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_1, arg_4_0._tf)

	return
end

function var_0_1.InitData(arg_5_0)
	arg_5_0.showGoodVO = arg_5_0.contextData.showGoodVO
	arg_5_0.chargedList = arg_5_0.contextData.chargedList

	local var_5_0 = arg_5_0.showGoodVO

	arg_5_0.goodVOList = var_1.getSameLimitGroupTecGoods(var_5_0)
	arg_5_0.normalGoodVO = nil
	arg_5_0.specailGoodVO = nil
	ipairs = var_1

	for iter_5_0, iter_5_1 in var_1(arg_5_0.goodVOList) do
		if iter_5_1:getConfig("limit_arg") == 1 then
			if not arg_5_0.normalGoodVO then
				arg_5_0.normalGoodVO = iter_5_1
			else
				arg_5_0.specailGoodVO = iter_5_1
			end
		end
	end

	arg_5_0.battleSkinId = nil

	return
end

function var_0_1.InitUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.bg = var_1.Find(var_6_0, "BG")

	local var_6_1 = arg_6_0._tf

	arg_6_0.titleText = var_1.Find(var_6_1, "mainPanel/topBar/left/nameMask/name")

	local var_6_2 = arg_6_0._tf

	arg_6_0.tipText = var_1.Find(var_6_2, "mainPanel/topBar/left/tipText")

	local var_6_3 = arg_6_0._tf

	arg_6_0.middleText = var_1.Find(var_6_3, "mainPanel/topBar/middle/Text")

	local var_6_4 = arg_6_0._tf

	arg_6_0.closeBtn = var_1.Find(var_6_4, "mainPanel/topBar/right")

	local var_6_5 = arg_6_0._tf

	arg_6_0.startShowBtn = var_1.Find(var_6_5, "mainPanel/main/showWindow")

	local var_6_6 = arg_6_0._tf

	arg_6_0.normalWindow = var_1.Find(var_6_6, "mainPanel/main/normalWindow")

	local var_6_7 = arg_6_0._tf

	arg_6_0.specialWindow = var_1.Find(var_6_7, "mainPanel/main/specialWindow")

	local var_6_8 = arg_6_0.normalWindow

	arg_6_0.normalText = var_1.Find(var_6_8, "title")

	local var_6_9 = arg_6_0.specialWindow

	arg_6_0.specialText = var_1.Find(var_6_9, "title")

	local var_6_10 = arg_6_0.normalWindow

	arg_6_0.buyNormalBtn = var_1.Find(var_6_10, "buyNormalButton")

	local var_6_11 = arg_6_0.specialWindow

	arg_6_0.buySpecialBtn = var_1.Find(var_6_11, "buySpecialButton")

	local var_6_12 = arg_6_0._tf

	arg_6_0.itemTpl = var_1.Find(var_6_12, "itemTpl")
	UIItemList = var_1

	local var_6_13 = var_1.New
	local var_6_14 = arg_6_0.normalWindow

	arg_6_0.normalList = var_6_13(var_2.Find(var_6_14, "list"), arg_6_0.itemTpl)
	UIItemList = var_1

	local var_6_15 = var_1.New
	local var_6_16 = arg_6_0.specialWindow

	arg_6_0.specialList = var_6_15(var_2.Find(var_6_16, "list"), arg_6_0.itemTpl)
	setScrollText = var_1

	var_1(arg_6_0.titleText, "")

	setText = var_1

	local var_6_17 = arg_6_0.tipText

	i18n = var_3

	var_1(var_6_17, var_3("ui_pack_tip1"))

	setText = var_1

	local var_6_18 = arg_6_0.normalText

	i18n = var_3

	var_1(var_6_18, var_3("ui_pack_tip2"))

	setText = var_1

	local var_6_19 = arg_6_0.specialText

	i18n = var_3

	var_1(var_6_19, var_3("ui_pack_tip3"))

	local var_6_20 = arg_6_0._tf

	arg_6_0.preview = var_1.Find(var_6_20, "mainPanel/main/preview")

	local var_6_21 = arg_6_0.preview

	arg_6_0.sea = var_1.Find(var_6_21, "sea")

	local var_6_22 = arg_6_0.sea

	arg_6_0.rawImage = var_1.GetComponent(var_6_22, "RawImage")
	setActive = var_1

	var_1(arg_6_0.preview, false)

	setActive = var_1

	var_1(arg_6_0.rawImage, false)

	onButton = var_1

	local var_6_23 = arg_6_0
	local var_6_24 = arg_6_0.closeBtn

	local function var_6_25()
		local var_7_0 = arg_6_0

		var_0.ClearPreviewer(var_7_0)

		local var_7_1 = arg_6_0

		var_0.closeView(var_7_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_6_23, var_6_24, var_6_25, var_1_10005)

	onButton = var_1

	local var_6_26 = arg_6_0
	local var_6_27 = arg_6_0.bg

	local function var_6_28()
		local var_8_0 = arg_6_0

		var_0.ClearPreviewer(var_8_0)

		local var_8_1 = arg_6_0

		var_0.closeView(var_8_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_6_26, var_6_27, var_6_28, var_1_10005)

	local var_6_29 = arg_6_0._tf

	arg_6_0.tipsGo = var_1.Find(var_6_29, "mainPanel/topBar/left/tips")

	local var_6_30 = arg_6_0._tf

	arg_6_0.tipsText = var_1.Find(var_6_30, "mainPanel/topBar/left/tips/text")
	UIItemList = var_1

	local var_6_31 = var_1.New
	local var_6_32 = arg_6_0._tf
	local var_6_33 = var_2.Find(var_6_32, "mainPanel/topBar/left/elementList")
	local var_6_34 = arg_6_0._tf

	arg_6_0.toggleList = var_6_31(var_6_33, var_3.Find(var_6_34, "mainPanel/topBar/left/elementList/main_toggle"))
	UpdateBeat = var_1
	arg_6_0.handle = var_1:CreateListener(arg_6_0.UpdateClick, arg_6_0)
	UpdateBeat = var_1

	var_1:AddListener(arg_6_0.handle)

	return
end

function var_0_1.ShowTips(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0.tipsGo, arg_9_1)

	return
end

function var_0_1.UpdateClick(arg_10_0)
	UnityEngine = var_1_10001

	if var_1_10001.Input.GetMouseButtonDown(0) then
		local var_10_0 = arg_10_0.toggleList

		var_1.each(var_10_0, function(arg_11_0, arg_11_1)
			GetComponent = var_2_10002

			local var_11_0 = arg_11_1

			typeof = var_2_10004
			Toggle = var_2_10005
			var_2_10002(var_11_0, var_2_10004(var_2_10005)).isOn = false

			return
		end)
	end

	return
end

function var_0_1.updateGiftWindow(arg_12_0)
	setText = var_1_10001

	local var_12_0 = arg_12_0.buyNormalBtn
	local var_12_1 = var_2.Find(var_12_0, "Price/BuyText")

	i18n = var_12_0

	var_1_10001(var_12_1, var_12_0("word_buy"))

	setText = var_1_10001

	local var_12_2 = arg_12_0.buyNormalBtn
	local var_12_3 = var_2.Find(var_12_2, "Price/content/Text")
	local var_12_4 = arg_12_0.normalGoodVO

	var_1_10001(var_12_3, var_3.getConfig(var_12_4, "money"))

	onButton = var_1_10001

	local var_12_5 = arg_12_0
	local var_12_6 = arg_12_0.buyNormalBtn

	local function var_12_7()
		pg = var_2_10000

		local var_13_0 = var_2_10000.m02
		local var_13_1 = var_0.sendNotification

		GAME = var_2_10002

		var_13_1(var_13_0, var_2_10002.CHARGE_OPERATION, {
			shopId = arg_12_0.normalGoodVO.id
		})

		local var_13_2 = arg_12_0

		var_0.ClearPreviewer(var_13_2)

		local var_13_3 = arg_12_0

		var_0.closeView(var_13_3)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_12_5, var_12_6, var_12_7, var_5)

	setText = var_1_10001

	local var_12_8 = arg_12_0.buySpecialBtn
	local var_12_9 = var_2.Find(var_12_8, "Price/BuyText")

	i18n = var_12_8

	var_1_10001(var_12_9, var_12_8("word_buy"))

	setText = var_1_10001

	local var_12_10 = arg_12_0.buySpecialBtn
	local var_12_11 = var_2.Find(var_12_10, "Price/content/Text")
	local var_12_12 = arg_12_0.specailGoodVO

	var_1_10001(var_12_11, var_3.getConfig(var_12_12, "money"))

	onButton = var_1_10001

	local var_12_13 = arg_12_0
	local var_12_14 = arg_12_0.buySpecialBtn

	local function var_12_15()
		pg = var_2_10000

		local var_14_0 = var_2_10000.m02
		local var_14_1 = var_0.sendNotification

		GAME = var_2_10002

		var_14_1(var_14_0, var_2_10002.CHARGE_OPERATION, {
			shopId = arg_12_0.specailGoodVO.id
		})

		local var_14_2 = arg_12_0

		var_0.ClearPreviewer(var_14_2)

		local var_14_3 = arg_12_0

		var_0.closeView(var_14_3)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_12_13, var_12_14, var_12_15, var_5)

	local var_12_16 = {}

	ipairs = var_12_13

	local var_12_17 = arg_12_0.normalGoodVO

	for iter_12_0, iter_12_1 in var_12_13(var_3.GetExtraServiceItem(var_12_17)) do
		table = var_1_10007

		var_1_10007.insert(var_12_16, iter_12_1)

		if not arg_12_0.battleSkinId then
			arg_12_0.battleSkinId = iter_12_1.id
		end
	end

	local var_12_18 = arg_12_0.normalList

	var_2.make(var_12_18, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = arg_15_2:Find("Container")
			local var_15_1 = var_3.GetChild(var_15_0, 0)
			local var_15_2 = arg_15_2:Find("TextMask/Text")
			local var_15_3 = var_12_16[arg_15_1 + 1]

			var_15_3.notPlay = true
			updateDrop = var_7

			var_7(var_15_1, var_15_3)

			onButton = var_7

			local var_15_4 = arg_12_0
			local var_15_5 = var_15_1

			local function var_15_6()
				local var_16_0 = arg_12_0
				local var_16_1 = var_0.emit

				BaseUI = var_3_10002

				var_16_1(var_16_0, var_3_10002.ON_DROP, var_15_3)

				return
			end

			SFX_PANEL = var_2_10011

			var_7(var_15_4, var_15_5, var_15_6, var_2_10011)

			setScrollText = var_7

			local var_15_7 = var_15_2
			local var_15_8 = var_15_3

			var_7(var_15_7, var_15_3.getName(var_15_8))

			local var_15_9 = arg_12_0.titleText
			local var_15_10 = var_7.GetComponent

			typeof = var_9
			Text = var_15_8

			if var_15_10(var_15_9, var_9(var_15_8)).text == "" then
				setScrollText = var_7

				var_7(arg_12_0.titleText, var_15_3:getName())
			end
		end

		return
	end)

	local var_12_19 = arg_12_0.normalList

	var_2.align(var_12_19, #var_12_16)

	var_12_16 = {}
	ipairs = var_2

	local var_12_20 = arg_12_0.specailGoodVO

	for iter_12_2, iter_12_3 in var_2(var_3.GetExtraServiceItem(var_12_20)) do
		table = var_1_10007

		var_1_10007.insert(var_12_16, iter_12_3)
	end

	local var_12_21 = arg_12_0.specialList

	var_2.make(var_12_21, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = arg_17_2:Find("Container")
			local var_17_1 = var_3.GetChild(var_17_0, 0)
			local var_17_2 = arg_17_2:Find("TextMask/Text")
			local var_17_3 = var_12_16[arg_17_1 + 1]

			updateDrop = var_7

			var_7(var_17_1, var_17_3)

			var_17_3.notPlay = true
			onButton = var_7

			local var_17_4 = arg_12_0
			local var_17_5 = var_17_1

			local function var_17_6()
				local var_18_0 = arg_12_0
				local var_18_1 = var_0.emit

				BaseUI = var_3_10002

				var_18_1(var_18_0, var_3_10002.ON_DROP, var_17_3)

				return
			end

			SFX_PANEL = var_2_10011

			var_7(var_17_4, var_17_5, var_17_6, var_2_10011)

			setScrollText = var_7

			var_7(var_17_2, var_17_3:getName())
		end

		return
	end)

	local var_12_22 = arg_12_0.specialList

	var_2.align(var_12_22, #var_12_16)
	arg_12_0:InitTitle(var_12_16)

	return
end

function var_0_1.InitBattleShow(arg_19_0)
	Ship = var_1_10001

	local var_19_0 = var_1_10001.New({
		id = 100001,
		configId = 100001,
		skin_id = 100000
	})

	Ship = var_2

	local var_19_1 = var_2.New({
		id = 100011,
		configId = 100011,
		skin_id = 100010
	})

	pg = var_3

	local var_19_2 = var_3.item_data_battleui[arg_19_0.battleSkinId].key

	onButton = var_4

	local var_19_3 = arg_19_0
	local var_19_4 = arg_19_0.startShowBtn

	local function var_19_5()
		local var_20_0 = "CombatUI" .. var_19_2
		local var_20_1 = "CombatHPBar" .. var_19_2
		local var_20_2
		local var_20_3
		local var_20_4

		seriesAsync = var_2_10005

		var_2_10005({
			function(arg_21_0)
				PoolMgr = var_3_10001

				local var_21_0 = var_3_10001.GetInstance()

				var_1.GetUI(var_21_0, var_20_1, true, function(arg_22_0)
					var_20_3 = arg_22_0

					arg_21_0()

					return
				end)

				return
			end,
			function(arg_23_0)
				PoolMgr = var_3_10001

				local var_23_0 = var_3_10001.GetInstance()

				var_1.GetUI(var_23_0, var_20_1, true, function(arg_24_0)
					var_20_4 = arg_24_0

					arg_23_0()

					return
				end)

				return
			end,
			function(arg_25_0)
				PoolMgr = var_3_10001

				local var_25_0 = var_3_10001.GetInstance()

				var_1.GetUI(var_25_0, var_20_0, true, function(arg_26_0)
					var_20_2 = arg_26_0

					arg_25_0()

					return
				end)

				return
			end
		}, function()
			pg = var_3_10000

			local var_27_0 = var_3_10000.UIMgr.GetInstance().UIMain
			local var_27_1 = var_20_2.transform

			var_1.SetParent(var_27_1, arg_19_0.preview, false)

			local var_27_2 = var_20_3.transform

			var_1.SetParent(var_27_2, arg_19_0.preview, false)

			local var_27_3 = var_20_4.transform

			var_1.SetParent(var_27_3, arg_19_0.preview, false)

			setActive = var_1

			var_1(arg_19_0.preview, true)

			local var_27_4 = arg_19_0.sea.rect.width
			local var_27_5 = arg_19_0.sea.rect.height
			local var_27_6 = var_20_2.transform

			Vector3 = var_4
			var_27_6.localScale = var_4(var_27_4 / 0, var_27_5 / 1080, 1)

			local var_27_7 = arg_19_0

			CombatUIPreviewer = var_4
			var_27_7.previewer = var_4.New(arg_19_0.rawImage)

			local var_27_8 = arg_19_0.previewer

			var_3.setDisplayWeapon(var_27_8, {
				100
			})

			local var_27_9 = arg_19_0.previewer

			var_3.setCombatUI(var_27_9, var_20_2, var_20_3, var_20_4, var_19_2)

			local var_27_10 = arg_19_0.previewer

			var_3.load(var_27_10, 40000, var_19_0, var_19_1, {}, function()
				return
			end)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_19_3, var_19_4, var_19_5, var_1_10008)

	triggerButton = var_4

	var_4(arg_19_0.startShowBtn)

	return
end

function var_0_1.InitTitle(arg_29_0, arg_29_1)
	ipairs = var_1_10002

	for iter_29_0, iter_29_1 in var_1_10002(arg_29_1) do
		local var_29_0 = iter_29_1.type

		DROP_TYPE_COMBAT_UI_STYLE = var_1_10008

		if var_29_0 == var_1_10008 then
			setScrollText = var_29_0

			var_29_0(arg_29_0.titleText, iter_29_1:getName())

			local var_29_1 = iter_29_1.id

			pg = var_1_10008

			local var_29_2 = var_1_10008.item_data_battleui[var_29_1].rare
			local var_29_3 = arg_29_0.loader
			local var_29_4 = var_10.GetSpriteQuiet
			local var_29_5 = "ui/combatskinrare"

			string = var_1_10013
			var_1_10013 = var_1_10013.format("rare_%s", var_29_2)

			local var_29_6 = arg_29_0._tf

			var_29_4(var_29_3, var_29_5, var_1_10013, var_14.Find(var_29_6, "mainPanel/topBar/left/rareImage"))

			local var_29_7 = arg_29_0.toggleList

			var_10.make(var_29_7, function(arg_30_0, arg_30_1, arg_30_2)
				UIItemList = var_2_10003

				if arg_30_0 == var_2_10003.EventUpdate then
					local var_30_0 = var_1_10008.rare_display[arg_30_1 + 1]
					local var_30_1 = arg_29_0.loader
					local var_30_2 = var_4.GetSpriteQuiet
					local var_30_3 = "ui/combatskinrare"

					CombatSkinConst = var_2_10007

					local var_30_4 = var_2_10007.TYPE_ICON_NAME[var_30_0]

					findTF = var_2_10008

					var_30_2(var_30_1, var_30_3, var_30_4, var_2_10008(arg_30_2, "on"))

					local var_30_5 = arg_29_0.loader
					local var_30_6 = var_4.GetSpriteQuiet
					local var_30_7 = "ui/combatskinrare"

					string = var_30_4

					local var_30_8 = var_30_4.format
					local var_30_9 = "%s_unselected"

					CombatSkinConst = var_9

					local var_30_10 = var_30_8(var_30_9, var_9.TYPE_ICON_NAME[var_30_0])

					findTF = var_30_9

					var_30_6(var_30_5, var_30_7, var_30_10, var_30_9(arg_30_2, "off"))

					onToggle = var_30_6

					local var_30_11 = arg_29_0
					local var_30_12 = arg_30_2

					local function var_30_13(arg_31_0)
						setText = var_3_10001

						local var_31_0 = arg_29_0.tipsText

						i18n = var_3_10003

						var_3_10001(var_31_0, var_3_10003("battleui_display" .. var_30_0))

						local var_31_1 = arg_29_0._tf
						local var_31_2 = var_1.Find(var_31_1, "mainPanel/topBar/left")
						local var_31_3 = var_1.InverseTransformPoint(var_31_2, arg_30_2.transform.position)

						setLocalPosition = var_31_2

						local var_31_4 = arg_29_0.tipsGo

						Vector3 = var_4

						var_31_2(var_31_4, var_31_3 + var_4(-20, 46, 0))

						local var_31_5 = arg_29_0

						var_2.ShowTips(var_31_5, arg_31_0)

						return
					end

					SFX_CONFIRM = var_8

					var_30_6(var_30_11, var_30_12, var_30_13, var_8)
				end

				return
			end)

			local var_29_8 = arg_29_0.toggleList

			var_10.align(var_29_8, #var_1_10008.rare_display)
		end
	end

	return
end

function var_0_1.ClearPreviewer(arg_32_0)
	if arg_32_0.previewer then
		setActive = var_1

		var_1(arg_32_0.preview, false)

		local var_32_0 = arg_32_0.previewer

		var_1.clear(var_32_0)

		arg_32_0.previewer = nil
	end

	return
end

function var_0_1.onBackPressed(arg_33_0)
	arg_33_0:ClearPreviewer()
	arg_33_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

return var_0_1
