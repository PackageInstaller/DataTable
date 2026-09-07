local ShipCustomMsgBox = class("ShipCustomMsgBox", import("...base.BaseSubView"))

function ShipCustomMsgBox:getUIName()
	return "ShipCustomMsgBox"
end

function ShipCustomMsgBox:OnInit()
	self.customMsgbox = self._tf
	self.msgBoxItemPanel = self.customMsgbox:Find("frame/bg/item_panel")
	self.msgboxItemContains = self.customMsgbox:Find("frame/bg/item_panel/items")
	self.msgBoxItemTpl = self.msgboxItemContains:Find("equipmenttpl")
	self.msgBoxItemContent = self.customMsgbox:Find("frame/bg/item_panel/content")
	self.msgBoxItemContent1 = self.customMsgbox:Find("frame/bg/item_panel/content_num")
	self.msgBoxCancelBtn = self.customMsgbox:Find("frame/btns/cancel_btn")
	self.msgBoxConfirmBtn = self.customMsgbox:Find("frame/btns/confirm_btn")
	self.msgBoxContent = self.customMsgbox:Find("frame/bg/content")
	self.msgBtnBack = self.customMsgbox:Find("frame/top/btnBack")
	self.msgBoxTitle = self.customMsgbox:Find("frame/top/title_list/infomation/title")
	self.msgBoxTitleEn = self.customMsgbox:Find("frame/top/title_list/infomation/title_en")

	SetActive(self.customMsgbox, false)

	self.settings = {}

	onButton(self, self.msgBoxConfirmBtn, function()
		if self.settings.onYes then
			self.settings.onYes()
		else
			self:hideCustomMsgBox()
		end

		return
	end, SFX_PANEL)
	SetActive(self.msgBoxCancelBtn, not defaultValue(self.settings.hideNO, false))
	onButton(self, self.msgBoxCancelBtn, function()
		if self.settings.onCancel then
			self.settings.onCancel()
		else
			self:hideCustomMsgBox()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.customMsgbox, function()
		self:hideCustomMsgBox()

		return
	end, SFX_PANEL)
	onButton(self, self.msgBtnBack, function()
		self:hideCustomMsgBox()

		return
	end, SFX_CANCEL)

	return
end

function ShipCustomMsgBox:SetShareData(arg_7_1)
	self.shareData = arg_7_1

	return
end

function ShipCustomMsgBox:showCustomMsgBox(arg_8_1)
	self.isShowCustomMsgBox = true
	self.settings = arg_8_1

	setActive(self.customMsgbox, true)
	pg.UIMgr.GetInstance():OverlayPanel(self.customMsgbox)

	local var_8_0 = arg_8_1.items and #arg_8_1.items > 0

	setActive(self.msgBoxItemPanel, var_8_0)
	setActive(self.msgBoxContent, not var_8_0)

	if var_8_0 then
		local var_8_1 = arg_8_1.items

		for iter_8_0 = self.msgboxItemContains.childCount + 1, #arg_8_1.items do
			cloneTplTo(self.msgBoxItemTpl, self.msgboxItemContains)
		end

		for iter_8_1 = 1, self.msgboxItemContains.childCount do
			local var_8_2 = self.msgboxItemContains:GetChild(iter_8_1 - 1)

			SetActive(var_8_2, iter_8_1 <= #var_8_1)

			if iter_8_1 <= #var_8_1 then
				local var_8_3 = var_8_1[iter_8_1]

				updateDrop(var_8_2, var_8_1[iter_8_1])

				local var_8_4 = 0

				if var_8_3.type == DROP_TYPE_RESOURCE then
					var_8_4 = self.shareData.player:getResById(var_8_3.id)
				elseif var_8_3.type == DROP_TYPE_ITEM then
					var_8_4 = getProxy(BagProxy):getItemCountById(var_8_3.id)
				end

				var_8_4 = var_8_4 < var_8_3.count and "<color=#D6341DFF>" .. var_8_4 .. "</color>" or "<color=#A9F548FF>" .. var_8_4 .. "</color>"

				setText(var_8_2:Find("icon_bg/count"), var_8_4 .. "/" .. var_8_3.count)
			end
		end

		setText(self.msgBoxItemContent, arg_8_1.content or "")
		setText(self.msgBoxItemContent1, arg_8_1.content1 or "")
	else
		setText(self.msgBoxContent, (not arg_8_1.content or nil) and "")
	end

	if arg_8_1.title then
		setText(self.msgBoxTitle, arg_8_1.title.title)
		setText(self.msgBoxTitleEn, arg_8_1.title.titleEn or "")
	end

	return
end

function ShipCustomMsgBox:hideCustomMsgBox()
	self.isShowCustomMsgBox = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self.customMsgbox, self._tf)
	SetActive(self.customMsgbox, false)

	return
end

function ShipCustomMsgBox:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.customMsgbox, self._tf)

	self.shareData = nil

	return
end

return ShipCustomMsgBox
