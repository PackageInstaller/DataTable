local RechargeLimitComp = class("RechargeLimitComp", require("app.fairyGUI.recharge.UI_RechargeLimitComp"))

function RechargeLimitComp:ctor()
	self:setTouchable(false)
end

function RechargeLimitComp:addEffect()
	self.m_effHolder:removeAllEffect()
	self.m_effHolder:addEffectSpine({
		anim = "play_handbook",
		name = "eff_ui_recharge_limitmarkcn",
		isLoop = true
	})
end

return RechargeLimitComp
