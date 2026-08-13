class = var_0_10000

local var_0_0 = "PlayerVitaeShipsPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 1

var_0_1.RANDOM_FLAG_SHIP_PAGE = 2
var_0_1.EDUCATE_CHAR_SLOT_ID = 6
var_0_1.ON_BEGIN_DRAG_CARD = "PlayerVitaeShipsPage:ON_BEGIN_DRAG_CARD"
var_0_1.ON_DRAGING_CARD = "PlayerVitaeShipsPage:ON_DRAGING_CARD"
var_0_1.ON_DRAG_END_CARD = "PlayerVitaeShipsPage:ON_DRAG_END_CARD"

function var_0_1.GetSlotIndexList()
	local var_1_0, var_1_1 = var_0_1.GetSlotMaxCnt()
	local var_1_2 = {}

	for iter_1_0 = 1, var_1_1 do
		table = var_1_10007

		var_1_10007.insert(var_1_2, iter_1_0)
	end

	NewEducateHelper = var_3

	if var_3.GetEducateCharSlotMaxCnt() > 0 then
		table = var_3

		var_3.insert(var_1_2, var_0_1.EDUCATE_CHAR_SLOT_ID)
	end

	return var_1_2
end

function var_0_1.GetAllUnlockSlotCnt()
	local var_2_0, var_2_1 = var_0_1.GetSlotMaxCnt()

	NewEducateHelper = var_1_10002

	return var_2_1 + var_1_10002.GetEducateCharSlotMaxCnt()
end

function var_0_1.GetSlotMaxCnt()
	pg = var_1_10000

	local var_3_0 = var_0[#var_1_10000.gameset.secretary_group_unlock.description][2]
	local var_3_1 = 1

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(var_0) do
		getProxy = var_1_10008
		ChapterProxy = var_1_10010
		var_1_10010 = var_1_10008(var_1_10010)

		if var_1_10008.isClear(var_1_10010, iter_3_1[1]) then
			var_3_1 = iter_3_1[2]
		end
	end

	return var_3_0, var_3_1
end

function var_0_1.getUIName(arg_4_0)
	return "PlayerVitaeShipsPage"
end

function var_0_1.UpdateCard(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.cards[var_0_2]

	ipairs = var_3

	for iter_5_0, iter_5_1 in var_3(var_5_0) do
		isActive = var_1_10008

		if var_1_10008(iter_5_1._tf) and iter_5_1.displayShip then
			local var_5_1 = iter_5_1.displayShip

			if var_1_10008.GetShipPhantomMark(var_5_1) == arg_5_1 then
				iter_5_1:Refresh()

				break
			end
		end
	end

	return
end

function var_0_1.UpdateCardPaintingTag(arg_6_0)
	local var_6_0 = arg_6_0.cards[var_0_2]

	ipairs = var_2

	for iter_6_0, iter_6_1 in var_2(var_6_0) do
		iter_6_1:updatePaintingTag()
	end

	return
end

function var_0_1.RefreshShips(arg_7_0)
	arg_7_0:Update()

	return
end

function var_0_1.OnLoaded(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.cardContainer = var_1.Find(var_8_0, "frame")

	local var_8_1 = arg_8_0._tf

	arg_8_0.shipTpl = var_1.Find(var_8_1, "frame/shipCard")

	local var_8_2 = arg_8_0._tf

	arg_8_0.emptyTpl = var_1.Find(var_8_2, "frame/addCard")

	local var_8_3 = arg_8_0._tf

	arg_8_0.lockTpl = var_1.Find(var_8_3, "frame/lockCard")

	local var_8_4 = arg_8_0._tf

	arg_8_0.helpBtn = var_1.Find(var_8_4, "help_btn")

	local var_8_5 = arg_8_0._tf

	arg_8_0.settingBtn = var_1.Find(var_8_5, "setting_btn")

	local var_8_6 = arg_8_0.settingBtn

	arg_8_0.settingBtnSlider = var_1.Find(var_8_6, "toggle/on")

	local var_8_7 = arg_8_0._tf

	arg_8_0.randomBtn = var_1.Find(var_8_7, "ran_setting_btn")

	local var_8_8 = arg_8_0.randomBtn

	arg_8_0.randomBtnSlider = var_1.Find(var_8_8, "toggle/on")

	local var_8_9 = arg_8_0._tf

	arg_8_0.settingSeceneBtn = var_1.Find(var_8_9, "setting_scene_btn")

	local var_8_10 = arg_8_0._tf

	arg_8_0.nativeBtn = var_1.Find(var_8_10, "native_setting_btn")

	local var_8_11 = arg_8_0.nativeBtn

	arg_8_0.nativeBtnOn = var_1.Find(var_8_11, "on")

	local var_8_12 = arg_8_0.nativeBtn

	arg_8_0.nativeBtnOff = var_1.Find(var_8_12, "off")

	local var_8_13 = arg_8_0._tf

	arg_8_0.getMailBtn = var_1.Find(var_8_13, "get_mail")

	local var_8_14 = arg_8_0._tf

	arg_8_0.educateCharTr = var_1.Find(var_8_14, "educate_char")
	UIItemList = var_1

	local var_8_15 = var_1.New
	local var_8_16 = arg_8_0._tf
	local var_8_17 = var_3.Find(var_8_16, "educate_char/shipCard/settings/panel")
	local var_8_18 = arg_8_0._tf

	arg_8_0.educateCharSettingList = var_8_15(var_8_17, var_4.Find(var_8_18, "educate_char/shipCard/settings/panel/tpl"))

	local var_8_19 = arg_8_0._tf

	arg_8_0.educateCharSettingBtn = var_1.Find(var_8_19, "educate_char/shipCard/settings/tpl")

	local var_8_20 = arg_8_0.educateCharTr

	arg_8_0.educateCharTrTip = var_1.Find(var_8_20, "tip")
	LOCK_EDUCATE_SYSTEM = var_1

	if var_1 then
		setActive = var_1

		var_1(arg_8_0.educateCharTr, false)

		setAnchoredPosition = var_1

		var_1(arg_8_0.cardContainer, {
			x = 0
		})

		setAnchoredPosition = var_1

		local var_8_21 = arg_8_0._tf

		var_1(var_8_20.Find(var_8_21, "flagship"), {
			x = -720
		})

		setAnchoredPosition = var_1

		local var_8_22 = arg_8_0._tf

		var_1(var_8_20.Find(var_8_22, "zs"), {
			x = 763
		})

		setAnchoredPosition = var_1

		local var_8_23 = arg_8_0._tf

		var_1(var_8_20.Find(var_8_23, "line"), {
			x = 740
		})
	end

	local var_8_24 = {}
	local var_8_25 = var_0_2

	PlayerVitaeEducateShipCard = var_8_20

	local var_8_26 = var_8_20.New
	local var_8_27 = arg_8_0._tf

	var_8_24[var_8_25] = var_8_26(var_5.Find(var_8_27, "educate_char/shipCard"), arg_8_0.event)

	local var_8_28 = var_0_3

	PlayerVitaeEducateAddCard = var_3

	local var_8_29 = var_3.New
	local var_8_30 = arg_8_0._tf

	var_8_24[var_8_28] = var_8_29(var_5.Find(var_8_30, "educate_char/addCard"), arg_8_0.event)

	local var_8_31 = var_0_4

	PlayerVitaeEducateLockCard = var_3

	local var_8_32 = var_3.New
	local var_8_33 = arg_8_0._tf

	var_8_24[var_8_31] = var_8_32(var_5.Find(var_8_33, "educate_char/lockCard"), arg_8_0.event)
	arg_8_0.educateCharCards = var_8_24

	local var_8_34 = arg_8_0._tf
	local var_8_35 = var_1.Find(var_8_34, "tip")
	local var_8_36 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_8_0.tip = var_8_36(var_8_35, var_4(var_6))

	local var_8_37 = arg_8_0._tf

	arg_8_0.flagShipMark = var_1.Find(var_8_37, "flagship")

	arg_8_0:bind(var_0_1.ON_BEGIN_DRAG_CARD, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_8_0

		var_2.OnBeginDragCard(var_9_0, arg_9_1)

		return
	end)
	arg_8_0:bind(var_0_1.ON_DRAGING_CARD, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_8_0

		var_2.OnDragingCard(var_10_0, arg_10_1)

		return
	end)
	arg_8_0:bind(var_0_1.ON_DRAG_END_CARD, function(arg_11_0)
		local var_11_0 = arg_8_0

		var_1.OnEndDragCard(var_11_0)

		return
	end)

	setText = var_1

	local var_8_38 = arg_8_0.nativeBtnOn
	local var_8_39 = var_3.Find(var_8_38, "Text")

	i18n = var_4

	var_1(var_8_39, var_4("random_ship_before"))

	setText = var_1

	local var_8_40 = arg_8_0.nativeBtnOff
	local var_8_41 = var_3.Find(var_8_40, "Text")

	i18n = var_4

	var_1(var_8_41, var_4("random_ship_now"))

	setText = var_1

	local var_8_42 = arg_8_0.settingBtn
	local var_8_43 = var_3.Find(var_8_42, "Text")

	i18n = var_4

	var_1(var_8_43, var_4("player_vitae_skin_setting"))

	setText = var_1

	local var_8_44 = arg_8_0.randomBtn
	local var_8_45 = var_3.Find(var_8_44, "Text")

	i18n = var_4

	var_1(var_8_45, var_4("random_ship_label"))

	setText = var_1

	local var_8_46 = arg_8_0.settingSeceneBtn
	local var_8_47 = var_3.Find(var_8_46, "Text")

	i18n = var_4

	var_1(var_8_47, var_4("playervtae_setting_btn_label"))

	setText = var_1

	local var_8_48 = arg_8_0.getMailBtn
	local var_8_49 = var_3.Find(var_8_48, "Text")

	i18n = var_4

	var_1(var_8_49, var_4("spring_present_tips_btn"))

	setText = var_1

	local var_8_50 = arg_8_0.getMailBtn
	local var_8_51 = var_3.Find(var_8_50, "time")

	i18n = var_4

	var_1(var_8_51, var_4("spring_present_tips_time"))

	GetOrAddComponent = var_1

	local var_8_52 = arg_8_0.cardContainer

	typeof = var_4
	CanvasGroup = var_6
	arg_8_0.cardContainerCG = var_1(var_8_52, var_4(var_6))

	return
end

function var_0_1.OnBeginDragCard(arg_12_0, arg_12_1)
	arg_12_0.dragIndex = arg_12_1
	arg_12_0.displayCards = {}
	arg_12_0.displayPos = {}

	local var_12_0 = arg_12_0.cards[var_0_2]

	ipairs = var_3

	for iter_12_0, iter_12_1 in var_3(var_12_0) do
		isActive = var_1_10008

		if var_1_10008(iter_12_1._tf) then
			var_1_10008 = arg_12_0.displayCards
			var_1_10008[iter_12_0] = iter_12_1
			var_1_10008 = arg_12_0.displayPos
			var_1_10008[iter_12_0] = iter_12_1._tf.localPosition
		end
	end

	pairs = var_3

	for iter_12_2, iter_12_3 in var_3(arg_12_0.displayCards) do
		if iter_12_2 ~= arg_12_1 then
			iter_12_3:DisableDrag()
		end
	end

	return
end

function var_0_1.OnDragingCard(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.displayCards[arg_13_0.dragIndex - 1]
	local var_13_1 = arg_13_0.displayCards[arg_13_0.dragIndex + 1]

	if var_13_0 and arg_13_0:ShouldSwap(arg_13_1, arg_13_0.dragIndex - 1) then
		arg_13_0:Swap(arg_13_0.dragIndex, arg_13_0.dragIndex - 1)
	elseif var_13_1 and arg_13_0:ShouldSwap(arg_13_1, arg_13_0.dragIndex + 1) then
		arg_13_0:Swap(arg_13_0.dragIndex, arg_13_0.dragIndex + 1)
	end

	return
end

function var_0_1.Swap(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.displayCards[arg_14_1]
	local var_14_1 = arg_14_0.displayPos[arg_14_1]

	arg_14_0.displayCards[arg_14_2]._tf.localPosition = var_14_1
	arg_14_0.displayCards[arg_14_1], arg_14_0.displayCards[arg_14_2] = arg_14_0.displayCards[arg_14_2], arg_14_0.displayCards[arg_14_1]
	arg_14_0.dragIndex = arg_14_2
	var_14_0.slotIndex = arg_14_2
	var_5.slotIndex = arg_14_1
	var_14_0.typeIndex, var_5.typeIndex = var_5.typeIndex, var_14_0.typeIndex
	var_6[arg_14_1], var_6[arg_14_2] = arg_14_0.cards[var_0_2][arg_14_2], var_6[arg_14_1]

	return
end

function var_0_1.ShouldSwap(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.displayPos[arg_15_2]

	math = var_1_10004

	return var_1_10004.abs(var_15_0.x - arg_15_1.x) <= 130
end

function var_0_1.OnEndDragCard(arg_16_0)
	local var_16_0 = arg_16_0.displayPos[arg_16_0.dragIndex]

	arg_16_0.displayCards[arg_16_0.dragIndex]._tf.localPosition = var_16_0

	local var_16_1 = {}

	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_16_2 = var_1_10004(var_1_10006)
	local var_16_3 = var_4.getRawData(var_16_2)
	local var_16_4 = var_4.GetShipPhantomMarks(var_16_3)
	local var_16_5 = false

	pairs = var_16_3

	for iter_16_0, iter_16_1 in var_16_3(arg_16_0.displayCards) do
		iter_16_1:EnableDrag()

		table = var_12

		local var_16_6 = var_12.insert
		local var_16_7 = var_16_1
		local var_16_8 = iter_16_1.displayShip

		var_16_6(var_16_7, var_15.GetShipPhantomMark(var_16_8))

		if not var_16_5 and var_16_4[#var_16_1] ~= var_16_1[#var_16_1] then
			var_16_5 = true
		end
	end

	arg_16_0.dragIndex = nil
	arg_16_0.displayCards = nil
	arg_16_0.displayPos = nil
	arg_16_0.cardContainerCG.blocksRaycasts = false

	if var_16_5 then
		local var_16_9 = arg_16_0
		local var_16_10 = arg_16_0.emit

		PlayerVitaeMediator = iter_16_0

		var_16_10(var_16_9, iter_16_0.CHANGE_PAINTS, var_16_1, function()
			Timer = var_2_10000

			local var_17_0 = var_2_10000.New(function()
				if arg_16_0.cardContainerCG then
					arg_16_0.cardContainerCG.blocksRaycasts = true
				end

				return
			end, 0.3, 1)

			var_0.Start(var_17_0)

			return
		end)
	else
		arg_16_0.cardContainerCG.blocksRaycasts = true
	end

	return
end

function var_0_1.OnInit(arg_19_0)
	onButton = var_1_10001

	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.helpBtn

	local function var_19_2()
		pg = var_2_10000

		local var_20_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_20_1 = var_0.ShowMsgBox
		local var_20_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_20_2.type = var_2_10004
		i18n = var_2_10004
		var_20_2.helps = var_2_10004("secretary_help")

		var_20_1(var_20_0, var_20_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_19_0, var_19_1, var_19_2, var_1_10006)

	local var_19_3 = false

	local function var_19_4()
		local var_21_0 = {
			68,
			-68
		}

		setAnchoredPosition = var_2_10001

		var_2_10001(arg_19_0.settingBtnSlider, {
			x = var_21_0[var_19_3 and 1 or 2]
		})

		return
	end

	onButton = var_19_0

	local var_19_5 = arg_19_0
	local var_19_6 = arg_19_0.settingBtn

	local function var_19_7()
		var_19_3 = not var_19_3

		local var_22_0 = arg_19_0

		var_0.EditCards(var_22_0, var_19_3)
		var_19_4()

		return
	end

	SFX_PANEL = var_1_10008

	var_19_0(var_19_5, var_19_6, var_19_7, var_1_10008)
	var_19_4()

	getProxy = var_3
	SettingsProxy = var_19_5

	local var_19_8 = var_3(var_19_5)

	arg_19_0.randomFlag = var_3.IsOpenRandomFlagShip(var_19_8)
	arg_19_0.nativeFlag = false

	local function var_19_9()
		local var_23_0 = {
			68,
			-68
		}

		setAnchoredPosition = var_2_10001

		var_2_10001(arg_19_0.randomBtnSlider, {
			x = var_23_0[arg_19_0.randomFlag and 1 or 2]
		})

		setActive = var_2_10001

		var_2_10001(arg_19_0.nativeBtn, arg_19_0.randomFlag)

		setActive = var_2_10001

		var_2_10001(arg_19_0.flagShipMark, not arg_19_0.randomFlag or arg_19_0.nativeFlag)

		if arg_19_0.randomFlag and var_19_3 then
			triggerButton = var_1

			var_1(arg_19_0.settingBtn)
		end

		return
	end

	local function var_19_10()
		setActive = var_2_10000

		var_2_10000(arg_19_0.nativeBtnOn, arg_19_0.nativeFlag)

		setActive = var_2_10000

		var_2_10000(arg_19_0.nativeBtnOff, not arg_19_0.nativeFlag)

		setActive = var_2_10000

		var_2_10000(arg_19_0.flagShipMark, not arg_19_0.randomFlag or arg_19_0.nativeFlag)

		if var_19_3 then
			triggerButton = var_0

			var_0(arg_19_0.settingBtn)
		end

		return
	end

	onButton = var_19_8

	local var_19_11 = arg_19_0
	local var_19_12 = arg_19_0.randomBtn

	local function var_19_13()
		arg_19_0.randomFlag = not arg_19_0.randomFlag

		local var_25_2

		if arg_19_0.randomFlag then
			MainRandomFlagShipSequence = var_0

			local var_25_0 = var_0.New()

			if not var_0.Random(var_25_0) or #var_0 <= 0 then
				pg = var_25_2

				local var_25_1 = var_25_2.TipsMgr.GetInstance()

				var_25_2 = var_25_2.ShowTips
				i18n = var_2_10004

				var_25_2(var_25_1, var_2_10004("random_ship_off_0"))

				var_25_2 = arg_19_0
				var_25_2.randomFlag = not arg_19_0.randomFlag

				return
			end

			local var_25_3 = var_0

			var_25_2.UpdateRandomFlagShipList(var_25_3, var_0)
		else
			local var_25_4 = var_0

			var_0.UpdateRandomFlagShipList(var_25_4, {})

			arg_19_0.nativeFlag = false

			var_19_10()
		end

		local var_25_5 = arg_19_0
		local var_25_6 = var_0.SwitchToPage
		local var_25_7

		if not arg_19_0.randomFlag or not var_0 then
			var_25_7 = var_0_5
		end

		var_25_6(var_25_5, var_25_7)
		var_19_9()

		if arg_19_0.randomFlag then
			i18n = var_25_8

			local var_25_8

			if not var_25_8("random_ship_on") then
				i18n = var_25_8
				var_25_8 = var_25_8("random_ship_off")
			end

			pg = var_25_2

			local var_25_9 = var_25_2.TipsMgr.GetInstance()

			var_1.ShowTips(var_25_9, var_25_8)

			local var_25_10 = arg_19_0
			local var_25_11 = var_1.emit

			PlayerVitaeMediator = var_4

			var_25_11(var_25_10, var_4.ON_SWITCH_RANDOM_FLAG_SHIP_BTN, arg_19_0.randomFlag)

			return
		end
	end

	SFX_PANEL = var_1_10011

	var_19_8(var_19_11, var_19_12, var_19_13, var_1_10011)
	var_19_9()

	onButton = var_6

	local var_19_14 = arg_19_0
	local var_19_15 = arg_19_0.nativeBtn

	local function var_19_16()
		arg_19_0.nativeFlag = not arg_19_0.nativeFlag

		var_19_10()

		local var_26_0 = arg_19_0
		local var_26_1 = var_0.SwitchToPage
		local var_26_2

		if not arg_19_0.nativeFlag or not var_0_5 then
			var_26_2 = var_0
		end

		var_26_1(var_26_0, var_26_2)

		return
	end

	SFX_PANEL = var_1_10011

	var_6(var_19_14, var_19_15, var_19_16, var_1_10011)
	var_19_10()

	onButton = var_6

	var_6(arg_19_0, arg_19_0.getMailBtn, function()
		local var_27_1

		if arg_19_0.randomFlag then
			pg = var_27_1

			local var_27_0 = var_27_1.TipsMgr.GetInstance()

			var_27_1 = var_27_1.ShowTips
			i18n = var_2_10003

			var_27_1(var_27_0, var_2_10003("spring_present_tips0"))

			return
		end

		pg = var_27_1

		local var_27_2 = var_27_1.MsgboxMgr.GetInstance()
		local var_27_3 = var_0.ShowMsgBox
		local var_27_4 = {}

		i18n = var_2_10004
		var_27_4.content = var_2_10004("spring_present_tips1")

		function var_27_4.onYes()
			getProxy = var_3_10000
			ActivityProxy = var_3_10002

			local var_28_0 = var_3_10000(var_3_10002)
			local var_28_1 = var_0.getActivityByType

			ActivityConst = var_3_10003

			if not var_28_1(var_28_0, var_3_10003.ACTIVITY_TYPE_LOVE_LETTER_MAIL) then
				setActive = var_3_10001

				var_3_10001(arg_19_0.getMailBtn, false)

				pg = var_3_10001

				local var_28_2 = var_3_10001.TipsMgr.GetInstance()
				local var_28_3 = var_1.ShowTips

				i18n = var_3_10004

				var_28_3(var_28_2, var_3_10004("challenge_end_tip"))

				return
			end

			local var_28_4 = arg_19_0
			local var_28_5 = var_1.emit

			PlayerVitaeMediator = var_3_10004

			var_28_5(var_28_4, var_3_10004.ON_GET_LOVE_LETTER_MAIL, var_0.id)

			return
		end

		var_27_3(var_27_2, var_27_4)

		return
	end)
	arg_19_0:UpdateGetMailBtn()

	onButton = var_6

	local var_19_17 = arg_19_0
	local var_19_18 = arg_19_0.educateCharSettingBtn

	local function var_19_19()
		isActive = var_2_10000

		local var_29_0 = var_2_10000(arg_19_0.educateCharSettingList.container)

		setActive = var_2_10001

		var_2_10001(arg_19_0.educateCharSettingList.container, not var_29_0)

		return
	end

	SFX_PANEL = var_1_10011

	var_6(var_19_17, var_19_18, var_19_19, var_1_10011)

	onButton = var_6

	local var_19_20 = arg_19_0
	local var_19_21 = arg_19_0.settingSeceneBtn

	local function var_19_22()
		arg_19_0.contextData.showSelectCharacters = true

		local var_30_0 = arg_19_0
		local var_30_1 = var_0.emit

		PlayerVitaeMediator = var_2_10003

		local var_30_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_30_3 = var_2_10004.SETTINGS
		local var_30_4 = {}

		NewSettingsScene = var_2_10006
		var_30_4.page = var_2_10006.PAGE_OPTION
		SettingsRandomFlagShipAndSkinPanel = var_6
		var_30_4.scroll = var_6

		var_30_1(var_30_0, var_30_2, var_30_3, var_30_4)

		return
	end

	SFX_PANEL = var_1_10011

	var_6(var_19_20, var_19_21, var_19_22, var_1_10011)

	arg_19_0.cards = {
		{},
		{},
		{}
	}
	table = var_6

	local var_19_23 = var_6.insert
	local var_19_24 = arg_19_0.cards[var_0_2]

	PlayerVitaeShipCard = var_9

	var_19_23(var_19_24, var_9.New(arg_19_0.shipTpl, arg_19_0.event))

	table = var_19_23

	local var_19_25 = var_19_23.insert
	local var_19_26 = arg_19_0.cards[var_0_3]

	PlayerVitaeAddCard = var_9

	var_19_25(var_19_26, var_9.New(arg_19_0.emptyTpl, arg_19_0.event))

	table = var_19_25

	local var_19_27 = var_19_25.insert
	local var_19_28 = arg_19_0.cards[var_0_4]

	PlayerVitaeLockCard = var_9

	var_19_27(var_19_28, var_9.New(arg_19_0.lockTpl, arg_19_0.event))

	return
end

function var_0_1.UpdateGetMailBtn(arg_31_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_31_0 = var_1_10001(var_1_10003)
	local var_31_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_31_2 = var_31_1(var_31_0, var_1_10004.ACTIVITY_TYPE_LOVE_LETTER_MAIL)

	setActive = var_1_10002

	var_1_10002(arg_31_0.getMailBtn, var_31_2 and not var_31_2:isEnd() and var_31_2:readyToAchieve())

	return
end

function var_0_1.Update(arg_32_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_32_0 = var_1_10001(var_1_10003)
	local var_32_1

	if arg_32_0.randomFlag and arg_32_0.nativeFlag then
		var_32_1 = var_0_5
	else
		var_32_1 = var_32_0:IsOpenRandomFlagShip() and var_0 or var_0_5
	end

	arg_32_0:SwitchToPage(var_32_1)
	arg_32_0:UpdateEducateChar()
	arg_32_0:UpdateGetMailBtn()
	arg_32_0:Show()

	return
end

function var_0_1.UpdateEducateChar(arg_33_0)
	arg_33_0:UpdateEducateCharSettings()
	arg_33_0:UpdateEducateSlot()
	arg_33_0:UpdateEducateCharTrTip()

	return
end

function var_0_1.UpdateEducateCharTrTip(arg_34_0)
	setActive = var_1_10001

	local var_34_0 = arg_34_0.educateCharTrTip

	getProxy = var_1_10004
	SettingsProxy = var_1_10006

	local var_34_1 = var_1_10004(var_1_10006)

	var_1_10001(var_34_0, var_4.ShouldEducateCharTip(var_34_1))

	return
end

local function var_0_6()
	NewEducateHelper = var_1_10000

	if var_1_10000.GetEducateCharSlotMaxCnt() <= 0 then
		return var_0_4
	end

	getProxy = var_0
	PlayerProxy = var_1_10002

	local var_35_0 = var_0(var_1_10002)
	local var_35_1 = var_0.getRawData(var_35_0)

	if var_0.ExistEducateChar(var_35_1) then
		return var_0_2
	end

	return var_0_3
end

function var_0_1.UpdateEducateSlot(arg_36_0)
	local var_36_0 = var_0_6()
	local var_36_1

	pairs = var_1_10003

	for iter_36_0, iter_36_1 in var_1_10003(arg_36_0.educateCharCards) do
		local var_36_2 = iter_36_0 == var_36_0

		iter_36_1:ShowOrHide(var_36_2)

		if var_36_2 then
			var_36_1 = iter_36_1
		end
	end

	var_36_1:Flush()

	return
end

function var_0_1.UpdateEducateCharSettings(arg_37_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_37_0 = var_1_10001(var_1_10003)

	local function var_37_1()
		local var_38_0 = var_37_0
		local var_38_1 = var_0.GetFlagShipDisplayMode(var_38_0)

		setText = var_2_10001

		local var_38_2 = arg_37_0.educateCharSettingBtn
		local var_38_3 = var_3.Find(var_38_2, "Text")

		i18n = var_2_10004

		var_2_10001(var_38_3, var_2_10004("flagship_display_mode_" .. var_38_1))

		return
	end

	local var_37_2 = {}

	FlAG_SHIP_DISPLAY_ONLY_SHIP = var_1_10004
	var_37_2[1] = var_1_10004
	FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR = var_1_10004
	var_37_2[2] = var_1_10004
	FlAG_SHIP_DISPLAY_ALL = var_1_10004
	var_37_2[3] = var_1_10004

	local var_37_3 = arg_37_0.educateCharSettingList

	var_4.make(var_37_3, function(arg_39_0, arg_39_1, arg_39_2)
		UIItemList = var_2_10003

		if arg_39_0 == var_2_10003.EventUpdate then
			local var_39_0 = var_37_2[arg_39_1 + 1]

			setText = var_4

			local var_39_1 = arg_39_2:Find("Text")

			i18n = var_2_10007

			var_4(var_39_1, var_2_10007("flagship_display_mode_" .. var_39_0))

			onButton = var_4

			local var_39_2 = arg_37_0
			local var_39_3 = arg_39_2

			local function var_39_4()
				local var_40_0 = var_37_0

				var_0.SetFlagShipDisplayMode(var_40_0, var_39_0)
				var_37_1()

				setActive = var_0

				var_0(arg_37_0.educateCharSettingList.container, false)

				return
			end

			SFX_PANEL = var_9

			var_4(var_39_2, var_39_3, var_39_4, var_9)

			setActive = var_4

			var_4(arg_39_2:Find("line"), arg_39_1 + 1 ~= #var_37_2)
		end

		return
	end)

	local var_37_4 = arg_37_0.educateCharSettingList

	var_4.align(var_37_4, #var_37_2)
	var_37_1()

	return
end

function var_0_1.SwitchToPage(arg_41_0, arg_41_1)
	local var_41_0

	if arg_41_1 == var_0 then
		_ = var_3

		local var_41_1 = var_3.select

		getProxy = var_1_10005
		SettingsProxy = var_1_10007
		var_1_10007 = var_1_10005(var_1_10007)
		var_41_0 = var_41_1(var_1_10005.GetRandomFlagShipList(var_1_10007), function(arg_42_0)
			getProxy = var_2_10001
			BayProxy = var_2_10003

			local var_42_0 = var_2_10001(var_2_10003)

			return var_1.GetShipPhantom(var_42_0, arg_42_0) ~= nil
		end)

		local var_41_2 = arg_41_0.tip

		i18n = var_1_10004
		var_41_2.text = var_1_10004("random_ship_tips1")
		var_1_10005 = arg_41_0

		local var_41_3 = arg_41_0.emit

		PlayerVitaeScene = var_6

		local var_41_4 = var_6.ON_PAGE_SWTICH

		PlayerVitaeScene = var_1_10007

		var_41_3(var_1_10005, var_41_4, var_1_10007.PAGE_RANDOM_SHIPS)
	elseif arg_41_1 == var_0_5 then
		getProxy = var_3
		PlayerProxy = var_1_10005

		local var_41_5 = var_3(var_1_10005)
		local var_41_6 = var_3.getRawData(var_41_5)

		var_41_0 = var_3.GetShipPhantomMarks(var_41_6)

		local var_41_7 = arg_41_0.tip

		i18n = var_1_10004
		var_41_7.text = var_1_10004("random_ship_tips2")

		local var_41_8 = arg_41_0
		local var_41_9 = arg_41_0.emit

		PlayerVitaeScene = var_6

		local var_41_10 = var_6.ON_PAGE_SWTICH

		PlayerVitaeScene = var_1_10007

		var_41_9(var_41_8, var_41_10, var_1_10007.PAGE_NATIVE_SHIPS)
	end

	arg_41_0:Flush(var_41_0, arg_41_1)

	setActive = var_3

	var_3(arg_41_0.tip.gameObject, arg_41_0.randomFlag)

	return
end

function var_0_1.Flush(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0, var_43_1 = var_0_1.GetSlotMaxCnt()

	arg_43_0.max = var_43_0
	arg_43_0.unlockCnt = var_43_1

	local var_43_2 = arg_43_0:GetUnlockShipCnt(arg_43_1)

	arg_43_0:UpdateCards(arg_43_2, arg_43_1, var_43_2)

	return
end

function var_0_1.UpdateCards(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = {
		0
	}
	local var_44_1 = {}

	ipairs = var_1_10006

	for iter_44_0, iter_44_1 in var_1_10006(arg_44_3) do
		table = var_1_10011

		var_1_10011.insert(var_44_1, function(arg_45_0)
			local var_45_0 = arg_44_0

			var_1.UpdateTypeCards(var_45_0, arg_44_1, arg_44_2, iter_44_0, iter_44_1, var_44_0, arg_45_0)

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_44_1)

	return
end

function var_0_1.UpdateTypeCards(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5, arg_46_6)
	local var_46_0 = {}
	local var_46_1 = arg_46_0.cards[arg_46_3]

	local function var_46_2(arg_47_0)
		local var_47_1

		if not var_46_1[arg_47_0] then
			local var_47_0 = var_46_1[1]

			var_47_1 = var_2.Clone(var_47_0)
			var_46_1[arg_47_0] = var_47_1
		end

		arg_46_5[1] = arg_46_5[1] + 1

		var_47_1:Enable()
		var_47_1:Update(arg_46_5[1], arg_47_0, arg_46_2, arg_46_1, arg_46_0.nativeFlag)

		return
	end

	for iter_46_0 = 1, arg_46_4 do
		table = var_1_10014

		var_1_10014.insert(var_46_0, function(arg_48_0)
			if arg_46_0.exited then
				return
			end

			var_46_2(iter_46_0)

			onNextTick = var_1

			var_1(arg_48_0)

			return
		end)
	end

	for iter_46_1 = #var_46_1, arg_46_4 + 1, -1 do
		local var_46_3 = var_46_1[iter_46_1]

		var_14.Disable(var_46_3)
	end

	seriesAsync = var_10

	var_10(var_46_0, arg_46_6)

	return
end

function var_0_1.GetUnlockShipCnt(arg_49_0, arg_49_1)
	local var_49_0 = 0
	local var_49_1 = 0
	local var_49_2 = 0
	local var_49_3 = #arg_49_1
	local var_49_4 = arg_49_0.unlockCnt - var_49_3
	local var_49_5 = arg_49_0.max - arg_49_0.unlockCnt

	return {
		var_49_3,
		var_49_4,
		var_49_5
	}
end

function var_0_1.EditCards(arg_50_0, arg_50_1)
	local var_50_0 = {
		var_0_2,
		var_0_3
	}

	ipairs = var_3

	for iter_50_0, iter_50_1 in var_3(var_50_0) do
		local var_50_1 = arg_50_0.cards[iter_50_1]

		ipairs = var_1_10009

		for iter_50_2, iter_50_3 in var_1_10009(var_50_1) do
			isActive = var_1_10014

			if var_1_10014(iter_50_3._tf) then
				iter_50_3:EditCard(arg_50_1)
			end
		end
	end

	arg_50_0.IsOpenEdit = arg_50_1

	return
end

function var_0_1.EditCardsForRandom(arg_51_0, arg_51_1)
	local var_51_0 = {}
	local var_51_1 = arg_51_0.cards[var_0_2]

	ipairs = var_4

	for iter_51_0, iter_51_1 in var_4(var_51_1) do
		isActive = var_1_10009

		if var_1_10009(iter_51_1._tf) then
			if not arg_51_1 then
				var_51_0[iter_51_1.slotIndex] = iter_51_1:GetRandomFlagValue()
			end

			iter_51_1:EditCardForRandom(arg_51_1)
		end
	end

	arg_51_0.IsOpenEditForRandom = arg_51_1

	if #var_51_0 > 0 then
		arg_51_0:SaveRandomSettings(var_51_0)
	end

	local var_51_2 = arg_51_0.cards[var_0_3]

	ipairs = var_5

	for iter_51_2, iter_51_3 in var_5(var_51_2) do
		isActive = var_1_10010

		if var_1_10010(iter_51_3._tf) then
			iter_51_3:EditCard(arg_51_1)
		end
	end

	return
end

function var_0_1.SaveRandomSettings(arg_52_0, arg_52_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_52_0 = var_1_10002(var_1_10004)
	local var_52_1 = var_2.getRawData(var_52_0)

	for iter_52_0 = 1, arg_52_0.max do
		if not arg_52_1[iter_52_0] then
			arg_52_1[iter_52_0] = var_52_1:RawGetRandomShipAndSkinValueInpos(iter_52_0)
		end
	end

	local var_52_2 = arg_52_0
	local var_52_3 = arg_52_0.emit

	PlayerVitaeMediator = iter_52_0

	var_52_3(var_52_2, iter_52_0.CHANGE_RANDOM_SETTING, arg_52_1)

	return
end

function var_0_1.Show(arg_53_0)
	var_0_1.super.Show(arg_53_0)

	Input = var_1
	var_1.multiTouchEnabled = false

	return
end

function var_0_1.Hide(arg_54_0)
	var_0_1.super.Hide(arg_54_0)

	if arg_54_0.IsOpenEdit then
		triggerButton = var_1

		var_1(arg_54_0.settingBtn)
	end

	if arg_54_0.IsOpenEditForRandom then
		triggerButton = var_1

		var_1(arg_54_0.randomBtn)
	end

	Input = var_1
	var_1.multiTouchEnabled = true

	local var_54_0 = arg_54_0
	local var_54_1 = arg_54_0.emit

	PlayerVitaeScene = var_1_10004

	local var_54_2 = var_1_10004.ON_PAGE_SWTICH

	PlayerVitaeScene = var_1_10005

	var_54_1(var_54_0, var_54_2, var_1_10005.PAGE_DEFAULT)

	return
end

function var_0_1.OnDestroy(arg_55_0)
	arg_55_0:Hide()

	pairs = var_1

	for iter_55_0, iter_55_1 in var_1(arg_55_0.cards) do
		pairs = var_1_10006

		for iter_55_2, iter_55_3 in var_1_10006(iter_55_1) do
			iter_55_3:Dispose()
		end
	end

	arg_55_0.exited = true

	return
end

return var_0_1
