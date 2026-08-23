local var_0_0 = g.core.const.ConstMgr.SoundConst
local var_0_1 = g.core.sound.SoundManager
local GEChessboardComp = class("GEChessboardComp", require("app.fairyGUI.summerThemeGame.UI_GEChessboardComp"))

function GEChessboardComp:ctor()
	self._comboTrans = self.m_comboLabel:getTransition("combo")
	self._themeValue = 0
end

function GEChessboardComp:updateWithInfo(arg_2_1, arg_2_2)
	self._themeValue = arg_2_2

	self.m_containerComp:updateWithInfo(arg_2_1, arg_2_2)
end

function GEChessboardComp:onStartGame(arg_3_1)
	self.m_containerComp:onStartGame(arg_3_1)
end

function GEChessboardComp:playComboAni(arg_4_1)
	self.m_comboLabel:setTitle(arg_4_1)
	self.m_comboLabel:setVisible(true)
	self._comboTrans:stop()
	self._comboTrans:play(handler(self, self._hideComboLabel))
	var_0_1:playSound(var_0_0.Sound.GEM_ELI_COMBO_TIP)
end

function GEChessboardComp:_hideComboLabel()
	self.m_comboLabel:setVisible(false)
end

function GEChessboardComp:onGameOver()
	self.m_containerComp:onGameOver()
end

return GEChessboardComp
