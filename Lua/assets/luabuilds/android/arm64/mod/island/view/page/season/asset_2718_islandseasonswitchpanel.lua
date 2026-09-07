local IslandSeasonSwitchPanel = class("IslandSeasonSwitchPanel", import("view.base.BaseSubView"))

function IslandSeasonSwitchPanel:getUIName()
	return "IslandSeasonSwitchPanel"
end

function IslandSeasonSwitchPanel:OnLoaded()
	self.frame = self._tf:Find("frame")
	self.uiList = UIItemList.New(self._tf:Find("frame/filter_panel/list/content"), self._tf:Find("frame/filter_panel/list/content/tpl"))
	self.selectorPanel = self._tf:Find("frame/filter_panel")
	self.fliterBtn = self._tf:Find("frame/filter")
	self.filterTxt = self.fliterBtn:Find("Text"):GetComponent(typeof(Text))

	return
end

function IslandSeasonSwitchPanel:OnInit()
	onButton(self, self.fliterBtn, function()
		self.isOpen = not self.isOpen

		self:UpdateSelector()

		return
	end, SFX_PANEL)
	self.uiList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			self:UpdateItem(arg_5_1, arg_5_2)
		end

		return
	end)

	return
end

function IslandSeasonSwitchPanel:Show(arg_6_1, arg_6_2)
	IslandSeasonSwitchPanel.super.Show(self)

	self.callback = arg_6_2
	self.isOpen = false

	self:UpdateSelector()

	self.filterTxt.text = pg.island_season[arg_6_1].name_short

	return
end

function IslandSeasonSwitchPanel:UpdateSelector()
	if self.isOpen then
		self.uiList:align(IslandSeasonAgency.GetCurrentSeason() - 1 or 0)
	end

	setActive(self.selectorPanel, self.isOpen)

	return
end

function IslandSeasonSwitchPanel:Hide()
	IslandSeasonSwitchPanel.super.Hide(self)

	if self.isOpen then
		self.isOpen = false

		self:UpdateSelector()
	end

	return
end

function IslandSeasonSwitchPanel:UpdateItem(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1 + 1
	local var_9_1 = pg.island_season[arg_9_1 + 1].name_short

	setText(arg_9_2, pg.island_season[arg_9_1 + 1].name_short)
	onButton(self, arg_9_2, function()
		self.filterTxt.text = var_9_1

		if self.callback then
			self.callback(var_9_0)
		end

		return
	end, SFX_PANEL)

	return
end

return IslandSeasonSwitchPanel
