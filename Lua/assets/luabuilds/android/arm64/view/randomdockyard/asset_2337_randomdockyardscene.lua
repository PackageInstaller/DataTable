local RandomDockYardScene = class("RandomDockYardScene", import("view.base.BaseUI"))

RandomDockYardScene.MODE_VIEW = 1
RandomDockYardScene.MODE_ADD = 2
RandomDockYardScene.MODE_REMOVE = 3

function RandomDockYardScene:getUIName()
	return "RandomDockYardUI"
end

function RandomDockYardScene:OnChangeRandomShips()
	self.randomFlagShips = nil
	self.dockyardShips = nil

	self:Switch(RandomDockYardScene.MODE_VIEW)

	return
end

function RandomDockYardScene:init()
	self.titleImg = self._tf:Find("blur_panel/adapt/top/title"):GetComponent(typeof(Image))
	self.titleEnImg = self._tf:Find("blur_panel/adapt/top/title/title_en"):GetComponent(typeof(Image))
	self.scrollrect = self._tf:Find("main/ship_container/ships"):GetComponent("LScrollRect")
	self.emptyTr = self._tf:Find("empty")
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back")
	self.addBtn = self._tf:Find("blur_panel/select_panel/add_button")
	self.removeBtn = self._tf:Find("blur_panel/select_panel/remove_button")
	self.cancelBtn = self._tf:Find("blur_panel/select_panel/cancel_button")
	self.confirmBtn = self._tf:Find("blur_panel/select_panel/confirm_button")
	self.confirmBtnMask = self.confirmBtn:Find("mask")
	self.allBtn = self._tf:Find("blur_panel/select_panel/all_button")
	self.tipTxt = self._tf:Find("blur_panel/select_panel/tip"):GetComponent(typeof(Text))
	self.selectedTxt = self._tf:Find("blur_panel/select_panel/bottom_info/bg_input/selected"):GetComponent(typeof(Text))
	self.frequentlyUseToggle = self._tf:Find("blur_panel/adapt/top/preference_toggle")
	self.lockToggle = self._tf:Find("blur_panel/adapt/top/lock_toggle")
	self.sortBtn = self._tf:Find("blur_panel/adapt/top/sort_button")
	self.sortTxt = self.sortBtn:Find("Image"):GetComponent(typeof(Text))
	self.sortUp = self.sortBtn:Find("asc")
	self.sortDown = self.sortBtn:Find("desc")
	self.indexBtn = self._tf:Find("blur_panel/adapt/top/index_button")
	self.indexBtnSel = self.indexBtn:Find("Image")
	self.selectedCntTxt = self._tf:Find("blur_panel/select_panel/bottom_info/bg_input/count"):GetComponent(typeof(Text))
	self.phantomToggle = self._tf:Find("toggle_phantom")
	self.selectPanelFrame = self._tf:Find("blur_panel/select_panel/bottom_info/bg_input")

	setActive(self.sortUp, false)
	setActive(self.sortDown, true)
	setText(self.emptyTr:Find("Text"), i18n("random_ship_custom_mode_main_empty"))
	setText(self.addBtn:Find("Text"), i18n("random_ship_custom_mode_main_button_add"))
	setText(self.removeBtn:Find("Text"), i18n("random_ship_custom_mode_main_button_remove"))
	setText(self.cancelBtn:Find("Text"), i18n("text_cancel"))
	setText(self.confirmBtn:Find("Text"), i18n("text_confirm"))
	setText(self.allBtn:Find("Text"), i18n("random_ship_custom_mode_select_all"))

	self.msgbox = RandomDockYardMsgBoxPgae.New(self._tf, self.event)

	self:InitDefault()

	return
end

function RandomDockYardScene:InitDefault()
	self.selected = {}
	self.titles = {
		[RandomDockYardScene.MODE_VIEW] = GetSpriteFromAtlas("ui/dockyardui_atlas", "title_random_ship"),
		[RandomDockYardScene.MODE_ADD] = GetSpriteFromAtlas("ui/dockyardui_atlas", "title_add_random_ship"),
		[RandomDockYardScene.MODE_REMOVE] = GetSpriteFromAtlas("ui/dockyardui_atlas", "title_remove_random_ship")
	}
	self.titleEns = {
		[RandomDockYardScene.MODE_VIEW] = GetSpriteFromAtlas("ui/dockyardui_atlas", "title_rd_en"),
		[RandomDockYardScene.MODE_ADD] = GetSpriteFromAtlas("ui/dockyardui_atlas", "title_add_en"),
		[RandomDockYardScene.MODE_REMOVE] = GetSpriteFromAtlas("ui/dockyardui_atlas", "title_remove_en")
	}
	self.msgBoxTitle = {
		[RandomDockYardScene.MODE_VIEW] = {
			en = "",
			cn = ""
		},
		[RandomDockYardScene.MODE_ADD] = {
			en = "ADD",
			cn = i18n("random_ship_custom_mode_add_title")
		},
		[RandomDockYardScene.MODE_REMOVE] = {
			en = "REMOVE",
			cn = i18n("random_ship_custom_mode_remove_title")
		}
	}
	self.msgBoxSubTitle = {
		[RandomDockYardScene.MODE_VIEW] = "",
		[RandomDockYardScene.MODE_ADD] = i18n("random_ship_custom_mode_add_tip2"),
		[RandomDockYardScene.MODE_REMOVE] = i18n("random_ship_custom_mode_remove_tip2")
	}
	self.tips = {
		[RandomDockYardScene.MODE_VIEW] = i18n("random_ship_custom_mode_main_tip1"),
		[RandomDockYardScene.MODE_ADD] = i18n("random_ship_custom_mode_add_tip1"),
		[RandomDockYardScene.MODE_REMOVE] = i18n("random_ship_custom_mode_remove_tip1")
	}
	self.selectedTxts = {
		[RandomDockYardScene.MODE_VIEW] = i18n("random_ship_custom_mode_main_tip2"),
		[RandomDockYardScene.MODE_ADD] = i18n("random_ship_custom_mode_select_number"),
		[RandomDockYardScene.MODE_REMOVE] = i18n("random_ship_custom_mode_select_number")
	}
	self.frequentlyUseFlags = {
		[RandomDockYardScene.MODE_VIEW] = false,
		[RandomDockYardScene.MODE_ADD] = false,
		[RandomDockYardScene.MODE_REMOVE] = false
	}
	self.lockFlags = {
		[RandomDockYardScene.MODE_VIEW] = false,
		[RandomDockYardScene.MODE_ADD] = false,
		[RandomDockYardScene.MODE_REMOVE] = false
	}
	self.sortFlags = {
		[RandomDockYardScene.MODE_VIEW] = false,
		[RandomDockYardScene.MODE_ADD] = false,
		[RandomDockYardScene.MODE_REMOVE] = false
	}
	self.indexDatas = {
		[RandomDockYardScene.MODE_VIEW] = {
			sortIndex = ShipIndexConst.SortLevel,
			typeIndex = ShipIndexConst.TypeAll,
			campIndex = ShipIndexConst.CampAll,
			rarityIndex = ShipIndexConst.RarityAll,
			extraIndex = ShipIndexConst.ExtraALL
		},
		[RandomDockYardScene.MODE_ADD] = {
			sortIndex = ShipIndexConst.SortLevel,
			typeIndex = ShipIndexConst.TypeAll,
			campIndex = ShipIndexConst.CampAll,
			rarityIndex = ShipIndexConst.RarityAll,
			extraIndex = ShipIndexConst.ExtraALL
		},
		[RandomDockYardScene.MODE_REMOVE] = {
			sortIndex = ShipIndexConst.SortLevel,
			typeIndex = ShipIndexConst.TypeAll,
			campIndex = ShipIndexConst.CampAll,
			rarityIndex = ShipIndexConst.RarityAll,
			extraIndex = ShipIndexConst.ExtraALL
		}
	}

	return
end

function RandomDockYardScene:didEnter()
	self.cards = {}

	function self.scrollrect.onInitItem(arg_6_0)
		self:OnItemUpdate(arg_6_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_7_0, arg_7_1)
		self:OnUpdateItem(arg_7_0, arg_7_1)

		return
	end

	function self.scrollrect.onReturnItem(arg_8_0, arg_8_1)
		self:onReturnItem(arg_8_0, arg_8_1)

		return
	end

	onButton(self, self.backBtn, function()
		if self.mode ~= RandomDockYardScene.MODE_VIEW then
			self:Switch(RandomDockYardScene.MODE_VIEW)

			return
		end

		self:emit(RandomDockYardScene.ON_RETURN, {
			page = NewSettingsScene.PAGE_OPTION,
			scroll = SettingsRandomFlagShipAndSkinPanel
		})

		return
	end, SFX_PANEL)
	onButton(self, self.addBtn, function()
		self:Switch(RandomDockYardScene.MODE_ADD)

		return
	end, SFX_PANEL)
	onButton(self, self.removeBtn, function()
		self:Switch(RandomDockYardScene.MODE_REMOVE)

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		if self.mode == RandomDockYardScene.MODE_VIEW then
			return
		end

		self:Switch(RandomDockYardScene.MODE_VIEW)

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if self.mode == RandomDockYardScene.MODE_VIEW then
			return
		end

		self:OnConfirm()

		return
	end, SFX_PANEL)
	onButton(self, self.allBtn, function()
		if self.mode == RandomDockYardScene.MODE_VIEW then
			return
		end

		self:OnAll()

		return
	end, SFX_PANEL)
	onToggle(self, self.frequentlyUseToggle, function(arg_15_0)
		self.frequentlyUseFlags[self.mode] = arg_15_0

		self:FlushShipList((self:GetShipList(self.mode)))

		return
	end, SFX_PANEL)
	onToggle(self, self.lockToggle, function(arg_16_0)
		self.lockFlags[self.mode] = arg_16_0

		self:FlushShipList((self:GetShipList(self.mode)))

		return
	end, SFX_PANEL)
	onButton(self, self.sortBtn, function()
		self.sortFlags[self.mode] = not self.sortFlags[self.mode]

		setActive(self.sortUp, self.sortFlags[self.mode])
		setActive(self.sortDown, not self.sortFlags[self.mode])
		self:FlushShipList((self:GetShipList(self.mode)))

		return
	end, SFX_PANEL)
	onButton(self, self.indexBtn, function()
		self:emit(RandomDockYardMediator.OPEN_INDEX, {
			OnFilter = function(arg_19_0)
				self:OnFilter(arg_19_0)

				return
			end,
			defaultIndex = self.indexDatas[self.mode]
		})

		return
	end, SFX_PANEL)
	setToggleEnabled(self.phantomToggle, false)
	onButton(self, self.phantomToggle:Find("off"), function()
		self:emit(RandomDockYardMediator.OPEN_PHANTOM_LAYER)

		return
	end, SFX_PANEL)
	self:Switch(RandomDockYardScene.MODE_VIEW)

	return
end

function RandomDockYardScene:GetRandomFlagShips()
	if not self.randomFlagShips then
		local var_21_0 = getProxy(PlayerProxy):getRawData()

		self.randomFlagShips = {}
		self.phantomCount = 0

		local var_21_1 = getProxy(BayProxy)

		for iter_21_0, iter_21_1 in ipairs(var_21_1:getRandomFlagShipPhantomMarks()) do
			local var_21_2 = var_21_1:GetShipPhantom(iter_21_1)

			if var_21_2 then
				if var_21_2.phantomId == 0 then
					table.insert(self.randomFlagShips, var_21_2)
				else
					self.phantomCount = self.phantomCount + 1
				end
			end
		end
	end

	return self.randomFlagShips
end

function RandomDockYardScene:GetDockYardShipAndNotInRandom()
	if not self.dockyardShips then
		local var_22_0 = {}

		for iter_22_0, iter_22_1 in ipairs((self:GetRandomFlagShips())) do
			var_22_0[iter_22_1.id] = true
		end

		self.dockyardShips = {}

		for iter_22_2, iter_22_3 in pairs((getProxy(BayProxy):getRawData())) do
			if not var_22_0[iter_22_3.id] and not iter_22_3:isActivityNpc() then
				table.insert(self.dockyardShips, iter_22_3)
			end
		end
	end

	return self.dockyardShips
end

function RandomDockYardScene:GetShipList(arg_23_1)
	local var_23_0 = {}

	if arg_23_1 == RandomDockYardScene.MODE_VIEW then
		var_23_0 = self:GetRandomFlagShips()
	elseif arg_23_1 == RandomDockYardScene.MODE_ADD then
		var_23_0 = self:GetDockYardShipAndNotInRandom()
	elseif arg_23_1 == RandomDockYardScene.MODE_REMOVE then
		var_23_0 = self:GetRandomFlagShips()
	end

	return var_23_0
end

function RandomDockYardScene:Switch(arg_24_1)
	self:Clear()

	self.selected = {}

	local var_24_0 = self:GetShipList(arg_24_1)

	self:UpdateModeStyle(arg_24_1, #var_24_0)

	self.mode = arg_24_1

	self:FlushShipList(var_24_0)

	if self.mode == RandomDockYardScene.MODE_VIEW then
		self:UpdateSelectedCnt(#var_24_0 + self.phantomCount)
	else
		self:UpdateSelectedCnt(table.getCount(self.selected))
	end

	setActive(self.phantomToggle, self.mode == RandomDockYardScene.MODE_VIEW)

	return
end

function RandomDockYardScene:UpdateModeStyle(arg_25_1, arg_25_2)
	self.titleImg.sprite = self.titles[arg_25_1]

	self.titleImg:SetNativeSize()

	self.titleEnImg.sprite = self.titleEns[arg_25_1]

	self.titleEnImg:SetNativeSize()
	setActive(self.addBtn, arg_25_1 == RandomDockYardScene.MODE_VIEW)
	setActive(self.removeBtn, arg_25_1 == RandomDockYardScene.MODE_VIEW)
	setActive(self.cancelBtn, arg_25_1 == RandomDockYardScene.MODE_ADD or arg_25_1 == RandomDockYardScene.MODE_REMOVE)
	setActive(self.confirmBtn, arg_25_1 == RandomDockYardScene.MODE_ADD or arg_25_1 == RandomDockYardScene.MODE_REMOVE)
	setActive(self.allBtn, arg_25_1 == RandomDockYardScene.MODE_ADD or arg_25_1 == RandomDockYardScene.MODE_REMOVE)

	self.tipTxt.text = self.tips[arg_25_1]
	self.selectedTxt.text = self.selectedTxts[arg_25_1]

	setButtonEnabled(self.removeBtn, arg_25_1 == RandomDockYardScene.MODE_VIEW and arg_25_2 > 0)
	setAnchoredPosition(self.selectPanelFrame, {
		x = arg_25_1 == RandomDockYardScene.MODE_VIEW and 0 or 180
	})

	return
end

function RandomDockYardScene:OnConfirm()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self.selected) do
		table.insert(var_26_0, iter_26_0)
	end

	self.msgbox:ExecuteAction("Flush", self.msgBoxTitle[self.mode], self.msgBoxSubTitle[self.mode], var_26_0, function()
		if self.mode == RandomDockYardScene.MODE_ADD then
			self:emit(RandomDockYardMediator.ON_ADD_SHIPS, var_26_0)
		elseif self.mode == RandomDockYardScene.MODE_REMOVE then
			self:emit(RandomDockYardMediator.ON_REMOVE_SHIPS, var_26_0)
		end

		return
	end)

	return
end

function RandomDockYardScene:OnAll()
	for iter_28_0, iter_28_1 in ipairs(self.displays) do
		self.selected[iter_28_1.id] = true
	end

	self.scrollrect:SetTotalCount(#self.displays)
	self:UpdateSelectedCnt(table.getCount(self.selected))

	return
end

function RandomDockYardScene:UpdateSelectedCnt(arg_29_1)
	self.selectedCntTxt.text = arg_29_1

	setButtonEnabled(self.confirmBtn, arg_29_1 > 0)
	setActive(self.confirmBtnMask, arg_29_1 <= 0)

	return
end

local function var_0_1(arg_30_0)
	return arg_30_0.sortIndex ~= ShipIndexConst.SortLevel or arg_30_0.typeIndex ~= ShipIndexConst.TypeAll or arg_30_0.campIndex ~= ShipIndexConst.CampAll or arg_30_0.rarityIndex ~= ShipIndexConst.RarityAll or arg_30_0.extraIndex ~= ShipIndexConst.ExtraALL
end

function RandomDockYardScene:OnFilter(arg_31_1)
	self.indexDatas[self.mode].sortIndex = arg_31_1.sortIndex
	self.indexDatas[self.mode].typeIndex = arg_31_1.typeIndex
	self.indexDatas[self.mode].campIndex = arg_31_1.campIndex
	self.indexDatas[self.mode].rarityIndex = arg_31_1.rarityIndex
	self.indexDatas[self.mode].extraIndex = arg_31_1.extraIndex

	setActive(self.indexBtnSel, var_0_1(self.indexDatas[self.mode]))
	self:FlushShipList((self:GetShipList(self.mode)))

	return
end

function RandomDockYardScene:OnItemUpdate(arg_32_1)
	local var_32_0 = RandomDockYardCard.New(arg_32_1)

	onButton(self, var_32_0._go, function()
		if self.mode == RandomDockYardScene.MODE_VIEW then
			return
		end

		if self.selected[var_32_0.ship.id] then
			self.selected[var_32_0.ship.id] = nil
		else
			self.selected[var_32_0.ship.id] = true
		end

		self:UpdateSelectedCnt(table.getCount(self.selected))
		var_32_0:UpdateSelected(self.selected[var_32_0.ship.id])

		return
	end, SFX_PANEL)

	self.cards[arg_32_1] = var_32_0

	return
end

function RandomDockYardScene:OnUpdateItem(arg_34_1, arg_34_2)
	if not self.cards[arg_34_2] then
		self:OnItemUpdate(arg_34_2)
	end

	self.cards[arg_34_2]:Update(self.displays[arg_34_1 + 1], self.selected[self.displays[arg_34_1 + 1].id])

	return
end

function RandomDockYardScene:onReturnItem(arg_35_1, arg_35_2)
	if self.exited then
		return
	end

	if self.cards[arg_35_2] then
		self.cards[arg_35_2]:Dispose()
	end

	return
end

function RandomDockYardScene:FlushShipList(arg_36_1)
	self.displays = {}

	self:FilterShips(arg_36_1, self.displays)
	self:SortShips(self.displays)

	local var_36_0 = #self.displays

	self.scrollrect:SetTotalCount(#self.displays)
	setActive(self.emptyTr, var_36_0 <= 0)

	return
end

function RandomDockYardScene:FilterShips(arg_37_1, arg_37_2)
	local var_37_0 = self.lockFlags[self.mode]
	local var_37_1 = self.frequentlyUseFlags[self.mode]
	local var_37_2 = self.indexDatas[self.mode]

	local function var_37_3(arg_38_0)
		return (not var_37_0 or not not arg_38_0:IsLocked()) and (not var_37_1 or not not arg_38_0:IsPreferenceTag()) and ShipIndexConst.filterByType(arg_38_0, var_37_2.typeIndex) and ShipIndexConst.filterByCamp(arg_38_0, var_37_2.campIndex) and ShipIndexConst.filterByRarity(arg_38_0, var_37_2.rarityIndex) and ShipIndexConst.filterByExtra(arg_38_0, var_37_2.extraIndex)
	end

	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		if var_37_3(iter_37_1) then
			table.insert(arg_37_2, iter_37_1)
		end
	end

	return
end

function RandomDockYardScene:SortShips(arg_39_1)
	local var_39_0, var_39_1 = ShipIndexConst.getSortFuncAndName(self.indexDatas[self.mode].sortIndex, self.sortFlags[self.mode])

	table.insert(var_39_0, 1, function(arg_40_0)
		return -arg_40_0.activityNpc
	end)
	table.sort(arg_39_1, CompareFuncs(var_39_0))

	self.sortTxt.text = i18n(var_39_1)

	return
end

function RandomDockYardScene:onBackPressed()
	RandomDockYardScene.super.onBackPressed(self)

	return
end

function RandomDockYardScene:Clear()
	for iter_42_0, iter_42_1 in pairs(self.cards) do
		iter_42_1:Dispose()
	end

	self.cards = {}

	return
end

function RandomDockYardScene:willExit()
	self.titles = nil

	if self.msgbox then
		self.msgbox:Destroy()
	end

	self.msgbox = nil

	return
end

return RandomDockYardScene
