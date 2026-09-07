local SharedIslandScene = class("SharedIslandScene", import("..View.base.IslandBaseScene"))

function SharedIslandScene:getUIName()
	return "SharedIslandUI"
end

function SharedIslandScene:GetIsland()
	return getProxy(IslandProxy):GetSharedIsland()
end

function SharedIslandScene:init()
	self.levelTxt = self._tf:Find("top/level_panel/level"):GetComponent(typeof(Text))
	self.expTr = self._tf:Find("top/level_panel/exp")
	self.nameTxt = self._tf:Find("top/level_panel/name"):GetComponent(typeof(Text))
	self.prosperityTxt = self._tf:Find("top/level_panel/prosperity/Text"):GetComponent(typeof(Text))
	self.prosperityLabel = self._tf:Find("top/level_panel/prosperity"):GetComponent(typeof(Text))
	self.mapBtn = self._tf:Find("top/map_btn")
	self.leaveBtn = self._tf:Find("top/leave_btn")

	setText(self.leaveBtn:Find("Text"), i18n("island_leave"))

	return
end

function SharedIslandScene:didEnter()
	onButton(self, self._tf:Find("top/level_panel"), function()
		self:OpenPage(SharedIslandOtherCardPage, self:GetIsland().id)

		return
	end, SFX_PANEL)
	onButton(self, self.mapBtn, function()
		self:OpenPage(SharedIslandMapPage)

		return
	end, SFX_PANEL)
	onButton(self, self.leaveBtn, function()
		self:emit(SharedIslandMediator.RETURN_SELF_ISLAND)

		return
	end, SFX_PANEL)
	self:StartCore()
	self:UpdateIslandInfo()

	return
end

function SharedIslandScene:OnOpenAnimatonOpPage()
	setActive(self.homeBtn, false)
	setActive(self.mapBtn, false)
	setActive(self.leaveBtn, false)

	return
end

function SharedIslandScene:OnCloseAnimatonOpPage()
	setActive(self.homeBtn, true)
	setActive(self.mapBtn, true)
	setActive(self.leaveBtn, true)

	return
end

function SharedIslandScene:UpdateIslandInfo()
	local var_10_0 = self:GetIsland()

	self.levelTxt.text = var_10_0:GetLevel()
	self.nameTxt.text = var_10_0:GetName()

	if var_10_0:IsMaxLevel() then
		setFillAmount(self.expTr, 1)
	else
		setFillAmount(self.expTr, var_10_0:GetExp() / var_10_0:GetTargeExp())
	end

	self.prosperityTxt.text = var_10_0:CanAddProsperity() and var_10_0:GetProsperity() .. "/" .. var_10_0:GetTargetProsperity() or "MAX"
	self.prosperityLabel.text = i18n("island_prosperity_level")

	return
end

function SharedIslandScene:willExit()
	return
end

function SharedIslandScene:onBackPressed()
	self:emit(SharedIslandScene.ON_BACK_PRESSED)

	return
end

return SharedIslandScene
