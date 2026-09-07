local IslandShopBuySuccessLayer = class("IslandShopBuySuccessLayer", import("...base.IslandBasePage"))

function IslandShopBuySuccessLayer:getUIName()
	return "IslandShopBuySuccessUI"
end

function IslandShopBuySuccessLayer:OnLoaded()
	self.awardList = UIItemList.New(self._tf:Find("awards"), self._tf:Find("awards/item"))

	setText(self._tf:Find("tip/text"), i18n("island_3Dshop_close"))

	return
end

function IslandShopBuySuccessLayer:OnInit()
	onButton(self, self._tf:Find("award_window"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("tip"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandShopBuySuccessLayer:SetUp(arg_6_1)
	self.awardList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = arg_6_1[arg_7_1 + 1]

			updateCustomDrop(arg_7_2:Find("IslandItemTpl"), arg_6_1[arg_7_1 + 1], {
				style = "island"
			})
			setActive(arg_7_2:Find("split"), var_7_0.type == VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT)
		end

		return
	end)
	self.awardList:align(#arg_6_1)

	return
end

function IslandShopBuySuccessLayer:OnShow(arg_8_1, arg_8_2)
	self:BlurPanel(self._tf)

	local var_8_0 = table.mergeArray(arg_8_1.awards or {}, arg_8_1.drops or {})

	table.sort(var_8_0, CompareFuncs({
		function(arg_9_0)
			return arg_9_0.type == VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT and 0 or 1
		end
	}))
	self:SetUp(var_8_0)

	self.callback = arg_8_2
	self.active = true

	return
end

function IslandShopBuySuccessLayer:OnHide()
	self:UnOverlayPanel(self._tf, self._parentTf)

	if self.active then
		self.active = false

		if self.callback then
			self.callback()
		end
	end

	return
end

function IslandShopBuySuccessLayer:OnDestroy()
	return
end

return IslandShopBuySuccessLayer
