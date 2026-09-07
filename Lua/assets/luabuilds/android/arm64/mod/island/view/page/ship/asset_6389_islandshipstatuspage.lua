local IslandShipStatusPage = class("IslandShipStatusPage", import("...base.IslandBasePage"))

function IslandShipStatusPage:getUIName()
	return "IslandShipStatusUI"
end

function IslandShipStatusPage:OnLoaded()
	self.scrollRect = self._tf:Find("adapt/attr_panel/srcollrect"):GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	self.giveBtn = self._tf:Find("adapt/attr_panel/send_panel/give_btn")
	self.emptyTr = self._tf:Find("adapt/attr_panel/send_panel/empty")
	self.giftEffectList = UIItemList.New(self._tf:Find("adapt/attr_panel/send_panel/scrollrect/list"), self._tf:Find("adapt/attr_panel/send_panel/scrollrect/list/tpl"))
	self.statusPanel = IslandShipStatusPanel.New(self._tf:Find("adapt/attr_panel/status"), self._tf:Find("adapt/attr_panel/status_empty"))

	setText(self.emptyTr:Find("Text"), i18n("island_select_ship_gift"))

	self.powerTr = self._tf:Find("adapt/attr_panel/power")

	setText(self.powerTr:Find("Text"), i18n("island_gift_tip_title"))

	return
end

function IslandShipStatusPage:OnInit()
	self.cards = {}

	onButton(self, self.giveBtn, function()
		if not self.selectedId then
			return
		end

		local var_6_0 = {}

		if self.addPower + self.curPower > self.maxPower then
			table.insert(var_6_0, function(arg_7_0)
				self:ShowMsgBox({
					type = IslandMsgBox.TYPE_COMMON,
					content = i18n("island_gift_tip"),
					onYes = arg_7_0
				})

				return
			end)
		end

		for iter_6_0, iter_6_1 in ipairs((self:CollectGiftBuffs(self.selectedId))) do
			table.insert(var_6_0, function(arg_8_0)
				IslandAddShipStatusHelper.CheckAddStatus(self, self.ship, iter_6_1, arg_8_0)

				return
			end)
		end

		seriesAsync(var_6_0, function()
			self:emit(IslandMediator.ON_GIVE_GIFT, self.selectedId, 1, self.shipId)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function IslandShipStatusPage:AddListeners()
	self:AddListener(GAME.ISLAND_GIVE_GIFT_DONE, self.OnUseItem)

	return
end

function IslandShipStatusPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_GIVE_GIFT_DONE, self.OnUseItem)

	return
end

function IslandShipStatusPage:OnUseItem()
	self.selectedId = nil

	self:FlushStatus(self.ship)
	self:FlushGifts()
	self:FlushPower()

	return
end

function IslandShipStatusPage:OnShow(arg_13_1)
	self.selectedId = nil

	local var_13_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_13_1)

	if var_13_0 == nil then
		return
	end

	self.ship = var_13_0
	self.shipId = self.ship.id

	self:FlushStatus(var_13_0)
	self:FlushGifts()
	self:FlushPower()
	self:UpdateSelected(self.selectedId)

	return
end

function IslandShipStatusPage:FlushStatus(arg_14_1)
	self.statusPanel:Flush(arg_14_1)

	local var_14_0 = arg_14_1:GetDisplayStatus()

	onButton(self, self.statusPanel.viewBtn, function()
		self:ShowMsgBox({
			hideNo = true,
			type = IslandMsgBox.TYPE_SHIP_OWN_STATUS,
			title = i18n("island_word_ship_buff_desc"),
			statusList = var_14_0
		})

		return
	end, SFX_PANEL)

	return
end

function IslandShipStatusPage:OnInitItem(arg_16_1)
	local var_16_0 = IslandGiftCard.New(arg_16_1)

	onButton(self, var_16_0.go, function()
		if var_16_0.item:GetCount() <= 0 then
			self:ShowMsgBox({
				title = i18n("island_word_ship_buff_desc"),
				type = IslandMsgBox.TYPE_COMMON_ITEM,
				itemId = var_16_0.item.id
			})

			return
		end

		self.selectedId = nil

		for iter_17_0, iter_17_1 in pairs(self.cards) do
			iter_17_1:UpdateSelected(self.selectedId)
		end

		self:UpdateSelected(var_16_0.itemId)
		var_16_0:UpdateSelected(self.selectedId)

		return
	end, SFX_PANEL)

	self.cards[arg_16_1] = var_16_0

	return
end

function IslandShipStatusPage:OnUpdateItem(arg_18_1, arg_18_2)
	if not self.cards[arg_18_2] then
		self:OnInitItem(arg_18_2)
	end

	self.cards[arg_18_2]:Update(self.shipId, self.displays[arg_18_1 + 1], self.selectedId)

	return
end

function IslandShipStatusPage:FlushGifts()
	self.displays = {}

	for iter_19_0, iter_19_1 in pairs((getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetGifts())) do
		table.insert(self.displays, iter_19_1)
	end

	table.sort(self.displays, function(arg_20_0, arg_20_1)
		return arg_20_0.id < arg_20_1.id
	end)
	self.scrollRect:SetTotalCount(#self.displays)

	return
end

function IslandShipStatusPage:UpdateSelected(arg_21_1)
	self.selectedId = arg_21_1

	setActive(self.emptyTr, self.selectedId == nil)
	setActive(self.giftEffectList.container, self.selectedId)

	if self.selectedId then
		local var_21_0 = self:CollectGiftEffect(arg_21_1)

		self.giftEffectList:make(function(arg_22_0, arg_22_1, arg_22_2)
			if arg_22_0 == UIItemList.EventUpdate then
				setText(arg_22_2, var_21_0[arg_22_1 + 1])
			end

			return
		end)
		self.giftEffectList:align(#var_21_0)
	end

	self:FlushPower()

	return
end

function IslandShipStatusPage:CollectGiftBuffs(arg_23_1)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs((IslandItem.StaticGetUsageArg(arg_23_1))) do
		if ((self.ship:IsFavoriteGift(arg_23_1) or nil) and (IslandConst.GIFT_INDEX_FAVORITE or IslandConst.GIFT_INDEX_COMMON)) == iter_23_0 then
			for iter_23_2, iter_23_3 in ipairs(iter_23_1[2]) do
				table.insert(var_23_0, iter_23_3)
			end
		end
	end

	return var_23_0
end

function IslandShipStatusPage:CollectGiftEffect(arg_24_1)
	local var_24_0 = {}
	local var_24_1 = IslandItem.StaticGetUsageArg(arg_24_1)
	local var_24_2 = IslandConst.GIFT_INDEX_COMMON
	local var_24_3

	if self.ship:IsFavoriteGift(arg_24_1) then
		var_24_3 = var_24_1[IslandConst.GIFT_INDEX_FAVORITE] or var_24_1[var_24_2]

		if var_24_3[var_24_2] > 0 then
			table.insert(var_24_0, i18n("island_word_ship_enengy_recover") .. var_24_3[var_24_2])
		end
	end

	for iter_24_0, iter_24_1 in ipairs(var_24_3[2]) do
		table.insert(var_24_0, pg.island_buff_template[iter_24_1].buff_desc)
	end

	return var_24_0
end

function IslandShipStatusPage:GetGiftAddPower(arg_25_1)
	if not arg_25_1 then
		return 0
	end

	local var_25_0 = IslandItem.StaticGetUsageArg(arg_25_1)
	local var_25_1 = IslandConst.GIFT_INDEX_COMMON

	if self.ship:IsFavoriteGift(arg_25_1) then
		local var_25_2 = var_25_0[IslandConst.GIFT_INDEX_FAVORITE] or var_25_0[var_25_1]

		if var_25_2[var_25_1] > 0 then
			return var_25_2[var_25_1]
		end
	end

	return 0
end

function IslandShipStatusPage:FlushPower()
	self.maxPower = self.ship:GetMaxEnergy()
	self.curPower = self.ship:GetCurrentEnergy()
	self.addPower = self:GetGiftAddPower(self.selectedId)

	local var_26_0 = math.min(self.addPower, self.maxPower - self.curPower)

	setText(self.powerTr:Find("value"), self.curPower .. setColorStr((var_26_0 > 0 or nil) and ("+" .. var_26_0 or ""), "#4FD775") .. "/" .. self.maxPower)
	setSlider(self.powerTr:Find("progress"), 0, 1, self.curPower / self.maxPower)
	setSlider(self.powerTr:Find("progress/add"), 0, 1, (self.addPower > 0 or nil) and ((self.curPower + self.addPower) / self.maxPower or 0))

	return
end

function IslandShipStatusPage:OnDestroy()
	ClearLScrollrect(self.scrollRect)
	self.statusPanel:Dispose()

	self.statusPanel = nil

	for iter_27_0, iter_27_1 in ipairs(self.cards or {}) do
		iter_27_1:Dispose()
	end

	self.cards = nil

	return
end

return IslandShipStatusPage
