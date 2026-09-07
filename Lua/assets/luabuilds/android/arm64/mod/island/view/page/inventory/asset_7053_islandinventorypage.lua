local IslandInventoryPage = class("IslandInventoryPage", import("...base.IslandBasePage"))
local var_0_1 = 101
local var_0_2 = 102
local var_0_3 = 103
local var_0_4 = false

IslandInventoryPage.INVENTORY_TYPE_OVERFLOW = 100
IslandInventoryPage.INVENTORY_TYPE_COMMON = 101
IslandInventoryPage.MODE_VIEW = 0
IslandInventoryPage.MODE_EDIT = 1

function IslandInventoryPage:getUIName()
	return "IslandInventoryUI"
end

function IslandInventoryPage:OnLoaded()
	self.closeBtn = self._tf:Find("window/close_btn")
	self.filterBtn = self._tf:Find("window/sort_panel/index")
	self.orderBtn = self._tf:Find("window/sort_panel/sort")
	self.orderTxt = self._tf:Find("window/sort_panel/sort/Text"):GetComponent(typeof(Text))
	self.orderArr = self._tf:Find("window/sort_panel/sort/arr")
	self.toggles = {
		[IslandInventoryPage.INVENTORY_TYPE_OVERFLOW] = self._tf:Find("window/toggles/0"),
		[IslandItem.TYPE_MATERIAL] = self._tf:Find("window/toggles/1"),
		[IslandItem.TYPE_PROP] = self._tf:Find("window/toggles/2"),
		[IslandItem.TYPE_SPECIAL_PROP] = self._tf:Find("window/toggles/3")
	}
	self.indexDatas = {
		[IslandInventoryPage.INVENTORY_TYPE_OVERFLOW] = IslandInventoryIndexData.New(var_0_1),
		[IslandItem.TYPE_MATERIAL] = IslandInventoryIndexData.New(var_0_1),
		[IslandItem.TYPE_PROP] = IslandInventoryIndexData.New(var_0_2),
		[IslandItem.TYPE_SPECIAL_PROP] = IslandInventoryIndexData.New(var_0_3)
	}
	self.capacityTxt = self._tf:Find("window/upgrade/Text"):GetComponent(typeof(Text))
	self.upgradeBtn = self._tf:Find("window/upgrade")
	self.upgradeProg = self._tf:Find("window/upgrade/bar")
	self.batchSellBtn = self._tf:Find("window/batch_sell")
	self.sellPanel = self._tf:Find("window/sell_panel")

	setText(self.sellPanel:Find("tip"), i18n("island_quickselect_tip"))

	self.sortPaenl = self._tf:Find("window/sort_panel")
	self.sellBtn = self._tf:Find("window/sell_panel/batch_sell_1")
	self.sellCancelBtn = self._tf:Find("window/sell_panel/cancel")
	self.sellAllBtn = self._tf:Find("window/sell_panel/all")

	setActive(self.sellAllBtn, var_0_4)

	self.sellAllFlagTF = self.sellAllBtn:Find("flag")
	self.sellPriceTxt = self._tf:Find("window/sell_panel/price/Text"):GetComponent(typeof(Text))

	LoadImageSpriteAsync("island/" .. getIslandSeasonPtInfo().icon, self._tf:Find("window/sell_panel/price/Text/icon"))

	self.oneKeyPanel = self._tf:Find("window/one_key_panel")
	self.onekeyBtn = self._tf:Find("window/one_key_panel/fetch_btn")
	self.scrollRect = self._tf:Find("window/item_scrollview"):GetComponent("LScrollRect")

	setText(self._tf:Find("window/title/Text"), i18n("island_bag_title"))
	setText(self._tf:Find("window/batch_sell/Text"), i18n("island_batch_covert"))
	setText(self._tf:Find("window/sell_panel/price/label"), i18n("island_total_price"))
	setText(self._tf:Find("window/sell_panel/cancel/Text"), i18n("word_cancel"))
	setText(self._tf:Find("window/sell_panel/all/Text"), i18n("island_selectall"))
	setText(self._tf:Find("window/sell_panel/batch_sell_1/Text"), i18n("island_batch_covert"))
	setText(self._tf:Find("window/one_key_panel/fetch_btn/Text"), i18n("mail_get_oneclick"))

	return
end

function IslandInventoryPage:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.upgradeBtn, function()
		self:OpenPage(IslandInventoryUpgradePage)

		return
	end, SFX_PANEL)
	onButton(self, self.batchSellBtn, function()
		self.mode = IslandInventoryPage.MODE_EDIT

		self:SetTotalCount()
		self:UpdateStyle()

		self.sellPriceTxt.text = "x 0"

		return
	end, SFX_PANEL)
	onButton(self, self.sellCancelBtn, function()
		self.mode = IslandInventoryPage.MODE_VIEW

		self:SetTotalCount()
		self:UpdateStyle()

		for iter_8_0, iter_8_1 in ipairs(self.values) do
			self.values[iter_8_0] = 0
		end

		return
	end, SFX_PANEL)
	onButton(self, self.sellAllBtn, function(arg_9_0)
		if not var_0_4 then
			return
		end

		if self.selAllFlag then
			self:UpdataUnselAll()
		else
			self:UpdataSelAll()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.sellBtn, function()
		local var_10_0 = self:GetSellItems()

		if #var_10_0 <= 0 then
			return
		end

		self:ShowMsgBox({
			content = i18n("island_season_window_transformtip"),
			onYes = function()
				if self.tagType == IslandInventoryPage.INVENTORY_TYPE_OVERFLOW then
					self:emit(IslandMediator.ON_CONVERT_SEASON_PT_4_OVERFLOW, var_10_0)
				else
					self:emit(IslandMediator.ON_CONVERT_SEASON_PT, var_10_0)
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.onekeyBtn, function()
		if self.tagType ~= IslandInventoryPage.INVENTORY_TYPE_OVERFLOW then
			return
		end

		self:emit(IslandMediator.ONE_KEY)

		return
	end, SFX_PANEL)

	return
end

function IslandInventoryPage:OnShow()
	self:SetUp()

	return
end

function IslandInventoryPage:GetSellItems()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self.values) do
		var_14_0[self.displays[iter_14_0].id] = (var_14_0[self.displays[iter_14_0].id] or 0) + iter_14_1
	end

	local var_14_2 = {}

	for iter_14_2, iter_14_3 in pairs(var_14_0) do
		if iter_14_3 > 0 then
			table.insert(var_14_2, {
				id = iter_14_2,
				num = iter_14_3
			})
		end
	end

	return var_14_2
end

function IslandInventoryPage:UpdateStyle()
	setActive(self.sellPanel, self.mode == IslandInventoryPage.MODE_EDIT)
	setActive(self.sortPaenl, self.mode == IslandInventoryPage.MODE_VIEW and self.tagType ~= IslandInventoryPage.INVENTORY_TYPE_OVERFLOW)
	setActive(self.oneKeyPanel, self.tagType == IslandInventoryPage.INVENTORY_TYPE_OVERFLOW and self.mode ~= IslandInventoryPage.MODE_EDIT)
	setActive(self.batchSellBtn, self.mode == IslandInventoryPage.MODE_VIEW)

	if self.mode == IslandInventoryPage.MODE_EDIT then
		self:CheckSelAllFlag()
	end

	return
end

function IslandInventoryPage:AddListeners()
	self:AddListener(IslandScene.ON_INVENTORY_FILTER, self.OnInventoryFilter)
	self:AddListener(GAME.ISLAND_UPGRADE_INVENTORY_DONE, self.OnUpgrade)
	self:AddListener(GAME.ISLAND_CONVERT_SEASON_PT_DONE, self.OnSell)
	self:AddListener(GAME.ISLAND_GET_OVERFLOW_ITEM_DOME, self.OnSell)
	self:AddListener(GAME.ISLAND_INVITE_SHIP_DONE, self.OnUseInvitation)

	return
end

function IslandInventoryPage:RemoveListeners()
	self:RemoveListener(IslandScene.ON_INVENTORY_FILTER, self.OnInventoryFilter)
	self:RemoveListener(GAME.ISLAND_UPGRADE_INVENTORY_DONE, self.OnUpgrade)
	self:RemoveListener(GAME.ISLAND_CONVERT_SEASON_PT_DONE, self.OnSell)
	self:RemoveListener(GAME.ISLAND_GET_OVERFLOW_ITEM_DOME, self.OnSell)
	self:RemoveListener(GAME.ISLAND_INVITE_SHIP_DONE, self.OnUseInvitation)

	return
end

function IslandInventoryPage:OnUseInvitation()
	self:SetTotalCount()

	return
end

function IslandInventoryPage:GetIndexData(arg_19_1)
	assert(self.indexDatas[arg_19_1])

	return self.indexDatas[arg_19_1]
end

function IslandInventoryPage:UpdateIndexData(arg_20_1, arg_20_2)
	assert(self.indexDatas[arg_20_1])
	self.indexDatas[arg_20_1]:SetData(arg_20_2)

	return
end

function IslandInventoryPage:OnInventoryFilter(arg_21_1)
	self:UpdateIndexData(self.tagType, arg_21_1)
	self:FlushSortBtn()
	self:SetTotalCount()

	return
end

function IslandInventoryPage:OnUpgrade()
	self:SetTotalCount()
	self:FlushCapacity()
	self:ClosePage(IslandInventoryUpgradePage)

	return
end

function IslandInventoryPage:OnSell()
	self.mode = IslandInventoryPage.MODE_VIEW

	self:SetTotalCount()
	self:UpdateStyle()
	self:FlushCapacity()

	self.sellPriceTxt.text = "x 0"

	return
end

function IslandInventoryPage:SetUp()
	self.tagType = IslandItem.TYPE_MATERIAL
	self.mode = IslandInventoryPage.MODE_VIEW
	self.asc = true
	self.cards = {}

	self:FlushTags()
	self:FlushFilterBtn()
	self:FlushSortBtn()
	self:FlushList()
	self:FlushCapacity()
	self:UpdateStyle()

	return
end

function IslandInventoryPage:FlushCapacity()
	if self.tagType == IslandItem.TYPE_MATERIAL then
		setActive(self.upgradeBtn, true)
		setActive(self.batchSellBtn, true)

		local var_25_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
		local var_25_1 = var_25_0:GetLength()
		local var_25_2 = var_25_0:GetCapacity()

		setButtonEnabled(self.upgradeBtn, not var_25_0:IsMaxLevel())

		local var_25_3 = var_25_1 / var_25_2

		self:managedTween(LeanTween.value, nil, go(self.upgradeBtn), 0, var_25_1 / var_25_2, (math.min(var_25_1 / var_25_2, 1))):setOnUpdate(System.Action_float(function(arg_26_0)
			self.capacityTxt.text = calcFloor(var_25_2 * arg_26_0) .. "/" .. var_25_2

			setFillAmount(self.upgradeProg, arg_26_0)

			return
		end)):setOnComplete(System.Action(function()
			self.capacityTxt.text = var_25_1 .. "/" .. var_25_2

			setFillAmount(self.upgradeProg, var_25_3)

			return
		end))

		self.upgradeProg:GetComponent(typeof(Image)).color = var_25_1 / var_25_2 > 0.85 and Color.New(0.9529411764705882, 0.4235294117647059, 0.43137254901960786, 1) or Color.New(0.2235294117647059, 0.7450980392156863, 1, 1)
	elseif self.tagType == IslandInventoryPage.INVENTORY_TYPE_OVERFLOW then
		setActive(self.upgradeBtn, false)
		setActive(self.batchSellBtn, true)
	else
		setActive(self.upgradeBtn, false)
		setActive(self.batchSellBtn, false)
	end

	return
end

function IslandInventoryPage:FlushTags()
	for iter_28_0, iter_28_1 in pairs(self.toggles) do
		onToggle(self, iter_28_1, function(arg_29_0)
			if arg_29_0 then
				self:CheckEditMode(iter_28_0)

				self.tagType = iter_28_0

				self:FlushCapacity()
				self:FlushSortBtn()
				self:SetTotalCount()
				self:UpdateStyle()
			end

			return
		end, SFX_PANEL)

		if iter_28_0 == IslandInventoryPage.INVENTORY_TYPE_OVERFLOW then
			setText(iter_28_1:Find("Text"), i18n("island_word_temp"))
		else
			setText(iter_28_1:Find("Text"), IslandItemKind.Type2TagName(iter_28_0))
		end
	end

	self:ActiveDefaultTag()

	return
end

function IslandInventoryPage:ActiveDefaultTag()
	local var_30_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency():ExistAnyOverFlowItem()

	setActive(self.toggles[IslandInventoryPage.INVENTORY_TYPE_OVERFLOW], var_30_0)

	if var_30_0 then
		triggerToggle(self.toggles[IslandInventoryPage.INVENTORY_TYPE_OVERFLOW], true)
	else
		triggerToggle(self.toggles[IslandItem.TYPE_MATERIAL], true)
	end

	return
end

function IslandInventoryPage:CheckEditMode(arg_31_1)
	if self.tagType ~= arg_31_1 and self.mode == IslandInventoryPage.MODE_EDIT then
		triggerButton(self.sellCancelBtn)
	end

	return
end

function IslandInventoryPage:FlushFilterBtn()
	onButton(self, self.filterBtn, function()
		self:OpenPage(IslandInventoryIndexPage, (self:GetIndexData(self.tagType)))

		return
	end, SFX_PANEL)

	return
end

function IslandInventoryPage:FlushSortBtn()
	local function var_34_0()
		self.orderTxt.text = self:GetIndexData(self.tagType):GetSortText()
		self.orderArr.localScale = self.asc and Vector2(1, -1, 1) or Vector2(1, 1, 1)

		return
	end

	onButton(self, self.orderBtn, function()
		self.asc = not self.asc

		var_34_0()
		self:SetTotalCount()

		return
	end, SFX_PANEL)
	var_34_0()

	return
end

function IslandInventoryPage:FlushList()
	function self.scrollRect.onInitItem(arg_38_0)
		self:OnInitItem(arg_38_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_39_0, arg_39_1)
		self:OnUpdateItem(arg_39_0, arg_39_1)

		return
	end

	self:SetTotalCount()

	return
end

function IslandInventoryPage:SetTotalCount()
	self.displays = self:Filter()
	self.values = {}
	self.selAllFlag = false

	for iter_40_0, iter_40_1 in ipairs(self.displays) do
		table.insert(self.values, 0)
	end

	local var_40_0 = self:GetIndexData(self.tagType)

	table.sort(self.displays, function(arg_41_0, arg_41_1)
		return var_40_0:Sort(arg_41_0, arg_41_1, self.asc)
	end)
	self.scrollRect:SetTotalCount(#self.displays, -1)

	return
end

function IslandInventoryPage:OnInitItem(arg_42_1)
	local var_42_0 = IslandItemCard.New(arg_42_1)

	onButton(self, var_42_0._go, function()
		if self.mode == IslandInventoryPage.MODE_VIEW then
			if self.tagType ~= IslandInventoryPage.INVENTORY_TYPE_OVERFLOW then
				self:OnClickItem(var_42_0)
			end
		elseif self.mode == IslandInventoryPage.MODE_EDIT then
			self:OnClickItemForSell(var_42_0)
		end

		return
	end, SFX_PANEL)
	onButton(self, var_42_0.reduceBtn, function()
		if self.mode == IslandInventoryPage.MODE_EDIT then
			self:UpdateSellPrice(var_42_0, -1)
		end

		return
	end, SFX_PANEL)
	onInputEndEdit(self, var_42_0.valueInput, function(arg_45_0)
		local var_45_0 = table.indexof(self.displays, var_42_0.item)

		if not var_45_0 then
			return
		end

		if not arg_45_0 or arg_45_0 == "" or not tonumber(arg_45_0) then
			-- block empty
		end

		self:UpdateSellPrice(var_42_0, tonumber(arg_45_0) - self.values[var_45_0])

		return
	end)
	pressPersistTrigger(var_42_0.calcPanel, 0.5, function()
		if self.mode == IslandInventoryPage.MODE_EDIT then
			self:UpdateSellPrice(var_42_0, 1)
		end

		return
	end, nil, true, true, 0.1, SFX_PANEL)

	self.cards[arg_42_1] = var_42_0

	return
end

function IslandInventoryPage:OnClickItem(arg_47_1)
	if isa(arg_47_1.item, IslandInvitation) then
		local var_47_0 = arg_47_1.item:GetShipName()

		self:ShowMsgBox({
			content = i18n("island_open_ship_tip"),
			onYes = function()
				self:Hide()
				self:emit(IslandBaseMediator.SWITCH_MAP, IslandConst.LABORATORY_MAP_ID, IslandConst.LETTEROFINVITATION_SP)

				return
			end
		})
	else
		self:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_ITEM,
			itemId = arg_47_1.item.id
		})
	end

	return
end

function IslandInventoryPage:OnClickItemForSell(arg_49_1)
	self:UpdateSellPrice(arg_49_1, 1)

	return
end

function IslandInventoryPage:_IsSelAll()
	for iter_50_0, iter_50_1 in ipairs(self.values) do
		if iter_50_1 ~= self.displays[iter_50_0]:GetCount() then
			return false
		end
	end

	return true
end

function IslandInventoryPage:CheckSelAllFlag()
	self.selAllFlag = self:_IsSelAll()

	setActive(self.sellAllFlagTF, self.selAllFlag)

	return
end

function IslandInventoryPage:UpdataSelAll()
	self.values = {}

	for iter_52_0, iter_52_1 in ipairs(self.displays) do
		self.values[iter_52_0] = iter_52_1:GetCount()
	end

	self.scrollRect:SetTotalCount(#self.displays, -1)

	local var_52_0 = 0

	for iter_52_2, iter_52_3 in ipairs(self.values) do
		var_52_0 = self.displays[iter_52_2]:GetConvertPt() * iter_52_3 + var_52_0
	end

	self.sellPriceTxt.text = "x " .. var_52_0
	self.selAllFlag = true

	setActive(self.sellAllFlagTF, self.selAllFlag)

	return
end

function IslandInventoryPage:UpdataUnselAll()
	self:SetTotalCount()

	self.sellPriceTxt.text = "x 0"
	self.selAllFlag = false

	setActive(self.sellAllFlagTF, self.selAllFlag)

	return
end

function IslandInventoryPage:UpdateSellPrice(arg_54_1, arg_54_2)
	local var_54_0 = table.indexof(self.displays, arg_54_1.item)

	if not var_54_0 then
		return
	end

	self.values[var_54_0] = math.max(0, math.min(self.values[var_54_0] + arg_54_2, arg_54_1.item:GetCount()))

	arg_54_1:UpdateValue(self.values[var_54_0])

	local var_54_1 = 0

	for iter_54_0, iter_54_1 in ipairs(self.values) do
		var_54_1 = self.displays[iter_54_0]:GetConvertPt() * iter_54_1 + var_54_1
	end

	self.sellPriceTxt.text = "x " .. var_54_1

	self:CheckSelAllFlag()

	return
end

function IslandInventoryPage:OnUpdateItem(arg_55_1, arg_55_2)
	local var_55_0 = self.cards[arg_55_2]

	if not self.cards[arg_55_2] then
		self:OnInitItem(arg_55_2)

		var_55_0 = self.cards[arg_55_2]
	end

	if self.displays[arg_55_1 + 1] then
		var_55_0:Update(self.displays[arg_55_1 + 1], self.mode, self.values[arg_55_1 + 1], self.tagType)
	end

	return
end

function IslandInventoryPage:Filter()
	local var_56_0 = {}

	if self.tagType == IslandInventoryPage.INVENTORY_TYPE_OVERFLOW then
		self:CollectOverFlowInventoryItems(var_56_0)
	else
		self:CollectCommonInventoryItems(var_56_0)
	end

	if self.mode == IslandInventoryPage.MODE_EDIT then
		var_56_0 = underscore.select(var_56_0, function(arg_57_0)
			return arg_57_0:CanConvert()
		end)
	end

	return var_56_0
end

function IslandInventoryPage:CollectOverFlowInventoryItems(arg_58_1)
	for iter_58_0, iter_58_1 in pairs((getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOverflowItemList())) do
		table.insert(arg_58_1, iter_58_1)
	end

	return
end

function IslandInventoryPage:CollectCommonInventoryItems(arg_59_1)
	for iter_59_0, iter_59_1 in ipairs((getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetGroupedItemList())) do
		if self.tagType == IslandItem.TYPE_MATERIAL and iter_59_1:IsMaterial() and self.indexDatas[IslandItem.TYPE_MATERIAL]:Match(iter_59_1) then
			table.insert(arg_59_1, iter_59_1)
		elseif self.tagType == IslandItem.TYPE_PROP and iter_59_1:IsProp() and self.indexDatas[IslandItem.TYPE_PROP]:Match(iter_59_1) then
			table.insert(arg_59_1, iter_59_1)
		elseif self.tagType == IslandItem.TYPE_SPECIAL_PROP and iter_59_1:IsSpecialProp() and self.indexDatas[IslandItem.TYPE_SPECIAL_PROP]:Match(iter_59_1) then
			table.insert(arg_59_1, iter_59_1)
		end
	end

	if self.tagType == IslandItem.TYPE_SPECIAL_PROP then
		for iter_59_2, iter_59_3 in ipairs((getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetInviteList())) do
			local var_59_0 = IslandInvitation.New(iter_59_3)

			if self.indexDatas[IslandItem.TYPE_SPECIAL_PROP]:Match(var_59_0) then
				table.insert(arg_59_1, var_59_0)
			end
		end
	end

	return
end

function IslandInventoryPage:OnDestroy()
	ClearLScrollrect(self.scrollRect)

	for iter_60_0, iter_60_1 in pairs(self.cards) do
		iter_60_1:Dispose()
	end

	self.cards = {}

	return
end

return IslandInventoryPage
