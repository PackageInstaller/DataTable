local BackYardDecorationBasePage = class("BackYardDecorationBasePage", import("....base.BaseSubView"))

function BackYardDecorationBasePage:OnLoaded()
	self.scrollRect = self._tf:GetComponent("LScrollRect")

	return
end

function BackYardDecorationBasePage:OnInit()
	self.cards = {}

	function self.scrollRect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function BackYardDecorationBasePage:SetUp(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:Show()

	self.pageType = arg_5_1
	self.dorm = arg_5_2
	self.customTheme = arg_5_3
	self.orderMode = arg_5_4

	self:OnDisplayList()
	self:UpdateFliterData()

	return
end

function BackYardDecorationBasePage:Show()
	setActiveViaLayer(self._tf, true)

	return
end

function BackYardDecorationBasePage:Hide()
	setActiveViaLayer(self._tf, false)

	return
end

function BackYardDecorationBasePage:DormUpdated(arg_8_1)
	self.dorm = arg_8_1

	self:UpdateFliterData()
	self:OnDormUpdated()

	return
end

function BackYardDecorationBasePage:FurnitureUpdated(arg_9_1)
	self:OnFurnitureUpdated(arg_9_1)

	return
end

function BackYardDecorationBasePage:CustomThemeAdded(arg_10_1)
	self.customTheme[arg_10_1.id] = arg_10_1

	self:CustomThemeUpdated(self.customTheme)

	return
end

function BackYardDecorationBasePage:CustomThemeDeleted(arg_11_1)
	for iter_11_0, iter_11_1 in pairs(self.customTheme) do
		if iter_11_1.id == arg_11_1 then
			self.customTheme[iter_11_0] = nil

			break
		end
	end

	self:CustomThemeUpdated(self.customTheme)

	return
end

function BackYardDecorationBasePage:ThemeUpdated()
	self:OnThemeUpdated()

	return
end

function BackYardDecorationBasePage:CustomThemeUpdated(arg_13_1)
	self.customTheme = arg_13_1

	self:ThemeUpdated()

	return
end

function BackYardDecorationBasePage:OrderModeUpdated(arg_14_1)
	self.orderMode = arg_14_1

	self:UpdateFliterData()

	if self.contextData.filterPanel:GetLoaded() then
		self.contextData.filterPanel:Sort()
		self:OnFilterDone((self.contextData.filterPanel:GetFilterData()))
	else
		self:OnOrderModeUpdated()
	end

	return
end

function BackYardDecorationBasePage:UpdateFliterData()
	self.contextData.filterPanel:SetDorm(self.dorm)
	self.contextData.filterPanel:updateOrderMode(self.orderMode)

	return
end

function BackYardDecorationBasePage:ShowFilterPanel(arg_16_1)
	self.contextData.filterPanel:setFilterData(self:GetDisplays())

	function self.contextData.filterPanel.confirmFunc()
		if arg_16_1 then
			arg_16_1(self.contextData.filterPanel.sortTxt)
		end

		self:OnFilterDone((self.contextData.filterPanel:GetFilterData()))

		return
	end

	self.contextData.filterPanel:ExecuteAction("Show")

	return
end

function BackYardDecorationBasePage:SearchKeyUpdated(arg_18_1)
	self.searchKey = arg_18_1

	self:OnSearchKeyChanged()

	return
end

function BackYardDecorationBasePage:OnInitItem(arg_19_1)
	return
end

function BackYardDecorationBasePage:OnUpdateItem(arg_20_1, arg_20_2)
	return
end

function BackYardDecorationBasePage:OnDisplayList()
	return
end

function BackYardDecorationBasePage:OnDormUpdated()
	return
end

function BackYardDecorationBasePage:OnFurnitureUpdated(arg_23_1)
	return
end

function BackYardDecorationBasePage:OnThemeUpdated()
	return
end

function BackYardDecorationBasePage:OnOrderModeUpdated()
	return
end

function BackYardDecorationBasePage:OnFilterDone(arg_26_1)
	return
end

function BackYardDecorationBasePage:GetDisplays()
	return {}
end

function BackYardDecorationBasePage:OnSearchKeyChanged()
	return
end

function BackYardDecorationBasePage:OnBackPressed()
	return false
end

function BackYardDecorationBasePage:OnApplyThemeBefore()
	return
end

function BackYardDecorationBasePage:OnApplyThemeAfter(arg_31_1)
	return
end

return BackYardDecorationBasePage
