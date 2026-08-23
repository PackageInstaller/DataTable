local FogNightmareAbandonComp = class("FogNightmareAbandonComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareAbandonComp"))

function FogNightmareAbandonComp:ctor()
	return
end

function FogNightmareAbandonComp:updateView(arg_2_1, arg_2_2)
	if arg_2_1 > 0 then
		arg_2_1 = arg_2_1 - 1
	end

	self.m_curNumText:setText(arg_2_1)
	self.m_maxNumText:setText(arg_2_2)
end

return FogNightmareAbandonComp
