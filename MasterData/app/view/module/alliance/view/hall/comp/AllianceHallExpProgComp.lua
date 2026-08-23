local var_0_0 = g.core.model.User.allianceData
local AllianceHallExpProgComp = class("AllianceHallExpProgComp", require("app.fairyGUI.alliance.UI_AllianceHallExpProgComp"))

function AllianceHallExpProgComp:ctor()
	return
end

function AllianceHallExpProgComp:updateExp()
	local var_2_0 = var_0_0:getNextGuildAllianceInfo()
	local var_2_1 = var_0_0:getAllianceExp()
	local var_2_2

	if var_2_0 then
		var_2_2 = var_2_0.cost_size or var_2_1
	end

	self.m_progBar:setPercent({
		tween = false,
		dur = 0.4,
		cur = var_2_1,
		max = var_2_2
	})
	self.m_progTxt:setText(var_2_1 .. "/" .. (var_2_0 and var_2_2 or "--"))
end

return AllianceHallExpProgComp
