local IslandExchangePage = class("IslandExchangePage", import("...base.IslandBasePage"))

function IslandExchangePage:getUIName()
	return "IslandExchangeUI"
end

function IslandExchangePage:OnLoaded()
	setText(self._tf:Find("top/title/Text"), i18n("island_exchange_title"))
	setText(self._tf:Find("top/title/Text/en"), i18n("island_exchange_title_en"))

	local var_2_0 = self._tf:Find("adapt/toggles/content")

	self.toggleUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	local var_2_1 = self._tf:Find("adapt/left")

	setText(var_2_1:Find("tip"), i18n("island_quickselect_tip"))

	self.allBtn = var_2_1:Find("btn_all")
	self.allFlagTF = self.allBtn:Find("flag")

	setText(self.allBtn:Find("Text"), i18n("island_selectall"))

	self.deleteBtn = var_2_1:Find("btn_delete")
	self.scrollRect = var_2_1:Find("view"):GetComponent("LScrollRect")
	self.emptyTF = var_2_1:Find("empty")

	local var_2_2 = self._tf:Find("adapt/right")

	self.itemNameTxt = var_2_2:Find("title/name"):GetComponent(typeof(Text))
	self.itemTF = var_2_2:Find("bg_item/item")

	setText(var_2_2:Find("bg_count/Text"), i18n("island_exchange_own_count"))

	self.itemOwnTxt = var_2_2:Find("bg_count/content/Text"):GetComponent(typeof(Text))
	self.itemAddTxt = var_2_2:Find("bg_count/content/add"):GetComponent(typeof(Text))
	self.exchangeBtn = var_2_2:Find("btn_exchange")

	setText(self.exchangeBtn:Find("Text"), i18n("island_exchange_btn_text"))

	self.blockTF = self._tf:Find("block")
	self.itemAnim = var_2_2:Find("bg_item"):GetComponent(typeof(Animation))
	self.itemAnimEvent = var_2_2:Find("bg_item"):GetComponent(typeof(DftAniEvent))

	return
end

function IslandExchangePage:OnInit()
	onButton(self, self._tf:Find("top/back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
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
		self:ShowMsgBox({
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

		self:ShowMsgBox({
			content = i18n("island_exchange_sure_tip"),
			onYes = function()
				self.itemAnim:Play("anim_IslandExchangeUI_Craft")
				setActive(self.blockTF, true)

				return
			end
		})

		return
	end, SFX_PANEL)
	self.toggleUIList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			self:UpdateToggleItem(arg_12_1, arg_12_2)
		end

		return
	end)

	function self.scrollRect.onInitItem(arg_13_0)
		self:OnInitItem(arg_13_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_14_0, arg_14_1)
		self:OnUpdateItem(arg_14_0, arg_14_1)

		return
	end

	return
end

function IslandExchangePage:SendExchangeProto()
	self:emit(IslandMediator.EXCHANGE_ITME, self.exchangeItems, self.showItemId, self.totalAddCnt)

	return
end

function IslandExchangePage:OnShow(arg_16_1)
	self.firstFlush = true
	self.cards = {}
	self.showIds = arg_16_1 or pg.island_exchange_group.all

	self.toggleUIList:align(#self.showIds)
	triggerToggle(self.toggleUIList.container:GetChild(0):Find("title"), true)
	setActive(self.blockTF, false)
	self.itemAnim:Play("anim_IslandExchangeUI_Craft_loop")
	self:BlurPanel()

	return
end

function IslandExchangePage:AddListeners()
	self:AddListener(GAME.ISLAND_EXCHANGE_ITEM_DONE, self.OnExchangeDone)

	return
end

function IslandExchangePage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_EXCHANGE_ITEM_DONE, self.OnExchangeDone)

	return
end

function IslandExchangePage:OnExchangeDone()
	self:FlushGroup()

	return
end

function IslandExchangePage:UpdateToggleItem(arg_20_1, arg_20_2)
	setText(arg_20_2:Find("title/name"), pg.island_exchange_group[self.showIds[arg_20_1 + 1]].text[1])
	setText(arg_20_2:Find("title/name/en"), pg.island_exchange_group[self.showIds[arg_20_1 + 1]].text[2])
	GetImageSpriteFromAtlasAsync("island/islandshopicon", pg.island_exchange_group[self.showIds[arg_20_1 + 1]].text[3], arg_20_2:Find("title/sel/icon"))
	onToggle(self, arg_20_2:Find("title"), function(arg_21_0)
		if arg_21_0 then
			triggerToggle(arg_20_2:Find("list"):GetChild(0), true)
		end

		return
	end, SFX_PANEL)

	local var_20_0 = pg.island_exchange_group[self.showIds[arg_20_1 + 1]].exchange_group

	UIItemList.StaticAlign(arg_20_2:Find("list"), arg_20_2:Find("list/tpl"), #pg.island_exchange_group[self.showIds[arg_20_1 + 1]].exchange_group, function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = arg_22_1 + 1
			local var_22_1 = var_20_0[arg_22_1 + 1][2]

			setText(arg_22_2:Find("name"), var_20_0[arg_22_1 + 1][1])
			setText(arg_22_2:Find("sel/name"), var_20_0[arg_22_1 + 1][1])
			setActive(arg_22_2:Find("line2"), var_22_0 ~= #var_20_0)
			onToggle(self, arg_22_2, function(arg_23_0)
				if arg_23_0 then
					if not self.firstFlush and self.showGroupId and self.showGroupId == var_22_1 then
						return
					end

					self.firstFlush = false
					self.showGroupId = var_22_1

					self:FlushGroup()
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function IslandExchangePage:FlushGroup()
	self:SetTotalCount()

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

function IslandExchangePage:SetTotalCount()
	self.displays = self:CollectDisplayItems()
	self.values = {}

	for iter_25_0, iter_25_1 in ipairs(self.displays) do
		table.insert(self.values, 0)
	end

	self.scrollRect:SetTotalCount(#self.displays, -1)
	setActive(self.emptyTF, #self.displays == 0)

	self.selAllFlag = false

	setActive(self.allFlagTF, self.selAllFlag)

	return
end

function IslandExchangePage:UpdateCount()
	self.totalAddCnt = 0

	for iter_26_0, iter_26_1 in ipairs(self.values) do
		self.totalAddCnt = self.totalAddCnt + self.displays[iter_26_0].targetNum * iter_26_1
	end

	if self.totalAddCnt > 0 then
		self.itemAddTxt.text = "+" .. self.totalAddCnt or ""
	end

	return
end

function IslandExchangePage:OnInitItem(arg_27_1)
	local var_27_0 = IslandExchangeItemCard.New(arg_27_1)

	onButton(self, var_27_0._go, function()
		self:UpdateCardSel(var_27_0, 1)

		return
	end, SFX_PANEL)
	onButton(self, var_27_0.reduceBtn, function()
		self:UpdateCardSel(var_27_0, -1)

		return
	end, SFX_PANEL)
	onInputEndEdit(self, var_27_0.valueInput, function(arg_30_0)
		local var_30_0 = table.indexof(self.displays, var_27_0.item)

		if not var_30_0 then
			return
		end

		if not arg_30_0 or arg_30_0 == "" or not tonumber(arg_30_0) then
			-- block empty
		end

		self:UpdateCardSel(var_27_0, tonumber(arg_30_0) - self.values[var_30_0])

		return
	end)
	pressPersistTrigger(var_27_0.calcPanel, 0.5, function()
		self:UpdateCardSel(var_27_0, 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)

	self.cards[arg_27_1] = var_27_0

	return
end

function IslandExchangePage:OnUpdateItem(arg_32_1, arg_32_2)
	local var_32_0 = self.cards[arg_32_2]

	if not self.cards[arg_32_2] then
		self:OnInitItem(arg_32_2)

		var_32_0 = self.cards[arg_32_2]
	end

	if self.displays[arg_32_1 + 1] then
		var_32_0:Update(self.displays[arg_32_1 + 1], self.values[arg_32_1 + 1])
	end

	return
end

function IslandExchangePage:UpdateCardSel(arg_33_1, arg_33_2)
	local var_33_0 = table.indexof(self.displays, arg_33_1.item)

	if not var_33_0 then
		return
	end

	self.values[var_33_0] = math.max(0, math.min(self.values[var_33_0] + arg_33_2, arg_33_1.item:GetCount()))

	arg_33_1:UpdateValue(self.values[var_33_0])
	self:UpdateCount()
	self:CheckSelAllFlag()

	return
end

function IslandExchangePage:_IsSelAll()
	for iter_34_0, iter_34_1 in ipairs(self.values) do
		if iter_34_1 ~= self.displays[iter_34_0]:GetCount() then
			return false
		end
	end

	return true
end

function IslandExchangePage:CheckSelAllFlag()
	self.selAllFlag = self:_IsSelAll()

	setActive(self.allFlagTF, self.selAllFlag)

	return
end

function IslandExchangePage:SelecteAll()
	self.values = {}

	for iter_36_0, iter_36_1 in ipairs(self.displays) do
		self.values[iter_36_0] = iter_36_1:GetCount()
	end

	self.scrollRect:SetTotalCount(#self.displays, -1)
	self:UpdateCount()

	self.selAllFlag = true

	setActive(self.allFlagTF, self.selAllFlag)

	return
end

function IslandExchangePage:CollectDisplayItems()
	local var_37_0 = {}
	local var_37_1 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	self.showExchangeIds = pg.island_exchange_template.get_id_list_by_group[self.showGroupId]
	self.showItemId = pg.island_exchange_template[self.showExchangeIds[1]].target_item

	for iter_37_0, iter_37_1 in ipairs(self.showExchangeIds) do
		local var_37_2 = var_37_1:GetItemById(pg.island_exchange_template[iter_37_1].origin_item)

		if var_37_2 then
			local var_37_3 = Clone(var_37_2)

			var_37_3.exchangeId = iter_37_1
			var_37_3.targetNum = pg.island_exchange_template[iter_37_1].target_num

			table.insert(var_37_0, var_37_3)
		end
	end

	return var_37_0
end

function IslandExchangePage:GetExchangeItems()
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in ipairs(self.values) do
		if iter_38_1 > 0 then
			table.insert(var_38_0, {
				exchangeId = self.displays[iter_38_0].exchangeId,
				itemId = self.displays[iter_38_0].id,
				num = iter_38_1
			})
		end
	end

	return var_38_0
end

function IslandExchangePage:OnHide()
	self.itemAnim:Stop()
	self:UnBlurPanel()

	return
end

function IslandExchangePage:OnDisable()
	self:OnHide()

	return
end

function IslandExchangePage:OnDestroy()
	self:OnHide()
	ClearLScrollrect(self.scrollRect)

	for iter_41_0, iter_41_1 in pairs(self.cards) do
		iter_41_1:Dispose()
	end

	self.cards = {}

	self.itemAnimEvent:SetTriggerEvent(nil)
	self.itemAnimEvent:SetEndEvent(nil)

	return
end

return IslandExchangePage
