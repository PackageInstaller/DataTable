local IslandMsgBoxSingleMaterialWindow = class("IslandMsgBoxSingleMaterialWindow", import(".IslandMsgBoxSingleItemWindow"))

function IslandMsgBoxSingleMaterialWindow:getUIName()
	return "IslandCommonMsgBoxWithSingleMaterial"
end

function IslandMsgBoxSingleMaterialWindow:OnLoaded()
	IslandMsgBoxSingleMaterialWindow.super.super.OnLoaded(self)

	self.itemTr = self._tf:Find("IslandItemTpl")
	self.nameTxt = self._tf:Find("name"):GetComponent(typeof(Text))
	self.ownTxt = self._tf:Find("own"):GetComponent(typeof(Text))
	self.uiItemList = UIItemList.New(self._tf:Find("list"), self._tf:Find("list/tpl"))

	setText(self._tf:Find("label/Text"), i18n("island_get_way"))

	self.valueInput = self._tf:Find("calc/value/InputField")
	self.addBtn = self._tf:Find("calc/add")
	self.reduceBtn = self._tf:Find("calc/reduce")
	self.sellBtn = self._tf:Find("calc/sell_btn")
	self.priceTxt = self._tf:Find("calc/sell_btn/price/Text"):GetComponent(typeof(Text))

	LoadImageSpriteAsync("island/" .. getIslandSeasonPtInfo().icon, self._tf:Find("calc/sell_btn/price/res"))
	setText(self._tf:Find("calc/sell_btn/Text"), i18n("island_word_convert"))

	return
end

function IslandMsgBoxSingleMaterialWindow:OnShow()
	IslandMsgBoxSingleMaterialWindow.super.OnShow(self)
	setActive(self._tf:Find("label"), false)
	onButton(self, self.addBtn, function()
		self:UpdateValue(self.value + 1)

		return
	end, SFX_PANEL)
	onButton(self, self.reduceBtn, function()
		self:UpdateValue(self.value - 1)

		return
	end, SFX_PANEL)
	onButton(self, self.sellBtn, function()
		self:Hide()

		if _IslandCore then
			_IslandCore:GetView():NotifiyIsland(ISLAND_EX_EVT.SHOW_MSG, {
				content = i18n("island_season_window_transformtip"),
				onYes = function()
					self:emit(IslandMediator.ON_CONVERT_SEASON_PT, {
						{
							id = self.item.id,
							num = self.value
						}
					})

					return
				end
			})
		end

		return
	end, SFX_PANEL)
	onInputEndEdit(self, self.valueInput, function(arg_8_0)
		if not arg_8_0 or arg_8_0 == "" or not tonumber(arg_8_0) then
			-- block empty
		end

		self:UpdateValue((tonumber(arg_8_0)))

		return
	end)
	self:bind(GAME.ISLAND_CONVERT_SEASON_PT_DONE, function()
		self:FlushCalc(self.item.id)

		return
	end)
	self:FlushCalc(self.settings.itemId)

	return
end

function IslandMsgBoxSingleMaterialWindow:FlushCalc(arg_10_1)
	local var_10_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetItemById(arg_10_1)

	var_10_0 = var_10_0 or IslandItem.New({
		id = arg_10_1
	})
	self.item = var_10_0
	self.value = 1

	self:UpdateValue(self.value)

	return
end

function IslandMsgBoxSingleMaterialWindow:UpdateValue(arg_11_1)
	self.value = math.max(1, math.min(arg_11_1, self.item:GetCount()))
	self.priceTxt.text = "x" .. self.item:GetConvertPt() * self.value

	setInputText(self.valueInput, self.value)

	return
end

return IslandMsgBoxSingleMaterialWindow
