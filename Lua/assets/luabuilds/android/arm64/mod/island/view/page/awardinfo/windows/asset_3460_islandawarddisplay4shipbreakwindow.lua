local IslandAwardDisplay4ShipBreakWindow = class("IslandAwardDisplay4ShipBreakWindow", import("view.base.BaseSubView"))

function IslandAwardDisplay4ShipBreakWindow:getUIName()
	return "IslandAwardDisplay4ShipBreakUI"
end

function IslandAwardDisplay4ShipBreakWindow:OnLoaded()
	self.title = self._tf:Find("frame/Board/Top/text/text"):GetComponent("Text")
	self.uiNewStart = UIItemList.New(self._tf:Find("frame/bg/starts"), self._tf:Find("frame/bg/starts/tpl"))
	self.oldLevelTxt = self._tf:Find("frame/bg/item/level/Text_1"):GetComponent("Text")
	self.newLevelTxt = self._tf:Find("frame/bg/item/level/Text_2"):GetComponent("Text")
	self.oldEnergyTxt = self._tf:Find("frame/bg/item/energy/Text_1"):GetComponent("Text")
	self.newEnergyTxt = self._tf:Find("frame/bg/item/energy/Text_2"):GetComponent("Text")

	setText(self._tf:Find("frame/bg/item/energy/Text"), i18n("island_ship_level_limit"))
	setText(self._tf:Find("frame/bg/item/level/Text"), i18n("island_ship_energy_limit"))
	setText(self._tf:Find("frame/tip"), i18n("island_click_close"))

	self.frameTr = self._tf:Find("frame")
	self.animator = self.frameTr:GetComponent(typeof(Animation))
	self.aniDft = self.frameTr:GetComponent(typeof(DftAniEvent))

	return
end

function IslandAwardDisplay4ShipBreakWindow:Show(arg_3_1)
	self.title.text = i18n("island_break_finish")

	self:UpdateBreakLevel(arg_3_1.oldShip, arg_3_1.newShip)
	self:UpdateLevel(arg_3_1.oldShip, arg_3_1.newShip)
	self:UpdateEnergy(arg_3_1.oldShip, arg_3_1.newShip)

	return
end

function IslandAwardDisplay4ShipBreakWindow:PlayExitAniamtion(arg_4_1)
	self.aniDft:SetEndEvent(function()
		self.aniDft:SetEndEvent(nil)
		arg_4_1()

		return
	end)
	self.animator:Play("anim_Island_commonget_single_out")

	return
end

function IslandAwardDisplay4ShipBreakWindow:UpdateBreakLevel(arg_6_1, arg_6_2)
	self.uiNewStart:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			setActive(arg_7_2:Find("Image"), arg_7_1 < arg_6_2:GetBreakLevel())
		end

		return
	end)
	self.uiNewStart:align((arg_6_2:GetBreakMaxLevel()))

	return
end

function IslandAwardDisplay4ShipBreakWindow:UpdateLevel(arg_8_1, arg_8_2)
	self.oldLevelTxt.text = "Lv." .. arg_8_1:GetMaxLevel()
	self.newLevelTxt.text = "Lv." .. arg_8_2:GetMaxLevel()

	return
end

function IslandAwardDisplay4ShipBreakWindow:UpdateEnergy(arg_9_1, arg_9_2)
	self.oldEnergyTxt.text = arg_9_1:GetMaxEnergy()
	self.newEnergyTxt.text = arg_9_2:GetMaxEnergy()

	return
end

function IslandAwardDisplay4ShipBreakWindow:OnDestroy()
	self.aniDft:SetEndEvent(nil)

	return
end

return IslandAwardDisplay4ShipBreakWindow
