local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.allianceTrialData
local var_0_3 = g.core.model.User.allianceData
local AllianceTrialMainLayer = class("AllianceTrialMainLayer", require("app.fairyGUI.allianceTrial.UI_AllianceTrialMainLayer"), function()
	return fgui.GComponent:create({
		resName = "AllianceTrialMainLayer",
		pkgPath = "ui/allianceTrial/allianceTrial",
		isFullScreen = true,
		pkgName = "allianceTrial"
	}, ...)
end)

function AllianceTrialMainLayer:ctor()
	self:initView()
end

function AllianceTrialMainLayer:initView()
	self.m_topBar:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.ALLIANCE_TRIAL)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE_TRIAL)
	self.m_mapComp:loadTiledMap()
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_boxBtn:addClickListener(handler(self, self._onClickBoxBtn))
	self.m_giveBtn:addClickListener(handler(self, self._onClickGiveBtn))
end

function AllianceTrialMainLayer:_onClickRankBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.allianceTrial.view.AllianceTrialRankPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function AllianceTrialMainLayer:_onClickBoxBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.allianceTrial.view.AllianceTrialBoxPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function AllianceTrialMainLayer:_onClickGiveBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.allianceTrial.view.AllianceTrialGivePop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function AllianceTrialMainLayer:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._refreshRoomInfo), self)
	var_0_0:addEventListener(var_0_1.EVENT_GAME_RESUME_FINISH, self._onReconnect, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_ALLIANCE_TRIAL_ENTER, handler(self, self._onGetEnter), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_ALLIANCE_TRIAL_NOTIFYMOVE, self._onS2CAllianceTrialNotifyMove, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_ALLIANCE_TRIAL_CHALLENGEFINISH, self.updateChallengeCount, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_ALLIANCE_TRIAL_CHALLENGEFINISH_SWEEP, self.updateChallengeCount, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_ALLIANCE_TRIAL_UPDATEMONSTER, self.updateMonster, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_ALLIANCE_TRIAL_NOTIFYLEVEL, self.onS2CLevelChange, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_ALLIANCE_TRIAL_UPDATEUSER, self.updateChallengeCount, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_ALLIANCE_TRIAL_NOTIFYEXIT, handler(self, self.notifyExit), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_ALLIANCE_TRIAL_NOTIFYCHALLENGE, handler(self, self.notifyUserChallenge), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_ALLIANCE_TRIAL_MOVE_ERROR, handler(self, self.moveError), self)
	var_0_0:addEventListener(var_0_1.EVENT_LOADING_FINISH, handler(self, self.onCheckWeakGuild), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_USERLIST, self._onGetAllianceUser, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, handler(self, self._onNoticeState), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_RECONNECT, self._exitLayer, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_TIMEOUT, self._exitLayer, self)

	if var_0_3:hasAlliance() then
		if var_0_2:isEnter() then
			self:_onGetEnter()
		else
			g.core.network.GameNetProxy:send_C2S_AllianceTrial_Enter({})
		end
	else
		self:newScheduleOnce(handler(self, self._onNoticeState), 0.1)
	end
end

function AllianceTrialMainLayer:_onNoticeState()
	if not g.core.model.User.allianceData:hasAlliance() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
		g.core.module.ModuleManager:tip(g.core.lang:get(428567))
	end
end

function AllianceTrialMainLayer:_onGetAllianceUser()
	self.m_mapComp:createShamUser()
end

function AllianceTrialMainLayer:_onS2CAllianceTrialNotifyMove(arg_10_1, arg_10_2, arg_10_3)
	self:_refreshRoomInfo()

	if arg_10_3.user.id then
		self.m_mapComp:getMapWorld():playerRouteToCoord(arg_10_3.user.id, arg_10_3.user.pos)
	end
end

function AllianceTrialMainLayer:_onCrossDayUpdate()
	if g.core.common.ServerTime:getWeekDay() == 1 then
		self._isNotifyExit = true

		g.core.module.ModuleManager:tip(g.core.lang:get(430405))
		g.core.module.ModuleManager:popAllPopup()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	else
		self:updateChallengeCount()
	end
end

function AllianceTrialMainLayer:_onReconnect()
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_AllianceTrial_Enter({})
end

function AllianceTrialMainLayer:_refreshRoomInfo()
	self.m_mapComp:syncRoomUserStatus()
	self.m_mapComp:createShamUser()
end

function AllianceTrialMainLayer:updateMonster()
	self.m_mapComp:updateMonster()
	self.m_monsterComp:updateView()
	self.m_topComp:updateTopComp()
end

function AllianceTrialMainLayer:_onGetEnter()
	self:_refreshRoomInfo()
	self.m_mapComp:startWorld()
	self:updateMonster()
	self.m_topComp:updateTopComp()
	self.m_mapComp:createShamUser()
	self:updateChallengeCount()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_boxBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_giveBtn
	})
	self.m_enterTransition:play(handler(self, self.onCheckWeakGuild))
end

function AllianceTrialMainLayer:onCheckWeakGuild()
	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	end, 0.5)
end

function AllianceTrialMainLayer:onCheckWeakGuild()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function AllianceTrialMainLayer:updateChallengeCount()
	self.m_challengeCountComp:setTitle(var_0_2:getLastChallengeCount())
end

function AllianceTrialMainLayer:notifyUserChallenge(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	self.m_mapComp:notifyUserChallenge(arg_20_4.user_id, arg_20_4.monster_id)
end

function AllianceTrialMainLayer:moveError(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	self._isNotifyExit = true

	self:_exitAllianceTrialLayer()
	g.core.module.ModuleManager:tip(g.core.lang:get(430406))
end

function AllianceTrialMainLayer:notifyExit(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if arg_22_4.user_id == g.core.model.User:getId() then
		self._isNotifyExit = true

		g.core.module.ModuleManager:tip(g.core.lang:get(430406))
		self:_exitAllianceTrialLayer()
	else
		self._isNotifyExit = false

		self.m_mapComp:notifyExit(arg_22_4.user_id)
	end
end

function AllianceTrialMainLayer:_exitLayer(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	self._isNotifyExit = true

	self:_exitAllianceTrialLayer()
end

function AllianceTrialMainLayer:onRemoved()
	self.m_mapComp:removeAllSchedule()
	var_0_2:setEnter(false)

	if not self._isNotifyExit and var_0_3:hasAlliance() then
		g.core.network.GameNetProxy:send_C2S_AllianceTrial_Exit({})
	end
end

function AllianceTrialMainLayer:onS2CLevelChange()
	g.core.module.ModuleManager:replaceModuleRoot(g.view.entrance.ALLIANCE_TRIAL)
end

function AllianceTrialMainLayer:receiveCompEvent(arg_26_1, arg_26_2)
	if arg_26_1 == "allianceTrial_click_monster" then
		self.m_mapComp:autoGoToTerminus(arg_26_2.bid)
	end
end

function AllianceTrialMainLayer:_exitAllianceTrialLayer()
	g.core.module.ModuleManager:popAllPopup()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return AllianceTrialMainLayer
