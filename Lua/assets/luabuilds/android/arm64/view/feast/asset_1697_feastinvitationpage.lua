local FeastInvitationPage = class("FeastInvitationPage", import("view.base.BaseSubView"))

function FeastInvitationPage:getUIName()
	return "FeastInvitationUI"
end

function FeastInvitationPage:OnLoaded()
	self.backBtn = self._tf:Find("return")
	self.scrollrect = self._tf:Find("left/scrollrect")
	self.uilist = UIItemList.New(self._tf:Find("left/scrollrect/conent"), self._tf:Find("left/scrollrect/conent/tpl"))
	self.resTicketTr = self._tf:Find("res/ticket")
	self.resGiftTr = self._tf:Find("res/gift")
	self.resTicket = self._tf:Find("res/ticket/Text"):GetComponent(typeof(Text))
	self.resGift = self._tf:Find("res/gift/Text"):GetComponent(typeof(Text))
	self.ticketTr = self._tf:Find("main/ticket")
	self.ticketMarkTr = self._tf:Find("main/ticket/finish")
	self.giftTr = self._tf:Find("main/gift")
	self.giftImg = self.giftTr:Find("icon"):GetComponent(typeof(Image))
	self.giftMarkTr = self._tf:Find("main/gift/finish")
	self.ticketTxt = self.ticketTr:Find("make/Text"):GetComponent(typeof(Text))

	setText(self.giftTr:Find("make/Text"), i18n("feast_label_give_gift"))
	setText(self.ticketTr:Find("finish/frame/label"), i18n("feast_label_give_invitation_finish"))
	setText(self.giftTr:Find("finish/frame/label"), i18n("feast_label_give_gift_finish"))

	self.painting = self._tf:Find("main/painting"):GetComponent(typeof(Image))
	self.puzzlePage = FeastMakeTicketPage.New(self._tf, self.event)
	self.giveTicketPage = FeastGiveTicketPage.New(self._tf, self.event)
	self.giveGiftPage = FeastGiveGiftPage.New(self._tf, self.event)
	self.resWindow = FeastResWindow.New(self._tf, self.event)
	self.homeBtn = self._tf:Find("home")

	return
end

function FeastInvitationPage:OnInit()
	self:bind(FeastScene.ON_SKIP_GIVE_GIFT, function(arg_4_0, arg_4_1)
		self.giveTicketPage:ExecuteAction("Show", arg_4_1)

		return
	end)
	self:bind(FeastScene.ON_MAKE_TICKET, function(arg_5_0)
		self:OnFlush()
		self:UpdateRes()

		return
	end)
	self:bind(FeastScene.ON_GOT_TICKET, function(arg_6_0)
		self:OnFlush()

		return
	end)
	self:bind(FeastScene.ON_GOT_GIFT, function(arg_7_0)
		self:OnFlush()
		self:UpdateRes()

		return
	end)
	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.homeBtn, function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)

	return
end

function FeastInvitationPage:OnFlush()
	if self.feastShip then
		self:UpdateMain(self.feastShip)
	end

	self:UpdateFeastShips((getProxy(FeastProxy):getRawData():GetInvitedFeastShipList()))

	return
end

function FeastInvitationPage:Show()
	FeastInvitationPage.super.Show(self)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)
	self:UpdateFeastShips((getProxy(FeastProxy):getRawData():GetInvitedFeastShipList()))
	self:UpdateRes()
	triggerToggle(self.toggles[1], true)
	scrollTo(self.scrollrect, 0, 1)

	return
end

function FeastInvitationPage:UpdateRes()
	local var_12_0, var_12_1 = getProxy(FeastProxy):GetConsumeList()
	local var_12_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

	self.ticketCnt = var_12_2:getVitemNumber(var_12_0)
	self.giftCnt = var_12_2:getVitemNumber(var_12_1)
	self.resTicket.text = self.ticketCnt
	self.resGift.text = self.giftCnt

	onButton(self, self.resTicketTr, function()
		self.resWindow:ExecuteAction("Show", var_12_0)

		return
	end, SFX_PANEL)
	onButton(self, self.resGiftTr, function()
		self.resWindow:ExecuteAction("Show", var_12_1)

		return
	end, SFX_PANEL)

	return
end

function FeastInvitationPage:UpdateFeastShips(arg_15_1)
	self.toggles = {}

	self.uilist:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_0 = arg_15_1[arg_16_1 + 1]

			LoadSpriteAsync("FeastIcon/" .. arg_15_1[arg_16_1 + 1]:GetPrefab(), function(arg_17_0)
				local var_17_0 = arg_16_2:Find("icon"):GetComponent(typeof(Image))

				var_17_0.sprite = arg_17_0

				var_17_0:SetNativeSize()

				return
			end)
			setActive(arg_16_2:Find("finish"), arg_15_1[arg_16_1 + 1]:GotGift() and arg_15_1[arg_16_1 + 1]:GotTicket())
			onToggle(self, arg_16_2, function(arg_18_0)
				if arg_18_0 then
					self:UpdateMain(var_16_0)
				end

				return
			end, SFX_PANEL)
			table.insert(self.toggles, arg_16_2)
		end

		return
	end)
	self.uilist:align(#arg_15_1)

	return
end

local var_0_1 = {
	[0] = i18n("feast_label_make_invitation"),
	(i18n("feast_label_give_invitation"))
}

function FeastInvitationPage:UpdateMain(arg_19_1)
	setActive(self.ticketMarkTr, arg_19_1:GotTicket())
	setActive(self.giftMarkTr, arg_19_1:GotGift())

	self.ticketTxt.text = var_0_1[arg_19_1:GetInvitationState()]

	local var_19_0 = arg_19_1:GetPrefab()

	LoadSpriteAsync("FeastPainting/" .. var_19_0, function(arg_20_0)
		self.painting.sprite = arg_20_0

		self.painting:SetNativeSize()

		return
	end)
	LoadSpriteAsync("FeastCharGift/" .. var_19_0, function(arg_21_0)
		self.giftImg.sprite = arg_21_0

		self.giftImg:SetNativeSize()

		return
	end)
	onButton(self, self.ticketTr, function()
		if arg_19_1:HasTicket() then
			self.giveTicketPage:ExecuteAction("Show", arg_19_1)
		elseif not arg_19_1:GotTicket() then
			if self.ticketCnt <= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("feast_no_invitation"))

				return
			end

			self.puzzlePage:ExecuteAction("Show", arg_19_1)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.giftTr, function()
		if not arg_19_1:GotTicket() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("feast_cant_give_gift_tip"))

			return
		end

		if self.giftCnt <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("feast_no_gift"))

			return
		end

		if not arg_19_1:GotGift() then
			self.giveGiftPage:ExecuteAction("Show", arg_19_1)
		end

		return
	end, SFX_PANEL)

	self.feastShip = arg_19_1

	return
end

function FeastInvitationPage:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	if self.puzzlePage and self.puzzlePage:GetLoaded() and self.puzzlePage:isShowing() then
		self.puzzlePage:Hide()
	end

	if self.giveTicketPage and self.giveTicketPage:GetLoaded() and self.giveTicketPage:isShowing() then
		self.giveTicketPage:Hide()
	end

	if self.giveGiftPage and self.giveGiftPage:GetLoaded() and self.giveGiftPage:isShowing() then
		self.giveGiftPage:Hide()
	end

	if self.resWindow and self.resWindow:GetLoaded() and self.resWindow:isShowing() then
		self.resWindow:Hide()
	end

	FeastInvitationPage.super.Hide(self)

	self.feastShip = nil

	return
end

function FeastInvitationPage:onBackPressed()
	if self.puzzlePage and self.puzzlePage:GetLoaded() and self.puzzlePage:isShowing() then
		self.puzzlePage:Hide()

		return
	end

	if self.giveTicketPage and self.giveTicketPage:GetLoaded() and self.giveTicketPage:isShowing() then
		if not self.giveTicketPage:CanInterAction() then
			return
		end

		self.giveTicketPage:Hide()

		return
	end

	if self.giveGiftPage and self.giveGiftPage:GetLoaded() and self.giveGiftPage:isShowing() then
		if not self.giveGiftPage:CanInterAction() then
			return
		end

		self.giveGiftPage:Hide()

		return
	end

	if self.resWindow and self.resWindow:GetLoaded() and self.resWindow:isShowing() then
		self.resWindow:Hide()

		return
	end

	if self:isShowing() then
		self:Hide()
	end

	return
end

function FeastInvitationPage:OnDestroy()
	if self.puzzlePage then
		self.puzzlePage:Destroy()

		self.puzzlePage = nil
	end

	if self.giveTicketPage then
		self.giveTicketPage:Destroy()

		self.giveTicketPage = nil
	end

	if self.giveGiftPage then
		self.giveGiftPage:Destroy()

		self.giveGiftPage = nil
	end

	if self.resWindow then
		self.resWindow:Destroy()

		self.resWindow = nil
	end

	if self:isShowing() then
		self:Hide()
	end

	return
end

return FeastInvitationPage
