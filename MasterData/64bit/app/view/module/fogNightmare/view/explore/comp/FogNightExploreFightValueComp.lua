local FogNightExploreFightValueComp = class("FogNightExploreFightValueComp", require("app.fairyGUI.fogNightmare.UI_FogNightExploreFightValueComp"))

function FogNightExploreFightValueComp:ctor()
	return
end

function FogNightExploreFightValueComp:updateView(arg_2_1, arg_2_2)
	self.m_fightValuePreText:setText(g.core.lang:get(500278, {
		seq = arg_2_1
	}))

	if arg_2_1 == 1 then
		self.m_line:setVisible(false)
	end

	if arg_2_2 > 0 then
		self.m_powerNumText:setText(arg_2_2)
	else
		self.m_powerNumText:setText(g.core.lang:get(500279))
	end
end

return FogNightExploreFightValueComp
