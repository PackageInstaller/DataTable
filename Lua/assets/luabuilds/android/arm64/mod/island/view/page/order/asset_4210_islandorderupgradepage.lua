local IslandOrderUpgradePage = class("IslandOrderUpgradePage", import("view.base.BaseSubView"))

function IslandOrderUpgradePage:getUIName()
	return "IslandOrderUpgradeUI"
end

function IslandOrderUpgradePage:OnLoaded()
	self.levelTxt = self._tf:Find("level"):GetComponent(typeof(Text))
	self.nextLevelTxt = self._tf:Find("next_level"):GetComponent(typeof(Text))

	return
end

function IslandOrderUpgradePage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandOrderUpgradePage:Show(arg_5_1, arg_5_2)
	IslandOrderUpgradePage.super.Show(self)

	self.levelTxt.text = arg_5_1 - 1
	self.nextLevelTxt.text = arg_5_1
	self.callback = arg_5_2

	return
end

function IslandOrderUpgradePage:Hide()
	IslandOrderUpgradePage.super.Hide(self)

	if self.callback then
		self.callback()

		self.callback = nil
	end

	return
end

function IslandOrderUpgradePage:OnDestroy()
	return
end

return IslandOrderUpgradePage
