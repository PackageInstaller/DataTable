local var_0_0 = class("PlayerVitaeShipsPage", import("...base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 1

var_0_0.RANDOM_FLAG_SHIP_PAGE = 2
var_0_0.EDUCATE_CHAR_SLOT_ID = 6
var_0_0.ON_BEGIN_DRAG_CARD = "PlayerVitaeShipsPage:ON_BEGIN_DRAG_CARD"
var_0_0.ON_DRAGING_CARD = "PlayerVitaeShipsPage:ON_DRAGING_CARD"
var_0_0.ON_DRAG_END_CARD = "PlayerVitaeShipsPage:ON_DRAG_END_CARD"

function var_0_0.GetSlotIndexList()
	local var_1_0, var_1_1 = var_0_0.GetSlotMaxCnt()

	for iter_1_0 = 1, var_1_1 do
		table.insert({}, iter_1_0)
	end

	if NewEducateHelper.GetEducateCharSlotMaxCnt() > 0 then
		table.insert({}, var_0_0.EDUCATE_CHAR_SLOT_ID)
	end

	return {}
end

function var_0_0.GetAllUnlockSlotCnt()
	local var_2_0, var_2_1 = var_0_0.GetSlotMaxCnt()

	return var_2_1 + NewEducateHelper.GetEducateCharSlotMaxCnt()
end

function var_0_0.GetSlotMaxCnt()
	local var_3_0 = 1

	for iter_3_0, iter_3_1 in ipairs(pg.gameset.secretary_group_unlock.description) do
		local var_3_1 = getProxy(ChapterProxy)

		if var_3_1:isClear(iter_3_1[1]) then
			var_3_0 = iter_3_1[2]
		end
	end

	return pg.gameset.secretary_group_unlock.description[#pg.gameset.secretary_group_unlock.description][2], var_3_0
end

function var_0_0.getUIName(arg_4_0)
	return "PlayerVitaeShipsPage"
end

function var_0_0.UpdateCard(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.cards[var_0_1]) do
		if isActive(iter_5_1._tf) and iter_5_1.displayShip and iter_5_1.displayShip:GetShipPhantomMark() == arg_5_1 then
			iter_5_1:Refresh()

			break
		end
	end

	return
end

function var_0_0.UpdateCardPaintingTag(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.cards[var_0_1]) do
		iter_6_1:updatePaintingTag()
	end

	return
end

function var_0_0.RefreshShips(arg_7_0)
	arg_7_0:Update()

	return
end

function var_0_0.OnLoaded(arg_8_0)
	arg_8_0.cardContainer = arg_8_0._tf:Find("frame")
	arg_8_0.shipTpl = arg_8_0._tf:Find("frame/shipCard")
	arg_8_0.emptyTpl = arg_8_0._tf:Find("frame/addCard")
	arg_8_0.lockTpl = arg_8_0._tf:Find("frame/lockCard")
	arg_8_0.helpBtn = arg_8_0._tf:Find("help_btn")
	arg_8_0.settingBtn = arg_8_0._tf:Find("setting_btn")
	arg_8_0.settingBtnSlider = arg_8_0.settingBtn:Find("toggle/on")
	arg_8_0.randomBtn = arg_8_0._tf:Find("ran_setting_btn")
	arg_8_0.randomBtnSlider = arg_8_0.randomBtn:Find("toggle/on")
	arg_8_0.settingSeceneBtn = arg_8_0._tf:Find("setting_scene_btn")
	arg_8_0.nativeBtn = arg_8_0._tf:Find("native_setting_btn")
	arg_8_0.nativeBtnOn = arg_8_0.nativeBtn:Find("on")
	arg_8_0.nativeBtnOff = arg_8_0.nativeBtn:Find("off")
	arg_8_0.getMailBtn = arg_8_0._tf:Find("get_mail")
	arg_8_0.educateCharTr = arg_8_0._tf:Find("educate_char")
	arg_8_0.educateCharSettingList = UIItemList.New(arg_8_0._tf:Find("educate_char/shipCard/settings/panel"), arg_8_0._tf:Find("educate_char/shipCard/settings/panel/tpl"))
	arg_8_0.educateCharSettingBtn = arg_8_0._tf:Find("educate_char/shipCard/settings/tpl")
	arg_8_0.educateCharTrTip = arg_8_0.educateCharTr:Find("tip")

	if LOCK_EDUCATE_SYSTEM then
		setActive(arg_8_0.educateCharTr, false)
		setAnchoredPosition(arg_8_0.cardContainer, {
			x = 0
		})
		setAnchoredPosition(arg_8_0._tf:Find("flagship"), {
			x = -720
		})
		setAnchoredPosition(arg_8_0._tf:Find("zs"), {
			x = 763
		})
		setAnchoredPosition(arg_8_0._tf:Find("line"), {
			x = 740
		})
	end

	arg_8_0.educateCharCards = {
		[var_0_1] = PlayerVitaeEducateShipCard.New(arg_8_0._tf:Find("educate_char/shipCard"), arg_8_0.event),
		[var_0_2] = PlayerVitaeEducateAddCard.New(arg_8_0._tf:Find("educate_char/addCard"), arg_8_0.event),
		[var_0_3] = PlayerVitaeEducateLockCard.New(arg_8_0._tf:Find("educate_char/lockCard"), arg_8_0.event)
	}
	arg_8_0.tip = arg_8_0._tf:Find("tip"):GetComponent(typeof(Text))
	arg_8_0.flagShipMark = arg_8_0._tf:Find("flagship")

	arg_8_0:bind(var_0_0.ON_BEGIN_DRAG_CARD, function(arg_9_0, arg_9_1)
		arg_8_0:OnBeginDragCard(arg_9_1)

		return
	end)
	arg_8_0:bind(var_0_0.ON_DRAGING_CARD, function(arg_10_0, arg_10_1)
		arg_8_0:OnDragingCard(arg_10_1)

		return
	end)
	arg_8_0:bind(var_0_0.ON_DRAG_END_CARD, function(arg_11_0)
		arg_8_0:OnEndDragCard()

		return
	end)
	setText(arg_8_0.nativeBtnOn:Find("Text"), i18n("random_ship_before"))
	setText(arg_8_0.nativeBtnOff:Find("Text"), i18n("random_ship_now"))
	setText(arg_8_0.settingBtn:Find("Text"), i18n("player_vitae_skin_setting"))
	setText(arg_8_0.randomBtn:Find("Text"), i18n("random_ship_label"))
	setText(arg_8_0.settingSeceneBtn:Find("Text"), i18n("playervtae_setting_btn_label"))
	setText(arg_8_0.getMailBtn:Find("Text"), i18n("spring_present_tips_btn"))
	setText(arg_8_0.getMailBtn:Find("time"), i18n("spring_present_tips_time"))

	arg_8_0.cardContainerCG = GetOrAddComponent(arg_8_0.cardContainer, typeof(CanvasGroup))

	return
end

function var_0_0.OnBeginDragCard(arg_12_0, arg_12_1)
	arg_12_0.dragIndex = arg_12_1
	arg_12_0.displayCards = {}
	arg_12_0.displayPos = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.cards[var_0_1]) do
		if isActive(iter_12_1._tf) then
			arg_12_0.displayCards[iter_12_0] = iter_12_1
			arg_12_0.displayPos[iter_12_0] = iter_12_1._tf.localPosition
		end
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0.displayCards) do
		if iter_12_2 ~= arg_12_1 then
			iter_12_3:DisableDrag()
		end
	end

	return
end

function var_0_0.OnDragingCard(arg_13_0, arg_13_1)
	if arg_13_0.displayCards[arg_13_0.dragIndex - 1] and arg_13_0:ShouldSwap(arg_13_1, arg_13_0.dragIndex - 1) then
		arg_13_0:Swap(arg_13_0.dragIndex, arg_13_0.dragIndex - 1)
	elseif arg_13_0.displayCards[arg_13_0.dragIndex + 1] and arg_13_0:ShouldSwap(arg_13_1, arg_13_0.dragIndex + 1) then
		arg_13_0:Swap(arg_13_0.dragIndex, arg_13_0.dragIndex + 1)
	end

	return
end

function var_0_0.Swap(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.displayCards[arg_14_1]
	local var_14_1 = arg_14_0.displayCards[arg_14_2]

	arg_14_0.displayCards[arg_14_2]._tf.localPosition = arg_14_0.displayPos[arg_14_1]
	arg_14_0.displayCards[arg_14_1], arg_14_0.displayCards[arg_14_2] = arg_14_0.displayCards[arg_14_2], arg_14_0.displayCards[arg_14_1]
	arg_14_0.dragIndex = arg_14_2
	arg_14_0.displayCards[arg_14_1].slotIndex = arg_14_2
	arg_14_0.displayCards[arg_14_2].slotIndex = arg_14_1
	var_14_0.typeIndex, var_14_1.typeIndex = arg_14_0.displayCards[arg_14_2].typeIndex, arg_14_0.displayCards[arg_14_1].typeIndex

	local var_14_2 = arg_14_0.cards[var_0_1]

	var_14_2[arg_14_1], var_14_2[arg_14_2] = arg_14_0.cards[var_0_1][arg_14_2], arg_14_0.cards[var_0_1][arg_14_1]

	return
end

function var_0_0.ShouldSwap(arg_15_0, arg_15_1, arg_15_2)
	return math.abs(arg_15_0.displayPos[arg_15_2].x - arg_15_1.x) <= 130
end

function var_0_0.OnEndDragCard(arg_16_0)
	arg_16_0.displayCards[arg_16_0.dragIndex]._tf.localPosition = arg_16_0.displayPos[arg_16_0.dragIndex]

	local var_16_0 = getProxy(PlayerProxy):getRawData():GetShipPhantomMarks()
	local var_16_1 = false

	for iter_16_0, iter_16_1 in pairs(arg_16_0.displayCards) do
		iter_16_1:EnableDrag()
		table.insert({}, iter_16_1.displayShip:GetShipPhantomMark())

		if not var_16_1 and var_16_0[#{}] ~= ({})[#{}] then
			var_16_1 = true
		end
	end

	arg_16_0.dragIndex = nil
	arg_16_0.displayCards = nil
	arg_16_0.displayPos = nil
	arg_16_0.cardContainerCG.blocksRaycasts = false

	if var_16_1 then
		arg_16_0:emit(PlayerVitaeMediator.CHANGE_PAINTS, {}, function()
			Timer.New(function()
				if arg_16_0.cardContainerCG then
					arg_16_0.cardContainerCG.blocksRaycasts = true
				end

				return
			end, 0.3, 1):Start()

			return
		end)
	else
		arg_16_0.cardContainerCG.blocksRaycasts = true
	end

	return
end

function var_0_0.OnInit(arg_19_0)
	onButton(arg_19_0, arg_19_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("secretary_help")
		})

		return
	end, SFX_PANEL)

	local var_19_0 = false

	local function var_19_1()
		setAnchoredPosition(arg_19_0.settingBtnSlider, {
			x = ({
				68,
				-68
			})[var_19_0 and 1 or 2]
		})

		return
	end

	onButton(arg_19_0, arg_19_0.settingBtn, function()
		var_19_0 = not var_19_0

		arg_19_0:EditCards(var_19_0)
		var_19_1()

		return
	end, SFX_PANEL)
	;(function()
		setAnchoredPosition(arg_19_0.settingBtnSlider, {
			x = ({
				68,
				-68
			})[var_19_0 and 1 or 2]
		})

		return
	end)()

	local var_19_2 = getProxy(SettingsProxy)

	arg_19_0.randomFlag = getProxy(SettingsProxy):IsOpenRandomFlagShip()
	arg_19_0.nativeFlag = false

	local function var_19_3()
		setAnchoredPosition(arg_19_0.randomBtnSlider, {
			x = ({
				68,
				-68
			})[arg_19_0.randomFlag and 1 or 2]
		})
		setActive(arg_19_0.nativeBtn, arg_19_0.randomFlag)
		setActive(arg_19_0.flagShipMark, not arg_19_0.randomFlag or arg_19_0.nativeFlag)

		if arg_19_0.randomFlag and var_19_0 then
			triggerButton(arg_19_0.settingBtn)
		end

		return
	end

	local function var_19_4()
		setActive(arg_19_0.nativeBtnOn, arg_19_0.nativeFlag)
		setActive(arg_19_0.nativeBtnOff, not arg_19_0.nativeFlag)
		setActive(arg_19_0.flagShipMark, not arg_19_0.randomFlag or arg_19_0.nativeFlag)

		if var_19_0 then
			triggerButton(arg_19_0.settingBtn)
		end

		return
	end

	onButton(arg_19_0, arg_19_0.randomBtn, function()
		arg_19_0.randomFlag = not arg_19_0.randomFlag

		local var_25_1

		if arg_19_0.randomFlag then
			local var_25_0 = MainRandomFlagShipSequence.New():Random()

			if not var_25_0 or #var_25_0 <= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_off_0"))

				arg_19_0.randomFlag = not arg_19_0.randomFlag

				return
			end

			var_19_2:UpdateRandomFlagShipList(var_25_0)
		else
			var_19_2:UpdateRandomFlagShipList({})

			arg_19_0.nativeFlag = false

			var_19_4()

			var_25_1 = arg_19_0
		end

		if arg_19_0.randomFlag then
			local var_25_3 = var_0 or var_0_4

			var_25_2(var_25_1, var_25_3)
			var_19_3()

			local var_25_4 = arg_19_0.randomFlag and i18n("random_ship_on") or i18n("random_ship_off")

			pg.TipsMgr.GetInstance():ShowTips(var_25_4)
			arg_19_0:emit(PlayerVitaeMediator.ON_SWITCH_RANDOM_FLAG_SHIP_BTN, arg_19_0.randomFlag)

			return
		end
	end, SFX_PANEL)
	;(function()
		setAnchoredPosition(arg_19_0.randomBtnSlider, {
			x = ({
				68,
				-68
			})[arg_19_0.randomFlag and 1 or 2]
		})
		setActive(arg_19_0.nativeBtn, arg_19_0.randomFlag)
		setActive(arg_19_0.flagShipMark, not arg_19_0.randomFlag or arg_19_0.nativeFlag)

		if arg_19_0.randomFlag and var_19_0 then
			triggerButton(arg_19_0.settingBtn)
		end

		return
	end)()
	onButton(arg_19_0, arg_19_0.nativeBtn, function()
		arg_19_0.nativeFlag = not arg_19_0.nativeFlag

		var_19_4()

		local var_26_0 = arg_19_0

		if arg_19_0.nativeFlag then
			local var_26_2 = var_0_4 or var_0

			var_26_1(var_26_0, var_26_2)

			return
		end
	end, SFX_PANEL)
	;(function()
		setActive(arg_19_0.nativeBtnOn, arg_19_0.nativeFlag)
		setActive(arg_19_0.nativeBtnOff, not arg_19_0.nativeFlag)
		setActive(arg_19_0.flagShipMark, not arg_19_0.randomFlag or arg_19_0.nativeFlag)

		if var_19_0 then
			triggerButton(arg_19_0.settingBtn)
		end

		return
	end)()
	onButton(arg_19_0, arg_19_0.getMailBtn, function()
		if arg_19_0.randomFlag then
			pg.TipsMgr.GetInstance():ShowTips(i18n("spring_present_tips0"))

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("spring_present_tips1"),
			onYes = function()
				local var_28_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOVE_LETTER_MAIL)

				if not var_28_0 then
					setActive(arg_19_0.getMailBtn, false)
					pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

					return
				end

				arg_19_0:emit(PlayerVitaeMediator.ON_GET_LOVE_LETTER_MAIL, var_28_0.id)

				return
			end
		})

		return
	end)
	arg_19_0:UpdateGetMailBtn()
	onButton(arg_19_0, arg_19_0.educateCharSettingBtn, function()
		setActive(arg_19_0.educateCharSettingList.container, not isActive(arg_19_0.educateCharSettingList.container))

		return
	end, SFX_PANEL)
	onButton(arg_19_0, arg_19_0.settingSeceneBtn, function()
		arg_19_0.contextData.showSelectCharacters = true

		arg_19_0:emit(PlayerVitaeMediator.GO_SCENE, SCENE.SETTINGS, {
			page = NewSettingsScene.PAGE_OPTION,
			scroll = SettingsRandomFlagShipAndSkinPanel
		})

		return
	end, SFX_PANEL)

	arg_19_0.cards = {
		{},
		{},
		{}
	}

	table.insert(arg_19_0.cards[var_0_1], PlayerVitaeShipCard.New(arg_19_0.shipTpl, arg_19_0.event))
	table.insert(arg_19_0.cards[var_0_2], PlayerVitaeAddCard.New(arg_19_0.emptyTpl, arg_19_0.event))
	table.insert(arg_19_0.cards[var_0_3], PlayerVitaeLockCard.New(arg_19_0.lockTpl, arg_19_0.event))

	return
end

function var_0_0.UpdateGetMailBtn(arg_31_0)
	local var_31_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOVE_LETTER_MAIL)

	setActive(arg_31_0.getMailBtn, var_31_0 and not var_31_0:isEnd() and var_31_0:readyToAchieve())

	return
end

function var_0_0.Update(arg_32_0)
	local var_32_0 = arg_32_0.randomFlag and arg_32_0.nativeFlag and var_0_4 or getProxy(SettingsProxy):IsOpenRandomFlagShip() and var_0 or var_0_4

	arg_32_0:SwitchToPage(var_32_0)
	arg_32_0:UpdateEducateChar()
	arg_32_0:UpdateGetMailBtn()
	arg_32_0:Show()

	return
end

function var_0_0.UpdateEducateChar(arg_33_0)
	arg_33_0:UpdateEducateCharSettings()
	arg_33_0:UpdateEducateSlot()
	arg_33_0:UpdateEducateCharTrTip()

	return
end

function var_0_0.UpdateEducateCharTrTip(arg_34_0)
	setActive(arg_34_0.educateCharTrTip, getProxy(SettingsProxy):ShouldEducateCharTip())

	return
end

local function var_0_5()
	if NewEducateHelper.GetEducateCharSlotMaxCnt() <= 0 then
		return var_0_3
	end

	local var_35_0 = getProxy(PlayerProxy):getRawData()

	if var_35_0:ExistEducateChar() then
		return var_0_1
	end

	return var_0_2
end

function var_0_0.UpdateEducateSlot(arg_36_0)
	local var_36_0 = var_0_5()
	local var_36_1

	for iter_36_0, iter_36_1 in pairs(arg_36_0.educateCharCards) do
		local var_36_2 = iter_36_0 == var_36_0

		iter_36_1:ShowOrHide(iter_36_0 == var_36_0)

		if var_36_2 then
			var_36_1 = iter_36_1
		end
	end

	var_36_1:Flush()

	return
end

function var_0_0.UpdateEducateCharSettings(arg_37_0)
	local var_37_0 = getProxy(SettingsProxy)

	local function var_37_1()
		setText(arg_37_0.educateCharSettingBtn:Find("Text"), i18n("flagship_display_mode_" .. var_37_0:GetFlagShipDisplayMode()))

		return
	end

	local var_37_2 = {
		FlAG_SHIP_DISPLAY_ONLY_SHIP,
		FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR,
		FlAG_SHIP_DISPLAY_ALL
	}

	arg_37_0.educateCharSettingList:make(function(arg_39_0, arg_39_1, arg_39_2)
		if arg_39_0 == UIItemList.EventUpdate then
			setText(arg_39_2:Find("Text"), i18n("flagship_display_mode_" .. var_37_2[arg_39_1 + 1]))
			onButton(arg_37_0, arg_39_2, function()
				var_37_0:SetFlagShipDisplayMode(var_0)
				var_37_1()
				setActive(arg_37_0.educateCharSettingList.container, false)

				return
			end, SFX_PANEL)
			setActive(arg_39_2:Find("line"), arg_39_1 + 1 ~= #var_37_2)
		end

		return
	end)
	arg_37_0.educateCharSettingList:align(#{
		FlAG_SHIP_DISPLAY_ONLY_SHIP,
		FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR,
		FlAG_SHIP_DISPLAY_ALL
	})
	;(function()
		setText(arg_37_0.educateCharSettingBtn:Find("Text"), i18n("flagship_display_mode_" .. var_37_0:GetFlagShipDisplayMode()))

		return
	end)()

	return
end

function var_0_0.SwitchToPage(arg_41_0, arg_41_1)
	local var_41_0

	if arg_41_1 == var_0 then
		var_41_0 = _.select(getProxy(SettingsProxy):GetRandomFlagShipList(), function(arg_42_0)
			local var_42_0 = getProxy(BayProxy)

			return var_42_0:GetShipPhantom(arg_42_0) ~= nil
		end)
		arg_41_0.tip.text = i18n("random_ship_tips1")

		arg_41_0:emit(PlayerVitaeScene.ON_PAGE_SWTICH, PlayerVitaeScene.PAGE_RANDOM_SHIPS)
	elseif arg_41_1 == var_0_4 then
		var_41_0 = getProxy(PlayerProxy):getRawData():GetShipPhantomMarks()
		arg_41_0.tip.text = i18n("random_ship_tips2")

		arg_41_0:emit(PlayerVitaeScene.ON_PAGE_SWTICH, PlayerVitaeScene.PAGE_NATIVE_SHIPS)
	end

	arg_41_0:Flush(var_41_0, arg_41_1)
	setActive(arg_41_0.tip.gameObject, arg_41_0.randomFlag)

	return
end

function var_0_0.Flush(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0, var_43_1 = var_0_0.GetSlotMaxCnt()

	arg_43_0.max = var_43_0
	arg_43_0.unlockCnt = var_43_1

	arg_43_0:UpdateCards(arg_43_2, arg_43_1, (arg_43_0:GetUnlockShipCnt(arg_43_1)))

	return
end

function var_0_0.UpdateCards(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = {
		0
	}

	for iter_44_0, iter_44_1 in ipairs(arg_44_3) do
		table.insert({}, function(arg_45_0)
			arg_44_0:UpdateTypeCards(arg_44_1, arg_44_2, iter_44_0, iter_44_1, var_44_0, arg_45_0)

			return
		end)
	end

	seriesAsync({})

	return
end

function var_0_0.UpdateTypeCards(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5, arg_46_6)
	local var_46_0 = arg_46_0.cards[arg_46_3]

	local function var_46_1(arg_47_0)
		local var_47_0 = var_46_0[arg_47_0]

		if not var_46_0[arg_47_0] then
			var_47_0 = var_46_0[1]:Clone()
			var_46_0[arg_47_0] = var_47_0
		end

		arg_46_5[1] = arg_46_5[1] + 1

		var_47_0:Enable()
		var_47_0:Update(arg_46_5[1], arg_47_0, arg_46_2, arg_46_1, arg_46_0.nativeFlag)

		return
	end

	for iter_46_0 = 1, arg_46_4 do
		table.insert({}, function(arg_48_0)
			if arg_46_0.exited then
				return
			end

			var_46_1(iter_46_0)
			onNextTick(arg_48_0)

			return
		end)
	end

	for iter_46_1 = #arg_46_0.cards[arg_46_3], arg_46_4 + 1, -1 do
		arg_46_0.cards[arg_46_3][iter_46_1]:Disable()
	end

	seriesAsync({}, arg_46_6)

	return
end

function var_0_0.GetUnlockShipCnt(arg_49_0, arg_49_1)
	return {
		#arg_49_1,
		arg_49_0.unlockCnt - #arg_49_1,
		arg_49_0.max - arg_49_0.unlockCnt
	}
end

function var_0_0.EditCards(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in ipairs({
		var_0_1,
		var_0_2
	}) do
		for iter_50_2, iter_50_3 in ipairs(arg_50_0.cards[iter_50_1]) do
			if isActive(iter_50_3._tf) then
				iter_50_3:EditCard(arg_50_1)
			end
		end
	end

	arg_50_0.IsOpenEdit = arg_50_1

	return
end

function var_0_0.EditCardsForRandom(arg_51_0, arg_51_1)
	for iter_51_0, iter_51_1 in ipairs(arg_51_0.cards[var_0_1]) do
		if isActive(iter_51_1._tf) then
			if not arg_51_1 then
				({})[iter_51_1.slotIndex] = iter_51_1:GetRandomFlagValue()
			end

			iter_51_1:EditCardForRandom(arg_51_1)
		end
	end

	arg_51_0.IsOpenEditForRandom = arg_51_1

	if #{} > 0 then
		arg_51_0:SaveRandomSettings({})
	end

	for iter_51_2, iter_51_3 in ipairs(arg_51_0.cards[var_0_2]) do
		if isActive(iter_51_3._tf) then
			iter_51_3:EditCard(arg_51_1)
		end
	end

	return
end

function var_0_0.SaveRandomSettings(arg_52_0, arg_52_1)
	local var_52_0 = getProxy(PlayerProxy):getRawData()

	for iter_52_0 = 1, arg_52_0.max do
		arg_52_1[iter_52_0] = arg_52_1[iter_52_0] or var_52_0:RawGetRandomShipAndSkinValueInpos(iter_52_0)
	end

	arg_52_0:emit(PlayerVitaeMediator.CHANGE_RANDOM_SETTING, arg_52_1)

	return
end

function var_0_0.Show(arg_53_0)
	var_0_0.super.Show(arg_53_0)

	Input.multiTouchEnabled = false

	return
end

function var_0_0.Hide(arg_54_0)
	var_0_0.super.Hide(arg_54_0)

	if arg_54_0.IsOpenEdit then
		triggerButton(arg_54_0.settingBtn)
	end

	if arg_54_0.IsOpenEditForRandom then
		triggerButton(arg_54_0.randomBtn)
	end

	Input.multiTouchEnabled = true

	arg_54_0:emit(PlayerVitaeScene.ON_PAGE_SWTICH, PlayerVitaeScene.PAGE_DEFAULT)

	return
end

function var_0_0.OnDestroy(arg_55_0)
	arg_55_0:Hide()

	for iter_55_0, iter_55_1 in pairs(arg_55_0.cards) do
		for iter_55_2, iter_55_3 in pairs(iter_55_1) do
			iter_55_3:Dispose()
		end
	end

	arg_55_0.exited = true

	return
end

return var_0_0
