local FogNightmareExploreBlessPop = class("FogNightmareExploreBlessPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreBlessPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareExploreBlessPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		pkgName = "fogNightmare"
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
		anim = "play",
		name = "eff_ui_FogNightmare_popTitle",
		isLoop = false
	})
	self.m_effPopbg:addEffectSpine({
		anim = "play",
		name = "eff_ui_FogNightmare_popbg",
		isLoop = false
	})
end

function FogNightmareExploreBlessPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
end

return FogNightmareExploreBlessPop
