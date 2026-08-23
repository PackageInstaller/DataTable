local TeamBattleRedPacketRainCountDownPop = class("TeamBattleRedPacketRainCountDownPop", require("app.fairyGUI.teamBattle.UI_TeamBattleRedPacketRainCountDownPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleRedPacketRainCountDownPop",
		pkgName = "teamBattle",
		pkgPath = "ui/teamBattle/teamBattle"
	}, ...)
end)

function TeamBattleRedPacketRainCountDownPop:ctor(arg_2_1)
	self:showAtCenter()

	self._countDownTime = 3

	self:setTouchable(false)
	self:init(arg_2_1)
end

function TeamBattleRedPacketRainCountDownPop:init(arg_3_1)
	self._closeCallBack = arg_3_1.callBack

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Count_Down)
	self.m_countDownTransition:play(handler(self, self._onDelayClose))
end

function TeamBattleRedPacketRainCountDownPop:_onDelayClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._closeCallBack then
		self._closeCallBack()
	end
end

function TeamBattleRedPacketRainCountDownPop:onCancelCallback()
	return
end

return TeamBattleRedPacketRainCountDownPop
