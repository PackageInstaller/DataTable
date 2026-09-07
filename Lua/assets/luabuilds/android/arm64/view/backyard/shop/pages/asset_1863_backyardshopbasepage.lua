local BackYardShopBasePage = class("BackYardShopBasePage", import("....base.BaseSubView"))

function BackYardShopBasePage:PlayerUpdated(arg_1_1)
	self.player = arg_1_1

	self:OnPlayerUpdated()

	return
end

function BackYardShopBasePage:DormUpdated(arg_2_1)
	self.dorm = arg_2_1

	self:OnDormUpdated()

	return
end

function BackYardShopBasePage:FurnituresUpdated(arg_3_1)
	local var_3_0 = self.dorm:GetPurchasedFurnitures()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		self:OnDisplayUpdated(var_3_0[iter_3_1])
		self:OnCardUpdated(var_3_0[iter_3_1])
	end

	return
end

function BackYardShopBasePage:SetUp(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self:Show()

	self.pageType = arg_4_1
	self.dorm = arg_4_2
	self.player = arg_4_3

	self:OnSetUp()

	if arg_4_4 then
		arg_4_4()
	end

	return
end

function BackYardShopBasePage:Show()
	setActiveViaLayer(self._tf, true)

	return
end

function BackYardShopBasePage:Hide()
	setActiveViaLayer(self._tf, false)

	return
end

function BackYardShopBasePage:ShowFurnitureMsgBox(arg_7_1)
	self.contextData.furnitureMsgBox:ExecuteAction("SetUp", arg_7_1, self.dorm, self.player)

	return
end

function BackYardShopBasePage:ShowThemeVOMsgBox(arg_8_1)
	self.contextData.themeMsgBox:ExecuteAction("SetUp", arg_8_1, self.dorm, self.player)

	return
end

function BackYardShopBasePage:OnSetUp()
	return
end

function BackYardShopBasePage:OnPlayerUpdated()
	return
end

function BackYardShopBasePage:OnDisplayUpdated(arg_11_1)
	return
end

function BackYardShopBasePage:OnCardUpdated(arg_12_1)
	return
end

function BackYardShopBasePage:OnDormUpdated()
	return
end

return BackYardShopBasePage
