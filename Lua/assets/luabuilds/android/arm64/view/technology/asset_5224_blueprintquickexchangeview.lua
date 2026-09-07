local BlueprintQuickExchangeView = class("BlueprintQuickExchangeView", import("view.base.BaseSubView"))

function BlueprintQuickExchangeView:getUIName()
	return "BlueprintQuickExchangeUI"
end

function BlueprintQuickExchangeView:OnInit()
	self.rtBg = self._tf:Find("bg")

	onButton(self, self.rtBg, function()
		self:Hide()

		return
	end, SFX_CANCEL)

	self.rtPreview = self._tf:Find("window/preview/got")
	self.rtEmpty = self.rtPreview:Find("empty")

	setText(self.rtEmpty:Find("Text"), i18n("blueprint_exchange_empty_tip"))

	local var_2_0 = self.rtPreview:Find("list")

	self.itemList = UIItemList.New(var_2_0, var_2_0:Find("item"))

	self.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = self.displayList[arg_4_1]
			local var_4_1 = self.awardList[arg_4_1].count

			updateDrop(arg_4_2:Find("icon"), self.displayList[arg_4_1])
			onButton(self, arg_4_2:Find("icon"), function()
				self:emit(BaseUI.ON_DROP, var_4_0)

				return
			end, SFX_PANEL)
			setText(arg_4_2:Find("calc/value"), self.countList[arg_4_1])
			setScrollText(arg_4_2:Find("name/Text"), self.displayList[arg_4_1]:getConfig("name"))
			setText(arg_4_2:Find("kc"), i18n("tec_tip_material_stock") .. ":" .. self.displayList[arg_4_1].count)
			pressPersistTrigger(arg_4_2:Find("calc/plus"), 0.5, function()
				if var_4_0.count > self.countList[arg_4_1] and self.count + var_4_1 <= self.need then
					self.countList[arg_4_1] = self.countList[arg_4_1] + 1

					setText(arg_4_2:Find("calc/value"), self.countList[arg_4_1])

					self.count = self.count + var_4_1

					setText(self.rtExchange:Find("bg/count"), setColorStr(self.count, "#FFEC6E") .. "/" .. self.need)
				end

				return
			end, nil, true, true, 0.1, SFX_PANEL)
			pressPersistTrigger(arg_4_2:Find("calc/minus"), 0.5, function()
				if self.countList[arg_4_1] > 0 then
					self.countList[arg_4_1] = self.countList[arg_4_1] - 1

					setText(arg_4_2:Find("calc/value"), self.countList[arg_4_1])

					self.count = self.count - var_4_1

					setText(self.rtExchange:Find("bg/count"), setColorStr(self.count, "#FFEC6E") .. "/" .. self.need)
				end

				return
			end, nil, true, true, 0.1, SFX_PANEL)
			onButton(self, arg_4_2:Find("calc/max"), function()
				if var_4_0.count > self.countList[arg_4_1] and self.count + var_4_1 <= self.need then
					local var_8_0 = math.min(math.floor((self.need - self.count + var_4_1 - 1) / var_4_1), var_4_0.count - self.countList[arg_4_1])

					self.countList[arg_4_1] = self.countList[arg_4_1] + var_8_0

					setText(arg_4_2:Find("calc/value"), self.countList[arg_4_1])

					self.count = self.count + var_4_1 * var_8_0

					setText(self.rtExchange:Find("bg/count"), setColorStr(self.count, "#FFEC6E") .. "/" .. self.need)
				end

				return
			end)
		end

		return
	end)
	setText(self._tf:Find("window/cancel_button/label"), i18n("word_cancel"))
	onButton(self, self._tf:Find("window/cancel_button"), function()
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("window/confirm_button"), function()
		if self.count <= 0 then
			return
		end

		local var_10_0 = {}

		if self.isSwitch and not self.blueprintVO:IsFate() then
			table.insert(var_10_0, function(arg_11_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("blueprint_lab_exchange_fate_unlock"),
					onYes = arg_11_0
				})

				return
			end)
		end

		seriesAsync(var_10_0, function()
			local var_12_0 = {}

			for iter_12_0, iter_12_1 in ipairs(self.displayList) do
				if self.countList[iter_12_0] > 0 then
					table.insert(var_12_0, {
						id = iter_12_1.id,
						count = self.countList[iter_12_0],
						arg = Item.getConfigData(iter_12_1.id).usage_arg[self.awardList[iter_12_0].index]
					})
				end
			end

			self:emit(ShipBluePrintMediator.QUICK_EXCHAGE_BLUEPRINT, var_12_0)
			self:Hide()

			return
		end)

		return
	end, SFX_CANCEL)

	self.rtResult = self._tf:Find("window/result")
	self.rtTarget = self.rtResult:Find("target")
	self.rtExchange = self.rtResult:Find("exchange")
	self.fate = self.rtResult:Find("fate")
	self.fateText = self.fate:Find("Text")

	setText(self.rtExchange:Find("bg/title"), i18n("blueprint_exchange_select_display"))

	self.toggleSwitch = self.rtResult:Find("switch")

	setText(self.toggleSwitch:Find("front/Text_off"), i18n("show_fate_demand_count"))
	setText(self.toggleSwitch:Find("front/Text_on"), i18n("show_design_demand_count"))
	onToggle(self, self.toggleSwitch, function(arg_13_0)
		self.isSwitch = arg_13_0

		self:UpdateResult()
		setActive(self.fate, self.isSwitch)

		return
	end)

	return
end

function BlueprintQuickExchangeView:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setActive(self._tf, true)

	return
end

function BlueprintQuickExchangeView:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	setActive(self._tf, false)

	return
end

function BlueprintQuickExchangeView:UpdateBlueprint(arg_16_1)
	self.blueprintVO = arg_16_1

	local var_16_0 = Drop.New({
		type = DROP_TYPE_ITEM,
		id = arg_16_1:getItemId()
	})

	changeToScrollText(self.rtResult:Find("title/Text"), var_16_0:getName())

	self.displayList = {}
	self.awardList = {}

	local var_16_1 = getProxy(BagProxy)

	for iter_16_0, iter_16_1 in ipairs(pg.gameset.general_blueprint_list.description) do
		local var_16_2 = var_16_1:getItemCountById(iter_16_1)

		if var_16_2 > 0 then
			local var_16_3

			for iter_16_2, iter_16_3 in ipairs(Drop.New({
				type = DROP_TYPE_ITEM,
				id = iter_16_1
			}):getConfig("display_icon")) do
				if iter_16_3[1] == DROP_TYPE_ITEM and iter_16_3[2] == var_16_0.id then
					var_16_3 = {
						index = iter_16_2,
						count = iter_16_3[3]
					}
				end
			end

			if var_16_3 then
				table.insert(self.displayList, {
					type = DROP_TYPE_ITEM,
					id = iter_16_1,
					count = var_16_2
				})
				table.insert(self.awardList, var_16_3)
			end
		end
	end

	setActive(self.rtEmpty, #self.displayList == 0)
	setActive(self.itemList.container, #self.displayList > 0)
	updateDrop(self.rtResult:Find("target/IconTpl"), var_16_0)
	GetImageSpriteFromAtlasAsync("ui/fragresolveui_atlas", "bg_" .. ItemRarity.Rarity2Print(var_16_0:getConfig("rarity")), self.rtResult:Find("target/bg"))

	self.countList = underscore.map(self.displayList, function(arg_17_0)
		return 0
	end)
	self.count = 0

	self.itemList:align(#self.displayList)
	triggerToggle(self.toggleSwitch, arg_16_1:canFateSimulation())
	setText(self.fateText, arg_16_1:IsFate() and i18n("blueprint_lab_fate_unlock") or i18n("blueprint_lab_fate_lock"))

	return
end

function BlueprintQuickExchangeView:UpdateResult()
	self.bagProxy = self.bagProxy or getProxy(BagProxy)
	self.need = math.max(self.blueprintVO:getUseageMaxItem() + (self.isSwitch and self.blueprintVO:getFateMaxLeftOver() or 0) - self.bagProxy:getItemCountById(self.blueprintVO:getItemId()), 0)

	local var_18_0 = #self.displayList

	while var_18_0 > 0 and self.count > self.need do
		if self.countList[var_18_0] > 0 then
			local var_18_1 = math.floor((self.count - self.need + self.awardList[var_18_0].count - 1) / self.awardList[var_18_0].count)

			if var_18_1 > self.countList[var_18_0] then
				self.count = self.count - self.awardList[var_18_0].count * self.countList[var_18_0]
				self.countList[var_18_0] = 0
			end

			local var_18_2

			do
				self.count = self.count - self.awardList[var_18_0].count * var_18_1
				self.countList[var_18_0] = self.countList[var_18_0] - var_18_1
				var_18_2 = self.itemList.container:GetChild(var_18_0 - 1)
			end

			setText(var_18_2:Find("calc/value"), self.countList[var_18_0])
		end

		var_18_0 = var_18_0 - 1
	end

	setText(self.rtExchange:Find("bg/count"), setColorStr(self.count, "#FFEC6E") .. "/" .. self.need)

	return
end

return BlueprintQuickExchangeView
