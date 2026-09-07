local IslandShowCardLabelBox = class("IslandShowCardLabelBox", import("view.base.BaseSubView"))

function IslandShowCardLabelBox:getUIName()
	return "IslandShowCardLabelBox"
end

function IslandShowCardLabelBox:OnLoaded()
	setText(self._tf:Find("frame/title"), i18n("island_card_label_list"))

	self.closeBtn = self._tf:Find("frame/close")
	self.emptyTF = self._tf:Find("empty")

	setText(self.emptyTF, i18n("island_card_no_label_tip"))

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

function IslandShowCardLabelBox:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.cards = {}

	return
end

function IslandShowCardLabelBox:OnInitItem(arg_7_1)
	self.cards[arg_7_1] = IslandCardShowLabelCard.New(arg_7_1)

	return
end

function IslandShowCardLabelBox:OnUpdateItem(arg_8_1, arg_8_2)
	local var_8_0 = self.cards[arg_8_2]

	if not self.cards[arg_8_2] then
		self:OnInitItem(arg_8_2)

		var_8_0 = self.cards[arg_8_2]
	end

	local var_8_1 = self.labelList[arg_8_1 + 1]

	if self.labelList[arg_8_1 + 1] then
		var_8_0:Update(var_8_1.id, var_8_1.num)
	end

	return
end

function IslandShowCardLabelBox:Show(arg_9_1)
	IslandShowCardLabelBox.super.Show(self)

	self.labelList = arg_9_1

	self.scrollRect:SetTotalCount(#self.labelList, -1)
	setActive(self.emptyTF, #self.labelList == 0)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function IslandShowCardLabelBox:Hide()
	IslandShowCardLabelBox.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandShowCardLabelBox:OnDestroy()
	ClearLScrollrect(self.scrollRect)

	for iter_11_0, iter_11_1 in pairs(self.cards) do
		iter_11_1:Dispose()
	end

	self.cards = {}

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

return IslandShowCardLabelBox
