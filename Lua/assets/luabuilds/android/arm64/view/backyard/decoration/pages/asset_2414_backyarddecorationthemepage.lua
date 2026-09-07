local BackYardDecorationThemePage = class("BackYardDecorationThemePage", import(".BackYardDecorationBasePage"))

function BackYardDecorationThemePage:getUIName()
	return "BackYardDecorationThemePage"
end

function BackYardDecorationThemePage:OnLoaded()
	BackYardDecorationThemePage.super.OnLoaded(self)

	self.msgbox = BackYardDecorationMsgBox.New(self._parentTf.parent.parent.parent.parent.parent, self.event, self.contextData)
	self.refreshList = {}

	return
end

function BackYardDecorationThemePage:OnDisplayList()
	self:InitList()

	return
end

function BackYardDecorationThemePage:InitList()
	self.displays = {}

	local var_4_0 = self.dorm:GetPurchasedFurnitures()

	for iter_4_0, iter_4_1 in ipairs((getProxy(DormProxy):GetSystemThemes())) do
		if iter_4_1:IsPurchased(var_4_0) then
			table.insert(self.displays, iter_4_1)
		end
	end

	local var_4_1 = 0

	if self.customTheme then
		for iter_4_2, iter_4_3 in pairs(self.customTheme) do
			var_4_1 = var_4_1 + 1

			table.insert(self.displays, iter_4_3)
		end
	end

	if var_4_1 < BackYardConst.MAX_USER_THEME then
		table.insert(self.displays, {
			id = "",
			isEmpty = true
		})
	end

	self:SortDisplays()

	return
end

local function var_0_1(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.isEmpty and 1 or 0
	local var_5_1 = arg_5_1.isEmpty and 1 or 0

	if (arg_5_0.isEmpty and 1 or 0) == (arg_5_1.isEmpty and 1 or 0) then
		local var_5_2 = arg_5_0:IsSystem() and 1 or 0
		local var_5_3 = arg_5_1:IsSystem() and 1 or 0

		if var_5_2 == var_5_3 then
			if arg_5_0.order == arg_5_1.order then
				return arg_5_0.id > arg_5_1.id
			else
				return arg_5_0.order > arg_5_1.order
			end
		else
			return var_5_2 < var_5_3
		end
	else
		return var_5_1 < var_5_0
	end

	return
end

local function var_0_2(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.isEmpty and 1 or 0
	local var_6_1 = arg_6_1.isEmpty and 1 or 0

	if (arg_6_0.isEmpty and 1 or 0) == (arg_6_1.isEmpty and 1 or 0) then
		local var_6_2 = arg_6_0:IsSystem() and 1 or 0
		local var_6_3 = arg_6_1:IsSystem() and 1 or 0

		if var_6_2 == var_6_3 then
			if arg_6_0.order == arg_6_1.order then
				return arg_6_0.id < arg_6_1.id
			else
				return arg_6_0.order < arg_6_1.order
			end
		else
			return var_6_3 < var_6_2
		end
	else
		return var_6_1 < var_6_0
	end

	return
end

function BackYardDecorationThemePage:SortDisplays()
	table.sort(self.displays, function(arg_8_0, arg_8_1)
		if self.orderMode == BackYardDecorationFilterPanel.ORDER_MODE_ASC then
			return var_0_2(arg_8_0, arg_8_1)
		else
			return var_0_1(arg_8_0, arg_8_1)
		end

		return
	end)
	self:SetTotalCount()

	return
end

function BackYardDecorationThemePage:OnOrderModeUpdated()
	self:SortDisplays()

	return
end

function BackYardDecorationThemePage:OnInitItem(arg_10_1)
	local var_10_0 = BackYardDecorationThemeCard.New(arg_10_1)

	onButton(self, var_10_0._tf, function()
		if var_10_0:HasMask() then
			return
		end

		self.msgbox:ExecuteAction("Show", var_10_0.themeVO, true)

		return
	end)
	onButton(self, var_10_0.add, function()
		self.msgbox:ExecuteAction("Show", {
			id = getProxy(DormProxy):GetTemplateNewID()
		}, false)

		return
	end)

	self.cards[arg_10_1] = var_10_0

	return
end

function BackYardDecorationThemePage:OnUpdateItem(arg_13_1, arg_13_2)
	if not self.cards[arg_13_2] then
		self:OnInitItem(arg_13_2)
	end

	self.cards[arg_13_2]:Update(self.lastDiaplys[arg_13_1 + 1], false)

	return
end

function BackYardDecorationThemePage:OnThemeUpdated()
	self.currHouse = nil

	self:InitList()

	return
end

function BackYardDecorationThemePage:OnApplyThemeBefore()
	self.currHouse = nil

	for iter_15_0, iter_15_1 in pairs(self.cards) do
		iter_15_1:Update(iter_15_1.themeVO, false)
	end

	self.temps = {}

	return
end

function BackYardDecorationThemePage:OnApplyThemeAfter(arg_16_1)
	for iter_16_0, iter_16_1 in pairs(self.cards) do
		if iter_16_1.themeVO.id == arg_16_1 then
			iter_16_1:Update(iter_16_1.themeVO, false)
		end
	end

	return
end

function BackYardDecorationThemePage:SetTotalCount()
	if not self.searchKey or self.searchKey == "" then
		self.lastDiaplys = self.displays
	else
		self.lastDiaplys = {}

		for iter_17_0, iter_17_1 in ipairs(self.displays) do
			if iter_17_1.id == "" or iter_17_1:MatchSearchKey(self.searchKey) then
				table.insert(self.lastDiaplys, iter_17_1)
			end
		end
	end

	self.scrollRect.enabled = true

	self.scrollRect:SetTotalCount(#self.lastDiaplys)

	return
end

function BackYardDecorationThemePage:OnSearchKeyChanged()
	self:SetTotalCount()

	return
end

function BackYardDecorationThemePage:OnDestroy()
	self.msgbox:Destroy()

	for iter_19_0, iter_19_1 in pairs(self.cards or {}) do
		iter_19_1:Dispose()
	end

	self.cards = nil

	return
end

function BackYardDecorationThemePage:OnBackPressed()
	if self:GetLoaded() and self.msgbox:GetLoaded() and self.msgbox:isShowing() then
		self.msgbox:Hide()

		return true
	end

	return false
end

return BackYardDecorationThemePage
