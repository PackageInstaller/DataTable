local KnightInfoExSkillIcon = class("KnightInfoExSkillIcon", require("app.fairyGUI.knight.UI_KnightInfoExSkillIcon"))

function KnightInfoExSkillIcon:updateStarTalentIcon(arg_1_1, arg_1_2)
	self._talentSkillCfg = arg_1_2.talentSkillCfg

	if arg_1_2.isActive then
		self.m_isActiveController:setSelectedIndex(1)
		self:setGrayed(false)
	else
		self.m_isActiveController:setSelectedIndex(0)
		self.m_activeStarTxt:setText(g.core.lang:get(201032, {
			star = arg_1_2.star
		}))
		self:setGrayed(true)
	end

	self.m_skillIcon:updateKnightAdvExIcon(arg_1_1, arg_1_2.talentSkillCfg)
	self.m_skillIcon:setClickCallFunc(handler(self, self.showTalentTip))
end

function KnightInfoExSkillIcon:showTalentTip()
	if self._talentSkillCfg then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.KnightTalentSkillTip").new(self._talentSkillCfg), {
			touchDisappear = true
		})
	end
end

return KnightInfoExSkillIcon
