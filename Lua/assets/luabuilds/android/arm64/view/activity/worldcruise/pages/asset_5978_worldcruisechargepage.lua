local WorldCruiseChargePage = class("WorldCruiseChargePage", import("view.base.BaseSubView"))

function WorldCruiseChargePage:getUIName()
	return "WorldCruiseChargePage"
end

function WorldCruiseChargePage:OnLoaded()
	return
end

function WorldCruiseChargePage:OnInit()
	self.buyWindow = self._tf:Find("buy_window")
	self.cancelBtn = self.buyWindow:Find("button_container/button_cancel")

	setText(self.cancelBtn:Find("Image"), i18n("text_cancel"))

	self.confirmBtn = self.buyWindow:Find("button_container/button_ok")
	self.priceTF = self.confirmBtn:Find("Image")

	setText(self.buyWindow:Find("left/got/desc"), i18n("battlepass_pay_acquire"))

	local var_3_0 = self.buyWindow:Find("right/items/scrollview/list")

	self.uiItemList = UIItemList.New(var_3_0, var_3_0:Find("tpl"))

	self.uiItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = self.itemList[arg_4_1]

			updateDrop(arg_4_2, self.itemList[arg_4_1])
			setText(arg_4_2:Find("name"), shortenString(self.itemList[arg_4_1]:getConfig("name"), 4))
			onButton(self, arg_4_2, function()
				self:emit(BaseUI.ON_NEW_STYLE_DROP, {
					drop = var_4_0
				})

				return
			end, SFX_CONFIRM)
		end

		return
	end)

	self.unlcokWindow = self._tf:Find("unlock_window")

	setText(self.unlcokWindow:Find("tip"), i18n("word_click_to_close"))

	self.unlockItem = self.unlcokWindow:Find("IconTpl")

	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if ChargeConst.isNeedSetBirth() then
			self:emit(WorldCruiseMediator.EVENT_OPEN_BIRTHDAY)
		else
			pg.m02:sendNotification(GAME.CHARGE_OPERATION, {
				shopId = self.passId
			})
		end

		return
	end, SFX_PANEL)

	return
end

function WorldCruiseChargePage:ShowBuyWindow()
	setActive(self.buyWindow, true)
	setActive(self.unlcokWindow, false)
	self:Show()

	if self.passId and self.passId == WorldCruiseChargePage.GetPassID() then
		return
	end

	self.passId = WorldCruiseChargePage.GetPassID()

	local var_9_0 = Goods.Create({
		shop_id = self.passId
	}, Goods.TYPE_CHARGE)
	local var_9_1 = Drop.Create(var_9_0:getConfig("display")[1])

	LoadImageSpriteAtlasAsync(var_9_1:getIcon(), "", self.buyWindow:Find("left/got/award/icon"))
	setText(self.buyWindow:Find("left/got/award/count"), "x" .. var_9_1.count)
	setText(self.buyWindow:Find("right/tip"), var_9_0:getConfig("descrip_extra"))

	local var_9_2 = var_9_0:getConfig("money")

	if PLATFORM_CODE == PLATFORM_CHT and var_9_0:IsLocalPrice() then
		-- block empty
	else
		var_9_2 = GetMoneySymbol() .. var_9_2
	end

	setText(self.priceTF, var_9_2)

	self.itemList = var_9_0:GetExtraServiceItem()

	self.uiItemList:align(#self.itemList)

	return
end

function WorldCruiseChargePage.GetPassID()
	local var_10_0 = getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)

	if var_10_0 and not var_10_0:isEnd() then
		for iter_10_0, iter_10_1 in ipairs(pg.pay_data_display.all) do
			if pg.pay_data_display[iter_10_1].sub_display and type(pg.pay_data_display[iter_10_1].sub_display) == "table" and pg.pay_data_display[iter_10_1].sub_display[1] == var_10_0.id then
				return iter_10_1
			end
		end
	end

	return
end

function WorldCruiseChargePage:ShowUnlockWindow(arg_11_1)
	setActive(self.buyWindow, false)
	setActive(self.unlcokWindow, true)
	self:Show()

	local var_11_0 = Drop.Create(arg_11_1:getConfig("display")[1])

	updateDrop(self.unlockItem, var_11_0)
	onButton(self, self.unlockItem, function()
		self:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_11_0
		})

		return
	end, SFX_CONFIRM)

	return
end

function WorldCruiseChargePage:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	WorldCruiseChargePage.super.Show(self)

	return
end

function WorldCruiseChargePage:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	WorldCruiseChargePage.super.Hide(self)

	return
end

function WorldCruiseChargePage:OnDestroy()
	return
end

return WorldCruiseChargePage
