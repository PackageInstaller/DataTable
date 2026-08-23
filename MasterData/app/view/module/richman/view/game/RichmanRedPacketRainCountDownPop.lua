local RichmanRedPacketRainCountDownPop = class("RichmanRedPacketRainCountDownPop", require("app.fairyGUI.richman.UI_RichmanRedPacketRainCountDownPop"), function()
	return fgui.GComponent:create({
		resName = "RichmanRedPacketRainCountDownPop",
		pkgPath = "ui/richman/richman",
		pkgName = "richman"
	}, ...)
end)

function RichmanRedPacketRainCountDownPop:ctor(arg_2_1)
	self:showAtCenter()

	self._countDownTime = 3

	self:setTouchable(false)
	self:init(arg_2_1)
end

function RichmanRedPacketRainCountDownPop:init(arg_3_1)
	self._closeCallBack = arg_3_1.callBack

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Count_Down)
	self.m_countDownTransition:play(handler(self, self._onDelayClose))
end

function RichmanRedPacketRainCountDownPop:_onDelayClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._closeCallBack then
		self._closeCallBack()
	end
end

function RichmanRedPacketRainCountDownPop:onCancelCallback()
	return
end

return RichmanRedPacketRainCountDownPop
