local TeamBattleBuffSelectPop = class("TeamBattleBuffSelectPop", require("app.fairyGUI.teamBattle.UI_TeamBattleBuffSelectPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleBuffSelectPop",
		pkgName = "teamBattle"
	})
end)

function TeamBattleBuffSelectPop:ctor(arg_2_1)
	self:showAtCenter()

	self._event = arg_2_1
	self._buffIdList = self._event:getEventInfo().buffIdList

	self:_initBtn()
	self:updateView()
end

function TeamBattleBuffSelectPop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SELECTBUFF, self._onRecvSelectBuff, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYSELECTBUFF, self._onRecvSelectBuff, self)
end

function TeamBattleBuffSelectPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EXPLORATION_FORMATION_FIGHT_VALUE_CHECK, false)
end

function TeamBattleBuffSelectPop:_initBtn()
	for iter_5_0 = 1, 3 do
		self["m_cardComp" .. iter_5_0].powerIndex = iter_5_0

		self["m_cardComp" .. iter_5_0]:addClickListener(handler(self, self.onSelectCardClick))
	end
end

function TeamBattleBuffSelectPop:updateView()
	for iter_6_0 = 1, 3 do
		self["m_cardComp" .. iter_6_0]:updateCardInfo(self._buffIdList[iter_6_0].id)
	end
end

function TeamBattleBuffSelectPop:onSelectCardClick(arg_7_1)
	local var_7_0 = arg_7_1:getSender().powerIndex

	if self._buffIdList[var_7_0].id then
		g.core.network.GameNetProxy:send_C2S_TeamBattle_SelectBuff({
			grid_id = self._event:getEventInfo().grid,
			pos = var_7_0
		})
	end
end

function TeamBattleBuffSelectPop:_onRecvSelectBuff(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3 then
		g.core.module.ModuleManager:tip(g.core.lang:get(420667))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

return TeamBattleBuffSelectPop
