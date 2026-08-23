local PubgMapHelp = require("app.view.module.pubg.view.pubgMap.mapWorld.PubgMapHelp")
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.const.ConstMgr.PubgConst.map
local var_0_3
local PubgMapLayer = class("PubgMapLayer", require("app.fairyGUI.pubg.UI_PubgMapLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/pubg/pubg",
		resName = "PubgMapLayer",
		pkgName = "pubg"
	}, ...)
end)
local var_0_5 = 100
local var_0_6 = 350

function PubgMapLayer:ctor(arg_2_1)
	var_0_3 = g.core.model.User.pubgData:getMapData()
	self._isExitBack = false
	self._showTopTipList = {}
	self._myId = g.core.model.User:getId()

	self:_initView()
end

function PubgMapLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetUserSnapshot), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_MOVENOTICE, handler(self, self._onMoveNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_UPDATEUSER, handler(self, self._onUpdateUser), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_ADDEXPNOTICE, handler(self, self._onAddExp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_DEADNOTICE, handler(self, self._onDeadNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_RECOVERNOTICE, handler(self, self._onRecoverNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_PICKBUFFNOTICE, handler(self, self._onPickBuffNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_REMOVEBUFFNOTICE, handler(self, self._onRemoveBuffNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_SHRINKCIRCLE, handler(self, self._onShrinkCircle), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_REFRESH, handler(self, self._onRefreshEvent), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_GAMEEND, handler(self, self._onGameEnd), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_TEXTNOTICE, handler(self, self._onTextNotice), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_REFRESHAIRDROP, handler(self, self.onAirDropRefresh), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_PICKAIRDROPNOTICE, handler(self, self.userStarPickAirDrop), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_GAINAIRDROP, handler(self, self.onAirDropEnd), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_RECONNECT, handler(self, self._onAppExitBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.APP_ENTER_BACKGROUND_EVENT, handler(self, self._onAppExitBack), self)

	for iter_3_0, iter_3_1 in pairs(var_0_3:getAllUser()) do
		iter_3_1:getSnapShot()
	end

	self.m_mapComp:moveToPoint(var_0_3:getMyPos())
	self.m_miniMapComp:updateMapPos(var_0_3:getMyPos())
	self.m_playInfoComp:updateInfoComp()
	self:newSchedule(handler(self, self.updateMapTime), 1)

	if var_0_1:getTime() < var_0_3:getMapStartTime() then
		self:newScheduleOnce(handler(self, self.showStartTimePop))
	end

	if var_0_1:getTime() < var_0_3:getMyUser():getRecoverTime() then
		self:showRecoverPop()
	end

	self.m_miniMapComp:updateDeadNum(var_0_3:getMyUser():getFailCount())
	self.m_miniMapComp:updateKillNum(var_0_3:getMyUser():getWinCount())
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_PsychedelicRoom)
	var_0_3:setTimeScale(cc.Director:getInstance():getScheduler():getTimeScale())
end

function PubgMapLayer:_initView(arg_4_1)
	self.m_mapComp:setStage(self)
	self.m_quitBtn:addClickListener(handler(self, self._onClickQuitBtn))
	self.m_playerIcon:addClickListener(handler(self, self._onClickPlayerIcon))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self:updateRankComp()
	self:updateRecordComp()
end

function PubgMapLayer:_onAppExitBack()
	self._isExitBack = true

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		onConfirm = handler(self, self._quitGame),
		onCancel = handler(self, self._quitGame),
		confirmText = g.core.lang:get(1160),
		cancelText = g.core.lang:get(1037),
		desc = g.core.lang:get(430938)
	}), {
		touchDisappear = false
	})
end

function PubgMapLayer:_onClickQuitBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		onConfirm = handler(self, self._quitGame),
		confirmText = g.core.lang:get(1160),
		cancelText = g.core.lang:get(1037),
		desc = g.core.lang:get(430937)
	})))
end

function PubgMapLayer:_quitGame()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function PubgMapLayer:_onTouchEnd(arg_8_1)
	self.m_playInfoComp:onTouchEnd(arg_8_1)
end

function PubgMapLayer:updateRankComp()
	self.m_rankComp:updateComp()
end

function PubgMapLayer:updateRecordComp()
	self.m_miniMapComp:updateKillNum(var_0_3:getMyUser():getWinCount())
	self.m_recordComp:updateComp()
end

function PubgMapLayer:_onMoveNotify(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if self._isExitBack then
		return
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_4.list or {}) do
		self.m_mapComp:getFloorComp():playUserMove(iter_11_1)

		if iter_11_1.user_id == self._myId then
			self.m_mapComp:updatePlayerIcon()
			self.m_miniMapComp:updateMapPos(var_0_3:getMyPos())
		end
	end
end

function PubgMapLayer:_onGetUserSnapshot(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self.m_mapComp:getFloorComp():refreshGridByUser(nil, false)
	self.m_mapComp:refreshAttackUserComp()
	self:updateRankComp()
end

function PubgMapLayer:_onDeadNotify(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if self._isExitBack then
		return
	end

	self.m_mapComp:getFloorComp():playDeadNotify(arg_13_4)

	if arg_13_4.dead.tp == 2 and arg_13_4.dead.id == self._myId then
		self:newScheduleOnce(handler(self, self.showRecoverPop), 1)

		if arg_13_4.drop_buff then
			self.m_playInfoComp:updateBuff(arg_13_4.drop_buff.tp)
		end
	end

	self:newScheduleOnce(handler(self, self.updateRecordComp), 1.5)
end

function PubgMapLayer:_onRecoverNotify(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if self._isExitBack then
		return
	end

	self.m_mapComp:getFloorComp():userRecover(arg_14_4)
	self.m_playInfoComp:updateHp()

	if arg_14_4.user_id == self._myId then
		self.m_mapComp:moveToPoint(var_0_3:getMyPos())
	end
end

function PubgMapLayer:_onPickBuffNotify(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	self.m_mapComp:getFloorComp():pickBuffNotify(arg_15_4)

	local var_15_0 = arg_15_4.userId == self._myId

	if arg_15_4.userId == self._myId then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SH_BuffGet)
	end

	if arg_15_4.buff then
		if var_15_0 then
			self.m_playInfoComp:updateBuff(arg_15_4.buff.tp, true)
		end

		if arg_15_4.buff.tp == var_0_2.BUFF_TYPE.FIGHT_VALUE_VALUE then
			self:updateRankComp()
		end
	end
end

function PubgMapLayer:_onRemoveBuffNotify(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if self._isExitBack then
		return
	end

	self.m_mapComp:getFloorComp():removeBuffNotify(arg_16_4)

	if arg_16_4.user_id == self._myId then
		self.m_playInfoComp:updateBuff(arg_16_4.tp)
	end
end

function PubgMapLayer:_onRefreshEvent(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if self._isExitBack then
		return
	end

	self.m_miniMapComp:updateMapPos(var_0_3:getMyPos())
	self.m_mapComp:getFloorComp():refreshEvent(arg_17_4)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SH_Refresh)
end

function PubgMapLayer:_onDropBuff(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if self._isExitBack then
		return
	end

	local var_18_0 = arg_18_4.buff

	if arg_18_4.buff then
		self.m_mapComp:getFloorComp():refreshGridList({
			[PubgMapHelp.getKey(var_18_0.x, var_18_0.y)] = true
		})
	end

	if arg_18_4.user_id == self._myId then
		self.m_playInfoComp:updateBuff(arg_18_4.tp)
	end
end

function PubgMapLayer:_onGameEnd(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	g.core.module.ModuleManager:popAllPopup()
	self.m_mapComp:getFloorComp():setVisible(false)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.pubg.view.PubgGameRankPop").new(), {
		hideContinue = false,
		touchDisappear = true
	})

	if arg_19_4.awards then
		require("app.view.module.show.ShowFactory"):awardSummary(arg_19_4.awards, false, nil, nil)
	end

	if arg_19_4.score then
		local var_19_0 = {}

		var_19_0.score = arg_19_4.score or 0

		g.core.module.ModuleManager:tip(g.core.lang:get(430939, var_19_0))
	end
end

function PubgMapLayer:_onTextNotice(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	table.insert(self._showTopTipList, {
		content = arg_20_4,
		startTime = var_0_1:getTime() + 1
	})
end

function PubgMapLayer:_onShrinkCircle(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if self._isExitBack then
		return
	end

	self.m_mapComp:getFloorComp():refreshLevelChange()
end

function PubgMapLayer:_onUpdateUser(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if self._isExitBack then
		return
	end

	local var_22_0 = arg_22_4.user_id
	local var_22_1 = arg_22_4.user_id == self._myId

	for iter_22_0, iter_22_1 in ipairs(arg_22_4.list or {}) do
		if iter_22_1.key == var_0_2.USER_UPDATE_TYPE.HP then
			if var_22_1 then
				self.m_playInfoComp:updateHp()
			end
		elseif iter_22_1.key == var_0_2.USER_UPDATE_TYPE.LEVEL then
			if var_22_1 then
				self.m_playInfoComp:updateLevel()
			end

			self.m_mapComp:getFloorComp():playUserLevelUp(var_22_0)
		elseif iter_22_1.key == var_0_2.USER_UPDATE_TYPE.EXP then
			if var_22_1 then
				self.m_playInfoComp:updateExp()
			end
		elseif iter_22_1.key == var_0_2.USER_UPDATE_TYPE.SCORE then
			self:updateRankComp()
		elseif iter_22_1.key == var_0_2.USER_UPDATE_TYPE.FIGHT_VALUE then
			self.m_mapComp:getFloorComp():refreshGridByUser()
			self:updateRankComp()
		elseif iter_22_1.key == var_0_2.USER_UPDATE_TYPE.RECOVER_TIME then
			-- block empty
		elseif iter_22_1.key == var_0_2.USER_UPDATE_TYPE.INVINCIBLE_TIME then
			-- block empty
		end
	end
end

function PubgMapLayer:_onAddExp(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if self._isExitBack then
		return
	end

	self.m_playInfoComp:updateExp()
	self.m_mapComp:refreshAddExp(arg_23_4.add_exp or 0)
end

function PubgMapLayer:calcBorderAngle()
	if not self._angle then
		local function var_24_0(arg_25_0, arg_25_1)
			return (math.radian2angle((cc.pToAngleSelf(cc.pSub(arg_25_1, arg_25_0)))) + 360) % 360
		end

		self._angle = {
			right = {
				var_24_0(cc.p(display.cx, display.cy), cc.p(display.width, 0)),
				var_24_0(cc.p(display.cx, display.cy), cc.p(display.width, display.height))
			},
			left = {
				var_24_0(cc.p(display.cx, display.cy), cc.p(0, display.height)),
				var_24_0(cc.p(display.cx, display.cy), cc.p(0, 0))
			},
			top = {
				var_24_0(cc.p(display.cx, display.cy), cc.p(0, 0)),
				var_24_0(cc.p(display.cx, display.cy), cc.p(display.width, 0))
			},
			bottom = {
				var_24_0(cc.p(display.cx, display.cy), cc.p(display.width, display.height)),
				var_24_0(cc.p(display.cx, display.cy), cc.p(0, display.height))
			}
		}
	end
end

function PubgMapLayer:_onClickPlayerIcon()
	self.m_mapComp:moveToPoint(var_0_3:getMyPos())
end

function PubgMapLayer:updatePlayerIcon(arg_27_1, arg_27_2)
	if math.abs(arg_27_2.x - arg_27_1.x) < display.cx and math.abs(arg_27_2.y - arg_27_1.y) < display.cy then
		self.m_playerIcon:setVisible(false)
	else
		self:calcBorderAngle()
		self.m_playerIcon:setVisible(true)

		local var_27_0 = self.m_playerIcon:updateArrow(arg_27_1, arg_27_2)
		local var_27_1 = 0
		local var_27_2 = 0
		local var_27_3 = display.cx
		local var_27_4 = display.cy
		local var_27_5 = var_27_0

		if var_27_0 >= self._angle.right[1] and var_27_0 <= 360 or var_27_0 <= self._angle.right[2] and var_27_0 >= 0 then
			var_27_1 = var_27_3 - var_0_6

			if var_27_0 >= self._angle.right[1] then
				var_27_5 = var_27_5 - 360
			end

			var_27_2 = var_27_3 * math.tan(var_27_5 / 180 * math.pi)
		elseif var_27_0 >= self._angle.bottom[1] and var_27_0 <= self._angle.bottom[2] then
			var_27_2 = var_27_4 - var_0_5
			var_27_1 = -var_27_4 * math.tan((var_27_0 - 90) / 180 * math.pi)
		elseif var_27_0 >= self._angle.left[1] and var_27_0 <= self._angle.left[2] then
			var_27_1 = -var_27_3 + var_0_6
			var_27_2 = -var_27_3 * math.tan((var_27_0 - 180) / 180 * math.pi)
		elseif var_27_0 >= self._angle.top[1] and var_27_0 <= self._angle.top[2] then
			var_27_2 = -var_27_4 + var_0_5
			var_27_1 = var_27_4 * math.tan((var_27_0 - 270) / 180 * math.pi)
		end

		if var_27_2 < -var_27_4 + var_0_5 then
			var_27_2 = -var_27_4 + var_0_5
		elseif var_27_2 > var_27_4 - var_0_5 then
			var_27_2 = var_27_4 - var_0_5
		end

		if var_27_1 < -var_27_3 + var_0_6 then
			var_27_1 = -var_27_3 + var_0_6
		elseif var_27_1 > var_27_3 - var_0_6 then
			var_27_1 = var_27_3 - var_0_6
		end

		self.m_playerIcon:setPosition(display.cx + var_27_1, display.cy + var_27_2)
	end
end

function PubgMapLayer:showStartTimePop()
	if self._isExitBack then
		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.pubg.view.pubgMap.PubgMapStartTimePop").new(), {
		blackOpacity = 0,
		ignoreTouch = true,
		touchDisappear = false
	})
end

function PubgMapLayer:showRecoverPop()
	if self._isExitBack then
		return
	end

	self.m_miniMapComp:updateDeadNum(var_0_3:getMyUser():getFailCount())

	if var_0_3:getMyUser():getHp() < 1 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.pubg.view.pubgMap.PubgRecoverPop").new(), {
			isUpdateBlack = true,
			ignoreTouch = true,
			touchDisappear = false
		})
	end
end

function PubgMapLayer:updateMapTime()
	local var_30_0 = var_0_1:getTime()

	self.m_fertileTip:setVisible(false)

	local var_30_1 = self._showTopTipList[#self._showTopTipList]

	if self._showTopTipList[#self._showTopTipList] then
		local var_30_2 = var_30_1.startTime

		if var_30_0 > var_30_1.startTime + var_0_2.TOP_TIP_DELAY then
			table.remove(self._showTopTipList, #self._showTopTipList)
		elseif var_30_2 <= var_30_0 then
			self.m_fertileTip:updateViewComp(var_30_1.content, var_30_2 == var_30_0)
			self.m_fertileTip:setVisible(true)
		end
	end

	if var_30_0 < var_0_3:getMapStartTime() then
		self.m_hasLevelChangeController:setSelectedIndex(0)

		return
	end

	self.m_miniMapComp:updateEventTime((var_0_3:getRefreshEventTime()))
	self.m_miniMapComp:updateStartInvincibleTime(var_0_3:getLastStartInvincibleTime())
	self.m_miniMapComp:updateAirDropTip(var_0_3:hasShowAirDropTip())

	local var_30_3 = var_0_3:getLevelTime()

	if var_30_3 - var_30_0 <= 0 then
		self.m_hasLevelChangeController:setSelectedIndex(0)
	else
		local var_30_4 = var_30_3 - var_30_0 - var_0_3:getLevelChangePreviewTime()

		if var_30_4 <= 1 then
			self.m_mapComp:getFloorComp():refreshShowLevelBaning()
			self.m_timeComp:setInCountdown(true, var_30_4)
		else
			self.m_timeComp:setInCountdown(false)
		end

		self.m_hasLevelChangeController:setSelectedIndex(1)
		self.m_timeComp:setTitle(var_0_1:getLeftMSFormat(var_30_3, true))
		self.m_isMaxLevelController:setSelectedIndex(var_0_3:isMaxLevel() and 1 or 0)
	end

	self:updateAirDrop()
end

function PubgMapLayer:userStarPickAirDrop(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	self.m_mapComp:getFloorComp():playUserPickingAirDrop(arg_31_4)
end

function PubgMapLayer:onAirDropRefresh(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	self:updateAirDrop(arg_32_4.airdrop.id)
	self.m_miniMapComp:playAirDropShow(arg_32_4)
end

function PubgMapLayer:onAirDropEnd(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	self.m_mapComp:getFloorComp():pickAirDropEnd(arg_33_4)
	self.m_miniMapComp:updateMapPos(var_0_3:getMyPos())
end

function PubgMapLayer:updateAirDrop(arg_34_1)
	self.m_mapComp:getFloorComp():refreshAirDrop(arg_34_1)
	self.m_playInfoComp:updateAirDropBuff()
end

function PubgMapLayer:onUnload()
	var_0_3:clearMapCacheData()
end

function PubgMapLayer:onRemoved()
	var_0_3:clearMapCfg()
	var_0_3:clearCacheKnightSpine()
	self.m_mapComp:getFloorComp():clearConfig(var_0_3:getMapId())
	g.core.network.GameNetProxy:send_C2S_Pubg_Exit({})
end

return PubgMapLayer
