local var_0_0 = class("FeastInvitationPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "FeastInvitationUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("return")
	arg_2_0.scrollrect = arg_2_0._tf:Find("left/scrollrect")
	arg_2_0.uilist = UIItemList.New(arg_2_0._tf:Find("left/scrollrect/conent"), arg_2_0._tf:Find("left/scrollrect/conent/tpl"))
	arg_2_0.resTicketTr = arg_2_0._tf:Find("res/ticket")
	arg_2_0.resGiftTr = arg_2_0._tf:Find("res/gift")
	arg_2_0.resTicket = arg_2_0._tf:Find("res/ticket/Text"):GetComponent(typeof(Text))
	arg_2_0.resGift = arg_2_0._tf:Find("res/gift/Text"):GetComponent(typeof(Text))
	arg_2_0.ticketTr = arg_2_0._tf:Find("main/ticket")
	arg_2_0.ticketMarkTr = arg_2_0._tf:Find("main/ticket/finish")
	arg_2_0.giftTr = arg_2_0._tf:Find("main/gift")
	arg_2_0.giftImg = arg_2_0.giftTr:Find("icon"):GetComponent(typeof(Image))
	arg_2_0.giftMarkTr = arg_2_0._tf:Find("main/gift/finish")
	arg_2_0.ticketTxt = arg_2_0.ticketTr:Find("make/Text"):GetComponent(typeof(Text))

	setText(arg_2_0.giftTr:Find("make/Text"), i18n("feast_label_give_gift"))
	setText(arg_2_0.ticketTr:Find("finish/frame/label"), i18n("feast_label_give_invitation_finish"))
	setText(arg_2_0.giftTr:Find("finish/frame/label"), i18n("feast_label_give_gift_finish"))

	arg_2_0.painting = arg_2_0._tf:Find("main/painting"):GetComponent(typeof(Image))
	arg_2_0.puzzlePage = FeastMakeTicketPage.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.giveTicketPage = FeastGiveTicketPage.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.giveGiftPage = FeastGiveGiftPage.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.resWindow = FeastResWindow.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.homeBtn = arg_2_0._tf:Find("home")

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0:bind(FeastScene.ON_SKIP_GIVE_GIFT, function(arg_4_0, arg_4_1)
		arg_3_0.giveTicketPage:ExecuteAction("Show", arg_4_1)

		return
	end)
	arg_3_0:bind(FeastScene.ON_MAKE_TICKET, function(arg_5_0)
		arg_3_0:OnFlush()
		arg_3_0:UpdateRes()

		return
	end)
	arg_3_0:bind(FeastScene.ON_GOT_TICKET, function(arg_6_0)
		arg_3_0:OnFlush()

		return
	end)
	arg_3_0:bind(FeastScene.ON_GOT_GIFT, function(arg_7_0)
		arg_3_0:OnFlush()
		arg_3_0:UpdateRes()

		return
	end)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.homeBtn, function()
		arg_3_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnFlush(arg_10_0)
	if arg_10_0.feastShip then
		arg_10_0:UpdateMain(arg_10_0.feastShip)
	end

	local var_10_0 = getProxy(FeastProxy):getRawData()

	arg_10_0:UpdateFeastShips((var_10_0:GetInvitedFeastShipList()))

	return
end

function var_0_0.Show(arg_11_0)
	var_0_0.super.Show(arg_11_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_11_0._tf)
	arg_11_0:UpdateFeastShips((getProxy(FeastProxy):getRawData():GetInvitedFeastShipList()))
	arg_11_0:UpdateRes()
	triggerToggle(arg_11_0.toggles[1], true)
	scrollTo(arg_11_0.scrollrect, 0, 1)

	return
end

function var_0_0.UpdateRes(arg_12_0)
	local var_12_0, var_12_1 = getProxy(FeastProxy):GetConsumeList()
	local var_12_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

	arg_12_0.ticketCnt = var_12_2:getVitemNumber(var_12_0)
	arg_12_0.giftCnt = var_12_2:getVitemNumber(var_12_1)
	arg_12_0.resTicket.text = arg_12_0.ticketCnt
	arg_12_0.resGift.text = arg_12_0.giftCnt

	onButton(arg_12_0, arg_12_0.resTicketTr, function()
		arg_12_0.resWindow:ExecuteAction("Show", var_12_0)

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.resGiftTr, function()
		arg_12_0.resWindow:ExecuteAction("Show", var_12_1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateFeastShips(arg_15_0, arg_15_1)
	arg_15_0.toggles = {}

	arg_15_0.uilist:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_0 = arg_15_1[arg_16_1 + 1]

			LoadSpriteAsync("FeastIcon/" .. arg_15_1[arg_16_1 + 1]:GetPrefab(), function(arg_17_0)
				local var_17_0 = arg_16_2:Find("icon"):GetComponent(typeof(Image))

				var_17_0.sprite = arg_17_0

				var_17_0:SetNativeSize()

				return
			end)

			local var_16_1 = arg_15_1[arg_16_1 + 1]:GotGift() and arg_15_1[arg_16_1 + 1]:GotTicket()

			setActive(arg_16_2:Find("finish"), var_16_1)
			onToggle(arg_15_0, arg_16_2, function(arg_18_0)
				if arg_18_0 then
					arg_15_0:UpdateMain(var_16_0)
				end

				return
			end, SFX_PANEL)
			table.insert(arg_15_0.toggles, arg_16_2)
		end

		return
	end)
	arg_15_0.uilist:align(#arg_15_1)

	return
end

local var_0_1 = {
	[0] = i18n("feast_label_make_invitation"),
	(i18n("feast_label_give_invitation"))
}

function var_0_0.UpdateMain(arg_19_0, arg_19_1)
	setActive(arg_19_0.ticketMarkTr, arg_19_1:GotTicket())
	setActive(arg_19_0.giftMarkTr, arg_19_1:GotGift())

	arg_19_0.ticketTxt.text = var_0_1[arg_19_1:GetInvitationState()]

	local var_19_0 = arg_19_1:GetPrefab()

	LoadSpriteAsync("FeastPainting/" .. var_19_0, function(arg_20_0)
		arg_19_0.painting.sprite = arg_20_0

		arg_19_0.painting:SetNativeSize()

		return
	end)
	LoadSpriteAsync("FeastCharGift/" .. var_19_0, function(arg_21_0)
		arg_19_0.giftImg.sprite = arg_21_0

		arg_19_0.giftImg:SetNativeSize()

		return
	end)
	onButton(arg_19_0, arg_19_0.ticketTr, function()
		if arg_19_1:HasTicket() then
			arg_19_0.giveTicketPage:ExecuteAction("Show", arg_19_1)
		elseif not arg_19_1:GotTicket() then
			if arg_19_0.ticketCnt <= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("feast_no_invitation"))

				return
			end

			arg_19_0.puzzlePage:ExecuteAction("Show", arg_19_1)
		end

		return
	end, SFX_PANEL)
	onButton(arg_19_0, arg_19_0.giftTr, function()
		if not arg_19_1:GotTicket() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("feast_cant_give_gift_tip"))

			return
		end

		if arg_19_0.giftCnt <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("feast_no_gift"))

			return
		end

		if not arg_19_1:GotGift() then
			arg_19_0.giveGiftPage:ExecuteAction("Show", arg_19_1)
		end

		return
	end, SFX_PANEL)

	arg_19_0.feastShip = arg_19_1

	return
end

function var_0_0.Hide(arg_24_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_24_0._tf, arg_24_0._parentTf)

	if arg_24_0.puzzlePage and arg_24_0.puzzlePage:GetLoaded() and arg_24_0.puzzlePage:isShowing() then
		arg_24_0.puzzlePage:Hide()
	end

	if arg_24_0.giveTicketPage and arg_24_0.giveTicketPage:GetLoaded() and arg_24_0.giveTicketPage:isShowing() then
		arg_24_0.giveTicketPage:Hide()
	end

	if arg_24_0.giveGiftPage and arg_24_0.giveGiftPage:GetLoaded() and arg_24_0.giveGiftPage:isShowing() then
		arg_24_0.giveGiftPage:Hide()
	end

	if arg_24_0.resWindow and arg_24_0.resWindow:GetLoaded() and arg_24_0.resWindow:isShowing() then
		arg_24_0.resWindow:Hide()
	end

	var_0_0.super.Hide(arg_24_0)

	arg_24_0.feastShip = nil

	return
end

function var_0_0.onBackPressed(arg_25_0)
	if arg_25_0.puzzlePage and arg_25_0.puzzlePage:GetLoaded() and arg_25_0.puzzlePage:isShowing() then
		arg_25_0.puzzlePage:Hide()

		return
	end

	if arg_25_0.giveTicketPage and arg_25_0.giveTicketPage:GetLoaded() and arg_25_0.giveTicketPage:isShowing() then
		if not arg_25_0.giveTicketPage:CanInterAction() then
			return
		end

		arg_25_0.giveTicketPage:Hide()

		return
	end

	if arg_25_0.giveGiftPage and arg_25_0.giveGiftPage:GetLoaded() and arg_25_0.giveGiftPage:isShowing() then
		if not arg_25_0.giveGiftPage:CanInterAction() then
			return
		end

		arg_25_0.giveGiftPage:Hide()

		return
	end

	if arg_25_0.resWindow and arg_25_0.resWindow:GetLoaded() and arg_25_0.resWindow:isShowing() then
		arg_25_0.resWindow:Hide()

		return
	end

	if arg_25_0:isShowing() then
		arg_25_0:Hide()
	end

	return
end

function var_0_0.OnDestroy(arg_26_0)
	if arg_26_0.puzzlePage then
		arg_26_0.puzzlePage:Destroy()

		arg_26_0.puzzlePage = nil
	end

	if arg_26_0.giveTicketPage then
		arg_26_0.giveTicketPage:Destroy()

		arg_26_0.giveTicketPage = nil
	end

	if arg_26_0.giveGiftPage then
		arg_26_0.giveGiftPage:Destroy()

		arg_26_0.giveGiftPage = nil
	end

	if arg_26_0.resWindow then
		arg_26_0.resWindow:Destroy()

		arg_26_0.resWindow = nil
	end

	if arg_26_0:isShowing() then
		arg_26_0:Hide()
	end

	return
end

return var_0_0
