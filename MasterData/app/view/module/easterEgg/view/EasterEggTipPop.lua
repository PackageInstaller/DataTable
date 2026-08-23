local EasterEggTipPop = class("EasterEggTipPop", require("app.fairyGUI.easterEgg.UI_EasterEggTipPop"), function()
	return fgui.GComponent:create({
		resName = "EasterEggTipPop",
		pkgPath = "ui/easterEgg/easterEgg",
		pkgName = "easterEgg"
	}, ...)
end)

function EasterEggTipPop:ctor(arg_2_1)
	self:showAtCenter()
	self:init(arg_2_1)
end

function EasterEggTipPop:init(arg_3_1)
	self._closeCallBack = arg_3_1.callBack

	self.m_enterTransition:play()
	self.m_enterTransition:setHook("pop", handler(self, self._onDelayClose))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.EASTER_EGG_FIND_EXPLORE)
end

function EasterEggTipPop:_onDelayClose()
	if self._isClose then
		return
	end

	self._isClose = true
	self._closeCallBack = nil

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._closeCallBack then
		self._closeCallBack()
	end
end

function EasterEggTipPop:onUnload()
	if not self._isClose then
		if self._closeCallBack then
			self._closeCallBack()
		end
	end

	self._isClose = true
end

return EasterEggTipPop
