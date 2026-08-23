local var_0_0 = g.core.model.User.knightsData
local GveInstituteKnightComp = class("GveInstituteKnightComp", require("app.fairyGUI.gve.UI_GveInstituteKnightComp"))

function GveInstituteKnightComp:updateByKnightAdvId(arg_1_1)
	local var_1_0 = var_0_0:getKnightByAdvanceId(arg_1_1)

	if var_1_0:isOwn() then
		self.m_hasController:setSelectedIndex(0)
	else
		self.m_hasController:setSelectedIndex(1)
	end

	self.m_knightIcon:updateIcon({
		struct = var_1_0
	})
	self.m_knightIcon:hideAdvanceShow()
end

function GveInstituteKnightComp:playSelectEff()
	self.m_effSelect:addEffectSpine({
		anim = "play",
		remove = true,
		name = "eff_ui_gveII_select",
		isLoop = false
	})
	self.m_selectTransition:play()
end

return GveInstituteKnightComp
