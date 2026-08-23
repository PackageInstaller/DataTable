local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveData()
local GveQuitComp = class("GveQuitComp", require("app.fairyGUI.gve.UI_GveQuitComp"))

function GveQuitComp:ctor()
	var_0_1 = var_0_0:getGveData()
end

function GveQuitComp:updateQuitComp(arg_2_1, arg_2_2)
	self.m_timeTxt:setText(math.max(0, (var_0_1:getGiveUpTime(arg_2_1, arg_2_2) or 0) - g.core.common.ServerTime:getTime()))
	self.m_effQuit:removeAllEffect()

	local var_2_0 = self.m_stateController:getSelectedIndex()

	if var_2_0 == 0 then
		self.m_effQuit:addEffectSpine({
			anim = "play2",
			name = "eff_ui_gve_quitA",
			isLoop = true
		})
	elseif var_2_0 == 1 then
		self.m_effQuit:addEffectSpine({
			anim = "play",
			name = "eff_ui_gve_quitB",
			isLoop = true
		})
	elseif var_2_0 == 2 then
		self.m_effQuit:addEffectSpine({
			anim = "play2",
			name = "eff_ui_gve_quitB",
			isLoop = true
		})
	elseif var_2_0 == 3 then
		self.m_effQuit:addEffectSpine({
			anim = "play",
			name = "eff_ui_gve_quitA",
			isLoop = true
		})
	end
end

function GveQuitComp:setType(arg_3_1)
	self.m_stateController:setSelectedIndex(arg_3_1 - 1)
end

return GveQuitComp
