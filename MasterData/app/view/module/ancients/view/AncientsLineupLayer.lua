local AncientsLineupLayer = class("AncientsLineupLayer", require("app.fairyGUI.ancients.UI_AncientsLineupLayer"), function()
	return fgui.GComponent:create({
		resName = "AncientsLineupLayer",
		pkgPath = "ui/ancients/ancients",
		isFullScreen = true,
		pkgName = "ancients"
	}, ...)
end)
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self:addBg("bg/ancients/bg_jxmy_bzsmchangj.jpg", false, nil, 1)
	self.m_effDi:addEffectSpine({
		anim = "play",
		name = "eff_ui_ancients_battlebgbuzhen",
		remove = false,
		isLoop = true
	})
	self.m_effPetUp:addEffectSpine({
		anim = "up",
		name = "eff_ui_ancients_petglowbattlebz",
		isLoop = true
	})
	self.m_effPetDown:addEffectSpine({
		anim = "down",
		name = "eff_ui_ancients_petglowbattlebz",
		isLoop = true
	})
	self.m_Btn_lineup:addClickListener(handler(self, self._onClickBtnLineup))
	self.m_Comp_top_bar:setResInfoById(var_0_2.TopBarId)
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_FORMATIONNOTIFY, handler(self, self._onRcvFormationNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_MATCH, handler(self, self._onRcvMatch), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_BATTLESTART, handler(self, self._onRcvBattleStart), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_FINALFORMATIONNOTIFY, handler(self, self._onRcvFinalFormationNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_FINALMATCH, handler(self, self._onRcvFinalMatch), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RET_ERROR, handler(self, self._onRetError), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetCommonSimpleUserSnapshot), self)

	if not g.core.model.User.ancientsData:isFinalState() and self.m_lineup_stateController:getSelectedIndex() == 0 then
		g.core.network.GameNetProxy:send_C2S_Ancient_OperateStart({})
	end

	if g.core.model.User.ancientsData:isFinalState() then
		g.core.network.GameNetProxy:send_C2S_Ancient_FinalMatch({})
	end

	self:_updateView()
	self.m_enterTransition:play()
end

function var_0_0:onUnload()
	if not g.core.model.User.ancientsData:isFinalState() and self.m_lineup_stateController:getSelectedIndex() == 0 then
		g.core.network.GameNetProxy:send_C2S_Ancient_OperateEnd({})
	end
end

function var_0_0._onClickHome(arg_5_0)
	if g.core.model.User.ancientsData:getTeamOperateState(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM) == var_0_2.ANCIENT_OPERATE_STATUS.MATCH_FORMATION then
		g.core.module.ModuleManager:tip(g.core.lang:get(433308))

		return
	end

	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function var_0_0:_onClickBack()
	if g.core.model.User.ancientsData:getTeamOperateState(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM) == var_0_2.ANCIENT_OPERATE_STATUS.MATCH_FORMATION then
		g.core.module.ModuleManager:tip(g.core.lang:get(433308))

		return
	end

	self.m_Comp_top_bar:checkFullPageExitAnim()
end

function var_0_0.receiveCompEvent(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == "ANCIENTS_LINEUP_MATCH_EXIT" then
		g.core.module.ModuleManager:tip(g.core.lang:get(433312))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.ANCIENTS_MAIN_LAYER)
	elseif arg_7_1 == "ANCIENTS_LINEUP_CLICK_MATCH" then
		g.core.network.GameNetProxy:send_C2S_Ancient_Match({})
	elseif arg_7_1 == "ANCIENTS_LINEUP_CLICK_FIGHT" then
		g.core.network.GameNetProxy:send_C2S_Ancient_BattleStart({})
	end
end

function var_0_0:_updateView()
	local var_8_0 = g.core.model.User.ancientsData

	self.m_Comp_drag:updateView()
	self.m_Comp_pet:updateView()

	if var_8_0:isFinalState() then
		self.m_lineup_stateController:setSelectedIndex(1)
	else
		self.m_lineup_stateController:setSelectedIndex(0)
		self.m_Comp_match:updateView()
	end

	if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot((var_8_0:getTeamUserIds(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM))) then
		self.m_Comp_drag:updateUsersBaseInfo()
	end
end

function var_0_0._onClickBtnLineup(arg_9_0)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_FORMATION_LAYER, {
		formationType = g.core.const.ConstMgr.LineUpConst.MulTeamType.ANCIENTS
	})
end

function var_0_0:_onRcvFormationNotify(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self.m_Comp_drag:updateCompUsersFormationPos()
end

function var_0_0._onRcvMatch(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_LINEUP_MATCH_SUCC_POP)
end

function var_0_0._onRcvBattleStart(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	g.core.model.User.ancientsData:setOldAwardExp()
	g.core.module.ModuleManager:replaceModule(g.view.entrance.ANCIENTS_BATTLE_LAYER, {
		atkTeam = g.core.model.User.ancientsData:getTeam(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM),
		defTeam = g.core.model.User.ancientsData:getTeam(var_0_2.GET_TEAM_TYPE.ENEMY_TEAM)
	})
end

function var_0_0:_onRcvFinalFormationNotify(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self.m_Comp_drag:updateCompUsersFormationPos()
end

function var_0_0:_onRcvFinalMatch(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self.m_Comp_fight:updateView()
end

function var_0_0:_onRetError(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if arg_15_4 == g.core.network.proto.MSG_S2C_Ancient_Formation or arg_15_4 == g.core.network.proto.MSG_S2C_Ancient_FinalFormation then
		self.m_Comp_drag:updateCompUsersFormationPos()
	end
end

function var_0_0:_onGetCommonSimpleUserSnapshot(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	self.m_Comp_drag:updateUsersBaseInfo()
end

return var_0_0
