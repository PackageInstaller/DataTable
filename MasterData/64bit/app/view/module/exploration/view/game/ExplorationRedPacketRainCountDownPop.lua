local RedPacketRainCountDownPop = class("RedPacketRainCountDownPop", require("app.fairyGUI.exploration.UI_ExplorationRedPacketRainCountDownPop"), function()
	return fgui.GComponent:create({
		resName = "ExplorationRedPacketRainCountDownPop",
		pkgPath = "ui/exploration/exploration",
		pkgName = "exploration"
	}, ...)
end)

function RedPacketRainCountDownPop:ctor(arg_2_1)
	self:showAtCenter()

	self._countDownTime = 3

	self:setTouchable(false)
	self:init(arg_2_1)
end

function RedPacketRainCountDownPop:init(arg_3_1)
	self._closeCallBack = arg_3_1.callBack

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Count_Down)
	self.m_countDownTransition:play(handler(self, self._onDelayClose))
end

function RedPacketRainCountDownPop:_onDelayClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._closeCallBack then
		self._closeCallBack()
	end
end

function RedPacketRainCountDownPop:onCancelCallback()
	return
end

return RedPacketRainCountDownPop
