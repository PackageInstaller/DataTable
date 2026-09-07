local MonopolyCar2024TotalRewardPanel = class("MonopolyCar2024TotalRewardPanel", import("view.base.BaseSubView"))

function MonopolyCar2024TotalRewardPanel:getUIName()
	return "TotalRewardPanelForMonopoly"
end

function MonopolyCar2024TotalRewardPanel:OnLoaded()
	self.uiItemList = UIItemList.New(self._tf:Find("Window/Layout/Box/ScrollView/Content/ItemGrid2"), self._tf:Find("Window/Layout/Box/ScrollView/Content/ItemGrid2/GridItem"))
	self.confirmBtn = self._tf:Find("Window/Fixed/ButtonGO")
	self.closeBtn = self._tf:Find("BG")

	setText(self._tf:Find("Window/Fixed/top/bg/obtain/title"), i18n("MonopolyCar2024Game_total_award_title"))
	setText(self._tf:Find("Window/Fixed/ButtonGO/pic"), i18n("text_confirm"))

	return
end

function MonopolyCar2024TotalRewardPanel:OnInit()
	onButton(self, self.confirmBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function MonopolyCar2024TotalRewardPanel:Show(arg_6_1)
	MonopolyCar2024TotalRewardPanel.super.Show(self)
	self.uiItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_7_2, arg_6_1[arg_7_1 + 1])
		end

		return
	end)
	self.uiItemList:align(#arg_6_1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function MonopolyCar2024TotalRewardPanel:Hide()
	MonopolyCar2024TotalRewardPanel.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.parentTF)

	return
end

function MonopolyCar2024TotalRewardPanel:UpdateItem(arg_9_1, arg_9_2)
	updateDrop(arg_9_1:Find("Icon"), arg_9_2)

	return
end

function MonopolyCar2024TotalRewardPanel:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return MonopolyCar2024TotalRewardPanel
