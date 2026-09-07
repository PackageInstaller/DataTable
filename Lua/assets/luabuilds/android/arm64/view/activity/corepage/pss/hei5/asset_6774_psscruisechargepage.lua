local PSSCruiseChargePage = class("PSSCruiseChargePage", import("view.base.BaseSubView"))

function PSSCruiseChargePage:getUIName()
	return "PSSCruiseChargePage"
end

function PSSCruiseChargePage:OnLoaded()
	return
end

function PSSCruiseChargePage:initTplVar()
	self.descTip = "blackfriday_battlepass_pay_acquire"
	self.payTip = "blackfriday_battlepass_pay_tip"
	self.tplMaskName = nil

	return
end

function PSSCruiseChargePage:OnInit()
	self:initTplVar()

	self.buyWindow = self._tf:Find("buy_window")
	self.cancelBtn = self.buyWindow:Find("button_container/button_cancel")

	setText(self.cancelBtn:Find("Image"), i18n("text_cancel"))

	self.confirmBtn = self.buyWindow:Find("button_container/button_ok")
	self.priceTF = self.confirmBtn:Find("Image")

	setText(self.buyWindow:Find("left/got/desc"), i18n(self.descTip))

	local var_4_0 = self.buyWindow:Find("right/items/scrollview/list")

	setText(self.buyWindow:Find("right/items/Text"), i18n(self.payTip))

	self.uiItemList = UIItemList.New(var_4_0, var_4_0:Find("tpl"))

	self.uiItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = self.itemList[arg_5_1]

			if not self.tplMaskName then
				updateDrop(arg_5_2, var_5_0)
			else
				updateDrop(arg_5_2:Find(self.tplMaskName), var_5_0)
			end

			setText(arg_5_2:Find("name"), shortenString(var_5_0:getConfig("name"), 4))
			onButton(self, arg_5_2, function()
				self:emit(BaseUI.ON_NEW_STYLE_DROP, {
					drop = var_5_0
				})

				return
			end, SFX_CONFIRM)
		end

		return
	end)
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
			self:emit(PSSHei5Mediator.EVENT_OPEN_BIRTHDAY)
		else
			pg.m02:sendNotification(GAME.CHARGE_OPERATION, {
				shopId = self.passId
			})
		end

		return
	end, SFX_PANEL)

	return
end

function PSSCruiseChargePage:ShowBuyWindow()
	setActive(self.buyWindow, true)
	self:Show()

	if self.passId and self.passId == PSSCruiseChargePage.GetPassID() then
		return
	end

	self.passId = PSSCruiseChargePage.GetPassID()

	local var_10_0 = Goods.Create({
		shop_id = self.passId
	}, Goods.TYPE_CHARGE)
	local var_10_1 = Drop.Create(var_10_0:getConfig("display")[1])

	LoadImageSpriteAtlasAsync(var_10_1:getIcon(), "", self.buyWindow:Find("left/got/award/icon"))
	setText(self.buyWindow:Find("left/got/award/count"), "x" .. var_10_1.count)
	setText(self.buyWindow:Find("right/tip"), var_10_0:getConfig("descrip_extra"))

	local var_10_2 = var_10_0:getConfig("money")

	if PLATFORM_CODE == PLATFORM_CHT and var_10_0:IsLocalPrice() then
		-- block empty
	else
		var_10_2 = GetMoneySymbol() .. var_10_2
	end

	setText(self.priceTF, var_10_2)

	self.itemList = var_10_0:GetExtraServiceItem()

	self.uiItemList:align(#self.itemList)

	return
end

function PSSCruiseChargePage.GetPassID()
	local var_11_0 = getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_HEI5)

	if var_11_0 and not var_11_0:isEnd() then
		for iter_11_0, iter_11_1 in ipairs(pg.pay_data_display.all) do
			if pg.pay_data_display[iter_11_1].sub_display and type(pg.pay_data_display[iter_11_1].sub_display) == "table" and pg.pay_data_display[iter_11_1].sub_display[1] == var_11_0.id then
				return iter_11_1
			end
		end
	end

	return
end

function PSSCruiseChargePage:ShowUnlockWindow(arg_12_1)
	self:Hide()

	return
end

function PSSCruiseChargePage:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	PSSCruiseChargePage.super.Show(self)

	return
end

function PSSCruiseChargePage:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	PSSCruiseChargePage.super.Hide(self)

	return
end

function PSSCruiseChargePage:OnDestroy()
	return
end

return PSSCruiseChargePage
