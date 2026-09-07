local IslandTicketGroupCard = class("IslandTicketGroupCard", import(".IslandTicketCard"))

function IslandTicketGroupCard:Ctor(arg_1_1)
	IslandTicketGroupCard.super.Ctor(self, arg_1_1)
	setActive(self.validTimeTF, false)
	setActive(self.expiredTF, false)

	self.selectedPanel = self._tf:Find("icon_bg/selected_panel")
	self.countInput = self.selectedPanel:Find("InputField")
	self.reduceBtn = self.selectedPanel:Find("reduce")
	self.emptyTF = self._tf:Find("empty")
	self.shopBtn = self.emptyTF:Find("Image")

	setText(self.shopBtn:Find("Text"), i18n("island_ticket_shop"))

	return
end

function IslandTicketGroupCard:Update(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.group = arg_2_1
	self.allCnt = arg_2_3

	setActive(self.emptyTF, self.allCnt == 0)

	self.tickets = arg_2_2

	local var_2_0 = underscore.reduce(self.tickets, 0, function(arg_3_0, arg_3_1)
		return arg_3_0 + (arg_3_1:WillExpire() and arg_3_1:GetCount() or 0)
	end)

	self.willExpireTxt.text = i18n("island_ticket_nearing_expiration", var_2_0)

	setActive(self.willExpireTF, var_2_0 > 0)

	self.showTicket = self.tickets[1] or IslandTicket.New(pg.island_speedup_ticket.get_id_list_by_speedup_time[arg_2_1][1], 0, 1)

	setText(self.nameTF, self.showTicket:getConfig("name"))
	GetImageSpriteFromAtlasAsync("island/islandframe", self.showTicket:GetFrameName(), self.frameTF, true)
	GetImageSpriteFromAtlasAsync("ui/islandticketui_atlas", self.showTicket:GetBgName(), self.bgTF, true)
	GetImageSpriteFromAtlasAsync(self.showTicket:GetIconName(), "", self.iconTF, true)
	self:UpdateSelCnt(arg_2_4)

	return
end

function IslandTicketGroupCard:UpdateSelCnt(arg_4_1)
	self.selCnt = arg_4_1

	setInputText(self.countInput, self.selCnt)
	setText(self.countTF, self.allCnt - self.selCnt)
	setActive(self.selectedPanel, self.selCnt > 0)

	return
end

return IslandTicketGroupCard
