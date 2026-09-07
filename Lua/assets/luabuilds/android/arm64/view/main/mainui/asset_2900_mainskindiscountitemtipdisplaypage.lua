local MainSkinDiscountItemTipDisplayPage = class("MainSkinDiscountItemTipDisplayPage", import("view.base.BaseSubView"))

function MainSkinDiscountItemTipDisplayPage:getUIName()
	return "MainSkinDiscountItemTipUI"
end

function MainSkinDiscountItemTipDisplayPage:OnLoaded()
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.cancelBtn = self._tf:Find("window/btn_cancel")
	self.goBtn = self._tf:Find("window/btn_go")
	self.helpBtn = self._tf:Find("window/btn_help")
	self.remindBtn = self._tf:Find("window/stopRemind")
	self.uiItemList = UIItemList.New(self._tf:Find("window/item_panel/scrollview/list"), self._tf:Find("window/item_panel/scrollview/list/tpl"))

	setText(self._tf:Find("window/item_panel/label/Text"), i18n("skin_discount_item_expired_tip"))
	setText(self._tf:Find("window/stopRemind/Label"), i18n("skin_discount_item_repeat_remind_label"))

	return
end

function MainSkinDiscountItemTipDisplayPage:OnInit()
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.skin_discount_item_notice.tip
		})

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
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE)
		self:Destroy()

		return
	end, SFX_PANEL)
	onToggle(self, self.remindBtn, function(arg_8_0)
		if arg_8_0 then
			self:MarkRemind()
		else
			self:UnMarkRemind()
		end

		return
	end, SFX_PANEL)
	triggerToggle(self.remindBtn, true)

	return
end

function MainSkinDiscountItemTipDisplayPage:MarkRemind()
	PlayerPrefs.SetString("SkinDiscountItemTip" .. getProxy(PlayerProxy):getRawData().id, GetZeroTime() + 1)
	PlayerPrefs.Save()

	return
end

function MainSkinDiscountItemTipDisplayPage:UnMarkRemind()
	PlayerPrefs.DeleteKey("SkinDiscountItemTip" .. getProxy(PlayerProxy):getRawData().id)
	PlayerPrefs.Save()

	return
end

function MainSkinDiscountItemTipDisplayPage:Show(arg_11_1)
	self:UpdateList(arg_11_1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function MainSkinDiscountItemTipDisplayPage:UpdateList(arg_12_1)
	self.uiItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_12_1[arg_13_1 + 1], arg_13_2)
		end

		return
	end)
	self.uiItemList:align(#arg_12_1)

	return
end

function MainSkinDiscountItemTipDisplayPage:UpdateItem(arg_14_1, arg_14_2)
	local var_14_0 = Drop.Create({
		DROP_TYPE_ITEM,
		arg_14_1.id,
		arg_14_1.count
	})

	updateDrop(arg_14_2, var_14_0)
	setScrollText(arg_14_2:Find("name_bg/Text"), var_14_0:getName())
	onButton(self, arg_14_2, function()
		pg.m02:sendNotification(NewMainMediator.ON_DROP, var_14_0)

		return
	end, SFX_PANEL)

	return
end

function MainSkinDiscountItemTipDisplayPage:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance()._normalUIMain)

	return
end

return MainSkinDiscountItemTipDisplayPage
