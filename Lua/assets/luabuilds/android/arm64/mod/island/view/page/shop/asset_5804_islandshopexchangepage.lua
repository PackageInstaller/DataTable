local IslandShopExchangePage = class("IslandShopExchangePage", import("view.base.BaseSubView"))

function IslandShopExchangePage:getUIName()
	return "IslandShopExchangeUI"
end

function IslandShopExchangePage:Ctor(arg_2_1, arg_2_2)
	IslandShopExchangePage.super.Ctor(self, arg_2_1, arg_2_2.event, arg_2_2.contextData)

	self.viewComponent = arg_2_2

	return
end

function IslandShopExchangePage:OnLoaded()
	local var_3_0 = self._tf:Find("adapt/left")

	setText(var_3_0:Find("tip"), i18n("island_quickselect_tip"))

	self.allBtn = var_3_0:Find("btn_all")
	self.allFlagTF = self.allBtn:Find("flag")

	setText(self.allBtn:Find("Text"), i18n("island_selectall"))

	self.deleteBtn = var_3_0:Find("btn_delete")
	self.scrollRect = var_3_0:Find("view"):GetComponent("LScrollRect")
	self.emptyTF = var_3_0:Find("empty")

	local var_3_1 = self._tf:Find("adapt/right")

	self.itemNameTxt = var_3_1:Find("title/name"):GetComponent(typeof(Text))
	self.itemTF = var_3_1:Find("bg_item/item")

	setText(var_3_1:Find("bg_count/Text"), i18n("island_exchange_own_count"))

	self.itemOwnTxt = var_3_1:Find("bg_count/content/Text"):GetComponent(typeof(Text))
	self.itemAddTxt = var_3_1:Find("bg_count/content/add"):GetComponent(typeof(Text))
	self.exchangeBtn = var_3_1:Find("btn_exchange")

	setText(self.exchangeBtn:Find("Text"), i18n("island_exchange_btn_text"))

	self.blockTF = self._tf:Find("block")
	self.itemAnim = var_3_1:Find("bg_item"):GetComponent(typeof(Animation))
	self.itemAnimEvent = var_3_1:Find("bg_item"):GetComponent(typeof(DftAniEvent))

	return
end

function IslandShopExchangePage:OnInit()
	onButton(self, self.allBtn, function(arg_5_0)
		if self.selAllFlag or #self.displays == 0 then
			return
		end

		self:SelecteAll()

		return
	end, SFX_PANEL)
	onButton(self, self.deleteBtn, function()
		self:SetTotalCount()

		self.itemAddTxt.text = ""

		return
	end, SFX_PANEL)
	onButton(self, self.itemTF, function()
		self.viewComponent:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = self.showDropData
		})

		return
	end)
	self.itemAnimEvent:SetTriggerEvent(function()
		self:SendExchangeProto()

		return
	end)
	self.itemAnimEvent:SetEndEvent(function()
		setActive(self.blockTF, false)
		self.itemAnim:Play("anim_IslandExchangeUI_Craft_loop")

		return
	end)
	onButton(self, self.exchangeBtn, function()
		if getProxy(IslandProxy):GetIsland():GetInventoryAgency():ExistAnyOverFlowItem() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_bag_max_tip"))

			return
		end

		self.exchangeItems = self:GetExchangeItems()

		if #self.exchangeItems <= 0 then
			return
		end

		self.viewComponent:ShowMsgBox({
			content = i18n("island_exchange_sure_tip"),
			onYes = function()
				self.itemAnim:Play("anim_IslandExchangeUI_Craft")
				setActive(self.blockTF, true)

				return
			end
		})

		return
	end, SFX_PANEL)

	function self.scrollRect.onInitItem(arg_12_0)
		self:OnInitItem(arg_12_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_13_0, arg_13_1)
		self:OnUpdateItem(arg_13_0, arg_13_1)

		return
	end

	self.cards = {}

	return
end

function IslandShopExchangePage:SendExchangeProto()
	self:emit(IslandMediator.EXCHANGE_ITME, self.exchangeItems, self.showItemId, self.totalAddCnt)

	return
end

function IslandShopExchangePage:Show()
	IslandShopExchangePage.super.Show(self)

	self.groupConfig = pg.island_exchange_group

	setActive(self.blockTF, false)
	self.itemAnim:Play("anim_IslandExchangeUI_Craft_loop")
	self:OverlayPanel(self._tf, {
		pbList = {
			self._tf:Find("bg")
		}
	})

	return
end

function IslandShopExchangePage:FlushGroup(arg_16_1)
	local var_16_0

	if not arg_16_1 then
		::label_16_0::

		var_16_0 = self.showGroupId or self.groupConfig[self.groupConfig.all[1]].exchange_group[1][2]
	end

	self.showGroupId = var_16_0

	if self:isShowing() then
		self:SetTotalCount()
	end

	self.itemNameTxt.text = pg.island_item_data_template[self.showItemId].name
	self.itemOwnTxt.text = getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOwnCount(self.showItemId)
	self.itemAddTxt.text = ""
	self.showDropData = Drop.New({
		count = 0,
		type = DROP_TYPE_ISLAND_ITEM,
		id = self.showItemId
	})

	updateIslandItem(self.itemTF, self.showDropData)

	return
end

function IslandShopExchangePage:SetTotalCount()
	self.displays = self:CollectDisplayItems()
	self.values = {}

	for iter_17_0, iter_17_1 in ipairs(self.displays) do
		table.insert(self.values, 0)
	end

	self.scrollRect:SetTotalCount(#self.displays, -1)
	setActive(self.emptyTF, #self.displays == 0)

	self.selAllFlag = false

	setActive(self.allFlagTF, self.selAllFlag)

	return
end

function IslandShopExchangePage:UpdateCount()
	self.totalAddCnt = 0

	for iter_18_0, iter_18_1 in ipairs(self.values) do
		self.totalAddCnt = self.totalAddCnt + self.displays[iter_18_0].targetNum * iter_18_1
	end

	if self.totalAddCnt > 0 then
		self.itemAddTxt.text = "+" .. self.totalAddCnt or ""
	end

	return
end

function IslandShopExchangePage:OnInitItem(arg_19_1)
	local var_19_0 = IslandExchangeItemCard.New(arg_19_1)

	onButton(self, var_19_0._go, function()
		self:UpdateCardSel(var_19_0, 1)

		return
	end, SFX_PANEL)
	onButton(self, var_19_0.reduceBtn, function()
		self:UpdateCardSel(var_19_0, -1)

		return
	end, SFX_PANEL)
	onInputEndEdit(self, var_19_0.valueInput, function(arg_22_0)
		local var_22_0 = table.indexof(self.displays, var_19_0.item)

		if not var_22_0 then
			return
		end

		if not arg_22_0 or arg_22_0 == "" or not tonumber(arg_22_0) then
			-- block empty
		end

		self:UpdateCardSel(var_19_0, tonumber(arg_22_0) - self.values[var_22_0])

		return
	end)
	pressPersistTrigger(var_19_0.calcPanel, 0.5, function()
		self:UpdateCardSel(var_19_0, 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)

	self.cards[arg_19_1] = var_19_0

	return
end

function IslandShopExchangePage:OnUpdateItem(arg_24_1, arg_24_2)
	local var_24_0 = self.cards[arg_24_2]

	if not self.cards[arg_24_2] then
		self:OnInitItem(arg_24_2)

		var_24_0 = self.cards[arg_24_2]
	end

	if self.displays[arg_24_1 + 1] then
		var_24_0:Update(self.displays[arg_24_1 + 1], self.values[arg_24_1 + 1])
	end

	return
end

function IslandShopExchangePage:UpdateCardSel(arg_25_1, arg_25_2)
	local var_25_0 = table.indexof(self.displays, arg_25_1.item)

	if not var_25_0 then
		return
	end

	self.values[var_25_0] = math.max(0, math.min(self.values[var_25_0] + arg_25_2, arg_25_1.item:GetCount()))

	arg_25_1:UpdateValue(self.values[var_25_0])
	self:UpdateCount()
	self:CheckSelAllFlag()

	return
end

function IslandShopExchangePage:_IsSelAll()
	for iter_26_0, iter_26_1 in ipairs(self.values) do
		if iter_26_1 ~= self.displays[iter_26_0]:GetCount() then
			return false
		end
	end

	return true
end

function IslandShopExchangePage:CheckSelAllFlag()
	self.selAllFlag = self:_IsSelAll()

	setActive(self.allFlagTF, self.selAllFlag)

	return
end

function IslandShopExchangePage:SelecteAll()
	self.values = {}

	for iter_28_0, iter_28_1 in ipairs(self.displays) do
		self.values[iter_28_0] = iter_28_1:GetCount()
	end

	self.scrollRect:SetTotalCount(#self.displays, -1)
	self:UpdateCount()

	self.selAllFlag = true

	setActive(self.allFlagTF, self.selAllFlag)

	return
end

function IslandShopExchangePage:CollectDisplayItems()
	local var_29_0 = {}
	local var_29_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	self.showExchangeIds = pg.island_exchange_template.get_id_list_by_group[self.showGroupId]
	self.showItemId = pg.island_exchange_template[self.showExchangeIds[1]].target_item

	for iter_29_0, iter_29_1 in ipairs(self.showExchangeIds) do
		local var_29_2 = var_29_1:GetItemById(pg.island_exchange_template[iter_29_1].origin_item)

		if var_29_2 then
			local var_29_3 = Clone(var_29_2)

			var_29_3.exchangeId = iter_29_1
			var_29_3.targetNum = pg.island_exchange_template[iter_29_1].target_num

			table.insert(var_29_0, var_29_3)
		end
	end

	return var_29_0
end

function IslandShopExchangePage:GetExchangeItems()
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(self.values) do
		if iter_30_1 > 0 then
			table.insert(var_30_0, {
				exchangeId = self.displays[iter_30_0].exchangeId,
				itemId = self.displays[iter_30_0].id,
				num = iter_30_1
			})
		end
	end

	return var_30_0
end

function IslandShopExchangePage:OnHide()
	self.itemAnim:Stop()
	setActive(self.blockTF, false)
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandShopExchangePage:OnDestroy()
	self:OnHide()
	ClearLScrollrect(self.scrollRect)

	for iter_32_0, iter_32_1 in pairs(self.cards) do
		iter_32_1:Dispose()
	end

	self.cards = {}

	self.itemAnimEvent:SetTriggerEvent(nil)
	self.itemAnimEvent:SetEndEvent(nil)

	return
end

return IslandShopExchangePage
