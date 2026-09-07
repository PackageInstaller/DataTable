local PlayerVitaeShipsPage = class("PlayerVitaeShipsPage", import("...base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 1
local var_0_5 = 2

PlayerVitaeShipsPage.RANDOM_FLAG_SHIP_PAGE = 2
PlayerVitaeShipsPage.EDUCATE_CHAR_SLOT_ID = 6
PlayerVitaeShipsPage.ON_BEGIN_DRAG_CARD = "PlayerVitaeShipsPage:ON_BEGIN_DRAG_CARD"
PlayerVitaeShipsPage.ON_DRAGING_CARD = "PlayerVitaeShipsPage:ON_DRAGING_CARD"
PlayerVitaeShipsPage.ON_DRAG_END_CARD = "PlayerVitaeShipsPage:ON_DRAG_END_CARD"

function PlayerVitaeShipsPage.GetSlotIndexList()
	local var_1_0, var_1_1 = PlayerVitaeShipsPage.GetSlotMaxCnt()
	local var_1_2 = {}

	for iter_1_0 = 1, var_1_1 do
		table.insert(var_1_2, iter_1_0)
	end

	if NewEducateHelper.GetEducateCharSlotMaxCnt() > 0 then
		table.insert(var_1_2, PlayerVitaeShipsPage.EDUCATE_CHAR_SLOT_ID)
	end

	return var_1_2
end

function PlayerVitaeShipsPage.GetAllUnlockSlotCnt()
	local var_2_0, var_2_1 = PlayerVitaeShipsPage.GetSlotMaxCnt()

	return var_2_1 + NewEducateHelper.GetEducateCharSlotMaxCnt()
end

function PlayerVitaeShipsPage.GetSlotMaxCnt()
	local var_3_0 = 1

	for iter_3_0, iter_3_1 in ipairs(pg.gameset.secretary_group_unlock.description) do
		if getProxy(ChapterProxy):isClear(iter_3_1[1]) then
			var_3_0 = iter_3_1[2]
		end
	end

	return pg.gameset.secretary_group_unlock.description[#pg.gameset.secretary_group_unlock.description][2], var_3_0
end

function PlayerVitaeShipsPage:getUIName()
	return "PlayerVitaeShipsPage"
end

function PlayerVitaeShipsPage:UpdateCard(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self.cards[var_0_1]) do
		if isActive(iter_5_1._tf) and iter_5_1.displayShip and iter_5_1.displayShip:GetShipPhantomMark() == arg_5_1 then
			iter_5_1:Refresh()

			break
		end
	end

	return
end

function PlayerVitaeShipsPage:UpdateCardPaintingTag()
	for iter_6_0, iter_6_1 in ipairs(self.cards[var_0_1]) do
		iter_6_1:updatePaintingTag()
	end

	return
end

function PlayerVitaeShipsPage:RefreshShips()
	self:Update()

	return
end

function PlayerVitaeShipsPage:OnLoaded()
	self.cardContainer = self._tf:Find("frame")
	self.shipTpl = self._tf:Find("frame/shipCard")
	self.emptyTpl = self._tf:Find("frame/addCard")
	self.lockTpl = self._tf:Find("frame/lockCard")
	self.helpBtn = self._tf:Find("help_btn")
	self.settingBtn = self._tf:Find("setting_btn")
	self.settingBtnSlider = self.settingBtn:Find("toggle/on")
	self.randomBtn = self._tf:Find("ran_setting_btn")
	self.randomBtnSlider = self.randomBtn:Find("toggle/on")
	self.settingSeceneBtn = self._tf:Find("setting_scene_btn")
	self.nativeBtn = self._tf:Find("native_setting_btn")
	self.nativeBtnOn = self.nativeBtn:Find("on")
	self.nativeBtnOff = self.nativeBtn:Find("off")
	self.getMailBtn = self._tf:Find("get_mail")
	self.educateCharTr = self._tf:Find("educate_char")
	self.educateCharSettingList = UIItemList.New(self._tf:Find("educate_char/shipCard/settings/panel"), self._tf:Find("educate_char/shipCard/settings/panel/tpl"))
	self.educateCharSettingBtn = self._tf:Find("educate_char/shipCard/settings/tpl")
	self.educateCharTrTip = self.educateCharTr:Find("tip")

	if LOCK_EDUCATE_SYSTEM then
		setActive(self.educateCharTr, false)
		setAnchoredPosition(self.cardContainer, {
			x = 0
		})
		setAnchoredPosition(self._tf:Find("flagship"), {
			x = -720
		})
		setAnchoredPosition(self._tf:Find("zs"), {
			x = 763
		})
		setAnchoredPosition(self._tf:Find("line"), {
			x = 740
		})
	end

	self.educateCharCards = {
		[var_0_1] = PlayerVitaeEducateShipCard.New(self._tf:Find("educate_char/shipCard"), self.event),
		[var_0_2] = PlayerVitaeEducateAddCard.New(self._tf:Find("educate_char/addCard"), self.event),
		[var_0_3] = PlayerVitaeEducateLockCard.New(self._tf:Find("educate_char/lockCard"), self.event)
	}
	self.tip = self._tf:Find("tip"):GetComponent(typeof(Text))
	self.flagShipMark = self._tf:Find("flagship")

	self:bind(PlayerVitaeShipsPage.ON_BEGIN_DRAG_CARD, function(arg_9_0, arg_9_1)
		self:OnBeginDragCard(arg_9_1)

		return
	end)
	self:bind(PlayerVitaeShipsPage.ON_DRAGING_CARD, function(arg_10_0, arg_10_1)
		self:OnDragingCard(arg_10_1)

		return
	end)
	self:bind(PlayerVitaeShipsPage.ON_DRAG_END_CARD, function(arg_11_0)
		self:OnEndDragCard()

		return
	end)
	setText(self.nativeBtnOn:Find("Text"), i18n("random_ship_before"))
	setText(self.nativeBtnOff:Find("Text"), i18n("random_ship_now"))
	setText(self.settingBtn:Find("Text"), i18n("player_vitae_skin_setting"))
	setText(self.randomBtn:Find("Text"), i18n("random_ship_label"))
	setText(self.settingSeceneBtn:Find("Text"), i18n("playervtae_setting_btn_label"))
	setText(self.getMailBtn:Find("Text"), i18n("spring_present_tips_btn"))
	setText(self.getMailBtn:Find("time"), i18n("spring_present_tips_time"))

	self.cardContainerCG = GetOrAddComponent(self.cardContainer, typeof(CanvasGroup))

	return
end

function PlayerVitaeShipsPage:OnBeginDragCard(arg_12_1)
	self.dragIndex = arg_12_1
	self.displayCards = {}
	self.displayPos = {}

	for iter_12_0, iter_12_1 in ipairs(self.cards[var_0_1]) do
		if isActive(iter_12_1._tf) then
			self.displayCards[iter_12_0] = iter_12_1
			self.displayPos[iter_12_0] = iter_12_1._tf.localPosition
		end
	end

	for iter_12_2, iter_12_3 in pairs(self.displayCards) do
		if iter_12_2 ~= arg_12_1 then
			iter_12_3:DisableDrag()
		end
	end

	return
end

function PlayerVitaeShipsPage:OnDragingCard(arg_13_1)
	if self.displayCards[self.dragIndex - 1] and self:ShouldSwap(arg_13_1, self.dragIndex - 1) then
		self:Swap(self.dragIndex, self.dragIndex - 1)
	elseif self.displayCards[self.dragIndex + 1] and self:ShouldSwap(arg_13_1, self.dragIndex + 1) then
		self:Swap(self.dragIndex, self.dragIndex + 1)
	end

	return
end

function PlayerVitaeShipsPage:Swap(arg_14_1, arg_14_2)
	self.displayCards[arg_14_2]._tf.localPosition = self.displayPos[arg_14_1]
	self.displayCards[arg_14_1], self.displayCards[arg_14_2] = self.displayCards[arg_14_2], self.displayCards[arg_14_1]
	self.dragIndex = arg_14_2
	self.displayCards[arg_14_1].slotIndex = arg_14_2
	self.displayCards[arg_14_2].slotIndex = arg_14_1
	self.displayCards[arg_14_1].typeIndex, self.displayCards[arg_14_2].typeIndex = self.displayCards[arg_14_2].typeIndex, self.displayCards[arg_14_1].typeIndex

	local var_14_1 = self.cards[var_0_1]

	var_14_1[arg_14_1], var_14_1[arg_14_2] = self.cards[var_0_1][arg_14_2], self.cards[var_0_1][arg_14_1]

	return
end

function PlayerVitaeShipsPage:ShouldSwap(arg_15_1, arg_15_2)
	return math.abs(self.displayPos[arg_15_2].x - arg_15_1.x) <= 130
end

function PlayerVitaeShipsPage:OnEndDragCard()
	self.displayCards[self.dragIndex]._tf.localPosition = self.displayPos[self.dragIndex]

	local var_16_0 = {}
	local var_16_1 = getProxy(PlayerProxy):getRawData():GetShipPhantomMarks()
	local var_16_2 = false

	for iter_16_0, iter_16_1 in pairs(self.displayCards) do
		iter_16_1:EnableDrag()
		table.insert(var_16_0, iter_16_1.displayShip:GetShipPhantomMark())

		if not var_16_2 and var_16_1[#var_16_0] ~= var_16_0[#var_16_0] then
			var_16_2 = true
		end
	end

	self.dragIndex = nil
	self.displayCards = nil
	self.displayPos = nil
	self.cardContainerCG.blocksRaycasts = false

	if var_16_2 then
		self:emit(PlayerVitaeMediator.CHANGE_PAINTS, var_16_0, function()
			Timer.New(function()
				if self.cardContainerCG then
					self.cardContainerCG.blocksRaycasts = true
				end

				return
			end, 0.3, 1):Start()

			return
		end)
	else
		self.cardContainerCG.blocksRaycasts = true
	end

	return
end

function PlayerVitaeShipsPage:OnInit()
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("secretary_help")
		})

		return
	end, SFX_PANEL)

	local var_19_0 = false

	local function var_19_1()
		setAnchoredPosition(self.settingBtnSlider, {
			x = ({
				68,
				-68
			})[var_19_0 and 1 or 2]
		})

		return
	end

	onButton(self, self.settingBtn, function()
		var_19_0 = not var_19_0

		self:EditCards(var_19_0)
		var_19_1()

		return
	end, SFX_PANEL)
	var_19_1()

	local var_19_2 = getProxy(SettingsProxy)

	self.randomFlag = var_19_2:IsOpenRandomFlagShip()
	self.nativeFlag = false

	local function var_19_3()
		setAnchoredPosition(self.randomBtnSlider, {
			x = ({
				68,
				-68
			})[self.randomFlag and 1 or 2]
		})
		setActive(self.nativeBtn, self.randomFlag)
		setActive(self.flagShipMark, not self.randomFlag or self.nativeFlag)

		if self.randomFlag and var_19_0 then
			triggerButton(self.settingBtn)
		end

		return
	end

	local function var_19_4()
		setActive(self.nativeBtnOn, self.nativeFlag)
		setActive(self.nativeBtnOff, not self.nativeFlag)
		setActive(self.flagShipMark, not self.randomFlag or self.nativeFlag)

		if var_19_0 then
			triggerButton(self.settingBtn)
		end

		return
	end

	onButton(self, self.randomBtn, function()
		self.randomFlag = not self.randomFlag

		if self.randomFlag then
			local var_25_0 = MainRandomFlagShipSequence.New():Random()

			if not var_25_0 or #var_25_0 <= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_off_0"))

				self.randomFlag = not self.randomFlag

				return
			end

			var_19_2:UpdateRandomFlagShipList(var_25_0)
		else
			var_19_2:UpdateRandomFlagShipList({})

			self.nativeFlag = false

			var_19_4()
		end

		self:SwitchToPage((self.randomFlag or nil) and (var_0_5 or var_0_4))
		var_19_3()
		pg.TipsMgr.GetInstance():ShowTips(self.randomFlag and i18n("random_ship_on") or i18n("random_ship_off"))
		self:emit(PlayerVitaeMediator.ON_SWITCH_RANDOM_FLAG_SHIP_BTN, self.randomFlag)

		return
	end, SFX_PANEL)
	var_19_3()
	onButton(self, self.nativeBtn, function()
		self.nativeFlag = not self.nativeFlag

		var_19_4()
		self:SwitchToPage((self.nativeFlag or nil) and (var_0_4 or var_0_5))

		return
	end, SFX_PANEL)
	var_19_4()
	onButton(self, self.getMailBtn, function()
		if self.randomFlag then
			pg.TipsMgr.GetInstance():ShowTips(i18n("spring_present_tips0"))

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("spring_present_tips1"),
			onYes = function()
				local var_28_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOVE_LETTER_MAIL)

				if not var_28_0 then
					setActive(self.getMailBtn, false)
					pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

					return
				end

				self:emit(PlayerVitaeMediator.ON_GET_LOVE_LETTER_MAIL, var_28_0.id)

				return
			end
		})

		return
	end)
	self:UpdateGetMailBtn()
	onButton(self, self.educateCharSettingBtn, function()
		setActive(self.educateCharSettingList.container, not isActive(self.educateCharSettingList.container))

		return
	end, SFX_PANEL)
	onButton(self, self.settingSeceneBtn, function()
		self.contextData.showSelectCharacters = true

		self:emit(PlayerVitaeMediator.GO_SCENE, SCENE.SETTINGS, {
			page = NewSettingsScene.PAGE_OPTION,
			scroll = SettingsRandomFlagShipAndSkinPanel
		})

		return
	end, SFX_PANEL)

	self.cards = {
		{},
		{},
		{}
	}

	table.insert(self.cards[var_0_1], PlayerVitaeShipCard.New(self.shipTpl, self.event))
	table.insert(self.cards[var_0_2], PlayerVitaeAddCard.New(self.emptyTpl, self.event))
	table.insert(self.cards[var_0_3], PlayerVitaeLockCard.New(self.lockTpl, self.event))

	return
end

function PlayerVitaeShipsPage:UpdateGetMailBtn()
	local var_31_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOVE_LETTER_MAIL)

	setActive(self.getMailBtn, var_31_0 and not var_31_0:isEnd() and var_31_0:readyToAchieve())

	return
end

function PlayerVitaeShipsPage:Update()
	self:SwitchToPage(self.randomFlag and self.nativeFlag and var_0_4 or getProxy(SettingsProxy):IsOpenRandomFlagShip() and var_0_5 or var_0_4)
	self:UpdateEducateChar()
	self:UpdateGetMailBtn()
	self:Show()

	return
end

function PlayerVitaeShipsPage:UpdateEducateChar()
	self:UpdateEducateCharSettings()
	self:UpdateEducateSlot()
	self:UpdateEducateCharTrTip()

	return
end

function PlayerVitaeShipsPage:UpdateEducateCharTrTip()
	setActive(self.educateCharTrTip, getProxy(SettingsProxy):ShouldEducateCharTip())

	return
end

local function var_0_6()
	if NewEducateHelper.GetEducateCharSlotMaxCnt() <= 0 then
		return var_0_3
	end

	if getProxy(PlayerProxy):getRawData():ExistEducateChar() then
		return var_0_1
	end

	return var_0_2
end

function PlayerVitaeShipsPage:UpdateEducateSlot()
	local var_36_0 = var_0_6()
	local var_36_1

	for iter_36_0, iter_36_1 in pairs(self.educateCharCards) do
		local var_36_2 = iter_36_0 == var_36_0

		iter_36_1:ShowOrHide(iter_36_0 == var_36_0)

		if var_36_2 then
			var_36_1 = iter_36_1
		end
	end

	var_36_1:Flush()

	return
end

function PlayerVitaeShipsPage:UpdateEducateCharSettings()
	local var_37_0 = getProxy(SettingsProxy)

	local function var_37_1()
		setText(self.educateCharSettingBtn:Find("Text"), i18n("flagship_display_mode_" .. var_37_0:GetFlagShipDisplayMode()))

		return
	end

	local var_37_2 = {
		FlAG_SHIP_DISPLAY_ONLY_SHIP,
		FlAG_SHIP_DISPLAY_ONLY_EDUCATECHAR,
		FlAG_SHIP_DISPLAY_ALL
	}

	self.educateCharSettingList:make(function(arg_39_0, arg_39_1, arg_39_2)
		if arg_39_0 == UIItemList.EventUpdate then
			local var_39_0 = var_37_2[arg_39_1 + 1]

			setText(arg_39_2:Find("Text"), i18n("flagship_display_mode_" .. var_37_2[arg_39_1 + 1]))
			onButton(self, arg_39_2, function()
				var_37_0:SetFlagShipDisplayMode(var_39_0)
				var_37_1()
				setActive(self.educateCharSettingList.container, false)

				return
			end, SFX_PANEL)
			setActive(arg_39_2:Find("line"), arg_39_1 + 1 ~= #var_37_2)
		end

		return
	end)
	self.educateCharSettingList:align(#var_37_2)
	var_37_1()

	return
end

function PlayerVitaeShipsPage:SwitchToPage(arg_41_1)
	local var_41_0

	if arg_41_1 == var_0_5 then
		var_41_0 = _.select(getProxy(SettingsProxy):GetRandomFlagShipList(), function(arg_42_0)
			return getProxy(BayProxy):GetShipPhantom(arg_42_0) ~= nil
		end)
		self.tip.text = i18n("random_ship_tips1")

		self:emit(PlayerVitaeScene.ON_PAGE_SWTICH, PlayerVitaeScene.PAGE_RANDOM_SHIPS)
	elseif arg_41_1 == var_0_4 then
		var_41_0 = getProxy(PlayerProxy):getRawData():GetShipPhantomMarks()
		self.tip.text = i18n("random_ship_tips2")

		self:emit(PlayerVitaeScene.ON_PAGE_SWTICH, PlayerVitaeScene.PAGE_NATIVE_SHIPS)
	end

	self:Flush(var_41_0, arg_41_1)
	setActive(self.tip.gameObject, self.randomFlag)

	return
end

function PlayerVitaeShipsPage:Flush(arg_43_1, arg_43_2)
	local var_43_0, var_43_1 = PlayerVitaeShipsPage.GetSlotMaxCnt()

	self.max = var_43_0
	self.unlockCnt = var_43_1

	self:UpdateCards(arg_43_2, arg_43_1, (self:GetUnlockShipCnt(arg_43_1)))

	return
end

function PlayerVitaeShipsPage:UpdateCards(arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = {
		0
	}
	local var_44_1 = {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_3) do
		table.insert(var_44_1, function(arg_45_0)
			self:UpdateTypeCards(arg_44_1, arg_44_2, iter_44_0, iter_44_1, var_44_0, arg_45_0)

			return
		end)
	end

	seriesAsync(var_44_1)

	return
end

function PlayerVitaeShipsPage:UpdateTypeCards(arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5, arg_46_6)
	local var_46_0 = {}
	local var_46_1 = self.cards[arg_46_3]

	local function var_46_2(arg_47_0)
		local var_47_0 = var_46_1[arg_47_0]

		if not var_46_1[arg_47_0] then
			var_47_0 = var_46_1[1]:Clone()
			var_46_1[arg_47_0] = var_47_0
		end

		arg_46_5[1] = arg_46_5[1] + 1

		var_47_0:Enable()
		var_47_0:Update(arg_46_5[1], arg_47_0, arg_46_2, arg_46_1, self.nativeFlag)

		return
	end

	for iter_46_0 = 1, arg_46_4 do
		table.insert(var_46_0, function(arg_48_0)
			if self.exited then
				return
			end

			var_46_2(iter_46_0)
			onNextTick(arg_48_0)

			return
		end)
	end

	for iter_46_1 = #self.cards[arg_46_3], arg_46_4 + 1, -1 do
		self.cards[arg_46_3][iter_46_1]:Disable()
	end

	seriesAsync(var_46_0, arg_46_6)

	return
end

function PlayerVitaeShipsPage:GetUnlockShipCnt(arg_49_1)
	return {
		#arg_49_1,
		self.unlockCnt - #arg_49_1,
		self.max - self.unlockCnt
	}
end

function PlayerVitaeShipsPage:EditCards(arg_50_1)
	for iter_50_0, iter_50_1 in ipairs({
		var_0_1,
		var_0_2
	}) do
		for iter_50_2, iter_50_3 in ipairs(self.cards[iter_50_1]) do
			if isActive(iter_50_3._tf) then
				iter_50_3:EditCard(arg_50_1)
			end
		end
	end

	self.IsOpenEdit = arg_50_1

	return
end

function PlayerVitaeShipsPage:EditCardsForRandom(arg_51_1)
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in ipairs(self.cards[var_0_1]) do
		if isActive(iter_51_1._tf) then
			if not arg_51_1 then
				var_51_0[iter_51_1.slotIndex] = iter_51_1:GetRandomFlagValue()
			end

			iter_51_1:EditCardForRandom(arg_51_1)
		end
	end

	self.IsOpenEditForRandom = arg_51_1

	if #var_51_0 > 0 then
		self:SaveRandomSettings(var_51_0)
	end

	for iter_51_2, iter_51_3 in ipairs(self.cards[var_0_2]) do
		if isActive(iter_51_3._tf) then
			iter_51_3:EditCard(arg_51_1)
		end
	end

	return
end

function PlayerVitaeShipsPage:SaveRandomSettings(arg_52_1)
	local var_52_0 = getProxy(PlayerProxy):getRawData()

	for iter_52_0 = 1, self.max do
		arg_52_1[iter_52_0] = arg_52_1[iter_52_0] or var_52_0:RawGetRandomShipAndSkinValueInpos(iter_52_0)
	end

	self:emit(PlayerVitaeMediator.CHANGE_RANDOM_SETTING, arg_52_1)

	return
end

function PlayerVitaeShipsPage:Show()
	PlayerVitaeShipsPage.super.Show(self)

	Input.multiTouchEnabled = false

	return
end

function PlayerVitaeShipsPage:Hide()
	PlayerVitaeShipsPage.super.Hide(self)

	if self.IsOpenEdit then
		triggerButton(self.settingBtn)
	end

	if self.IsOpenEditForRandom then
		triggerButton(self.randomBtn)
	end

	Input.multiTouchEnabled = true

	self:emit(PlayerVitaeScene.ON_PAGE_SWTICH, PlayerVitaeScene.PAGE_DEFAULT)

	return
end

function PlayerVitaeShipsPage:OnDestroy()
	self:Hide()

	for iter_55_0, iter_55_1 in pairs(self.cards) do
		for iter_55_2, iter_55_3 in pairs(iter_55_1) do
			iter_55_3:Dispose()
		end
	end

	self.exited = true

	return
end

return PlayerVitaeShipsPage
