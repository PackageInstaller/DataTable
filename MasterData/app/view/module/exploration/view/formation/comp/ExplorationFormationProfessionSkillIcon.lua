local KnightSkillDescTip = require("app.view.module.tip.view.KnightSkillDescTip")
local ExplorationFormationProfessionSkillIcon = class("ExplorationFormationProfessionSkillIcon", require("app.fairyGUI.exploration.UI_ExplorationFormationProfessionSkillIcon"))

function ExplorationFormationProfessionSkillIcon:ctor()
	self._id = 0

	self:addClickListener(handler(self, self._onClickSkillIcon))
	self.m_eff:addEffectSpine({
		remove = false,
		name = "eff_ui_exploration_hongdi",
		isLoop = true
	})
end

function ExplorationFormationProfessionSkillIcon:setPassiveId(arg_2_1)
	self._id = arg_2_1
end

function ExplorationFormationProfessionSkillIcon:_onClickSkillIcon()
	if self._id > 0 then
		g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new({
			isPassive = true,
			isForceStyle = true,
			skillId = self._id
		}), {
			touchDisappear = true
		})
	end
end

return ExplorationFormationProfessionSkillIcon
