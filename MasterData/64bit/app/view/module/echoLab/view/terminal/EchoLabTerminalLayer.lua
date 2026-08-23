local EchoLabTerminalLayer = class("EchoLabTerminalLayer", require("app.fairyGUI.echoLab.UI_EchoLabTerminalLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/echoLab/echoLab",
		isFullScreen = true,
		pkgName = "echoLab",
		resName = "EchoLabTerminalLayer"
	}, ...)
end)

function EchoLabTerminalLayer:ctor()
	self:addBg("bg/echoLab/bg_echo_zhongduan.jpg", nil, nil, 1)

	self._isFirstEnter = true

	self.m_eff:addEffectSpine({
		name = "eff_ui_echoLab_layer",
		remove = true,
		isLoop = false
	})
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_SELECTMENU_ACHIEVE)
end

function EchoLabTerminalLayer:onLoad()
	self.m_coreComp:updateMainView()

	if not self._isFirstEnter then
		self.m_backTransition:play()
	end

	self._isFirstEnter = false
end

return EchoLabTerminalLayer
