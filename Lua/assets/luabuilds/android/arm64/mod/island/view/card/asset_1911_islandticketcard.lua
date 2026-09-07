local IslandTicketCard = class("IslandTicketCard")

function IslandTicketCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.bgTF = self._tf:Find("bg")
	self.frameTF = self._tf:Find("icon_bg")
	self.iconTF = self._tf:Find("icon_bg/icon")
	self.nameTF = self._tf:Find("name")
	self.countTF = self._tf:Find("icon_bg/count/Text")
	self.timePanel = self._tf:Find("time_panel")
	self.validTimeTF = self.timePanel:Find("valid")
	self.validTimeTxt = self.validTimeTF:Find("Text"):GetComponent(typeof(Text))
	self.expiredTF = self.timePanel:Find("expired")

	setText(self.expiredTF:Find("Text"), i18n("island_ticket_expired"))

	self.willExpireTF = self.timePanel:Find("will_expire")
	self.willExpireTxt = self.willExpireTF:Find("Text"):GetComponent(typeof(Text))

	return
end

function IslandTicketCard:Update(arg_2_1)
	self.ticket = arg_2_1

	setText(self.nameTF, self.ticket:getConfig("name"))
	setText(self.countTF, self.ticket:GetCount())
	GetImageSpriteFromAtlasAsync("island/islandframe", self.ticket:GetFrameName(), self.frameTF, true)
	GetImageSpriteFromAtlasAsync("ui/islandticketui_atlas", self.ticket:GetBgName(), self.bgTF, true)
	GetImageSpriteFromAtlasAsync(self.ticket:GetIconName(), "", self.iconTF, true)

	local var_2_0 = self.ticket:IsForever()

	setActive(self.timePanel, not var_2_0)
	self:UpdateTimer()
	self:StopTimer()

	if not var_2_0 then
		self:StartTimer()
	end

	return
end

function IslandTicketCard:StartTimer()
	self.timer = Timer.New(function()
		self:UpdateTimer()

		return
	end, 1, -1)

	self.timer:Start()

	return
end

function IslandTicketCard:UpdateTimer()
	local var_5_0 = self.ticket:IsExpired()

	setActive(self.expiredTF, var_5_0)
	setActive(self.validTimeTF, not var_5_0)

	if not var_5_0 then
		local var_5_1 = self.ticket:GetRemainTime()
		local var_5_2 = math.floor(var_5_1 / 0)

		self.validTimeTxt.text = var_5_2 >= 1 and i18n("island_ticket_expired_day", var_5_2) or pg.TimeMgr.GetInstance():DescCDTime(var_5_1)
	end

	return
end

function IslandTicketCard:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandTicketCard:Dispose()
	self:StopTimer()

	return
end

return IslandTicketCard
