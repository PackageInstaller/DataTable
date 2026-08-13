class = var_0_10000

local var_0_0 = "FeastInvitationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "FeastInvitationUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "return")

	local var_2_1 = arg_2_0._tf

	arg_2_0.scrollrect = var_1.Find(var_2_1, "left/scrollrect")
	UIItemList = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_3.Find(var_2_3, "left/scrollrect/conent")
	local var_2_5 = arg_2_0._tf

	arg_2_0.uilist = var_2_2(var_2_4, var_4.Find(var_2_5, "left/scrollrect/conent/tpl"))

	local var_2_6 = arg_2_0._tf

	arg_2_0.resTicketTr = var_1.Find(var_2_6, "res/ticket")

	local var_2_7 = arg_2_0._tf

	arg_2_0.resGiftTr = var_1.Find(var_2_7, "res/gift")

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "res/ticket/Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_2_5
	arg_2_0.resTicket = var_2_10(var_2_9, var_4(var_2_5))

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_1.Find(var_2_11, "res/gift/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_2_5
	arg_2_0.resGift = var_2_13(var_2_12, var_4(var_2_5))

	local var_2_14 = arg_2_0._tf

	arg_2_0.ticketTr = var_1.Find(var_2_14, "main/ticket")

	local var_2_15 = arg_2_0._tf

	arg_2_0.ticketMarkTr = var_1.Find(var_2_15, "main/ticket/finish")

	local var_2_16 = arg_2_0._tf

	arg_2_0.giftTr = var_1.Find(var_2_16, "main/gift")

	local var_2_17 = arg_2_0.giftTr
	local var_2_18 = var_1.Find(var_2_17, "icon")
	local var_2_19 = var_1.GetComponent

	typeof = var_4
	Image = var_2_5
	arg_2_0.giftImg = var_2_19(var_2_18, var_4(var_2_5))

	local var_2_20 = arg_2_0._tf

	arg_2_0.giftMarkTr = var_1.Find(var_2_20, "main/gift/finish")

	local var_2_21 = arg_2_0.ticketTr
	local var_2_22 = var_1.Find(var_2_21, "make/Text")
	local var_2_23 = var_1.GetComponent

	typeof = var_4
	Text = var_2_5
	arg_2_0.ticketTxt = var_2_23(var_2_22, var_4(var_2_5))
	setText = var_1

	local var_2_24 = arg_2_0.giftTr
	local var_2_25 = var_3.Find(var_2_24, "make/Text")

	i18n = var_4

	var_1(var_2_25, var_4("feast_label_give_gift"))

	setText = var_1

	local var_2_26 = arg_2_0.ticketTr
	local var_2_27 = var_3.Find(var_2_26, "finish/frame/label")

	i18n = var_4

	var_1(var_2_27, var_4("feast_label_give_invitation_finish"))

	setText = var_1

	local var_2_28 = arg_2_0.giftTr
	local var_2_29 = var_3.Find(var_2_28, "finish/frame/label")

	i18n = var_4

	var_1(var_2_29, var_4("feast_label_give_gift_finish"))

	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_1.Find(var_2_30, "main/painting")
	local var_2_32 = var_1.GetComponent

	typeof = var_4
	Image = var_6
	arg_2_0.painting = var_2_32(var_2_31, var_4(var_6))
	FeastMakeTicketPage = var_1
	arg_2_0.puzzlePage = var_1.New(arg_2_0._tf, arg_2_0.event)
	FeastGiveTicketPage = var_1
	arg_2_0.giveTicketPage = var_1.New(arg_2_0._tf, arg_2_0.event)
	FeastGiveGiftPage = var_1
	arg_2_0.giveGiftPage = var_1.New(arg_2_0._tf, arg_2_0.event)
	FeastResWindow = var_1
	arg_2_0.resWindow = var_1.New(arg_2_0._tf, arg_2_0.event)

	local var_2_33 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_33, "home")

	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bind

	FeastScene = var_1_10004

	var_3_1(var_3_0, var_1_10004.ON_SKIP_GIVE_GIFT, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0.giveTicketPage

		var_2.ExecuteAction(var_4_0, "Show", arg_4_1)

		return
	end)

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.bind

	FeastScene = var_4

	var_3_3(var_3_2, var_4.ON_MAKE_TICKET, function(arg_5_0)
		local var_5_0 = arg_3_0

		var_1.OnFlush(var_5_0)

		local var_5_1 = arg_3_0

		var_1.UpdateRes(var_5_1)

		return
	end)

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.bind

	FeastScene = var_4

	var_3_5(var_3_4, var_4.ON_GOT_TICKET, function(arg_6_0)
		local var_6_0 = arg_3_0

		var_1.OnFlush(var_6_0)

		return
	end)

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.bind

	FeastScene = var_4

	var_3_7(var_3_6, var_4.ON_GOT_GIFT, function(arg_7_0)
		local var_7_0 = arg_3_0

		var_1.OnFlush(var_7_0)

		local var_7_1 = arg_3_0

		var_1.UpdateRes(var_7_1)

		return
	end)

	onButton = var_3_7

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.backBtn

	local function var_3_10()
		local var_8_0 = arg_3_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_7(var_3_8, var_3_9, var_3_10, var_1_10006)

	onButton = var_3_7

	local var_3_11 = arg_3_0
	local var_3_12 = arg_3_0.homeBtn

	local function var_3_13()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		BaseUI = var_2_10003

		var_9_1(var_9_0, var_2_10003.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_7(var_3_11, var_3_12, var_3_13, var_1_10006)

	return
end

function var_0_1.OnFlush(arg_10_0)
	if arg_10_0.feastShip then
		var_1_10003 = arg_10_0

		arg_10_0.UpdateMain(var_1_10003, arg_10_0.feastShip)
	end

	getProxy = var_1
	FeastProxy = var_1_10003

	local var_10_0 = var_1(var_1_10003)
	local var_10_1 = var_1.getRawData(var_10_0)
	local var_10_2 = var_1.GetInvitedFeastShipList(var_10_1)

	arg_10_0:UpdateFeastShips(var_10_2)

	return
end

function var_0_1.Show(arg_11_0)
	var_0_1.super.Show(arg_11_0)

	pg = var_1

	local var_11_0 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_11_0, arg_11_0._tf)

	getProxy = var_1
	FeastProxy = var_11_0

	local var_11_1 = var_1(var_11_0)
	local var_11_2 = var_1.getRawData(var_11_1)
	local var_11_3 = var_1.GetInvitedFeastShipList(var_11_2)

	arg_11_0:UpdateFeastShips(var_11_3)
	arg_11_0:UpdateRes()

	triggerToggle = var_3

	var_3(arg_11_0.toggles[1], true)

	scrollTo = var_3

	var_3(arg_11_0.scrollrect, 0, 1)

	return
end

function var_0_1.UpdateRes(arg_12_0)
	getProxy = var_1_10001
	FeastProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1, var_12_2 = var_1.GetConsumeList(var_12_0)

	getProxy = var_12_0
	ActivityProxy = var_1_10005

	local var_12_3 = var_12_0(var_1_10005)
	local var_12_4 = var_3.getActivityByType

	ActivityConst = var_1_10006

	local var_12_5 = var_12_4(var_12_3, var_1_10006.ACTIVITY_TYPE_VIRTUAL_BAG)

	arg_12_0.ticketCnt = var_3.getVitemNumber(var_12_5, var_12_1)
	arg_12_0.giftCnt = var_3:getVitemNumber(var_12_2)
	arg_12_0.resTicket.text = arg_12_0.ticketCnt

	local var_12_6 = arg_12_0.resGift

	var_12_6.text = arg_12_0.giftCnt
	onButton = var_12_6

	local var_12_7 = arg_12_0
	local var_12_8 = arg_12_0.resTicketTr

	local function var_12_9()
		local var_13_0 = arg_12_0.resWindow

		var_0.ExecuteAction(var_13_0, "Show", var_12_1)

		return
	end

	SFX_PANEL = var_1_10009

	var_12_6(var_12_7, var_12_8, var_12_9, var_1_10009)

	onButton = var_12_6

	local var_12_10 = arg_12_0
	local var_12_11 = arg_12_0.resGiftTr

	local function var_12_12()
		local var_14_0 = arg_12_0.resWindow

		var_0.ExecuteAction(var_14_0, "Show", var_12_2)

		return
	end

	SFX_PANEL = var_1_10009

	var_12_6(var_12_10, var_12_11, var_12_12, var_1_10009)

	return
end

function var_0_1.UpdateFeastShips(arg_15_0, arg_15_1)
	arg_15_0.toggles = {}

	local var_15_0 = arg_15_0.uilist

	var_2.make(var_15_0, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = arg_15_1[arg_16_1 + 1]
			local var_16_1 = var_3.GetPrefab(var_16_0)

			LoadSpriteAsync = var_2_10005

			var_2_10005("FeastIcon/" .. var_16_1, function(arg_17_0)
				local var_17_0 = arg_16_2
				local var_17_1 = var_1.Find(var_17_0, "icon")
				local var_17_2 = var_1.GetComponent

				typeof = var_4
				Image = var_3_10006

				local var_17_3 = var_17_2(var_17_1, var_4(var_3_10006))

				var_17_3.sprite = arg_17_0

				var_17_3:SetNativeSize()

				return
			end)

			setActive = var_2_10005

			local var_16_2 = arg_16_2:Find("finish")
			local var_16_3 = var_3
			local var_16_4

			if var_3.GotGift(var_16_3) then
				var_16_3 = var_3
				var_16_4 = var_3.GotTicket(var_16_3)
			end

			var_2_10005(var_16_2, var_16_4)

			onToggle = var_2_10005

			local var_16_5 = arg_15_0
			local var_16_6 = arg_16_2

			local function var_16_7(arg_18_0)
				if arg_18_0 then
					local var_18_0 = arg_15_0

					var_1.UpdateMain(var_18_0, var_0)
				end

				return
			end

			SFX_PANEL = var_16_3

			var_2_10005(var_16_5, var_16_6, var_16_7, var_16_3)

			table = var_2_10005

			var_2_10005.insert(arg_15_0.toggles, arg_16_2)
		end

		return
	end)

	local var_15_1 = arg_15_0.uilist

	var_2.align(var_15_1, #arg_15_1)

	return
end

local var_0_2 = {}

i18n = var_0_0
var_0_2[0] = var_0_0("feast_label_make_invitation")
i18n = var_2
var_0_2[1] = var_2("feast_label_give_invitation")

function var_0_1.UpdateMain(arg_19_0, arg_19_1)
	setActive = var_1_10002

	var_1_10002(arg_19_0.ticketMarkTr, arg_19_1:GotTicket())

	setActive = var_1_10002

	var_1_10002(arg_19_0.giftMarkTr, arg_19_1:GotGift())

	arg_19_0.ticketTxt.text = var_0_2[arg_19_1:GetInvitationState()]

	local var_19_0 = arg_19_1:GetPrefab()

	LoadSpriteAsync = var_3

	var_3("FeastPainting/" .. var_19_0, function(arg_20_0)
		arg_19_0.painting.sprite = arg_20_0

		local var_20_0 = arg_19_0.painting

		var_1.SetNativeSize(var_20_0)

		return
	end)

	LoadSpriteAsync = var_3

	var_3("FeastCharGift/" .. var_19_0, function(arg_21_0)
		arg_19_0.giftImg.sprite = arg_21_0

		local var_21_0 = arg_19_0.giftImg

		var_1.SetNativeSize(var_21_0)

		return
	end)

	onButton = var_3

	local var_19_1 = arg_19_0
	local var_19_2 = arg_19_0.ticketTr

	local function var_19_3()
		local var_22_0 = arg_19_1

		if var_0.HasTicket(var_22_0) then
			local var_22_1 = arg_19_0.giveTicketPage

			var_0.ExecuteAction(var_22_1, "Show", arg_19_1)
		else
			local var_22_2 = arg_19_1

			if not var_0.GotTicket(var_22_2) then
				if arg_19_0.ticketCnt <= 0 then
					pg = var_0

					local var_22_3 = var_0.TipsMgr.GetInstance()
					local var_22_4 = var_0.ShowTips

					i18n = var_2_10003

					var_22_4(var_22_3, var_2_10003("feast_no_invitation"))

					return
				end

				local var_22_5 = arg_19_0.puzzlePage

				var_0.ExecuteAction(var_22_5, "Show", arg_19_1)
			end
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_19_1, var_19_2, var_19_3, var_1_10008)

	onButton = var_3

	local var_19_4 = arg_19_0
	local var_19_5 = arg_19_0.giftTr

	local function var_19_6()
		local var_23_0 = arg_19_1

		if not var_0.GotTicket(var_23_0) then
			pg = var_0

			local var_23_1 = var_0.TipsMgr.GetInstance()
			local var_23_2 = var_0.ShowTips

			i18n = var_2_10003

			var_23_2(var_23_1, var_2_10003("feast_cant_give_gift_tip"))

			return
		end

		if arg_19_0.giftCnt <= 0 then
			pg = var_0

			local var_23_3 = var_0.TipsMgr.GetInstance()
			local var_23_4 = var_0.ShowTips

			i18n = var_2_10003

			var_23_4(var_23_3, var_2_10003("feast_no_gift"))

			return
		end

		local var_23_5 = arg_19_1

		if not var_0.GotGift(var_23_5) then
			local var_23_6 = arg_19_0.giveGiftPage

			var_0.ExecuteAction(var_23_6, "Show", arg_19_1)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_19_4, var_19_5, var_19_6, var_1_10008)

	arg_19_0.feastShip = arg_19_1

	return
end

function var_0_1.Hide(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_24_0, arg_24_0._tf, arg_24_0._parentTf)

	if arg_24_0.puzzlePage then
		local var_24_1 = arg_24_0.puzzlePage

		if var_1.GetLoaded(var_24_1) then
			local var_24_2 = arg_24_0.puzzlePage

			if var_1.isShowing(var_24_2) then
				local var_24_3 = arg_24_0.puzzlePage

				var_1.Hide(var_24_3)
			end
		end
	end

	if arg_24_0.giveTicketPage then
		local var_24_4 = arg_24_0.giveTicketPage

		if var_1.GetLoaded(var_24_4) then
			local var_24_5 = arg_24_0.giveTicketPage

			if var_1.isShowing(var_24_5) then
				local var_24_6 = arg_24_0.giveTicketPage

				var_1.Hide(var_24_6)
			end
		end
	end

	if arg_24_0.giveGiftPage then
		local var_24_7 = arg_24_0.giveGiftPage

		if var_1.GetLoaded(var_24_7) then
			local var_24_8 = arg_24_0.giveGiftPage

			if var_1.isShowing(var_24_8) then
				local var_24_9 = arg_24_0.giveGiftPage

				var_1.Hide(var_24_9)
			end
		end
	end

	if arg_24_0.resWindow then
		local var_24_10 = arg_24_0.resWindow

		if var_1.GetLoaded(var_24_10) then
			local var_24_11 = arg_24_0.resWindow

			if var_1.isShowing(var_24_11) then
				local var_24_12 = arg_24_0.resWindow

				var_1.Hide(var_24_12)
			end
		end
	end

	var_0_1.super.Hide(arg_24_0)

	arg_24_0.feastShip = nil

	return
end

function var_0_1.onBackPressed(arg_25_0)
	if arg_25_0.puzzlePage then
		local var_25_0 = arg_25_0.puzzlePage

		if var_1.GetLoaded(var_25_0) then
			local var_25_1 = arg_25_0.puzzlePage

			if var_1.isShowing(var_25_1) then
				local var_25_2 = arg_25_0.puzzlePage

				var_1.Hide(var_25_2)

				return
			end
		end
	end

	if arg_25_0.giveTicketPage then
		local var_25_3 = arg_25_0.giveTicketPage

		if var_1.GetLoaded(var_25_3) then
			local var_25_4 = arg_25_0.giveTicketPage

			if var_1.isShowing(var_25_4) then
				local var_25_5 = arg_25_0.giveTicketPage

				if not var_1.CanInterAction(var_25_5) then
					return
				end

				local var_25_6 = arg_25_0.giveTicketPage

				var_1.Hide(var_25_6)

				return
			end
		end
	end

	if arg_25_0.giveGiftPage then
		local var_25_7 = arg_25_0.giveGiftPage

		if var_1.GetLoaded(var_25_7) then
			local var_25_8 = arg_25_0.giveGiftPage

			if var_1.isShowing(var_25_8) then
				local var_25_9 = arg_25_0.giveGiftPage

				if not var_1.CanInterAction(var_25_9) then
					return
				end

				local var_25_10 = arg_25_0.giveGiftPage

				var_1.Hide(var_25_10)

				return
			end
		end
	end

	if arg_25_0.resWindow then
		local var_25_11 = arg_25_0.resWindow

		if var_1.GetLoaded(var_25_11) then
			local var_25_12 = arg_25_0.resWindow

			if var_1.isShowing(var_25_12) then
				local var_25_13 = arg_25_0.resWindow

				var_1.Hide(var_25_13)

				return
			end
		end
	end

	if arg_25_0:isShowing() then
		arg_25_0:Hide()
	end

	return
end

function var_0_1.OnDestroy(arg_26_0)
	if arg_26_0.puzzlePage then
		local var_26_0 = arg_26_0.puzzlePage

		var_1.Destroy(var_26_0)

		arg_26_0.puzzlePage = nil
	end

	if arg_26_0.giveTicketPage then
		local var_26_1 = arg_26_0.giveTicketPage

		var_1.Destroy(var_26_1)

		arg_26_0.giveTicketPage = nil
	end

	if arg_26_0.giveGiftPage then
		local var_26_2 = arg_26_0.giveGiftPage

		var_1.Destroy(var_26_2)

		arg_26_0.giveGiftPage = nil
	end

	if arg_26_0.resWindow then
		local var_26_3 = arg_26_0.resWindow

		var_1.Destroy(var_26_3)

		arg_26_0.resWindow = nil
	end

	if arg_26_0:isShowing() then
		arg_26_0:Hide()
	end

	return
end

return var_0_1
