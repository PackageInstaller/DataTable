local AppreciateUnlockMsgBox = class("AppreciateUnlockMsgBox", import("..base.BaseSubView"))

function AppreciateUnlockMsgBox:getUIName()
	return "AppreciateUnlockMsgBox"
end

function AppreciateUnlockMsgBox:OnInit()
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

function AppreciateUnlockMsgBox:showCustomMsgBox(arg_7_1)
	self.isShowCustomMsgBox = true
	self.settings = arg_7_1

	setActive(self.customMsgbox, true)
	pg.UIMgr.GetInstance():OverlayPanel(self.customMsgbox)

	local var_7_0 = arg_7_1.items and #arg_7_1.items > 0

	setActive(self.msgBoxItemPanel, var_7_0)
	setActive(self.msgBoxContent, not var_7_0)

	local var_7_1 = getProxy(PlayerProxy):getData()

	if var_7_0 then
		local var_7_2 = arg_7_1.items

		for iter_7_0 = self.msgboxItemContains.childCount + 1, #arg_7_1.items do
			cloneTplTo(self.msgBoxItemTpl, self.msgboxItemContains)
		end

		for iter_7_1 = 1, self.msgboxItemContains.childCount do
			local var_7_3 = self.msgboxItemContains:GetChild(iter_7_1 - 1)

			SetActive(var_7_3, iter_7_1 <= #var_7_2)

			if iter_7_1 <= #var_7_2 then
				local var_7_4 = var_7_2[iter_7_1]

				updateDrop(var_7_3, var_7_2[iter_7_1])

				local var_7_5 = 0

				if var_7_4.type == DROP_TYPE_RESOURCE then
					var_7_5 = var_7_1:getResById(var_7_4.id)
				elseif var_7_4.type == DROP_TYPE_ITEM then
					var_7_5 = getProxy(BagProxy):getItemCountById(var_7_4.id)
				end

				setText(var_7_3:Find("icon_bg/count"), var_7_5 .. "/" .. ((var_7_5 < var_7_4.count or nil) and ("<color=#D6341DFF>" .. var_7_4.count .. "</color>" or "<color=#A9F548FF>" .. var_7_4.count .. "</color>")))
			end
		end

		setText(self.msgBoxItemContent, arg_7_1.content or "")
		setText(self.msgBoxItemContent1, arg_7_1.content1 or "")
	else
		setText(self.msgBoxContent, (not arg_7_1.content or nil) and "")
	end

	return
end

function AppreciateUnlockMsgBox:hideCustomMsgBox()
	self.isShowCustomMsgBox = nil

	SetActive(self.customMsgbox, false)
	self:Destroy()

	return
end

function AppreciateUnlockMsgBox:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.customMsgbox, self._tf)

	return
end

return AppreciateUnlockMsgBox
