local MailReDropWindow = class("MailReDropWindow", import("view.base.BaseSubView"))

function MailReDropWindow:getUIName()
	return "MailReDropMsgboxUI"
end

function MailReDropWindow:OnInit()
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.closeBtn = self._tf:Find("adapt/window_redrop/top/btnBack")

	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self._window_redrop = self._tf:Find("adapt/window_redrop")
	self.titleTips = self._window_redrop:Find("top/bg/infomation/title")
	self._itemConfireText = self._window_redrop:Find("content"):GetComponent("RichText")
	self._confireLabel = self._window_redrop:Find("desc/label1")
	self._confireInput = self._window_redrop:Find("desc/InputField")
	self._redroptitleTips = self._window_redrop:Find("top/bg/infomation/title")
	self.PlaceholderText = self._confireInput:Find("Placeholder")
	self._redropcancelButton = self._window_redrop:Find("button_container/btn_not")
	self._redropconfirmButton = self._window_redrop:Find("button_container/btn_ok")
	self.item = self._window_redrop:Find("item")
	self.items = self._window_redrop:Find("items")
	self.itemList = UIItemList.New(self.items, self.item)
	self.imgCache = {}
	self.dropIdCache = {}

	setText(self._redropcancelButton:Find("Text"), i18n("mail_box_cancel"))
	setText(self._redropconfirmButton:Find("Text"), i18n("mail_box_confirm"))
	setText(self.titleTips, i18n("mail_boxtitle_information"))
	setText(self.PlaceholderText, i18n("mail_search"))

	return
end

function MailReDropWindow:Updatelayout()
	if not self.key then
		self.key = math.random(100000, 999999)

		setText(self._confireLabel, i18n("mail_storeroom_max_2", self.key))
	else
		setText(self._confireLabel, "")
	end

	return
end

function MailReDropWindow:showConformMsgBox(arg_6_1)
	local var_6_0 = arg_6_1.dropList

	self:refrshContent(arg_6_1.dropList, arg_6_1.content)

	self.key = nil

	self:Updatelayout()
	onButton(self, self._redropcancelButton, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._redropconfirmButton, function()
		if self.key and self.key ~= tonumber((getInputText(self._confireInput))) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("mail_input_erro"))

			return
		end

		self:Hide()

		if arg_6_1.onYes then
			arg_6_1.onYes()
		end

		return
	end, SFX_PANEL)
	setActive(self.item, false)
	self.itemList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			updateDrop(arg_9_2:Find("IconTpl"), {
				type = var_6_0[arg_9_1 + 1].type,
				id = var_6_0[arg_9_1 + 1].id,
				count = var_6_0[arg_9_1 + 1].count
			})
			setScrollText(arg_9_2:Find("name_bg/name"), var_6_0[arg_9_1 + 1]:getName())
		end

		return
	end)
	self.itemList:align(#arg_6_1.dropList)

	return
end

function MailReDropWindow:refrshContent(arg_10_1, arg_10_2)
	local var_10_0 = 0
	local var_10_1 = ""

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		self.dropIdCache[iter_10_1.id] = self.dropIdCache[iter_10_1.id] or self:GetRestoreNumByTargetId(iter_10_1.id)

		local var_10_2 = self.dropIdCache[iter_10_1.id][1] or 0
		local var_10_3 = self.dropIdCache[iter_10_1.id][2]

		if self.dropIdCache[iter_10_1.id][2] and not self.imgCache[var_10_3] then
			local var_10_4 = Item.getConfigData(var_10_3).icon

			self.imgCache[var_10_3] = var_10_4

			self._itemConfireText:AddSprite(var_10_4, (GetSpriteFromAtlas(var_10_4, "")))
		end

		var_10_1 = self.imgCache[var_10_3]
		var_10_0 = var_10_2 * iter_10_1.count + var_10_0
	end

	self._itemConfireText.text = i18n(arg_10_2, string.format("<icon name=%s w=0.7 h=0.7/>%d", var_10_1, var_10_0))

	return
end

function MailReDropWindow:GetRestoreNumByTargetId(arg_11_1)
	return {
		pg.drop_data_restore[pg.equip_data_limit[arg_11_1].restore_id].resource_num,
		pg.drop_data_restore[pg.equip_data_limit[arg_11_1].restore_id].resource_type
	}
end

function MailReDropWindow:Show(arg_12_1)
	MailReDropWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:showConformMsgBox(arg_12_1)

	return
end

function MailReDropWindow:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	MailReDropWindow.super.Hide(self)
	setInputText(self._confireInput, "")

	return
end

function MailReDropWindow:OnDestroy()
	self.imgCache = nil

	if self:isShowing() then
		self:Hide()
	end

	return
end

return MailReDropWindow
