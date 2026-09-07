local IslandTicketExpiredMsgBoxWindow = class("IslandTicketExpiredMsgBoxWindow", import(".IslandCommonMsgboxWindow"))

IslandTicketExpiredMsgBoxWindow.TYPES = {
	EXPIRED = 1,
	REMIND = 2
}

function IslandTicketExpiredMsgBoxWindow:getUIName()
	return "IslandCommonMsgBoxForTicketExpired"
end

function IslandTicketExpiredMsgBoxWindow:OnLoaded()
	IslandTicketExpiredMsgBoxWindow.super.OnLoaded(self)

	self.contentText = self._tf:Find("Text")
	self.scrollRect = self._tf:Find("scrollrect"):GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	self.cards = {}

	return
end

function IslandTicketExpiredMsgBoxWindow:OnShow()
	IslandTicketExpiredMsgBoxWindow.super.OnShow(self)
	self:FlushInfo()

	return
end

function IslandTicketExpiredMsgBoxWindow:FlushBtn(arg_6_1)
	setActive(self.cancelBtn, false)
	setActive(self.confirmBtn, true)

	self.confirmTxt.text = i18n("word_ok")

	return
end

function IslandTicketExpiredMsgBoxWindow:OnInitItem(arg_7_1)
	self.cards[arg_7_1] = IslandTicketCard.New(arg_7_1)

	return
end

function IslandTicketExpiredMsgBoxWindow:OnUpdateItem(arg_8_1, arg_8_2)
	if not self.cards[arg_8_2] then
		self:OnInitItem(arg_8_2)
	end

	self.cards[arg_8_2]:Update(self.displays[arg_8_1 + 1])

	return
end

function IslandTicketExpiredMsgBoxWindow:FlushInfo()
	local var_9_0 = self.settings.body

	if self.settings.body.type == IslandTicketExpiredMsgBoxWindow.TYPES.EXPIRED then
		setText(self.contentText, i18n("island_ticket_expiration_tip2"))
	elseif var_9_0.type == IslandTicketExpiredMsgBoxWindow.TYPES.REMIND then
		setText(self.contentText, i18n("island_ticket_expiration_tip1"))
	end

	self.displays = var_9_0.tickets

	self.scrollRect:SetTotalCount(#self.displays, -1)

	return
end

function IslandTicketExpiredMsgBoxWindow:OnDestroy()
	ClearLScrollrect(self.scrollRect)

	if self.cards then
		for iter_10_0, iter_10_1 in pairs(self.cards) do
			iter_10_1:Dispose()
		end

		self.cards = nil
	end

	return
end

return IslandTicketExpiredMsgBoxWindow
