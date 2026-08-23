local var_0_0 = g.core.const.ConstMgr.SoundConst
local var_0_1 = g.core.sound.SoundManager
local WaitGameChessboardComp = class("WaitGameChessboardComp", require("app.fairyGUI.upgrade.UI_WaitGameChessboardComp"))

function WaitGameChessboardComp:ctor()
	self._comboTrans = self.m_comboLabel:getTransition("combo")
end

function WaitGameChessboardComp:updateWithInfo()
	self.m_containerComp:updateWithInfo()
end

function WaitGameChessboardComp:onStartGame(arg_3_1)
	self.m_containerComp:onStartGame(arg_3_1)
end

function WaitGameChessboardComp:playComboAni(arg_4_1)
	self.m_comboLabel:setTitle(arg_4_1)
	self.m_comboLabel:setVisible(true)
	self._comboTrans:stop()
	self._comboTrans:play(handler(self, self._hideComboLabel))
	var_0_1:playSound(var_0_0.Sound.GEM_ELI_COMBO_TIP)
end

function WaitGameChessboardComp:_hideComboLabel()
	self.m_comboLabel:setVisible(false)
end

function WaitGameChessboardComp:onGameOver()
	self.m_containerComp:onGameOver()
end

return WaitGameChessboardComp
