local AncientsBattleLayer = class("AncientsBattleLayer", require("app.fairyGUI.ancients.UI_AncientsBattleLayer"), function()
	return fgui.GComponent:create({
		resName = "AncientsBattleLayer",
		pkgPath = "ui/ancients/ancients",
		isFullScreen = true,
		pkgName = "ancients"
	}, ...)
end)

function var_0_0:ctor(arg_2_1)
	self:addBg("bg/ancients/bg_jxmy_zdchangj.jpg", false, nil, 1)
	self.m_effDi:addEffectSpine({
		anim = "play",
		name = "eff_ui_ancients_battlebglight",
		remove = false,
		isLoop = true
	})
	self.m_effLine:addEffectSpine({
		anim = "three",
		name = "eff_ui_ancients_battlebgline",
		remove = false,
		isLoop = true
	})

	self._isFinalBattle = arg_2_1.isFinalBattle
	self._report = arg_2_1.report or {}

	if self._isFinalBattle then
		self._atkTeam = self._report.atk_team or {}
		self._defTeam = self._report.def_team or {}
		self._turns = self._report.turns
	else
		self._atkTeam = arg_2_1.atkTeam
		self._defTeam = arg_2_1.defTeam
		self._turns = arg_2_1.turns
	end

	self:_updateView()
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_BATTLETURNNOTIFY, handler(self, self._onRcvBattleTurnNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_BATTLEENDNOTIFY, handler(self, self._onRcvBattleEndNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetCommonSimpleUserSnapshot), self)
end

function var_0_0.receiveCompEvent(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "ANCIENTS_BATTLE_NEXT_TURN" then
		-- block empty
	end
end

function var_0_0:_updateView()
	if self._isFinalBattle then
		-- block empty
	end

	self.m_Comp_battle:updateView({
		isFinalBattle = self._isFinalBattle,
		atkTeam = self._atkTeam,
		defTeam = self._defTeam,
		turns = self._turns
	})
end

function var_0_0:_onRcvBattleTurnNotify(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._turns = arg_6_4.turns

	self.m_Comp_battle:onTurnNotify(arg_6_4.turns)
end

function var_0_0:_onRcvBattleEndNotify(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self.m_Comp_battle:onBattleEndNotify(handler(self, function()
		self:_openResultPop(arg_7_4)
	end))
end

function var_0_0:_onGetCommonSimpleUserSnapshot(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self.m_Comp_battle:updateUsersBaseInfo()
end

function var_0_0._openResultPop(arg_10_0, arg_10_1)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_BATTLE_RESULT_POP, arg_10_1)
end

return var_0_0
