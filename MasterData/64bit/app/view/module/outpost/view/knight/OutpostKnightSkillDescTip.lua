local OutpostKnightSkillDescTip = class("OutpostKnightSkillDescTip", require("app.fairyGUI.outpost.UI_OutpostKnightSkillDescTip"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostKnightSkillDescTip",
		pkgName = "outpost",
		isFullScreen = false
	}, ...)
end)

function OutpostKnightSkillDescTip:ctor(arg_2_1)
	self._knight = arg_2_1.knight
	self._skill = arg_2_1.skill
	self._isPassive = arg_2_1.isPassive

	self:showAtCenter()
	self:updateSkillShow()
end

function OutpostKnightSkillDescTip:updateSkillShow()
	self.m_bgPanel:setTitle((self._isPassive or nil) and (self._skill.name or self._skill.curtain_name))
	self.m_descComp:updateSkillDesc(self._knight, self._skill, self._isPassive)
end

return OutpostKnightSkillDescTip
