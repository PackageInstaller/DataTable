local ItemRecycleConfirmationPage = class("ItemRecycleConfirmationPage", import("view.base.BaseSubView"))

function ItemRecycleConfirmationPage:getUIName()
	return "ItemRecycleConfirmationUI"
end

function ItemRecycleConfirmationPage:OnLoaded()
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.cancelBtn = self._tf:Find("window/button_container/cancel")
	self.confirmBtn = self._tf:Find("window/button_container/confirm")
	self.content = self._tf:Find("window/single_item_panel/Text")
	self.itemTpl = self._tf:Find("window/single_item_panel/left")
	self.resTpl = self._tf:Find("window/single_item_panel/right")
	self.itemName = self.itemTpl:Find("name_bg/Text"):GetComponent(typeof(Text))
	self.resName = self.resTpl:Find("name_bg/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("window/top/bg/infomation/title"), i18n("words_information"))
	setText(self._tf:Find("window/button_container/cancel/pic"), i18n("word_cancel"))
	setText(self._tf:Find("window/button_container/confirm/pic"), i18n("word_ok"))

	return
end

function ItemRecycleConfirmationPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if self.itemId then
			pg.m02:sendNotification(GAME.SELL_ITEM, {
				items = {
					{
						count = 1,
						id = self.itemId
					}
				}
			})
		end

		return
	end, SFX_PANEL)

	return
end

function ItemRecycleConfirmationPage:SetCallback(arg_8_1, arg_8_2)
	self.onShowFunc = arg_8_1
	self.onHideFunc = arg_8_2

	return
end

function ItemRecycleConfirmationPage:Hide()
	ItemRecycleConfirmationPage.super.Hide(self)

	if self.onHideFunc then
		self.onHideFunc()
	end

	return
end

function ItemRecycleConfirmationPage:Show(arg_10_1)
	ItemRecycleConfirmationPage.super.Show(self)

	self.itemId = arg_10_1.itemId

	setText(self.content, arg_10_1.content)
	self:UpdateItem()
	self:UpdateResource()

	if self.onShowFunc then
		self.onShowFunc()
	end

	return
end

function ItemRecycleConfirmationPage:UpdateItem()
	local var_11_0 = Drop.Create({
		DROP_TYPE_ITEM,
		self.itemId,
		1
	})

	updateDrop(self.itemTpl, var_11_0)

	self.itemName.text = shortenString(var_11_0:getName(), 5)

	return
end

function ItemRecycleConfirmationPage:UpdateResource()
	local var_12_0 = Item.New({
		id = self.itemId
	}):GetPrice() or {
		1,
		0
	}
	local var_12_1 = Drop.Create({
		DROP_TYPE_RESOURCE,
		var_12_0[1],
		var_12_0[2]
	})

	updateDrop(self.resTpl, var_12_1)

	self.resName.text = shortenString(var_12_1:getName(), 5)

	return
end

function ItemRecycleConfirmationPage:OnDestroy()
	self:SetCallback(nil, nil)

	return
end

return ItemRecycleConfirmationPage
