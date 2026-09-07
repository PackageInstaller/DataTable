local IslandBookAwardListBox = class("IslandBookAwardListBox", import("view.base.BaseSubView"))

function IslandBookAwardListBox:getUIName()
	return "IslandBookAwardListBox"
end

function IslandBookAwardListBox:OnLoaded()
	self.titleTxt = self._tf:Find("title"):GetComponent(typeof(Text))
	self.titleTxt.text = i18n("island_book_award_title")
	self.closeBtn = self._tf:Find("close")

	setActive(self._tf:Find("tpl"), false)

	self.scrollRect = self._tf:Find("scrollrect"):GetComponent("LScrollRect")

	function self.scrollRect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function IslandBookAwardListBox:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandBookAwardListBox:OnInitItem(arg_7_1)
	return
end

function IslandBookAwardListBox:OnUpdateItem(arg_8_1, arg_8_2)
	local var_8_0 = Drop.Create(pg.island_collection_reward[self.ids[arg_8_1 + 1]].award_display)

	updateCustomDrop(arg_8_2.transform:Find("drop"), var_8_0, {
		style = "island"
	})
	onButton(self, arg_8_2.transform, function()
		self.contextData:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_8_0
		})

		return
	end)
	setText(arg_8_2.transform:Find("level"), string.format("%02d", pg.island_collection_reward[self.ids[arg_8_1 + 1]].level))
	setText(arg_8_2.transform:Find("desc"), pg.island_collection_reward[self.ids[arg_8_1 + 1]].describe)

	local var_8_1 = table.contains(self.gotIds, self.ids[arg_8_1 + 1])

	setActive(arg_8_2.transform:Find("drop/got"), var_8_1)
	setGray(arg_8_2.transform, not var_8_1, true)

	return
end

function IslandBookAwardListBox:Show()
	IslandBookAwardListBox.super.Show(self)

	local var_10_0 = getProxy(IslandProxy):GetIsland():GetBookAgency()

	self.ids = var_10_0:GetPointAwardIds(self.contextData.type)
	self.gotIds = var_10_0:GetPointAwardGotIds(self.contextData.type)

	self.scrollRect:SetTotalCount(#self.ids, -1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function IslandBookAwardListBox:Hide()
	IslandBookAwardListBox.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandBookAwardListBox:OnDestroy()
	self:Hide()
	ClearLScrollrect(self.scrollRect)

	return
end

return IslandBookAwardListBox
