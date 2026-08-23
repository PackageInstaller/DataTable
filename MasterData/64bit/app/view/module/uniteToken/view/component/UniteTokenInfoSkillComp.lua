local UniteTokenInfoSkillComp = class("UniteTokenInfoSkillComp", require("app.fairyGUI.uniteToken.UI_UniteTokenInfoSkillComp"))

function UniteTokenInfoSkillComp:ctor()
	self._skillData = nil

	self.m_skillIcon:addClickListener(handler(self, self._onSkillClick))
end

function UniteTokenInfoSkillComp:updateSkillComp(arg_2_1)
	self._isSkill = true
	self._skillData = arg_2_1

	self.m_skillIcon:updateIcon(arg_2_1)
	self.m_skillNameTxt:setText(arg_2_1.cfg.curtain_name)
	self.m_descComp:setTitle(arg_2_1.desc)
end

function UniteTokenInfoSkillComp:updatePassiveSkillComp(arg_3_1, arg_3_2)
	self._isPassive = true
	self._skillData = arg_3_1
	self._tokenData = arg_3_2

	self.m_skillIcon:updateIcon(arg_3_1)
	self.m_skillNameTxt:setText(arg_3_1.passiveCfg.name)
	self.m_descComp:setTitle(arg_3_1.desc)
end

function UniteTokenInfoSkillComp:_onSkillClick()
	if self._skillData then
		if self._isSkill then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.UniteTokenSkillPop").new(self._skillData), {
				touchDisappear = true
			})
		elseif self._isPassive then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.UniteTokenPassiveSkillPop").new({
				skillData = self._skillData,
				tokenData = self._tokenData
			}), {
				touchDisappear = true
			})
		end
	end
end

return UniteTokenInfoSkillComp
