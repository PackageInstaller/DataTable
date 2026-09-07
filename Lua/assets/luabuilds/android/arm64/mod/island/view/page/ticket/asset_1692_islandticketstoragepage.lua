local IslandTicketStoragePage = class("IslandTicketStoragePage", import("...base.IslandBasePage"))

IslandTicketStoragePage.SORT_TYPES = {
	SPEED_UP = 2,
	VALID = 1
}

function IslandTicketStoragePage:getUIName()
	return "IslandTicketStorageUI"
end

function IslandTicketStoragePage:OnLoaded()
	setText(self._tf:Find("frame/title"), i18n("island_ticket_storage_title"))

	self.ascToggleTF = self._tf:Find("toggle_asc")
	self.sortToggleTF = self._tf:Find("toggle_sort")
	self.sortPanelAnim = self._tf:Find("sort_panel"):GetComponent(typeof(Animation))
	self.sortByValidBtn = self._tf:Find("sort_panel/valid")

	setText(self.sortByValidBtn:Find("Text"), i18n("island_ticket_sort_valid"))

	self.sortBySpeedupBtn = self._tf:Find("sort_panel/speedup")

	setText(self.sortBySpeedupBtn:Find("Text"), i18n("island_ticket_sort_speedup"))

	self.confirmBtn = self._tf:Find("confirm")

	setText(self.confirmBtn:Find("Text"), i18n("word_ok"))

	self.scrollRect = self._tf:Find("scrollrect"):GetComponent("LScrollRect")

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

function IslandTicketStoragePage:OnInit()
	onButton(self, self._tf:Find("frame/title/help"), function()
		self:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_helpbtn_speedup")
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("frame/close"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("mask"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onToggle(self, self.ascToggleTF, function(arg_10_0)
		self.isAsc = arg_10_0

		self:SetTotalCount()

		return
	end, SFX_PANEL)
	onToggle(self, self.sortToggleTF, function(arg_11_0)
		self.sortPanelAnim:Play(arg_11_0 and "anim_IslandTicketStorageUI_sort_in" or "anim_IslandTicketStorageUI_sort_out")

		return
	end, SFX_PANEL)
	onButton(self, self.sortByValidBtn, function()
		self.sortType = IslandTicketStoragePage.SORT_TYPES.VALID

		setText(self.sortToggleTF:Find("Text"), i18n("island_ticket_sort_valid"))
		triggerToggle(self.sortToggleTF, false)
		self:SetTotalCount()

		return
	end, SFX_PANEL)
	onButton(self, self.sortBySpeedupBtn, function()
		self.sortType = IslandTicketStoragePage.SORT_TYPES.SPEED_UP

		setText(self.sortToggleTF:Find("Text"), i18n("island_ticket_sort_speedup"))
		triggerToggle(self.sortToggleTF, false)
		self:SetTotalCount()

		return
	end, SFX_PANEL)

	self.cards = {}

	return
end

function IslandTicketStoragePage:OnInitItem(arg_14_1)
	self.cards[arg_14_1] = IslandTicketCard.New(arg_14_1)

	return
end

function IslandTicketStoragePage:OnUpdateItem(arg_15_1, arg_15_2)
	if not self.cards[arg_15_2] then
		self:OnInitItem(arg_15_2)
	end

	self.cards[arg_15_2]:Update(self.displays[arg_15_1 + 1])

	return
end

function IslandTicketStoragePage:OnShow()
	self:BlurPanel()

	self.ticketAgency = getProxy(IslandProxy):GetIsland():GetTicketAgency()
	self.displays = self.ticketAgency:GetAllTicketList()
	self.isAsc = true
	self.sortType = IslandTicketStoragePage.SORT_TYPES.SPEED_UP

	triggerButton(self.sortBySpeedupBtn)

	return
end

function IslandTicketStoragePage:SetTotalCount()
	if self.sortType == IslandTicketStoragePage.SORT_TYPES.VALID then
		self:SortByValid()
	elseif self.sortType == IslandTicketStoragePage.SORT_TYPES.SPEED_UP then
		self:SortBySpeedup()
	end

	self.scrollRect:SetTotalCount(#self.displays, -1)

	return
end

function IslandTicketStoragePage:SortBySpeedup()
	local var_18_0 = self.isAsc and 1 or -1

	table.sort(self.displays, CompareFuncs({
		function(arg_19_0)
			return var_18_0 * arg_19_0:GetTime()
		end,
		function(arg_20_0)
			return var_18_0 * (arg_20_0:IsForever() and 1 or 0)
		end,
		function(arg_21_0)
			return var_18_0 * arg_21_0:GetEndTime()
		end,
		function(arg_22_0)
			return var_18_0 * arg_22_0.id
		end
	}))

	return
end

function IslandTicketStoragePage:SortByValid()
	local var_23_0 = self.isAsc and 1 or -1

	table.sort(self.displays, CompareFuncs({
		function(arg_24_0)
			return var_23_0 * (arg_24_0:IsForever() and 1 or 0)
		end,
		function(arg_25_0)
			return var_23_0 * arg_25_0:GetEndTime()
		end,
		function(arg_26_0)
			return var_23_0 * arg_26_0:GetTime()
		end,
		function(arg_27_0)
			return var_23_0 * arg_27_0.id
		end
	}))

	return
end

function IslandTicketStoragePage:OnHide()
	self:UnBlurPanel()

	return
end

function IslandTicketStoragePage:OnDestroy()
	self:OnHide()
	ClearLScrollrect(self.scrollRect)

	for iter_29_0, iter_29_1 in pairs(self.cards) do
		iter_29_1:Dispose()
	end

	self.cards = {}

	return
end

return IslandTicketStoragePage
