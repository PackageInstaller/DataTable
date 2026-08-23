local TeamBattleDartCountDownPop = class("TeamBattleDartCountDownPop", require("app.fairyGUI.teamBattle.UI_TeamBattleDartCountDownPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleDartCountDownPop",
		pkgPath = "ui/teamBattle/teamBattle",
		pkgName = "teamBattle"
	}, ...)
end)

function TeamBattleDartCountDownPop:ctor(arg_2_1)
	self:showAtCenter()

	self._countDownTime = 3

	self:setTouchable(false)
	self:init(arg_2_1)
end

function TeamBattleDartCountDownPop:init(arg_3_1)
	self._closeCallBack = arg_3_1.callBack

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Count_Down)
	self.m_countDownTransition:play(handler(self, self._onDelayClose))
end

function TeamBattleDartCountDownPop:_onDelayClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._closeCallBack then
		self._closeCallBack()
	end
end

function TeamBattleDartCountDownPop:onCancelCallback()
	return
end

return TeamBattleDartCountDownPop
