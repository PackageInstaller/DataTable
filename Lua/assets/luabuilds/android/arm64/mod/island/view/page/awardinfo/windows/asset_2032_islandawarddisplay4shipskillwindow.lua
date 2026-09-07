local IslandAwardDisplay4ShipSkillWindow = class("IslandAwardDisplay4ShipSkillWindow", import(".IslandAwardDisplayWindow"))

function IslandAwardDisplay4ShipSkillWindow:getUIName()
	return "IslandAwardDisplayForShipSkillUI"
end

function IslandAwardDisplay4ShipSkillWindow:OnLoaded()
	IslandAwardDisplay4ShipSkillWindow.super.OnLoaded(self)

	self.nameTxt = self._tf:Find("frame/bg/item/name"):GetComponent(typeof(Text))
	self.levelTxt = self._tf:Find("frame/bg/item/level"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("frame/bg/item/desc"):GetComponent(typeof(Text))
	self.iconTr = self._tf:Find("frame/bg/item/icon")
	self.uiNewStart = UIItemList.New(self._tf:Find("frame/bg/starts"), self._tf:Find("frame/bg/starts/tpl"))

	return
end

function IslandAwardDisplay4ShipSkillWindow:Show(arg_3_1)
	arg_3_1.awards = {}

	IslandAwardDisplay4ShipSkillWindow.super.Show(self, arg_3_1)

	self.title.text = i18n("island_unlock_skill")
	self.nameTxt.text = arg_3_1.skill:GetName()
	self.levelTxt.text = "[Lv." .. arg_3_1.skill:GetLevel() .. "]"
	self.descTxt.text = arg_3_1.skill:GetEffectDesc()

	GetImageSpriteFromAtlasAsync("island/IslandSkillIcon/" .. arg_3_1.skill:GetIcon(), "", self.iconTr)
	self:UpdateBreakLevel(arg_3_1.ship)

	return
end

function IslandAwardDisplay4ShipSkillWindow:UpdateBreakLevel(arg_4_1)
	self.uiNewStart:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			setActive(arg_5_2:Find("Image"), arg_5_1 < arg_4_1:GetBreakLevel())
		end

		return
	end)
	self.uiNewStart:align((arg_4_1:GetBreakMaxLevel()))

	return
end

function IslandAwardDisplay4ShipSkillWindow:OnDestroy()
	return
end

return IslandAwardDisplay4ShipSkillWindow
