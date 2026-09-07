local NewYearHotSpringShopLayer = class("NewYearHotSpringShopLayer", import("view.base.BaseUI"))

function NewYearHotSpringShopLayer:getUIName()
	return "NewYearHotSpringShopUI"
end

function NewYearHotSpringShopLayer:init()
	self.goodsContainer = self._tf:Find("Box/Container/Goods")
	self.chat = self._tf:Find("Box/Bubble")
	self.chatAnimator = GetComponent(self.chat, typeof(Animator))
	self.chatAnimEvent = GetComponent(self.chat, typeof(DftAniEvent))
	self.chatText = self.chat:Find("BubbleText")
	self.chatClick = self.chat:Find("BubbleClick")

	setActive(self.chat, false)
	setLocalScale(self.chat, {
		x = 0,
		y = 0
	})
	setActive(self.chat, true)

	self.msgbox = self._tf:Find("Msgbox")

	setActive(self.msgbox, false)

	self.contentText = self.msgbox:Find("window/msg_panel/content"):GetComponent("RichText")

	return
end

function NewYearHotSpringShopLayer:SetShop(arg_3_1)
	self.shop = arg_3_1

	return
end

function NewYearHotSpringShopLayer:didEnter()
	onButton(self, self._tf:Find("Top/Back"), function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self._tf:Find("Top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hotspring_shop_help.tip
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
		self:HideChat()

		return
	end)
	onButton(self, self._tf:Find("Box/Spine"), function()
		self:DisplayChat({
			"hotspring_shop_touch1",
			"hotspring_shop_touch2",
			"hotspring_shop_touch3"
		})
		self.role:SetActionOnce("touch")

		return
	end)
	self:ShowEnterMsg()

	self.role = SpineRole.New()

	self.role:SetData("mingshi_2")
	self:LoadingOn()
	self.role:Load(function()
		self.role:SetParent(self._tf:Find("Box/Spine"))
		self.role:SetAction("stand")
		self.role:SetActionCallBack(function(arg_12_0)
			if arg_12_0 == "finish" then
				self.role:SetAction("stand")
			end

			return
		end)
		self:LoadingOff()

		return
	end, true)
	self:UpdateView()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function NewYearHotSpringShopLayer:ShowEnterMsg()
	local var_13_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)

	if not var_13_0 or var_13_0:isEnd() then
		self:DisplayChat({
			"hotspring_shop_end"
		})

		return
	end

	if _.all(_.values(self.shop.goods), function(arg_14_0)
		return not arg_14_0:canPurchase()
	end) then
		self:DisplayChat({
			"hotspring_shop_finish"
		})

		return
	end

	self:DisplayChat({
		"hotspring_shop_enter1",
		"hotspring_shop_enter2"
	})

	return
end

function NewYearHotSpringShopLayer:UpdateView()
	setText(self._tf:Find("Top/Ticket/TicketText"), getProxy(PlayerProxy):getRawData()[id2res((self.shop:getResId()))] or 0)
	self:UpdateGoods()

	return
end

function NewYearHotSpringShopLayer:UpdateGoods()
	local var_16_0 = _.values(self.shop.goods)

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		return arg_17_0.id < arg_17_1.id
	end)
	UIItemList.StaticAlign(self.goodsContainer, self.goodsContainer:GetChild(0), #var_16_0, function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_18_0 = var_16_0[arg_18_1 + 1]

		setActive(arg_18_2:Find("mask"), not var_16_0[arg_18_1 + 1]:canPurchase())
		updateDrop(arg_18_2:Find("Icon"), {
			type = var_18_0:getConfig("commodity_type"),
			id = var_18_0:getConfig("commodity_id"),
			count = var_18_0:getConfig("num")
		})
		onButton(self, arg_18_2, function()
			self:OnClickCommodity(var_18_0, function(arg_20_0, arg_20_1)
				self:OnPurchase(var_18_0, arg_20_1)

				return
			end)

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function NewYearHotSpringShopLayer:CheckRes(arg_21_1, arg_21_2)
	if not arg_21_1:canPurchase() then
		self:DisplayChat({
			"hotspring_shop_exchanged"
		})

		return false
	end

	if Drop.New({
		type = arg_21_1:getConfig("resource_category"),
		id = arg_21_1:getConfig("resource_type")
	}):getOwnedCount() < arg_21_1:getConfig("resource_num") * arg_21_2 then
		self:DisplayChat({
			"hotspring_shop_insufficient"
		})

		return false
	end

	return true
end

function NewYearHotSpringShopLayer:Purchase(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	self:ShowMsgbox({
		content = i18n("hotspring_shop_exchange", arg_22_1:getConfig("resource_num") * arg_22_2, arg_22_1:getConfig("num") * arg_22_2, arg_22_3),
		onYes = function()
			if self:CheckRes(arg_22_1, arg_22_2) then
				arg_22_4(arg_22_1, arg_22_2)
			end

			return
		end
	})

	return
end

function NewYearHotSpringShopLayer:OnClickCommodity(arg_24_1, arg_24_2)
	if not self:CheckRes(arg_24_1, 1) then
		return
	end

	self:Purchase(arg_24_1, 1, Drop.New({
		id = arg_24_1:getConfig("commodity_id"),
		type = arg_24_1:getConfig("commodity_type")
	}):getConfig("name"), arg_24_2)

	return
end

function NewYearHotSpringShopLayer:OnPurchase(arg_25_1, arg_25_2)
	self:emit(NewYearHotSpringShopMediator.ON_ACT_SHOPPING, self.shop.activityId, 1, arg_25_1.id, arg_25_2)

	return
end

function NewYearHotSpringShopLayer:OnShoppingDone()
	self:DisplayChat({
		"hotspring_shop_success1",
		"hotspring_shop_success2"
	})

	return
end

function NewYearHotSpringShopLayer:ShowMsgbox(arg_27_1)
	setActive(self.msgbox, true)

	self.contentText.text = arg_27_1.content

	onButton(self, self.msgbox:Find("window/button_container/Button2"), function()
		setActive(self.msgbox, false)
		existCall(arg_27_1.onYes)

		return
	end, SFX_CONFIRM)

	return
end

function NewYearHotSpringShopLayer:DisplayChat(arg_29_1)
	self:HideChat()
	onNextTick(function()
		self.chatTween = LeanTween.delayedCall(go(self.chat), 10, System.Action(function()
			self:HideChat()

			return
		end)).uniqueId

		local var_30_0 = i18n(arg_29_1[math.random(#arg_29_1)])

		self.chatAnimator:ResetTrigger("Shrink")
		self.chatAnimator:SetTrigger("Pop")
		self.chatAnimEvent:SetTriggerEvent(function()
			setText(self.chatText, var_30_0)

			return
		end)

		return
	end)

	return
end

function NewYearHotSpringShopLayer:HideChat()
	if self.chatTween then
		self.chatAnimator:ResetTrigger("Pop")
		self.chatAnimator:SetTrigger("Shrink")
		self.chatAnimEvent:SetTriggerEvent(nil)
		LeanTween.cancel(self.chatTween)

		self.chatTween = nil
	end

	return
end

function NewYearHotSpringShopLayer:LoadingOn()
	if self.animating then
		return
	end

	self.animating = true

	pg.UIMgr.GetInstance():LoadingOn(false)

	return
end

function NewYearHotSpringShopLayer:LoadingOff()
	if not self.animating then
		return
	end

	pg.UIMgr.GetInstance():LoadingOff()

	self.animating = false

	return
end

function NewYearHotSpringShopLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self:HideChat()
	self.role:Dispose()
	self:LoadingOff()

	return
end

return NewYearHotSpringShopLayer
