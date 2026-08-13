class = var_0_10000

local var_0_0 = "ChangeShipSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ChangeShipSkinPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_0, "window/cancel_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_1, "window/exchange_btn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_2, "window/top/btnBack")

	local var_2_3 = arg_2_0._tf

	arg_2_0.shipContent = var_1.Find(var_2_3, "window/sliders/scroll_rect/content")

	local var_2_4 = arg_2_0.shipContent

	arg_2_0.shipCardTpl = var_1.GetChild(var_2_4, 0)

	local var_2_5 = arg_2_0._tf

	arg_2_0.flagShipToggle = var_1.Find(var_2_5, "window/flag_bg/flag_ship")

	local var_2_6 = arg_2_0._tf

	arg_2_0.flagRandomToggle = var_1.Find(var_2_6, "window/flag_bg/flag_random")
	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.Find(var_2_7, "window/top/title_list/infomation/title")

	i18n = var_2_7

	var_1(var_2_8, var_2_7("chang_ship_skin_window_title"))

	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_2.Find(var_2_9, "window/sliders/please/Text")

	i18n = var_2_9

	var_1(var_2_10, var_2_9("choose_ship_to_wear_this_skin"))

	setText = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_2.Find(var_2_11, "window/exchange_btn/Image")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("change"))

	setText = var_1

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_2.Find(var_2_13, "window/cancel_btn/Image")

	i18n = var_2_13

	var_1(var_2_14, var_2_13("word_cancel"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.OnConfirm(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.closeBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0._tf
	local var_3_11 = var_3.Find(var_3_10, "bg0")

	local function var_3_12()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_9, var_3_11, var_3_12, var_5)

	onToggle = var_1_10001

	local var_3_13 = arg_3_0
	local var_3_14 = arg_3_0.flagShipToggle

	local function var_3_15(arg_8_0)
		arg_3_0.flagShipMark = arg_8_0

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_13, var_3_14, var_3_15, var_5)

	onToggle = var_1_10001

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0.flagRandomToggle

	local function var_3_18(arg_9_0)
		arg_3_0.flagRandomMark = arg_9_0

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_16, var_3_17, var_3_18, var_5)

	return
end

function var_0_1.OnConfirm(arg_10_0)
	local var_10_1

	if not arg_10_0.selectIds or #arg_10_0.selectIds <= 0 then
		pg = var_10_1

		local var_10_0 = var_10_1.MsgboxMgr.GetInstance()

		var_10_1 = var_10_1.ShowMsgBox

		local var_10_2 = {}

		i18n = var_1_10004
		var_10_2.content = var_1_10004("new_skin_no_choose")

		function var_10_2.onYes()
			local var_11_0 = arg_10_0

			var_0.Hide(var_11_0)

			return
		end

		var_10_1(var_10_0, var_10_2)

		return
	end

	ipairs = var_10_1

	for iter_10_0, iter_10_1 in var_10_1(arg_10_0.selectIds) do
		ShipPhantom = var_1_10006

		local var_10_3

		var_1_10006, var_10_3 = var_1_10006.UnpackMark(iter_10_1)
		pg = var_1_10008

		local var_10_4 = var_1_10008.m02

		var_1_10008 = var_1_10008.sendNotification
		GAME = var_1_10010

		var_1_10008(var_10_4, var_1_10010.SET_SHIP_SKIN, {
			shipId = var_1_10006,
			phantomId = var_10_3,
			skinId = arg_10_0.skin.id
		})
	end

	arg_10_0:SetFlagRandomMark(arg_10_0.flagRandomMark)

	if arg_10_0.flagRandomMark then
		pg = var_1

		local var_10_5 = var_1.m02
		local var_10_6 = var_1.sendNotification

		GAME = var_3

		local var_10_7 = var_3.CHANGE_RANDOM_SHIPS
		local var_10_8 = {}

		underscore = iter_10_1
		var_10_8.addList = iter_10_1.to_array(arg_10_0.selectIds)
		var_10_8.deleteList = {}

		var_10_6(var_10_5, var_10_7, var_10_8)
	end

	arg_10_0:SetFlagShipMark(arg_10_0.flagShipMark)

	if arg_10_0.flagShipMark then
		arg_10_0:ShowAdmiral()
	else
		arg_10_0:Hide()
	end

	return
end

function var_0_1.Show(arg_12_0, arg_12_1)
	var_0_1.super.Show(arg_12_0)

	setActive = var_2

	local var_12_0 = arg_12_0._tf

	var_2(var_3.Find(var_12_0, "window"), true)

	setActive = var_2

	local var_12_1 = arg_12_0._tf

	var_2(var_3.Find(var_12_1, "select_skin"), false)

	pg = var_2

	local var_12_2 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_12_2, arg_12_0._tf)

	arg_12_0.selectIds = {}
	arg_12_0.skin = arg_12_1
	arg_12_0.ships = arg_12_0:GetShips(arg_12_1)
	triggerToggle = var_2

	var_2(arg_12_0.flagShipToggle, arg_12_0:GetFlagShipMark())

	triggerToggle = var_2

	var_2(arg_12_0.flagRandomToggle, arg_12_0:GetFlagRandomMark())
	arg_12_0:FlushShips()

	return
end

function var_0_1.ShowAdmiral(arg_13_0)
	setActive = var_1_10001

	local var_13_0 = arg_13_0._tf

	var_1_10001(var_2.Find(var_13_0, "window"), false)

	setActive = var_1_10001

	local var_13_1 = arg_13_0._tf

	var_1_10001(var_2.Find(var_13_1, "select_skin"), true)

	local var_13_2 = arg_13_0._tf
	local var_13_3 = var_1.Find(var_13_2, "select_skin")

	onButton = var_13_2

	local var_13_4 = arg_13_0
	local var_13_5 = var_13_3:Find("btnBack")

	local function var_13_6()
		local var_14_0 = arg_13_0

		var_0.Hide(var_14_0)

		return
	end

	SFX_CANCEL = var_6

	var_13_2(var_13_4, var_13_5, var_13_6, var_6)

	arg_13_0.selectIndex = 1
	onButton = var_2

	local var_13_7 = arg_13_0
	local var_13_8 = var_13_3:Find("exchange_btn")

	local function var_13_9()
		local var_15_0 = arg_13_0.selectIds[1]

		getProxy = var_2_10001
		PlayerProxy = var_2_10002

		local var_15_1 = var_2_10001(var_2_10002)
		local var_15_2 = var_1.getRawData(var_15_1)
		local var_15_3 = var_1.GetShipPhantomMarks(var_15_2)

		var_15_3[arg_13_0.selectIndex] = var_15_0
		pg = var_2

		local var_15_4 = var_2.m02
		local var_15_5 = var_2.sendNotification

		GAME = var_2_10004

		var_15_5(var_15_4, var_2_10004.CHANGE_PLAYER_ICON, {
			skinPage = true,
			after = var_15_3
		})

		local var_15_6 = arg_13_0

		var_2.Hide(var_15_6)

		return
	end

	SFX_CONFIRM = var_6

	var_2(var_13_7, var_13_8, var_13_9, var_6)

	arg_13_0.paintingInfo = {}
	PlayerVitaeShipsPage = var_2

	local var_13_10, var_13_11 = var_2.GetSlotMaxCnt()

	getProxy = var_13_8
	PlayerProxy = var_13_9

	local var_13_12 = var_13_8(var_13_9)
	local var_13_13 = var_4.getRawData(var_13_12)
	local var_13_14 = var_4.GetShipPhantomMarks(var_13_13)
	local var_13_15 = var_13_3
	local var_13_16 = var_13_3.Find(var_13_15, "frame/style_scroll/view_port")

	UIItemList = var_13_15

	var_13_15.StaticAlign(var_13_16, var_13_16:GetChild(0), var_13_10, function(arg_16_0, arg_16_1, arg_16_2)
		arg_16_1 = arg_16_1 + 1
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			onToggle = var_3

			local var_16_0 = arg_13_0
			local var_16_1 = arg_16_2

			local function var_16_2(arg_17_0)
				if arg_17_0 then
					arg_13_0.selectIndex = arg_16_1
				end

				return
			end

			SFX_PANEL = var_2_10007

			var_3(var_16_0, var_16_1, var_16_2, var_2_10007)

			if var_13_14[arg_16_1] then
				getProxy = var_3
				BayProxy = var_16_0
				var_16_0 = var_3(var_16_0)

				local var_16_3

				if not var_3.GetShipPhantom(var_16_0, var_13_14[arg_16_1]) then
					var_16_3 = nil
				end

				setActive = var_16_0

				var_16_0(arg_16_2:Find("Style_card"), var_16_3)

				setActive = var_16_0

				var_16_0(arg_16_2:Find("empty"), not var_16_3)

				local var_16_4

				if var_16_3 then
					var_16_4 = var_16_3
					var_16_0 = var_16_3.getSkinId(var_16_4)
					pg = var_16_4
					var_16_4 = var_16_4.ship_skin_template[var_16_0]

					local var_16_5 = arg_13_0.paintingInfo
					local var_16_6 = {}
					local var_16_7

					if not var_16_4.painting then
						var_16_7 = "unknown"
					end

					var_16_6.paintingName = var_16_7
					var_16_6.painting = arg_16_2:Find("Style_card/bg/mask/painting")
					var_16_6.skinID = var_16_0
					var_16_5[arg_16_1] = var_16_6

					local var_16_8 = arg_13_0

					var_6.loadPainting(var_16_8, arg_13_0.paintingInfo[arg_16_1])

					changeToScrollText = var_6

					var_6(arg_16_2:Find("Style_card/bg/desc/name_bar/name"), var_16_4.name)

					setToggleEnabled = var_6

					var_6(arg_16_2, true)
				else
					var_16_0 = var_13_11 < arg_16_1
					setActive = var_16_4

					var_16_4(arg_16_2:Find("empty/add"), not var_16_0)

					setActive = var_16_4

					var_16_4(arg_16_2:Find("empty/lock"), var_16_0)

					setText = var_16_4

					local var_16_9 = arg_16_2
					local var_16_10 = arg_16_2.Find(var_16_9, "empty/lock/Text")

					i18n = var_16_9

					var_16_4(var_16_10, var_16_9("secretary_unlock" .. arg_16_1))

					setToggleEnabled = var_16_4

					var_16_4(arg_16_2, not var_16_0)
				end

				triggerToggle = var_16_0

				var_16_0(arg_16_2, arg_16_1 == arg_13_0.selectIndex)

				return
			end
		end
	end)

	setText = var_6

	local var_13_17 = arg_13_0._tf
	local var_13_18 = var_7.Find(var_13_17, "select_skin/title/Text")

	i18n = var_13_17

	var_6(var_13_18, var_13_17("choose_secretary_change_title"))

	setText = var_6

	local var_13_19 = arg_13_0._tf
	local var_13_20 = var_7.Find(var_13_19, "select_skin/please")

	i18n = var_13_19

	var_6(var_13_20, var_13_19("choose_secretary_change_to_this_ship"))

	setText = var_6

	local var_13_21 = arg_13_0._tf
	local var_13_22 = var_7.Find(var_13_21, "select_skin/exchange_btn/Image")

	i18n = var_13_21

	var_6(var_13_22, var_13_21("change"))

	return
end

function var_0_1.GetFlagShipMark(arg_18_0)
	if arg_18_0.isNew then
		getProxy = var_1
		SettingsProxy = var_1_10002
		var_1_10002 = var_1(var_1_10002)

		return var_1.GetSetFlagShip(var_1_10002)
	else
		getProxy = var_1
		SettingsProxy = var_1_10002

		local var_18_0 = var_1(var_1_10002)

		return var_1.GetSetFlagShipForSkinAtlas(var_18_0)
	end

	return
end

function var_0_1.SetFlagShipMark(arg_19_0, arg_19_1)
	if arg_19_0.isNew then
		getProxy = var_2
		SettingsProxy = var_1_10003
		var_1_10003 = var_2(var_1_10003)

		var_2.SetFlagShip(var_1_10003, arg_19_1)
	else
		getProxy = var_2
		SettingsProxy = var_1_10003

		local var_19_0 = var_2(var_1_10003)

		var_2.SetFlagShipForSkinAtlas(var_19_0, arg_19_1)
	end

	return
end

function var_0_1.GetFlagRandomMark(arg_20_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10002

	local var_20_0 = var_1_10001(var_1_10002)

	return var_1.GetFlagRandom(var_20_0)
end

function var_0_1.SetFlagRandomMark(arg_21_0, arg_21_1)
	getProxy = var_1_10002
	SettingsProxy = var_1_10003

	local var_21_0 = var_1_10002(var_1_10003)

	var_2.SetFlagRandom(var_21_0, arg_21_1)

	return
end

function var_0_1.GetShips(arg_22_0, arg_22_1)
	getProxy = var_1_10002
	BayProxy = var_1_10003

	local var_22_0 = var_1_10002(var_1_10003)
	local var_22_1 = var_2.CanUseShareSkinPhantoms(var_22_0, arg_22_1.id)

	table = var_22_0

	local var_22_2 = var_22_0.sort
	local var_22_3 = var_22_1

	CompareFuncs = var_1_10005

	var_22_2(var_22_3, var_1_10005({
		function(arg_23_0)
			return -arg_23_0.level
		end,
		function(arg_24_0)
			return -arg_24_0:getStar()
		end,
		function(arg_25_0)
			return arg_25_0.inFleet and 0 or 1
		end,
		function(arg_26_0)
			return arg_26_0.createTime
		end,
		function(arg_27_0)
			return arg_27_0.phantomId
		end
	}))

	return var_22_1
end

function var_0_1.FlushShips(arg_28_0)
	UIItemList = var_1_10001

	var_1_10001.StaticAlign(arg_28_0.shipContent, arg_28_0.shipCardTpl, #arg_28_0.ships, function(arg_29_0, arg_29_1, arg_29_2)
		arg_29_1 = arg_29_1 + 1
		UIItemList = var_2_10003

		if arg_29_0 == var_2_10003.EventUpdate then
			local var_29_0 = arg_28_0.ships[arg_29_1]

			ShipDetailCard = var_2_10004

			local var_29_1 = var_2_10004.New(arg_29_2.gameObject)

			var_4.update(var_29_1, var_29_0, arg_28_0.skin.id)

			local var_29_2 = var_29_0:getSkinId() == arg_28_0.skin.id

			setActive = var_6

			var_6(var_4.maskStatusOb, var_29_2)

			setText = var_6

			local var_29_3 = var_4.maskStatusOb
			local var_29_4 = var_7.Find(var_29_3, "Text")
			local var_29_5 = "-  "

			i18n = var_9

			var_6(var_29_4, var_29_5 .. var_9("shop_skin_already_inuse") .. "  -")

			setActive = var_6

			var_6(arg_29_2:Find("phantom_mark"), var_29_0.phantomId > 0)

			onToggle = var_6

			local var_29_6 = arg_28_0
			local var_29_7 = var_4.tr

			local function var_29_8(arg_30_0)
				local var_30_0 = var_29_0

				if var_1.getSkinId(var_30_0) == arg_28_0.skin.id then
					return
				end

				local var_30_1 = var_0

				var_1.updateSelected(var_30_1, arg_30_0)

				local var_30_2

				if arg_30_0 then
					table = var_30_2
					var_30_2 = var_30_2.insert

					local var_30_3 = arg_28_0.selectIds
					local var_30_4 = var_0.shipVO

					var_30_2(var_30_3, var_3.GetSelectMark(var_30_4))
				else
					table = var_30_2

					local var_30_5 = var_30_2.removebyvalue
					local var_30_6 = arg_28_0.selectIds
					local var_30_7 = var_0.shipVO

					var_30_5(var_30_6, var_3.GetSelectMark(var_30_7))
				end

				return
			end

			SFX_PANEL = var_10

			var_6(var_29_6, var_29_7, var_29_8, var_10)
		end

		return
	end)

	return
end

function var_0_1.Hide(arg_31_0)
	var_0_1.super.Hide(arg_31_0)

	pg = var_1

	local var_31_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_31_0, arg_31_0._tf, arg_31_0._parentTf)

	arg_31_0.selectIds = {}
	existCall = var_1

	var_1(arg_31_0.hideCallback)

	return
end

function var_0_1.loadPainting(arg_32_0, arg_32_1)
	checkABExist = var_1_10002

	local var_32_0 = var_1_10002("painting/" .. arg_32_1.paintingName .. "_n")

	setPaintingPrefabAsync = var_3

	var_3(arg_32_1.painting, arg_32_1.paintingName, "pifu", nil, {
		rotateZ = 0,
		skinID = arg_32_1.skinID
	})

	return
end

function var_0_1.clearPainting(arg_33_0, arg_33_1)
	if arg_33_1.paintingName then
		retPaintingPrefab = var_2

		var_2(arg_33_1.painting, arg_33_1.paintingName)

		arg_33_1.paintingName = nil
	end

	return
end

function var_0_1.OnDestroy(arg_34_0)
	if arg_34_0:isShowing() then
		arg_34_0:Hide()
	end

	if arg_34_0.paintingInfo then
		pairs = var_1

		for iter_34_0, iter_34_1 in var_1(arg_34_0.paintingInfo) do
			arg_34_0:clearPainting(iter_34_1)
		end
	end

	arg_34_0.shipCards = nil
	arg_34_0.selectIds = nil

	return
end

return var_0_1
