local FogNightmareExploreBlessPop = class("FogNightmareExploreBlessPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreBlessPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareExploreBlessPop",
		pkgName = "fogNightmare",
		pkgPath = "ui/fogNightmare/fogNightmare"
	}, ...)
end)

function FogNightmareExploreBlessPop:ctor(arg_2_1)
	self:showAtCenter()

	self._descTip = arg_2_1.desc

	self.m_descText:setText(self._descTip)

	if arg_2_1.title then
		self.m_title:setText(arg_2_1.title)
	end

	self:playEffAnim()
end

function FogNightmareExploreBlessPop:playEffAnim()
	self.m_enterTransition:play()
	self.m_effPopTitle:addEffectSpine({
		isLoop = false,
		anim = "play",
		name = "eff_ui_FogNightmare_popTitle"
	})
	self.m_effPopbg:addEffectSpine({
		isLoop = false,
		anim = "play",
		name = "eff_ui_FogNightmare_popbg"
	})
end

function FogNightmareExploreBlessPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
end

return FogNightmareExploreBlessPop
