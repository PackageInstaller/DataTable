local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.const.ConstMgr.TeamBattleConst
local var_0_2 = g.core.model.User.teamBattleData
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum
local TeamBattleMapLayer = class("TeamBattleMapLayer", require("app.fairyGUI.teamBattle.UI_TeamBattleMapLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/teamBattle/teamBattle",
		resName = "TeamBattleMapLayer",
		pkgName = "teamBattle"
	}, ...)
end)

function TeamBattleMapLayer:ctor()
	self._isFirst = true
	self._gameBtnStartPos = self.m_openCardBtn:getPosition()

	var_0_3:dispatchEvent(var_0_4.EVENT_GUIDE_WAIT)

	self._isFirstEnter = true

	self:initView()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_BATTLE)
	require("app.core.common.Provider"):clearProviderByKey("C2S_TeamBattleEnter")
end

function TeamBattleMapLayer:initView()
	self:addBg("bg/exploration/bg_slmj_main.jpg", false, nil, 1)
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))
	self.m_serverComp:addClickListener(handler(self, self._onServerCompClick))
	self.m_openCardBtn:addClickListener(handler(self, self._onOpenCardBtnClick))
	self.m_meteorBtn:addClickListener(handler(self, self._onMeteorBtnClick))
	self.m_dartBtn:addClickListener(handler(self, self._onDartBtnClick))
	self.m_bagBtn:addClickListener(handler(self, self._onKnightBagBtnClick))
	self.m_buffAttrBtn:addClickListener(handler(self, self._onBuffAttrBtnClick))
	self.m_formationBtn:addClickListener(handler(self, self._onFormationBtnClick))
	self.m_roomBtn:addClickListener(handler(self, self._onRoomBtnClick))
	self.m_logBtn:addClickListener(handler(self, self.onLogBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_mapComp:setStage(self)
	self.m_workComp.m_tipBtn:addClickListener(handler(self, self.onClickTipBtn))
	self.m_tipTouchComp:addClickListener(handler(self, self.onClickTipBtn))
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.TEAM_BATTLE)
	self.m_topBarComp:setTitle(g.core.config.function_info.get(g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_BATTLE).name)
	self.m_enterTransition:play()
end

function TeamBattleMapLayer:_updateTaskRedPoint()
	var_0_3:dispatchEvent(var_0_4.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn,
		customData = {}
	})
end

function TeamBattleMapLayer:addCustomLister()
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_EXIT, handler(self, self._onS2CTeamBattleExit), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_SETWORK, handler(self, self._updateTeamComp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYSETWORK, handler(self, self._updateTeamComp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_HELP, handler(self, self._onS2CTeamBattleHelp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYHELP, handler(self, self._onS2CTeamBattleNotifyHelp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYEXIT, handler(self, self._onS2CTeamBattleNotifyExit), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYMOVE, handler(self, self._onNotifyRoleMove), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_SETVISIBLEAREA, handler(self, self.updateMapComp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_OPCHALLENGERESULT, handler(self, self.updateMapComp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_MINE, handler(self, self.onS2CMineUpdateMapComp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_REBORN, handler(self, self.updateMapComp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_RECOVERHP, handler(self, self.updateMapComp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_SELECTBUFF, handler(self, self.updateMapComp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYREBORN, handler(self, self.updateMapComp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYRECOVERHP, handler(self, self.updateMapComp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYSELECTBUFF, handler(self, self.updateMapComp), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_SELECTGAME, handler(self, self._updateGameBtn), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_PLAYGAME, handler(self, self._updateGameBtn), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYSHAREAWARDS, handler(self, self._onS2CTeamBattleNotifyShareAwards), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_GETSHAREAWARDS, handler(self, self._onS2CTeamBattleGetShareAwards), self)
	var_0_3:addEventListener(var_0_4.EXPLORATION_OPEN_KNIGHT_BAG, handler(self, self._openKnightBag), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_FORMATION_GET, handler(self, self._onGetFormation), self)
	var_0_3:addEventListener(var_0_4.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	var_0_3:addEventListener(var_0_4.EXPLORATION_FORMATION_FIGHT_VALUE_CHECK, handler(self, self._checkFightValue), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYCHALLENGEBOSSFINISH, handler(self, self._onS2CTeamBattleNotifyChallengeBossFinish), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYCHALLENGEMONSTERFINISH, handler(self, self._onS2CTeamBattleNotifyChallengeMonsterFinish), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYMINE, handler(self, self._onS2CTeamBattleNotifyMine), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYENTERROOM, handler(self, self._onOtherRoleEnter), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.onGetUserSnap, self)
	self:_addNetStateLister()
end

function TeamBattleMapLayer:_addNetStateLister()
	var_0_3:addEventListener(var_0_4.EVENT_LOGIN_REPEAT, self._onNetBroken, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_G2C_OFFLINE_NEW, self._onNetBroken, self)
	var_0_3:addEventListener(var_0_4.EVENT_LOGIN_OFFINE, self._onNetBroken, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_CONNECT_FAIL, self._onNetBroken, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_CONNECT_BROKEN, self._onNetBroken, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_DISCONNECTED, self._onNetBroken, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_TIMEOUT, self._onNetBroken, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_EXPIRED, self._onNetBroken, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_SERVER_BROKEN, self._onNetBroken, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_RECONNECT, self._onNetBroken, self)
	var_0_3:addEventListener(var_0_4.EVENT_GAME_RESUME_FINISH, self._onNetBroken, self)
	var_0_3:addEventListener(var_0_4.EVENT_TEAM_BATTLE_NET_ERROR, self._checkBroken, self)
end

function TeamBattleMapLayer:onLoad()
	self:addCustomLister()
	var_0_2:saveEnteredMap()

	if var_0_2:getCurStage() == var_0_1.ACTIVITY_STATE.NOT_OPEN then
		var_0_0:tip(g.core.lang:get(420691))
		self:newScheduleOnce(function()
			var_0_0:switchModuleIntelligent(g.view.entrance.HOME)
		end, 0)
	end

	if not var_0_2:getFormationData():isGetSvrFormation() then
		g.core.network.GameNetProxy:send_C2S_Formation_Get({
			tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.TEAM_BATTLE
		})
	end

	self:_refreshRedPoint()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_FOREST)
	self:_checkFightValue()
	self:_checkMainVisible()
	self:_checkResult()
	self:_updateTeamComp()
	self:_updateGameBtn()
	self:_updateScore()
	self.m_roomTitle:setText(g.core.lang:get(427131, {
		name = var_0_2:getMapData():getRoomStructByRoomId(var_0_2:getMapData():getPlayerStruct():getRoomId()):getCfg().name
	}))
	g.core.network.GameNetProxy:send_C2S_TeamBattle_ServerInfos({})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	self:_checkBroken()
end

function TeamBattleMapLayer:_checkBroken()
	if g.core.model.User.teamBattleData:isNetBroKen() then
		self:_onNetBroken()
		g.core.model.User.teamBattleData:setNetBroken(false)
	end
end

function TeamBattleMapLayer:_checkResult()
	local var_10_0 = var_0_2:getMapData():getMapResult()

	if not var_10_0 then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_CHALLENGE_RESULT, false, 1, {
		challenge_result = var_10_0
	})
end

function TeamBattleMapLayer:_checkMainVisible()
	local var_11_0 = var_0_2:getMapData()
	local var_11_1 = var_11_0:getPlayerStruct()
	local var_11_2 = var_0_2:getMapData():getRoomStructByRoomId(var_11_1:getRoomId())

	self.m_mapComp:getFloorComp():setCurCheckPos(var_11_0.room_x, var_11_2:getCfg().room_y)
	self.m_mapComp:getMapWorld():moveLastCenter()

	if not var_0_2:getMapData():checkRoomIsEnter(var_11_2) then
		local var_11_3 = var_0_2:getMapData():getPlayerVisibleArea(var_11_1)

		if var_11_3 then
			g.core.network.GameNetProxy:send_C2S_TeamBattle_SetVisibleArea({
				visible_area = var_0_2:getMapData():getVisibleAreaStr(var_11_3)
			})
		end
	end
end

function TeamBattleMapLayer:_onS2CTeamBattleNotifyHelp()
	self:_updateTeamComp()
	self.m_mapComp:updateCurMap()
	g.core.module.ModuleManager:tip(g.core.lang:get(427116))
end

function TeamBattleMapLayer:_onS2CTeamBattleHelp()
	self:_updateTeamComp()
	self.m_mapComp:updateCurMap()
	g.core.module.ModuleManager:tip(g.core.lang:get(427116))
end

function TeamBattleMapLayer:_updateTeamComp()
	self.m_teamComp:updateTeam()
end

function TeamBattleMapLayer:_updateScore()
	self.m_killNumTxt:setText(g.core.lang:get(427135, {
		score = var_0_2:getMapData():getScore()
	}))
end

function TeamBattleMapLayer:_onNotifyRoleMove()
	self:_updateTeamComp()
end

function TeamBattleMapLayer:_onNotifyRoom()
	self:_updateTeamComp()
end

function TeamBattleMapLayer:_checkFightValue()
	local var_18_0 = var_0_2:getFormationData():getDiffFightValue()

	if var_18_0 > 0 then
		local var_18_1 = {
			otherFightValueChange = var_18_0
		}

		var_18_1.preValue = var_0_2:getFormationData():getMaxFormationFightValue()
		var_18_1.title = g.core.lang:get(420697)

		var_0_3:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, var_18_1)
	end

	self:_updateTeamComp()
end

function TeamBattleMapLayer:_onGetFormation(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	var_0_3:dispatchEvent(var_0_4.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_formationBtn,
		customData = {}
	})

	if self._isFirst then
		g.core.network.GameNetProxy:send_C2S_Formation_Save({
			tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.TEAM_BATTLE,
			formations = var_0_2:getFormationData():getOutBaseFormationArr()
		})
	end

	self._isFirst = false
end

function TeamBattleMapLayer:_updateLimitBtn()
	self.m_limitBtn:updateComp()
end

function TeamBattleMapLayer:_updateGameBtn()
	local var_21_0 = var_0_2:getMapData():getEventNumByType(var_0_1.EVENT_TYPE.GAME_TURN_CARD)

	self.m_openCardBtn:setTitle(var_21_0)
	self.m_openCardBtn:setVisible(var_21_0 > 0)

	local var_21_1 = var_0_2:getMapData():getEventNumByType(var_0_1.EVENT_TYPE.GAME_METEOR_SHOWER)

	self.m_meteorBtn:setTitle(var_21_1)
	self.m_meteorBtn:setVisible(var_21_1 > 0)

	local var_21_2 = var_0_2:getMapData():getEventNumByType(var_0_1.EVENT_TYPE.GAME_DART)

	self.m_dartBtn:setTitle(var_21_2)
	self.m_dartBtn:setVisible(var_21_2 > 0)
end

function TeamBattleMapLayer:_onS2CExplorationEventProcess(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	self:_refreshRedPoint()
end

function TeamBattleMapLayer:receiveCompEvent(arg_23_1, arg_23_2)
	if arg_23_1 == "moveToMap" then
		if self.m_mapComp:isRoleMoving() then
			var_0_0:tip(g.core.lang:get(420689))
		else
			self.m_mapComp:getMapWorld():moveCell2SC(arg_23_2.coord)

			if arg_23_2.closePop then
				g.core.module.ModuleManager:popComponent()
			end
		end

		return true
	elseif arg_23_1 == "moveToRole" then
		self:_moveToMainRole()

		return true
	end
end

function TeamBattleMapLayer:_moveToMainRole()
	if self.m_mapComp:isRoleMoving() then
		var_0_0:tip(g.core.lang:get(420689))
	else
		self.m_mapComp:getMapWorld():moveCell2SC((var_0_2:getMapData():getRoleCoordinate()))
	end
end

function TeamBattleMapLayer:_enterOtherRoom()
	self:_checkMainVisible()
	self:_moveToMainRole()
	self:_updateLimitBtn()
	self.m_roomTitle:setText(g.core.lang:get(427131, {
		name = var_0_2:getMapData():getRoomStructByRoomId(var_0_2:getMapData():getPlayerStruct():getRoomId()):getCfg().name
	}))
	self.m_mapComp:onPlayerTelportToRoom()
end

function TeamBattleMapLayer:_onOtherRoleEnter(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_4.user then
		if arg_26_4.user.user_id == g.core.model.User:getId() then
			local var_26_0 = var_0_2:getMapData():getMineRoom():getCfg()

			self.m_mapComp:getMapWorld():setCurRoom(var_26_0.room_x, var_26_0.room_y)

			if not self._isFirstEnter then
				self:_enterOtherRoom()

				return
			end
		end

		self._isFirstEnter = false

		self.m_mapComp:getFloorComp():updateRoleCoordinate(var_0_2:getMapData():getRoleCoordinate(arg_26_4.user.user_id), arg_26_4.user.user_id)
	end

	self.m_mapComp:updateCurMap()
	self:_updateTeamComp()
end

function TeamBattleMapLayer:updateTipIcon()
	local var_27_0 = var_0_2:getMapData():getRoleCoordinate()

	self.m_tipPosComp:updateCompAngleAndPos(cc.p(self.m_mapComp:getMapWorld():getMapGround():coordToPixel(var_27_0.x, var_27_0.y)), self.m_mapComp:getMapWorld():convertToNodeSpace({
		x = display.cx,
		y = display.cy
	}), (self.m_mapComp:getScale()))
end

function TeamBattleMapLayer:_refreshRedPoint()
	var_0_3:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_formationBtn,
		customData = {}
	})
	var_0_3:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_mirrorDirBtn,
		customData = {}
	})
	var_0_3:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_knightBtn,
		customData = {}
	})
	self:_updateTaskRedPoint()
end

function TeamBattleMapLayer:_onRankBtnClick()
	var_0_0:pushModule(g.view.entrance.TEAM_BATTLE_RANK_LAYER)
end

function TeamBattleMapLayer:_onOpenCardBtnClick()
	local var_30_0 = var_0_2:getMapData():getEventByType(var_0_1.EVENT_TYPE.GAME_TURN_CARD)

	if var_30_0 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.teamBattle.view.game.TeamBattleTickGamePop").new(var_30_0)))
	end
end

function TeamBattleMapLayer:_onMeteorBtnClick()
	local var_31_0 = var_0_2:getMapData():getEventByType(var_0_1.EVENT_TYPE.GAME_METEOR_SHOWER)

	if var_31_0 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.teamBattle.view.game.TeamBattleTickGamePop").new(var_31_0)))
	end
end

function TeamBattleMapLayer:_onDartBtnClick()
	local var_32_0 = var_0_2:getMapData():getEventByType(var_0_1.EVENT_TYPE.GAME_DART)

	if var_32_0 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.teamBattle.view.game.TeamBattleTickGamePop").new(var_32_0)))
	end
end

function TeamBattleMapLayer:_onKnightBagBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_KNIGHT_BAG_LAYER)
end

function TeamBattleMapLayer:_onShopBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.TEAM_BATTLE
	})
end

function TeamBattleMapLayer:_onBuffAttrBtnClick()
	var_0_0:pushModule(g.view.entrance.TEAM_BATTLE_BUFF_BAG_POP)
end

function TeamBattleMapLayer:_onFormationBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_FORMATION_LAYER, {
		isMainEnter = true
	})
end

function TeamBattleMapLayer:_onActionPointCompClick()
	return
end

function TeamBattleMapLayer:_onServerCompClick()
	g.core.common.GlobalFunc.pushMatchServerPop({
		serverInfo = var_0_2:getTeamUpData():getServerInfos()
	})
end

function TeamBattleMapLayer:_onMiniMapClicked()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.map.miniMap.ExplorationMiniDetailPop").new()))
end

function TeamBattleMapLayer:_popupMirror()
	return
end

function TeamBattleMapLayer:_openKnightBag()
	self:_onKnightBtnClick()
end

function TeamBattleMapLayer:onClickTipBtn()
	if self.m_showWorkTipController:getSelectedIndex() < 1 then
		self.m_showWorkTipController:setSelectedIndex(1)
	else
		self.m_showWorkTipController:setSelectedIndex(0)
	end
end

function TeamBattleMapLayer:onLogBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.teamBattle.view.pop.TeamBattleLogPop").new()))
end

function TeamBattleMapLayer:_onRoomBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.teamBattle.view.map.TeamBattleMapRoomPop").new()))
end

function TeamBattleMapLayer:_onCrossDayUpdate()
	local var_45_0 = var_0_2:getCurStage()

	if var_45_0 == var_0_1.ACTIVITY_STATE.RESULT then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.TEAM_BATTLE_RESULT_LAYER)
	elseif var_45_0 == var_0_1.ACTIVITY_STATE.NOT_OPEN then
		g.core.module.ModuleManager:tip(g.core.lang:get(420691))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	else
		self.m_activePointComp:onUpdateActivePoint()
	end
end

function TeamBattleMapLayer:onRemoved()
	g.core.network.GameNetProxy:send_C2S_TeamBattle_Exit({})
end

function TeamBattleMapLayer:_onS2CTeamBattleNotifyShareAwards(arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	self.m_teamComp:updateTeam()
end

function TeamBattleMapLayer:_onS2CTeamBattleGetShareAwards(arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	self.m_teamComp:updateTeam()
	var_0_0:awardSummary(arg_48_4.awards)
end

function TeamBattleMapLayer:_onS2CTeamBattleExit()
	self.m_teamComp:updateTeam()
	self.m_mapComp:updateCurMap()
end

function TeamBattleMapLayer:_onS2CTeamBattleNotifyExit()
	self.m_teamComp:updateTeam()
	self.m_mapComp:updateCurMap()
end

function TeamBattleMapLayer:_onS2CTeamBattleNotifyChallengeMonsterFinish()
	self:_updateScore()
	self.m_mapComp:updateCurMap()
end

function TeamBattleMapLayer:_onS2CTeamBattleNotifyChallengeBossFinish()
	self:_updateScore()
	self.m_mapComp:updateCurMap()
end

function TeamBattleMapLayer:_onS2CTeamBattleNotifyMine()
	self.m_mapComp:updateCurMap()
end

function TeamBattleMapLayer:onGetUserSnap()
	self.m_mapComp:updateCurMap()
	self.m_teamComp:updateTeam()
end

function TeamBattleMapLayer:updateMapComp()
	self.m_mapComp:updateCurMap()
end

function TeamBattleMapLayer:onS2CMineUpdateMapComp()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_RockCrack)
	self.m_mapComp:updateCurMap()
end

function TeamBattleMapLayer:_onNetBroken()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		singleButton = true,
		title = g.core.lang:get(1257),
		desc = g.core.lang:get(427158),
		onConfirm = function()
			var_0_0:switchModuleIntelligent(g.view.entrance.HOME)
		end
	}), {
		touchDisappear = false
	})
end

return TeamBattleMapLayer
