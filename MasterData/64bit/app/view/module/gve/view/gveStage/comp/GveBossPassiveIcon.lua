local var_0_0 = g.core.config.passive_skill_info
local KnightSkillDescTip = require("app.view.module.tip.view.KnightSkillDescTip")
local GveBossPassiveIcon = class("GveBossPassiveIcon", require("app.fairyGUI.gve.UI_GveBossPassiveIcon"))

function GveBossPassiveIcon:ctor()
	self:addClickListener(handler(self, self._onTouchClick))
end

function GveBossPassiveIcon:updateIconById(arg_2_1)
	self._cfg = var_0_0.get(arg_2_1)

	self.m_skillIcon:setURL(g.core.common.Path:getSkillIconById(g.core.config.skill_info.get(arg_2_1).icon))

	self._skill = {
		isForceStyle = true,
		skillId = arg_2_1
	}
end

function GveBossPassiveIcon:_onTouchClick()
	if not self._skill then
		return
	end

	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new(self._skill), {
		touchDisappear = true
	})
end

return GveBossPassiveIcon
