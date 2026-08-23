local TeamBattleInvitePlayerPop = require("app.view.module.teamBattle.view.teamUp.TeamBattleInvitePlayerPop")
local TeamBattleTeamLayer = class("TeamBattleTeamLayer", require("app.fairyGUI.teamBattle.UI_TeamBattleTeamLayer"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleTeamLayer",
		pkgPath = "ui/teamBattle/teamBattle",
		isFullScreen = true,
		pkgName = "teamBattle"
	}, ...)
end)

function TeamBattleTeamLayer:ctor(arg_2_1)
	self:addBg("bg/teamBattle/bg_hjtj_buzhen.jpg")

	self._popHome = false
	self._teamData = nil
	self._timer = nil

	self:_initView()

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end
end

function TeamBattleTeamLayer:_initView()
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.TEAM_BATTLE)
	self.m_checkOpenBtn:addClickListener(handler(self, self._onSetRoomState))
	self.m_exitBtn:addClickListener(handler(self, self._onClickLeaveTeam))
	self.m_inviteBtn:addClickListener(handler(self, self._onClickInviteBtn))
	self.m_formationBtn:addClickListener(handler(self, self._onClickFormationBtn))
	self.m_startBtn:addClickListener(handler(self, self._onClickStartBtn))
end

function TeamBattleTeamLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_TEAMINFO, handler(self, self.onS2CTeamBattleTeamInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SETTEAM, handler(self, self.onS2CTeamBattleSetTeam), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_LEAVETEAM, handler(self, self.onS2CTeamBattleLeaveTeam), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_KICKOUT, handler(self, self.onS2CTeamBattleKickOut), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_KICKNOTICE, handler(self, self.onS2CTeamBattleKickNotice), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_UPDATETEAM, handler(self, self.onS2CTeamBattleUpdateTeam), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.onS2CGetUserSnapShot, self)
	g.core.network.GameNetProxy:send_C2S_TeamBattle_TeamInfo({})
	self:_startTimer()
end

function TeamBattleTeamLayer:onUnload()
	self:_stopTimer()
end

function TeamBattleTeamLayer:_startTimer()
	self._timer = self._timer or self:newSchedule(handler(self, self._updateTime, 1))
end

function TeamBattleTeamLayer:_stopTimer()
	if self._timer then
		self:cancelSchedule(self._timer)
	end

	self._timer = nil
end

function TeamBattleTeamLayer:_onUpdateView()
	self.m_checkOpenBtn:setTouchable((g.core.model.User.teamBattleData:getTeamUpData():isLeader()))
	self.m_checkOpenBtn:setSelected(self._teamData.open)
	self.m_teamNameTxt:setText(self._teamData.name)

	local var_8_0 = {}

	var_8_0.level = self._teamData.level_limit or 1

	self.m_condTxt:setText(g.core.lang:get(427007, var_8_0))
	self:_updatePlayerComp()
	self:_updateTime()

	if self._teamData.ready then
		self.m_isReadyController:setSelectedIndex(1)
	else
		self.m_isReadyController:setSelectedIndex(0)
	end
end

function TeamBattleTeamLayer:_onCrossDayUpdate()
	local var_9_0 = g.core.model.User.teamBattleData:getCurStage()

	if var_9_0 == g.core.const.ConstMgr.TeamBattleConst.ACTIVITY_STATE.RESULT then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.TEAM_BATTLE_RESULT_LAYER)
	elseif var_9_0 == g.core.const.ConstMgr.TeamBattleConst.ACTIVITY_STATE.NOT_OPEN then
		g.core.module.ModuleManager:tip(g.core.lang:get(420691))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function TeamBattleTeamLayer:_updatePlayerComp()
	for iter_10_0 = 1, 3 do
		self["m_playerBgComp" .. iter_10_0]:updateComp((self._teamData.members[iter_10_0] or nil) and self._teamData.snapShotDic[self._teamData.members[iter_10_0]])
		self["m_playerBgComp" .. iter_10_0]:setReady(self._teamData.ready)
	end
end

function TeamBattleTeamLayer:_updateTime()
	local var_11_0 = g.core.model.User.teamBattleData:getActivityTimeInfo()

	if g.core.common.ServerTime:getTime() < var_11_0.startTime then
		self.m_timeTxt:setText(g.core.lang:get(427008, {
			time = g.core.common.ServerTime:getLeftDHMSFormat(var_11_0.startTime)
		}))
		self.m_isTimeMatchController:setSelectedIndex(0)
	else
		self.m_timeTxt:setText("")
		self:_stopTimer()
		self.m_isTimeMatchController:setSelectedIndex(1)
	end
end

function TeamBattleTeamLayer:_tickOutPlayer(arg_12_1)
	g.core.network.GameNetProxy:send_C2S_TeamBattle_KickOut({
		member_id = arg_12_1
	})
end

function TeamBattleTeamLayer:_showLeaveTeamTip()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(302032),
		desc = g.core.lang:get(427123),
		onConfirm = handler(self, function(arg_14_0)
			g.core.network.GameNetProxy:send_C2S_TeamBattle_LeaveTeam({})
		end)
	}))
end

function TeamBattleTeamLayer:_onClickLeaveTeam()
	self._popHome = false

	self:_showLeaveTeamTip()
end

function TeamBattleTeamLayer:_onClickOutAndGoHome()
	self._popHome = true

	self:_showLeaveTeamTip()
end

function TeamBattleTeamLayer:_onClickInviteBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.teamBattle.view.teamUp.TeamBattleInvitePlayerPop").new(true), {
		touchDisappear = true
	})
end

function TeamBattleTeamLayer:_onClickFormationBtn()
	local var_18_0 = require("app.view.module.teamBattle.view.formation.guard.TeamBattleGuardPoolPop").new(true)

	g.core.module.ModuleManager:pushModule({
		package = "teamBattle",
		modType = g.view.entrance.POPUP,
		create = function()
			return var_18_0
		end
	})
end

function TeamBattleTeamLayer:_onClickStartBtn()
	if #self._teamData.members < 3 and not self._teamData.ready then
		local var_20_0 = g.core.lang:get(427121) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_20_0,
			onConfirm = handler(self, self._showGuardPoolPop)
		}), {
			touchDisappear = true
		})
	else
		self:_showGuardPoolPop()
	end
end

function TeamBattleTeamLayer:_showGuardPoolPop()
	local var_21_0 = require("app.view.module.teamBattle.view.formation.guard.TeamBattleGuardPoolPop").new()

	g.core.module.ModuleManager:pushModule({
		package = "teamBattle",
		modType = g.view.entrance.POPUP,
		create = function()
			return var_21_0
		end
	})
end

function TeamBattleTeamLayer:_onSetRoomState(arg_23_1)
	if not g.core.model.User.teamBattleData:getTeamUpData():isLeader() then
		g.core.module.ModuleManager:tip(g.core.lang:get(427009))

		return
	end

	local var_23_0 = arg_23_1:getSender()

	g.core.network.GameNetProxy:send_C2S_TeamBattle_SetTeam({
		open = var_23_0:isSelected()
	})
end

function TeamBattleTeamLayer:receiveCompEvent(arg_24_1, arg_24_2)
	if arg_24_1 == "invitePlayer" then
		g.core.module.ModuleManager:pushPopup(TeamBattleInvitePlayerPop.new(arg_24_2), {
			touchDisappear = true
		})

		return true
	elseif arg_24_1 == "tickOutPlayer" then
		self:_tickOutPlayer(arg_24_2.uid)

		return true
	end
end

function TeamBattleTeamLayer:onS2CGetUserSnapShot(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = g.core.model.User.teamBattleData:getTeamUpData()

	self._teamData = var_25_0:getMyTeam()

	if var_25_0:checkTeamMemberSnapShot(self._teamData) then
		self:_onUpdateView()
	end
end

function TeamBattleTeamLayer:onS2CTeamBattleTeamInfo(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	self._teamData = g.core.model.User.teamBattleData:getTeamUpData():getMyTeam()

	if not self._teamData then
		g.core.module.ModuleManager:popComponent()
	else
		self:onS2CGetUserSnapShot(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	end
end

function TeamBattleTeamLayer:onS2CTeamBattleSetTeam(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	return
end

function TeamBattleTeamLayer:onS2CTeamBattleLeaveTeam(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	self:_onLeaveTeamLayer()
end

function TeamBattleTeamLayer:_onLeaveTeamLayer()
	if self._popHome then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	else
		g.core.module.ModuleManager:popToRoot()
	end
end

function TeamBattleTeamLayer:onS2CTeamBattleKickOut(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	self:_updatePlayerComp()
end

function TeamBattleTeamLayer:onS2CTeamBattleKickNotice(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	self._popHome = false

	self:_onLeaveTeamLayer()
	g.core.module.ModuleManager:tip(g.core.lang:get(427010))
end

function TeamBattleTeamLayer:onS2CTeamBattleUpdateTeam(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	local var_32_0 = g.core.model.User.teamBattleData:getTeamUpData()

	self._teamData = var_32_0:getMyTeam()

	if var_32_0:checkTeamMemberSnapShot(self._teamData) then
		self:_onUpdateView()
	end
end

function TeamBattleTeamLayer:onS2CTeamBattleEnter(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	return
end

return TeamBattleTeamLayer
