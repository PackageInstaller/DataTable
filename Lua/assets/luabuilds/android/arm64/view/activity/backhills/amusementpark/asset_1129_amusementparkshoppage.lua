local AmusementParkShopPage = class("AmusementParkShopPage", import("view.base.BaseUI"))

function AmusementParkShopPage:getUIName()
	return "AmusementParkShopPage"
end

function AmusementParkShopPage:init()
	self.goodsContainer = self._tf:Find("Box/Container/Goods")
	self.specialsContainer = self._tf:Find("Box/Container/SpecialList")
	self.specailsDecoration = self._tf:Find("Box/Container/Specials")
	self.specailsOtherDecoration = self._tf:Find("Box/Container/SpecialsOther")

	setActive(self.specailsOtherDecoration, false)

	self.chat = self._tf:Find("Box/Bubble")
	self.chatText = self.chat:Find("BubbleText")
	self.chatClick = self._tf:Find("Box/BubbleClick")
	self.chatActive = false
	self.pollText = {
		i18n("amusementpark_shop_carousel1"),
		i18n("amusementpark_shop_carousel2"),
		i18n("amusementpark_shop_carousel3"),
		i18n("amusementpark_shop_0")
	}
	self.pollIndex = math.random(0, math.max(0, #self.pollText - 1))
	self.msgbox = self._tf:Find("Msgbox")

	setActive(self.msgbox, false)

	self.contentText = self.msgbox:Find("window/msg_panel/content"):GetComponent("RichText")

	return
end

function AmusementParkShopPage:SetShop(arg_3_1)
	self.shop = arg_3_1

	return
end

function AmusementParkShopPage:SetSpecial(arg_4_1)
	self.specialLists = arg_4_1

	return
end

function AmusementParkShopPage:didEnter()
	onButton(self, self._tf:Find("Top/Back"), function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self._tf:Find("Top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.amusementpark_shop_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.msgbox:Find("BG"), function()
		setActive(self.msgbox, false)

		return
	end)
	onButton(self, self.msgbox:Find("window/button_container/Button1"), function()
		setActive(self.msgbox, false)

		return
	end, SFX_CANCEL)
	onButton(self, self.chatClick, function()
		self:SetActiveBubble(not self.chatActive)

		return
	end)

	local var_5_0 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = self.shop:getResId()
	}):getIcon()

	self.contentText:AddSprite(var_5_0, LoadSprite(var_5_0, ""))
	self:UpdateView()
	self:ShowEnterMsg()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function AmusementParkShopPage:ShowEnterMsg()
	if _.all(_.values(self.shop.goods), function(arg_12_0)
		return not arg_12_0:canPurchase()
	end) then
		self:ShowShipWord(i18n("amusementpark_shop_end"))

		return
	end

	self:ShowShipWord(i18n("amusementpark_shop_enter"))

	return
end

function AmusementParkShopPage:UpdateView()
	setText(self._tf:Find("Box/TicketText"), "X" .. (getProxy(PlayerProxy):getRawData()[id2res((self.shop:getResId()))] or 0))
	self:UpdateGoods()

	return
end

function AmusementParkShopPage:UpdateGoods()
	local var_14_0 = _.values(self.shop.goods)

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0.id < arg_15_1.id
	end)
	UIItemList.StaticAlign(self.goodsContainer, self.goodsContainer:GetChild(0), #var_14_0, function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_16_0 = var_14_0[arg_16_1 + 1]

		setActive(arg_16_2:Find("mask"), not var_14_0[arg_16_1 + 1]:canPurchase())
		updateDrop(arg_16_2, {
			type = var_16_0:getConfig("commodity_type"),
			id = var_16_0:getConfig("commodity_id"),
			count = var_16_0:getConfig("num")
		})
		setText(arg_16_2:Find("Price"), var_16_0:getConfig("resource_num"))
		onButton(self, arg_16_2, function()
			self:OnClickCommodity(var_16_0, function(arg_18_0, arg_18_1)
				self:OnPurchase(var_16_0, arg_18_1)

				return
			end)

			return
		end, SFX_PANEL)

		return
	end)
	setActive(self.specailsDecoration, #self.specialLists > 0)
	setActive(self.specailsOtherDecoration, #self.specialLists <= 0)
	UIItemList.StaticAlign(self.specialsContainer, self.specialsContainer:GetChild(0), 3, function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_19_0 = self.specialLists[arg_19_1 + 1]

		setActive(arg_19_2, self.specialLists[arg_19_1 + 1])

		if not var_19_0 then
			return
		end

		setActive(arg_19_2:Find("mask"), var_19_0.HasGot)
		onButton(self, arg_19_2, function()
			self:emit(BaseUI.ON_DROP, var_19_0)

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function AmusementParkShopPage:CheckRes(arg_21_1, arg_21_2)
	if not arg_21_1:canPurchase() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

		return false
	end

	if Drop.New({
		type = arg_21_1:getConfig("resource_category"),
		id = arg_21_1:getConfig("resource_type")
	}):getOwnedCount() < arg_21_1:getConfig("resource_num") * arg_21_2 then
		self:ShowMsgbox({
			useGO = true,
			content = i18n("amusementpark_shop_exchange"),
			onYes = function()
				self:emit(AmusementParkShopMediator.GO_SCENE, SCENE.TASK)

				return
			end
		})

		return false
	end

	return true
end

function AmusementParkShopPage:Purchase(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	self:ShowMsgbox({
		content = i18n("amusementpark_shop_exchange2", arg_23_1:getConfig("resource_num") * arg_23_2, arg_23_1:getConfig("num") * arg_23_2, arg_23_3),
		onYes = function()
			if self:CheckRes(arg_23_1, arg_23_2) then
				arg_23_4(arg_23_1, arg_23_2)
			end

			return
		end
	})

	return
end

function AmusementParkShopPage:OnClickCommodity(arg_25_1, arg_25_2)
	if not self:CheckRes(arg_25_1, 1) then
		return
	end

	self:Purchase(arg_25_1, 1, Drop.New({
		id = arg_25_1:getConfig("commodity_id"),
		type = arg_25_1:getConfig("commodity_type")
	}):getConfig("name"), arg_25_2)

	return
end

function AmusementParkShopPage:OnPurchase(arg_26_1, arg_26_2)
	self:emit(AmusementParkShopMediator.ON_ACT_SHOPPING, self.shop.activityId, 1, arg_26_1.id, arg_26_2)

	return
end

function AmusementParkShopPage:ShowMsgbox(arg_27_1)
	setActive(self.msgbox, true)

	self.contentText.text = arg_27_1.content

	local var_27_0 = self.msgbox:Find("window/button_container/Button2")
	local var_27_1 = self.msgbox:Find("window/button_container/Button3")
	local var_27_2 = arg_27_1.useGO

	setActive(var_27_0, not arg_27_1.useGO)
	setActive(var_27_1, var_27_2)
	onButton(self, var_27_2 and var_27_1 or var_27_0, function()
		setActive(self.msgbox, false)
		existCall(arg_27_1.onYes)

		return
	end, SFX_CONFIRM)

	return
end

function AmusementParkShopPage:SetActiveBubble(arg_29_1, arg_29_2)
	if self.chatActive == tobool(arg_29_1) and not arg_29_2 then
		return
	end

	LeanTween.cancel(go(self.chat))

	self.chatActive = tobool(arg_29_1)

	if arg_29_1 then
		setActive(self.chat, true)
		LeanTween.scale(self.chat.gameObject, Vector3.New(1, 1, 1), 0.3):setFrom(Vector3.New(0, 0, 0)):setEase(LeanTweenType.easeOutBack)
	else
		setActive(self.chat, true)
		LeanTween.scale(self.chat.gameObject, Vector3.New(0, 0, 0), 0.3):setFrom(Vector3.New(1, 1, 1)):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
			setActive(self.chat, false)

			return
		end))
	end

	return
end

function AmusementParkShopPage:ShowShipWord(arg_31_1)
	self:SetActiveBubble(true, true)
	setText(self.chatText, arg_31_1)
	self:AddPollingChat()

	return
end

function AmusementParkShopPage:AddPollingChat()
	self:StopPolling()

	self.pollTimer = Timer.New(function()
		self:ShowShipWord(self.pollText[self.pollIndex + 1])

		self.pollIndex = (self.pollIndex + 1) % #self.pollText

		return
	end, 6)

	self.pollTimer:Start()

	return
end

function AmusementParkShopPage:StopPolling()
	if not self.pollTimer then
		return
	end

	self.pollTimer:Stop()

	self.pollTimer = nil

	return
end

function AmusementParkShopPage:StopChat()
	if LeanTween.isTweening(go(self.chat)) then
		LeanTween.cancel(go(self.chat))
	end

	setActive(self.chat, false)

	return
end

function AmusementParkShopPage:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self:StopPolling()

	return
end

function AmusementParkShopPage.GetActivityShopTip()
	local var_37_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD)

	if not var_37_0 or var_37_0:isEnd() then
		return
	end

	local var_37_1 = pg.activity_shop_template

	for iter_37_0, iter_37_1 in ipairs(pg.activity_shop_template.all) do
		if var_37_0.id == var_37_1[iter_37_1].activity then
			local var_37_2 = table.indexof(var_37_0.data1_list, iter_37_1)

			if (var_37_1[iter_37_1].num_limit == 0 or ((var_37_2 or nil) and (var_37_0.data2_list[var_37_2] or 0)) < var_37_1[iter_37_1].num_limit) and Drop.New({
				type = var_37_1[iter_37_1].resource_category,
				id = var_37_1[iter_37_1].resource_type
			}):getOwnedCount() >= var_37_1[iter_37_1].resource_num then
				return true
			end
		end
	end

	return false
end

return AmusementParkShopPage
