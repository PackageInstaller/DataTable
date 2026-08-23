local RecruitSuccubaPicLoader = class("RecruitSuccubaPicLoader", require("app.fairyGUI.recruitSuccuba.UI_RecruitSuccubaPicLoader"))

function RecruitSuccubaPicLoader:updateSuccubaReward(arg_1_1)
	self.m_effHolder:removeAllEffect()

	if arg_1_1.type == g.core.common.Goods.TYPE_FRAGMENT then
		self.m_showTypeController:setSelectedIndex(1)
		self.m_succubaIcon:setSuccubaIcon(g.core.common.Path:getSuccubaIconById(arg_1_1.value))
		self.m_effHolder:addEffectSpine({
			anim = "play",
			name = "eff_ui_succubaRecruit_txglow",
			isLoop = true
		})
	else
		self.m_showTypeController:setSelectedIndex(0)
		self:setIcon(arg_1_1.icon)
	end
end

return RecruitSuccubaPicLoader
