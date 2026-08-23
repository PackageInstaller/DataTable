local var_0_0 = g.core.const.ConstMgr.PeakArenaConst.UserMatchState
local var_0_1 = {
	DEFEAT = 2,
	NO_START = 0,
	VICTORY = 1
}
local PAPeakStageLineComp = class("PAPeakStageLineComp", require("app.fairyGUI.peakArena.UI_PAPeakStageLineComp"))

function PAPeakStageLineComp:ctor()
	self._connectLine = false

	self:updateComp(var_0_0.EMPTY)
end

function PAPeakStageLineComp:setConnectLine(arg_2_1)
	self._connectLine = arg_2_1
end

function PAPeakStageLineComp:updateComp(arg_3_1)
	local var_3_0 = self._connectLine and ((arg_3_1 == var_0_0.EMPTY or arg_3_1 == var_0_0.WAITING_GAME_BEGIN) and var_0_1.NO_START or var_0_1.VICTORY) or arg_3_1 == var_0_0.VICTORY and var_0_1.VICTORY or arg_3_1 == var_0_0.DEFEAT and var_0_1.DEFEAT or var_0_1.NO_START

	if self.m_stateController:getSelectedIndex() ~= var_3_0 then
		self.m_stateController:setSelectedIndex(var_3_0)
	end
end

return PAPeakStageLineComp
