local IslandShipSkillMsgboxWindow = class("IslandShipSkillMsgboxWindow", import(".IslandBaseMsgboxWindow"))

function IslandShipSkillMsgboxWindow:getUIName()
	return "IslandCommonMsgBoxForShipSkill"
end

function IslandShipSkillMsgboxWindow:OnLoaded()
	self.closeBtn = self._tf:Find("close")
	self.nameTxt = self._tf:Find("name"):GetComponent(typeof(Text))
	self.levelTxt = self._tf:Find("level"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("content/Text"):GetComponent(typeof(Text))
	self.iconTr = self._tf:Find("icon")

	setText(self._tf:Find("title"), i18n("island_skill_desc"))

	return
end

function IslandShipSkillMsgboxWindow:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandShipSkillMsgboxWindow:OnShow()
	assert(self.settings.skill)

	self.nameTxt.text = self.settings.skill:GetName()
	self.descTxt.text = self.settings.skill:GetEffectDesc()
	self.levelTxt.text = "[Lv." .. self.settings.skill:GetLevel() .. "]"

	GetImageSpriteFromAtlasAsync("island/IslandSkillIcon/" .. self.settings.skill:GetIcon(), "", self.iconTr)

	return
end

function IslandShipSkillMsgboxWindow:OnHide()
	return
end

return IslandShipSkillMsgboxWindow
