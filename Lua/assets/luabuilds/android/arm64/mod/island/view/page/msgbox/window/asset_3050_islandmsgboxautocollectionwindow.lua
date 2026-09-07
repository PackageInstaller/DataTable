local IslandMsgBoxAutoCollectionWindow = class("IslandMsgBoxAutoCollectionWindow", import(".IslandBaseMsgboxWindow"))

function IslandMsgBoxAutoCollectionWindow:getUIName()
	return "IslandAutomaticCollectionMsgBox"
end

function IslandMsgBoxAutoCollectionWindow:OnLoaded()
	self.confirmBtn = self._tf:Find("container/btns/confirm")
	self.cancelBtn = self._tf:Find("container/btns/cancel")
	self.closeBtn = self._tf:Find("container/close")
	self.cancelTxt = self._tf:Find("container/btns/cancel/Text"):GetComponent(typeof(Text))
	self.confirmTxt = self._tf:Find("container/btns/confirm/Text"):GetComponent(typeof(Text))
	self.cancelTxt.text = i18n("word_cancel")
	self.confirmTxt.text = i18n("word_ok")

	setText(self.uigatherText, i18n("island_chara_gather_tag_1"))
	setText(self.uimineText, i18n("island_chara_gather_tag_2"))

	self.titleTxt = self._tf:Find("container/title"):GetComponent(typeof(Text))
	self.titleTxt.text = i18n("island_msg_info")

	return
end

function IslandMsgBoxAutoCollectionWindow:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.uigather, function()
		self.selectTypeDic[IslandAutoCollectHelper.SelectType.Gather] = not (self.selectTypeDic[IslandAutoCollectHelper.SelectType.Gather] or false)

		setActive(self.uigatherselected, not (self.selectTypeDic[IslandAutoCollectHelper.SelectType.Gather] or false))

		return
	end, SFX_PANEL)
	onButton(self, self.uimine, function()
		self.selectTypeDic[IslandAutoCollectHelper.SelectType.HandCollection] = not (self.selectTypeDic[IslandAutoCollectHelper.SelectType.HandCollection] or false)

		setActive(self.uimineselected, not (self.selectTypeDic[IslandAutoCollectHelper.SelectType.HandCollection] or false))

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		local var_9_0 = IslandAutoCollectHelper.SelectType.None

		if self.selectTypeDic[IslandAutoCollectHelper.SelectType.Gather] and self.selectTypeDic[IslandAutoCollectHelper.SelectType.HandCollection] then
			var_9_0 = IslandAutoCollectHelper.SelectType.Both
		elseif self.selectTypeDic[IslandAutoCollectHelper.SelectType.Gather] then
			var_9_0 = IslandAutoCollectHelper.SelectType.Gather
		elseif self.selectTypeDic[IslandAutoCollectHelper.SelectType.HandCollection] then
			var_9_0 = IslandAutoCollectHelper.SelectType.HandCollection
		end

		self.onYes(var_9_0, function()
			self:Hide()

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function IslandMsgBoxAutoCollectionWindow:OnShow()
	self.onYes = self.settings.onYes
	self.onNo = self.settings.onNo
	self.onHide = self.settings.onHide
	self.selectTypeDic = {}

	setActive(self.uigatherselected, false)
	setActive(self.uimineselected, false)

	return
end

function IslandMsgBoxAutoCollectionWindow:OnHide()
	self.onYes = nil
	self.onNo = nil

	if self.onHide then
		self.onHide()

		self.onHide = nil
	end

	return
end

return IslandMsgBoxAutoCollectionWindow
