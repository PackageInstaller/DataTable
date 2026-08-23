local FogNightmareKeepsakeTipsPop = class("FogNightmareKeepsakeTipsPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareKeepsakeTipsPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareKeepsakeTipsPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareKeepsakeTipsPop:ctor(arg_2_1)
	self:showAtCenter()
	self.m_txt:setText(arg_2_1.txt)
end

function FogNightmareKeepsakeTipsPop:_onCheckBtnClick()
	return
end

return FogNightmareKeepsakeTipsPop
