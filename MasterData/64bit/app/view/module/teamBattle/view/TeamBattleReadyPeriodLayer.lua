local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.config.team_battle_text_info
local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleReadyPeriodLayer = class("TeamBattleReadyPeriodLayer", require("app.fairyGUI.teamBattle.UI_TeamBattleReadyPeriodLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/teamBattle/teamBattle",
		resName = "TeamBattleReadyPeriodLayer",
		pkgName = "teamBattle",
		isFullScreen = true
	}, ...)
end)

function TeamBattleReadyPeriodLayer:ctor()
	self._regisId = 1
	self._signupEndTime = 0
	self._regisLen = var_0_1.getLength()

	self:addBg("bg/teamBattle/bg_hjtj_zhunbeiqi.jpg", false, nil, 1)
	self:_initRegisterUI()
	self.m_enterTransition:play()

	self._timer = nil

	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_BATTLE)
end

function TeamBattleReadyPeriodLayer:_initRegisterUI()
	self.m_preBtn:addClickListener(handler(self, self._onClickPreBtn))
	self.m_nextBtn:addClickListener(handler(self, self._onClickNextBtn))
	self.m_joinBtn:addClickListener(handler(self, self._onClickJoinRoomBtn))
	self.m_createBtn:addClickListener(handler(self, self._onClickCreateRoomBtn))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function TeamBattleReadyPeriodLayer:_onTouchBegin(arg_4_1)
	arg_4_1:captureTouch()

	self._startPosX = arg_4_1:getInput():getTouch():getLocationInView().x
end

function TeamBattleReadyPeriodLayer:_onTouchEnd(arg_5_1)
	if not self._startPosX then
		return
	end

	local var_5_0 = arg_5_1:getInput():getPosition().x - self._startPosX

	if 300 < var_5_0 then
		self:_onClickPreBtn()
	elseif var_5_0 < -300 then
		self:_onClickNextBtn()
	end
end

function TeamBattleReadyPeriodLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_TEAMINFO, handler(self, self.onS2CTeamBattleTeamInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self:_updatePreViewComp()

	if g.core.model.User.teamBattleData:getCurStage() == TeamBattleConst.ACTIVITY_STATE.RESULT then
		-- block empty
	else
		g.core.network.GameNetProxy:send_C2S_TeamBattle_ServerInfos({})
		self:onS2CTeamBattleTeamInfo()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function TeamBattleReadyPeriodLayer:_onCrossDayUpdate()
	local var_7_0 = g.core.model.User.teamBattleData:getCurStage()

	if var_7_0 == TeamBattleConst.ACTIVITY_STATE.RESULT then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.TEAM_BATTLE_RESULT_LAYER)
	elseif var_7_0 == TeamBattleConst.ACTIVITY_STATE.NOT_OPEN then
		g.core.module.ModuleManager:tip(g.core.lang:get(420691))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function TeamBattleReadyPeriodLayer:onUnload()
	g.core.event.EventManager:removeListenerWithTarget(self)
	self:_stopTimer()
end

function TeamBattleReadyPeriodLayer:_updatePreViewComp()
	self.m_previewComp:updatePreview(self._regisId)
	self.m_preBtn:setVisible(self._regisId > 1)
	self.m_preBg:setVisible(self._regisId > 1)
	self.m_nextBtn:setVisible(self._regisId < self._regisLen)
	self.m_nextBg:setVisible(self._regisId < self._regisLen)
	self:_updateTime()
	self:_startTimer()
end

function TeamBattleReadyPeriodLayer:onS2CTeamBattleTeamInfo(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if g.core.model.User.teamBattleData:getTeamUpData():getMyTeam() then
		if #g.core.model.User.teamBattleData:getFormationData():getAllKnightList() > 0 then
			self.m_teamStateController:setSelectedIndex(2)
		else
			self.m_teamStateController:setSelectedIndex(1)
		end
	else
		self.m_teamStateController:setSelectedIndex(0)
	end
end

function TeamBattleReadyPeriodLayer:_startTimer()
	self._timer = self._timer or self:newSchedule(handler(self, self._updateTime, 1))
end

function TeamBattleReadyPeriodLayer:_stopTimer()
	if self._timer then
		self:cancelSchedule(self._timer)
	end

	self._timer = nil
end

function TeamBattleReadyPeriodLayer:_updateTime()
	local var_13_0 = g.core.model.User.teamBattleData:getCurStage()
	local var_13_1 = g.core.model.User.teamBattleData:getActivityTimeInfo()
	local var_13_2 = 427117

	if var_13_0 == TeamBattleConst.ACTIVITY_STATE.PREPARE then
		self._signupEndTime = var_13_1.startTime
	elseif var_13_0 == TeamBattleConst.ACTIVITY_STATE.OPEN then
		self._signupEndTime = var_13_1.endTime
		var_13_2 = 427118
	end

	if self._signupEndTime > var_0_0:getTime() then
		self.m_timeTxt:setText(g.core.lang:get(var_13_2, {
			time = var_0_0:getLeftDHMSFormat(self._signupEndTime)
		}))
	else
		self.m_timeTxt:setText("")
		self:_stopTimer()
	end
end

function TeamBattleReadyPeriodLayer:_onClickPreBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_PSXY_To_Switch)

	if self._regisId <= 1 then
		return
	end

	self._regisId = self._regisId - 1

	self:_updatePreViewComp()
	self.m_switchTransition:play()
end

function TeamBattleReadyPeriodLayer:_onClickNextBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_PSXY_To_Switch)

	if self._regisId >= self._regisLen then
		return
	end

	self._regisId = self._regisId + 1

	self:_updatePreViewComp()
	self.m_switchTransition:play()
end

function TeamBattleReadyPeriodLayer:_onClickCreateRoomBtn()
	if self.m_teamStateController:getSelectedIndex() == 1 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_TEAM_UP_LAYER)

		return
	elseif self.m_teamStateController:getSelectedIndex() == 2 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_MAP_LAYER)

		return
	end

	local var_16_0 = require("app.view.module.teamBattle.view.teamUp.TeamBattleCreatePop").new()

	g.core.module.ModuleManager:pushModule({
		package = "teamBattle",
		modType = g.view.entrance.POPUP,
		create = function()
			return var_16_0
		end
	})
end

function TeamBattleReadyPeriodLayer:_onClickJoinRoomBtn()
	local var_18_0 = require("app.view.module.teamBattle.view.teamUp.TeamBattleTeamListPop").new()

	g.core.module.ModuleManager:pushModule({
		package = "teamBattle",
		modType = g.view.entrance.POPUP,
		create = function()
			return var_18_0
		end
	})
end

return TeamBattleReadyPeriodLayer
