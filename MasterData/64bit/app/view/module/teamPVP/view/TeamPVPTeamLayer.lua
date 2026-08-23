local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.common.Goods
local var_0_5 = g.core.const.ConstMgr.ShopConst
local var_0_6 = g.core.model.User.teamPvpData
local var_0_7 = g.core.const.ConstMgr.TeamPvpConst
local var_0_8 = g.core.common.Path
local TeamPVPTeamLayer = class("TeamPVPTeamLayer", require("app.fairyGUI.teamPVP.UI_TeamPVPTeamLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/teamPVP/teamPVP",
		resName = "TeamPVPTeamLayer",
		pkgName = "teamPVP",
		isFullScreen = true
	}, ...)
end)

function TeamPVPTeamLayer:ctor()
	self._autoKickHandler = nil
	self._autoJoin = self.m_autoJoinBtn:isSelected()
	self._playerNum = 0
	self._teamInfo = nil
	self._captainId = 0
	self._mapId = 0
	self._myGuid = ""
	self._myPlayerInfo = nil
	self._autoKickCd = var_0_6:getTeamPVPParameterById(var_0_7.PARAMETER_ID.AUTO_KICK_TIME)
	self._elapsedTime = 0
	self._allReadyState = false
	self._firstInPage = true
	self._quitType = 0
	self._lastTipTime = 0
	self._btnEff = nil
	self._isEnterBattle = false
	self._isClose = false

	self:_addListeners()
	self:_initView()
end

function TeamPVPTeamLayer:_addListeners()
	self.m_inviteBtn:addClickListener(handler(self, self._onClickInviteBtn))
	self.m_enterBattleBtn:addClickListener(handler(self, self._onClickEnterBattleBtn))
	self.m_autoJoinBtn:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangedAutoJoinBtn))
	self.m_isReadyController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onReadyStateChanged))
	self.m_deployBtn:addClickListener(handler(self, self._onClickDeployBtn))
	self.m_screenBtn:addClickListener(handler(self, self._onClickScreenBtn))
	self.m_topBarComp:setReturnCallBack(handler(self, self._onQuitRoom))
	self.m_topBarComp:setHomeCallBack(handler(self, self._onReturnHome))
end

function TeamPVPTeamLayer:_initView()
	self.m_topBarComp:setResInfoById(var_0_7.TOP_BAR_TEAM_ID)
	self.m_challengesNumComp:initView({
		playNum = 1,
		getTimesFunc = function()
			return g.core.model.User.shopData:getLeftCount(var_0_7.PLAY_NUM_ID) or 0
		end,
		fullTime = var_0_6:getPlayFullTimes(),
		onGetTimes = handler(self, self._onClickBuy),
		refreshEvent = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	})
end

function TeamPVPTeamLayer:_updateView()
	local var_6_0 = var_0_6:getMapId()

	if var_6_0 > 0 then
		if self._mapId ~= var_6_0 then
			self._mapId = var_6_0

			self:_updateMapView()
		end

		self:_updateRoomView()
	end
end

function TeamPVPTeamLayer:_updateRoomView()
	self._teamInfo = var_0_6:getTeamInfo()

	if not self._teamInfo then
		return
	end

	self._captainId = self._teamInfo.captain
	self._playerNum = #self._teamInfo.users

	for iter_7_0, iter_7_1 in ipairs(self._teamInfo.users) do
		if iter_7_1.npc_type and iter_7_1.npc_type > 0 then
			self._playerNum = self._playerNum - 1
		end
	end

	self.m_memberNum:setText(g.core.lang:get(420400, {
		num = self._playerNum
	}))

	self._myGuid = var_0_6:getMyGuid()
	self._myPlayerInfo = var_0_6:getTeamPlayerInfoByGuid(self._myGuid)

	if not self._myPlayerInfo then
		return
	end

	local var_7_0 = self._myPlayerInfo.battleUser
	local var_7_1 = self._captainId == self._myGuid

	self.m_isCaptainController:setSelectedIndex(self._captainId == self._myGuid and 1 or 0)

	local var_7_2 = var_7_0.is_ready or var_7_1 or self.m_isReadyController:getSelectedIndex() == 1

	if self._firstInPage then
		var_7_2 = var_7_2 or checkbool((var_0_6:getOpenRoomState(var_0_7.JSON_KEY.AUTO_READY)))

		self.m_isReadyController:setSelectedIndex(var_7_2 and 1 or 0)
	else
		self.m_isReadyController:setSelectedIndex(var_7_2 and 1 or 0)
	end

	if var_7_2 ~= var_7_0.is_ready then
		var_0_2:send_C2S_GroupBattle_Ready({
			is_ready = var_7_2
		})
	end

	if var_7_1 then
		self.m_autoJoinBtn:setTitle(g.core.lang:get(420407))
		self.m_tipsTxt:setText(g.core.lang:get(420416, {
			time = self._autoKickCd
		}))

		local var_7_3 = var_0_6:getOpenRoomState(var_0_7.JSON_KEY.OPEN_STATE)

		if var_7_3 or var_7_3 == nil then
			self.m_autoJoinBtn:setSelected(var_0_6:isOpenRoom())
		else
			self.m_autoJoinBtn:setSelected(false)
			var_0_2:send_C2S_GroupBattle_Setting({
				is_open = false,
				catalog = var_0_7.SETTING_CATALOG.AUTO_JOIN
			})
		end
	else
		self.m_autoJoinBtn:setTitle(g.core.lang:get(420408))
		self.m_tipsTxt:setText(g.core.lang:get(420415, {
			time = self._autoKickCd
		}))

		local var_7_4 = var_0_6:getOpenRoomState(var_0_7.JSON_KEY.AUTO_READY)

		if var_7_4 == nil then
			var_0_6:saveOpenRoomState(var_0_7.JSON_KEY.AUTO_READY, var_7_2)
			self.m_autoJoinBtn:setSelected(var_7_2)
		else
			self.m_autoJoinBtn:setSelected(var_7_4)
		end
	end

	if not var_7_2 then
		if not var_7_1 then
			self.m_enterBattleBtn:setTitle(g.core.lang:get(420413))
		end

		self:_startAutoKick()
	elseif var_7_1 then
		self.m_enterBattleBtn:setTitle(g.core.lang:get(420432))

		local var_7_5 = var_0_6:isAllPlayerReady()

		if var_7_5 then
			self:_startAutoKick()

			if var_7_5 and self._allReadyState ~= var_7_5 then
				self._allReadyState = var_7_5

				if self._lastTipTime == 0 or g.core.common.ServerTime:getTime() - self._lastTipTime >= 3 then
					var_0_3:tip(g.core.lang:get(420423))

					self._lastTipTime = g.core.common.ServerTime:getTime()
				end
			end
		else
			self:_cancelAutoKick()

			self._allReadyState = false
		end
	else
		self.m_enterBattleBtn:setTitle(g.core.lang:get(420414))
	end

	self:_updateBtnAnim()
	self.m_mapInfoComp:updateAddition()
	self.m_mapComp:updatePlayers(var_7_1, self._captainId)
end

function TeamPVPTeamLayer:_updateMapView()
	local var_8_0 = var_0_6:getMapInfo()

	if var_8_0 then
		self.m_bgLoader:setURL(var_0_8:getTeamPVPTeamBg(var_8_0.map_id))
		self.m_mapInfoComp:updateMapInfo({
			name = var_8_0.name,
			des = var_8_0.des,
			mapId = var_8_0.map_id
		})
		self.m_mapComp:updateMapInfo()
	end
end

function TeamPVPTeamLayer:_updateAutoKick()
	self._elapsedTime = self._elapsedTime + 1

	local var_9_0 = self.m_isCaptainController:getSelectedIndex() == 1

	if self._autoKickCd > self._elapsedTime then
		if self._elapsedTime + 3 >= self._autoKickCd then
			if var_9_0 then
				var_0_3:tip(g.core.lang:get(420411, {
					time = self._autoKickCd - self._elapsedTime
				}))
			else
				var_0_3:tip(g.core.lang:get(420409, {
					time = self._autoKickCd - self._elapsedTime
				}))
			end
		end
	elseif self._elapsedTime == self._autoKickCd then
		if var_9_0 then
			var_0_3:tip(g.core.lang:get(420412))
		else
			var_0_3:tip(g.core.lang:get(420410))
		end

		self._quitType = 1

		var_0_2:send_C2S_GroupBattle_QuitRoom({})
	elseif self._elapsedTime >= self._autoKickCd + 3 then
		self:_exitRoom()
	end
end

function TeamPVPTeamLayer:onLoad()
	if not var_0_6:getTeamInfo() then
		self:newScheduleOnce(handler(self, self._onClose))
		g.core.module.ModuleManager:tip(g.core.lang:get(420404))

		return
	end

	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GROUP_BATTLE_SETTING, self._onS2CSettingChange, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYROOMCHANGE, self._onS2CRoomChange, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYBEKICK, self._onS2CBeKick, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYDISBANDROOM, self._onS2CDisbandRoom, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GROUP_BATTLE_READY, self._onS2CReady, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYFIGHTREPORT, self._onS2CBattleNotifyFightReport, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYMATCH, self._onS2CNotifyMatch, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_FORMATION_CHANGEPOSITION, self._recvChangePosition, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GROUP_BATTLE_QUERYROOM, self._onS2CQueryRoom, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GROUP_BATTLE_QUITROOM, self._onS2CQuitRoom, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYMAPCHANGE, self._onS2CMapChange, self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	var_0_1:addEventListener(var_0_0.EVENT_GAME_RESUME_FINISH, self._onRcvResumeFinish, self)

	if not self._firstInPage then
		self:_queryRoom()
	else
		self:_updateView()
	end

	self._firstInPage = false

	self.m_enterTransition:play()
end

function TeamPVPTeamLayer:onUnload()
	if self._autoKickHandler then
		self:cancelSchedule(self._autoKickHandler)

		self._autoKickHandler = nil
	end
end

function TeamPVPTeamLayer:_onClickInviteBtn()
	var_0_3:pushPopup(require("app.view.module.teamPVP.view.TeamPVPInvitePlayerPop").new(), {
		touchDisappear = true
	})
end

function TeamPVPTeamLayer:_onClickEnterBattleBtn()
	if self._isClose then
		return
	end

	if not var_0_6:getTeamInfo() then
		var_0_3:tip(g.core.lang:get(420441))
		var_0_3:popToRoot()

		return
	end

	if self.m_isCaptainController:getSelectedIndex() == 1 then
		if self:isEnterBattleEnable() then
			if var_0_6:getChallengeNum() > 0 then
				self:_startMatchBattle()
			else
				local var_13_0 = require("app.view.base.pop.BaseConfirmPop").new

				var_0_3:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
					title = g.core.lang:get(420435),
					onConfirm = handler(self, self._startMatchBattle),
					desc = g.core.lang:get(420436)
				})))
			end
		end
	elseif self.m_isReadyController:getSelectedIndex() == 0 then
		self.m_isReadyController:setSelectedIndex(1)
		var_0_2:send_C2S_GroupBattle_Ready({
			is_ready = true
		})
	else
		self.m_isReadyController:setSelectedIndex(0)
		var_0_2:send_C2S_GroupBattle_Ready({
			is_ready = false
		})
	end
end

function TeamPVPTeamLayer:_startMatchBattle()
	self:_cancelAutoKick()

	local var_14_0 = require("app.view.module.teamPVP.view.TeamPVPMatchPop").new({
		matchType = var_0_7.MATCH_TYPE.BATTLE
	})

	self:addListen(var_14_0)
	var_0_3:pushPopup(var_14_0, {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function TeamPVPTeamLayer:_onClickDeployBtn()
	if self._isClose then
		return
	end

	if self.m_isCaptainController:getSelectedIndex() ~= 1 and self.m_isReadyController:getSelectedIndex() == 1 then
		var_0_3:tip(g.core.lang:get(420437))
	else
		var_0_3:pushModule(g.view.entrance.FORMATION)
	end
end

function TeamPVPTeamLayer:_onClickScreenBtn()
	var_0_3:tip(g.core.lang:get(420437))
end

function TeamPVPTeamLayer:_onClickBuy()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
		type = var_0_4.TYPE_ITEM,
		value = var_0_4.ITEM.TYPE_TEAM_PVP,
		shopId = var_0_5.SHOP_ITEM_ID.TEAM_PVP_TOKEN
	}), {
		touchDisappear = true
	})
end

function TeamPVPTeamLayer:_onChangedAutoJoinBtn()
	local var_18_0 = self.m_isCaptainController:getSelectedIndex() == 1

	self._autoJoin = self.m_autoJoinBtn:isSelected()

	if var_18_0 then
		var_0_6:saveOpenRoomState(var_0_7.JSON_KEY.OPEN_STATE, self._autoJoin)
		var_0_2:send_C2S_GroupBattle_Setting({
			catalog = var_0_7.SETTING_CATALOG.AUTO_JOIN,
			is_open = self._autoJoin
		})
	else
		var_0_6:saveOpenRoomState(var_0_7.JSON_KEY.AUTO_READY, self._autoJoin)
		var_0_2:send_C2S_GroupBattle_Setting({
			catalog = var_0_7.SETTING_CATALOG.AUTO_READY,
			is_open = self._autoJoin
		})
	end
end

function TeamPVPTeamLayer:onClickBackBtn()
	if var_0_6:getTeamInfo() then
		self:_onQuitRoom()
	else
		self:_onClose()
	end
end

function TeamPVPTeamLayer:_onReadyStateChanged()
	local var_20_0 = self.m_isReadyController:getSelectedIndex() == 1
	local var_20_1 = self.m_isCaptainController:getSelectedIndex() == 1

	if not var_20_1 then
		if var_20_0 then
			self.m_enterBattleBtn:setTitle(g.core.lang:get(420414))
		else
			self.m_enterBattleBtn:setTitle(g.core.lang:get(420413))
		end
	end

	if var_20_0 then
		if not var_20_1 then
			self:_cancelAutoKick()
		end
	else
		self:_startAutoKick()
	end
end

function TeamPVPTeamLayer:_onQuitRoom()
	self._quitType = 1

	var_0_3:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(420402),
		onConfirm = handler(self, function()
			var_0_3:popAllPopup()
			var_0_2:send_C2S_GroupBattle_QuitRoom({})
		end),
		desc = g.core.lang:get(420403)
	})))
end

function TeamPVPTeamLayer:_onReturnHome()
	self._quitType = 2

	var_0_3:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(420402),
		onConfirm = handler(self, function()
			var_0_3:popAllPopup()
			var_0_2:send_C2S_GroupBattle_QuitRoom({})
		end),
		desc = g.core.lang:get(420403)
	})))
end

function TeamPVPTeamLayer:_onCrossDayUpdate()
	if not var_0_6:isActivityInStart() then
		var_0_3:tip(g.core.lang:get(420453))
		var_0_3:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	self:_updateBtnAnim()
end

function TeamPVPTeamLayer:_onRcvResumeFinish()
	self:_queryRoom()
end

function TeamPVPTeamLayer:receiveCompEvent(arg_27_1, arg_27_2)
	if arg_27_1 == "restart_auto_kick" then
		local var_27_0 = self.m_isReadyController:getSelectedIndex() == 1

		if self.m_isCaptainController:getSelectedIndex() == 1 then
			if var_0_6:isAllPlayerReady() then
				self:_startAutoKick()
			end
		elseif not var_27_0 then
			self:_startAutoKick()
		end
	end
end

function TeamPVPTeamLayer:needSetAutoReady(arg_28_1)
	return var_0_6:getOpenRoomState(var_0_7.JSON_KEY.AUTO_READY) ~= arg_28_1
end

function TeamPVPTeamLayer:isEnterBattleEnable()
	if self._playerNum < var_0_7.REQUIRED_PLAYER_NUM then
		var_0_3:tip(g.core.lang:get(420417, {
			num = var_0_7.REQUIRED_PLAYER_NUM
		}))

		return false
	end

	if not var_0_6:isAllPlayerReady() then
		var_0_3:tip(g.core.lang:get(420418))

		return false
	end

	if not self.m_mapComp:isAllLaneValid() then
		var_0_3:tip(g.core.lang:get(420419))

		return false
	end

	return true
end

function TeamPVPTeamLayer:_cancelAutoKick()
	if self._autoKickHandler then
		self:cancelSchedule(self._autoKickHandler)

		self._autoKickHandler = nil
		self._elapsedTime = 0
	end
end

function TeamPVPTeamLayer:_popRankUp()
	local var_31_0 = var_0_6:getOldTitleId()
	local var_31_1 = var_0_6:getTitleId()

	if var_31_0 > 0 and var_31_0 < var_31_1 then
		var_0_3:pushPopup(require("app.view.module.teamPVP.view.TeamPVPRankUpPop").new({
			oldTitleId = var_31_0,
			curTitleId = var_31_1
		}), {
			touchDisappear = true
		})
	end
end

function TeamPVPTeamLayer:_queryRoom()
	g.core.network.GameNetProxy:send_C2S_GroupBattle_QueryRoom({
		room_id = var_0_6:getMyRoomId()
	})
end

function TeamPVPTeamLayer:_exitRoom()
	var_0_3:popAllPopup()
	var_0_3:onlyPopSelfByDisplay(self)
end

function TeamPVPTeamLayer:_updateBtnAnim()
	local var_34_0 = self.m_enterBattleBtn:getChild("battleEffect")

	var_34_0:setVisible(false)

	if self.m_isCaptainController:getSelectedIndex() == 1 then
		if self._playerNum ~= var_0_7.REQUIRED_PLAYER_NUM then
			return
		end

		if not var_0_6:isAllPlayerReady() then
			return false
		end

		if not self.m_mapComp:isAllLaneValid() then
			return false
		end

		self._btnEff = self._btnEff or var_34_0:addEffectSpine({
			name = "eff_ui_teamPvp_btnCreate",
			isLoop = true,
			anim = "play"
		})

		var_34_0:setVisible(true)
	end
end

function TeamPVPTeamLayer:_startAutoKick()
	self._elapsedTime = 0
	self._autoKickHandler = self._autoKickHandler or self:newSchedule(handler(self, self._updateAutoKick), 1)
end

function TeamPVPTeamLayer:_onS2CQuitRoom(arg_36_1, arg_36_2, arg_36_3)
	if self._isClose then
		return
	end

	self._isClose = true

	if arg_36_3.ret == g.core.network.proto.RET_OK then
		var_0_3:popAllPopup()

		if self._quitType == 1 then
			var_0_3:onlyPopSelfByDisplay(self)
		elseif self._quitType == 2 then
			var_0_3:popToRoot()
		end
	else
		var_0_3:tip(g.core.lang:get(420441))
		var_0_3:popToRoot()
	end
end

function TeamPVPTeamLayer:_onS2CSettingChange(arg_37_1, arg_37_2, arg_37_3)
	if arg_37_3.catalog == var_0_7.SETTING_CATALOG.AUTO_JOIN and self._autoJoin ~= arg_37_3.is_open then
		self._autoJoin = arg_37_3.is_open

		self.m_autoJoinBtn:setSelected(arg_37_3.is_open)
	end
end

function TeamPVPTeamLayer:_onS2CRoomChange()
	self:_updateView()

	if self._isEnterBattle and not var_0_6:getBattleReport() then
		self._isEnterBattle = false

		self:_popRankUp()
	end
end

function TeamPVPTeamLayer:_onS2CMapChange()
	var_0_2:send_C2S_GroupBattle_QueryRoom({
		room_id = var_0_6:getMyRoomId()
	})
end

function TeamPVPTeamLayer:_onS2CBeKick()
	var_0_3:tip(g.core.lang:get(420404))
	var_0_3:popAllPopup()
	var_0_3:onlyPopSelfByDisplay(self)
end

function TeamPVPTeamLayer:_onS2CDisbandRoom()
	var_0_3:tip(g.core.lang:get(420405))
	var_0_3:popToRoot()
end

function TeamPVPTeamLayer:_onS2CReady(arg_42_1, arg_42_2, arg_42_3)
	return
end

function TeamPVPTeamLayer:_onS2CBattleNotifyFightReport(arg_43_1, arg_43_2, arg_43_3)
	if arg_43_3 and arg_43_3.is_success then
		self._isEnterBattle = true

		g.core.module.ModuleManager:showCloud({
			callback = function()
				var_0_3:popAllPopupAndPush(g.view.entrance.TEAMPVP_BATTLE_LAYER)
			end
		})
	end
end

function TeamPVPTeamLayer:_onS2CNotifyMatch(arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = self.m_isCaptainController:getSelectedIndex() == 1

	var_0_6:setHelpState()

	if not var_45_0 and arg_45_3.tp == 1 then
		var_0_3:pushPopup(require("app.view.module.teamPVP.view.TeamPVPMatchPop").new({
			matchType = var_0_7.MATCH_TYPE.BATTLE
		}), {
			touchDisappear = false,
			ignoreTouch = true
		})
	end

	self:_cancelAutoKick()
end

function TeamPVPTeamLayer:_recvChangePosition()
	var_0_2:send_C2S_GroupBattle_RefreshBattleUser({})
end

function TeamPVPTeamLayer:_onS2CQueryRoom(arg_47_1, arg_47_2, arg_47_3)
	if var_0_6:isMyselfInRoom() then
		self:_updateView()

		return
	end

	if self._isClose then
		return
	end

	self._isClose = true

	var_0_3:tip(g.core.lang:get(420452))
	var_0_3:popAllPopup()
	var_0_3:onlyPopSelfByDisplay(self)
end

function TeamPVPTeamLayer:_onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	var_0_3:popAllPopup()
	var_0_3:onlyPopSelfByDisplay(self)
end

return TeamPVPTeamLayer
