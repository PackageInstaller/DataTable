local NewEducateMsgBoxLayer = class("NewEducateMsgBoxLayer", import("view.newEducate.base.NewEducateBaseUI"))

NewEducateMsgBoxLayer.TYPE = {
	SHOP = 3,
	RESET = 4,
	BOX = 1,
	ITEM = 2
}

local var_0_1 = {
	[NewEducateMsgBoxLayer.TYPE.BOX] = Vector2(924, 616),
	[NewEducateMsgBoxLayer.TYPE.ITEM] = Vector2(1060, 628),
	[NewEducateMsgBoxLayer.TYPE.SHOP] = Vector2(1060, 628),
	[NewEducateMsgBoxLayer.TYPE.RESET] = Vector2(980, 650)
}
local var_0_2 = {
	[NewEducateMsgBoxLayer.TYPE.BOX] = i18n("child_msg_title_tip"),
	[NewEducateMsgBoxLayer.TYPE.ITEM] = i18n("child_msg_title_detail"),
	[NewEducateMsgBoxLayer.TYPE.SHOP] = i18n("child_msg_title_detail"),
	[NewEducateMsgBoxLayer.TYPE.RESET] = i18n("child_msg_title_tip")
}

function NewEducateMsgBoxLayer:getUIName()
	return "NewEducateMsgBoxUI"
end

function NewEducateMsgBoxLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(NewEducateMsgBoxLayer.ON_CLOSE)

		return
	end)

	self._window = self._tf:Find("anim_root/window")

	setActive(self._window, true)

	self._top = self._window:Find("top")
	self._titleText = self._top:Find("title")
	self._closeBtn = self._top:Find("btnBack")
	self._msgPanel = self._window:Find("msg_panel")
	self.contentText = self._msgPanel:Find("content"):GetComponent("RichText")
	self._sigleItemPanel = self._window:Find("single_item_panel")
	self.singleItemTF = self._sigleItemPanel:Find("item")
	self.singleItemOwn = self._sigleItemPanel:Find("own")
	self.singleItemName = self._sigleItemPanel:Find("display_panel/name")
	self.singleItemDesc = self._sigleItemPanel:Find("display_panel/desc/Text")
	self._shopPanel = self._window:Find("shop_panel")
	self.goodsIcon = self._shopPanel:Find("item/frame/icon")
	self.goodsName = self._shopPanel:Find("display_panel/name")
	self.goodsDesc = self._shopPanel:Find("display_panel/desc/Text")
	self._resetPanel = self._window:Find("reset_panel")

	setText(self._resetPanel:Find("Text"), i18n("child2_endless_reset_tip"))

	self._resetContent = self._resetPanel:Find("content")
	self._noBtn = self._window:Find("button_container/no")

	setText(self._noBtn:Find("pic"), i18n("word_cancel"))

	self._yesBtn = self._window:Find("button_container/yes")

	setText(self._yesBtn:Find("pic"), i18n("word_ok"))

	self._buyBtn = self._window:Find("button_container/buy")

	setText(self._buyBtn:Find("pic"), i18n("word_ok"))

	return
end

function NewEducateMsgBoxLayer:didEnter()
	self:ShowMsgBox(self.contextData)

	self.isClosing = false

	return
end

function NewEducateMsgBoxLayer:ShowMsgBox(arg_5_1)
	self:commonSetting(arg_5_1)
	self:showByType(arg_5_1)

	return
end

function NewEducateMsgBoxLayer:commonSetting(arg_6_1)
	self.settings = arg_6_1

	local var_6_0 = self.settings.type or NewEducateMsgBoxLayer.TYPE.BOX

	self._window.sizeDelta = var_0_1[var_6_0]

	setText(self._titleText, var_0_2[var_6_0])
	setActive(self._msgPanel, false)
	setActive(self._sigleItemPanel, false)
	setActive(self._shopPanel, false)
	setActive(self._resetPanel, false)

	local var_6_1 = self.settings.hideNo or false
	local var_6_2 = self.settings.hideYes or false
	local var_6_3 = self.settings.hideClose or false
	local var_6_4 = self.settings.onYes or function()
		return
	end
	local var_6_5 = self.settings.onNo or function()
		return
	end
	local var_6_6 = self.settings.onBuy or function()
		return
	end
	local var_6_7 = self.settings.onClose or function()
		return
	end

	setText(self._noBtn:Find("pic"), self.settings.noText or i18n("word_cancel"))
	setText(self._yesBtn:Find("pic"), self.settings.yesText or i18n("word_ok"))
	setActive(self._noBtn, not var_6_1)
	onButton(self, self._noBtn, function()
		if self.isClosing then
			return
		end

		local var_11_0 = self.contextData.onExit

		function self.contextData.onExit()
			existCall(var_6_5)
			existCall(var_11_0)

			return
		end

		self:_close()

		return
	end, SFX_CANCEL)
	setActive(self._yesBtn, not var_6_2)
	onButton(self, self._yesBtn, function()
		if self.isClosing then
			return
		end

		local var_13_0 = self.contextData.onExit

		function self.contextData.onExit()
			existCall(var_6_4)
			existCall(var_13_0)

			return
		end

		self:_close()

		return
	end, SFX_CANCEL)
	setActive(self._buyBtn, self.settings.type == NewEducateMsgBoxLayer.TYPE.SHOP)
	onButton(self, self._buyBtn, function()
		if self.isClosing then
			return
		end

		local var_15_0 = self.contextData.onExit

		function self.contextData.onExit()
			existCall(var_6_6)
			existCall(var_15_0)

			return
		end

		self:_close()

		return
	end, SFX_CANCEL)
	setActive(self._closeBtn, not var_6_3)
	onButton(self, self._closeBtn, function()
		if self.isClosing then
			return
		end

		local var_17_0 = self.contextData.onExit

		function self.contextData.onExit()
			existCall(var_6_7)
			existCall(var_17_0)

			return
		end

		self:_close()

		return
	end, SFX_CANCEL)
	onButton(self, tf(self._go):Find("anim_root/bg"), function()
		if self.isClosing then
			return
		end

		if var_6_1 or var_6_3 then
			return
		end

		local var_19_0 = self.contextData.onExit

		function self.contextData.onExit()
			existCall(var_6_7)
			existCall(var_19_0)

			return
		end

		self:_close()

		return
	end, SFX_CANCEL)

	return
end

function NewEducateMsgBoxLayer:showByType(arg_21_1)
	switch(self.settings.type or NewEducateMsgBoxLayer.TYPE.BOX, {
		[NewEducateMsgBoxLayer.TYPE.BOX] = function()
			self:showNormalMsgBox()

			return
		end,
		[NewEducateMsgBoxLayer.TYPE.ITEM] = function()
			self:showSingleItemBox()

			return
		end,
		[NewEducateMsgBoxLayer.TYPE.SHOP] = function()
			self:showShopBuyBox()

			return
		end,
		[NewEducateMsgBoxLayer.TYPE.RESET] = function()
			self:showResetBox()

			return
		end
	})

	return
end

function NewEducateMsgBoxLayer:showNormalMsgBox()
	setActive(self._msgPanel, true)

	self.contentText.text = self.settings.content or ""

	return
end

function NewEducateMsgBoxLayer:showSingleItemBox()
	setActive(self._sigleItemPanel, true)
	setActive(self._noBtn, false)
	NewEducateHelper.UpdateItem(self.singleItemTF, self.settings.drop)

	local var_27_0 = NewEducateHelper.GetDropConfig(self.settings.drop)

	setText(self.singleItemName, var_27_0.name or "")

	local var_27_1 = getProxy(NewEducateProxy):GetCurChar()

	setText(self.singleItemOwn, i18n("child_msg_owned", (var_27_1:GetOwnCnt(self.settings.drop))))

	if self.settings.drop.type == NewEducateConst.DROP_TYPE.RES and var_27_0.type == NewEducateChar.RES_TYPE.MOOD then
		setText(self.singleItemDesc, string.gsub(var_27_0.desc, "$1", i18n("child2_mood_desc" .. var_27_1:GetMoodStage())))
	else
		setText(self.singleItemDesc, (not var_27_0.desc or nil) and (var_27_0.name or ""))
	end

	return
end

function NewEducateMsgBoxLayer:showShopBuyBox()
	setActive(self._shopPanel, true)
	setActive(self._yesBtn, false)
	setActive(self._buyBtn, true)
	setText(self._buyBtn:Find("price/Text"), self.settings.price)
	LoadImageSpriteAsync("neweducateicon/" .. pg.child2_shop[self.settings.shopId].icon, self.goodsIcon)
	setText(self.goodsName, pg.child2_shop[self.settings.shopId].name)

	if pg.child2_shop[self.settings.shopId].goods_type == NewEducateGoods.TYPE.BENEFIT then
		setText(self.goodsDesc, pg.child2_benefit_list[pg.child2_shop[self.settings.shopId].goods_id].desc)
	else
		setText(self.goodsDesc, pg.child2_shop[self.settings.shopId].desc)
	end

	return
end

function NewEducateMsgBoxLayer:showResetBox()
	setActive(self._resetPanel, true)

	local var_29_0 = getProxy(NewEducateProxy):GetCurChar():GetRoundData()
	local var_29_1 = var_29_0:GetHeighestWave()
	local var_29_2 = var_29_0:GetWave()

	setText(self._resetContent:Find("history"), i18n("child2_endless_history_wave", var_29_1))
	setText(self._resetContent:Find("current"), i18n("child2_endless_current_wave", var_29_2))
	setActive(self._resetContent:Find("current/new"), var_29_1 < var_29_2)

	return
end

function NewEducateMsgBoxLayer:_close()
	self.isClosing = true

	self.anim:Play("anim_educate_MsgBox_out")

	return
end

function NewEducateMsgBoxLayer:onBackPressed()
	if self.settings.hideNo or self.settings.hideClose then
		return
	end

	self:_close()

	return
end

function NewEducateMsgBoxLayer:willExit()
	self.animEvent:SetEndEvent(nil)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.contextData.onExit then
		self.contextData.onExit()
	end

	return
end

return NewEducateMsgBoxLayer
