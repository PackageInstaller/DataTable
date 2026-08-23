local TeamBattleLogPop = class("TeamBattleLogPop", require("app.fairyGUI.teamBattle.UI_TeamBattleLogPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleLogPop",
		pkgPath = "ui/teamBattle/teamBattle",
		pkgName = "teamBattle"
	})
end)

function TeamBattleLogPop:ctor()
	self:showAtCenter()
	self.m_logList:setVirtual()
	self.m_logList:setItemRenderer(handler(self, self._onRenderTeamBattleLogList))
	self.m_closePnl:addClickListener(handler(self, self._closeLogPop))
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		remove = true,
		name = "eff_ui_teamBattle_popBg",
		anim = "play_rizhi",
		isLoop = false
	})
	g.core.model.User.dayNotifyTool:saveTodayRecord(require("app.view.common.const.DayNotifyToolConst").TYPE_TEAM_BATTLE_LOG_RED_TIP)
end

function TeamBattleLogPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_GETLOG, handler(self, self._onGetTeamBattleLog), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateTeamBattleLogUser), self)
	g.core.network.GameNetProxy:send_C2S_TeamBattle_GetLog({})
end

function TeamBattleLogPop:_onGetTeamBattleLog(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self._logList = arg_4_4.logs

	if self._logList and #self._logList > 0 then
		self._logLen = #self._logList

		self.m_logList:setNumItems(self._logLen)
		self.m_emptyController:setSelectedIndex(0)
	else
		self.m_emptyController:setSelectedIndex(1)
	end
end

function TeamBattleLogPop:_onRenderTeamBattleLogList(arg_5_1, arg_5_2)
	arg_5_2:updateLogShow(self._logList[self._logLen - arg_5_1])
end

function TeamBattleLogPop:_updateTeamBattleLogUser()
	if self._logList and next(self._logList) then
		self._logLen = #self._logList

		self.m_logList:setNumItems(#self._logList)
	end
end

function TeamBattleLogPop:_closeLogPop()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return TeamBattleLogPop
