local MineConst = require("app.view.module.mine.const.MineConst")
local MineMainLayer = class("MineMainLayer", require("app.fairyGUI.mine.UI_MineMainLayer"), function()
	return fgui.GComponent:create({
		resName = "MineMainLayer",
		pkgPath = "ui/mine/mine",
		isFullScreen = true,
		pkgName = "mine"
	})
end)

MineMainLayer.Z_OFFSET = 0
MineMainLayer.MAP_HEIGHT = 1600

function MineMainLayer:ctor()
	self._curTouchX = 0
	self._curTouchY = 0
	self._scaleIndex = 1
	self._isFirstEnter = true
	self._isFinish = false
	self._countdownSchedule = nil
	self._firstEnterWithReq = false
	self._maxPower = g.core.config.mine_parameter_info.indexOf(1).max_hp
	self.m_bgCompObj = self.m_bgComp:displayObject()

	self.m_bgCompObj:setPositionZ(MineMainLayer.Z_OFFSET)
	self.m_bgComp:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_bgComp:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self.m_assembleBtn:addClickListener(handler(self, self._onAssembleBtnClick))
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskBtnClick))
	self.m_fightResultBtn:addClickListener(handler(self, self._onFightResultBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_topBar:setResInfoById(95)
	self.m_topBar:setHomeCallBack(function()
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end)
	self.m_topBar:setReturnCallBack(function()
		g.core.module.ModuleManager:popModule()
	end)
	self:_updateEdge()
	self.m_arrowComp:setVisible(false)
	self.m_arrowComp:getChild("playerIconComp"):getChild("icon"):updateAsUser(g.core.model.User:getUserData())
	self.m_arrowComp:addClickListener(handler(self, self._onClickSelfIcon))
	self.m_enterTransition:setHook("move", handler(self, self._moveToMainRole))
	self.m_bgComp:setTouchable(false)
	self.m_enterTransition:play(handler(self, self._onAnimEnterFinish))
end

function MineMainLayer:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_GETINFO, self._onRcvMineInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_MOVECITY, self._onRcvMoveCity, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_BUYPOWER, self._onRcvBuyPower, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_ATTACKUSERFINISH, self._onRcvAttackFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_PLAYERPOWERNOTIFY, self._onRcvPowerNotify, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, self._onRcvShopping, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_MASS, self._onRcvMineMass, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_MASSNOTIFY, self._onRcvMineMassNotify, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_CAPTURENOTIFY, self._onRcvCaptureNotify, self)

	local var_5_0, var_5_1 = g.core.model.User.mineData:getMoveReqPath()

	if var_5_0 then
		g.core.network.GameNetProxy:send_C2S_Mine_MoveCity({
			cityId = var_5_1
		})
	else
		g.core.network.GameNetProxy:send_C2S_Mine_GetInfo({})
	end

	self:_updateCountDown()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.MINE)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MINE_MAIN_LAYER)
	self:_updateCurPower()
end

function MineMainLayer:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "Mine_Move_City_move_end" then
		self:cancelSchedule(self._moveSchedule)

		self._moveSchedule = nil
	end
end

function MineMainLayer:_onRcvMineMass()
	self:_updateGatherState()
end

function MineMainLayer:_onRcvMineMassNotify()
	self:_updateGatherState()
end

function MineMainLayer:_onRcvCaptureNotify()
	self:_updateGatherState()
end

function MineMainLayer:_updateGatherState()
	self.m_gatherEffComp:removeAllEffect()
	self.m_gatherController:setSelectedIndex(0)

	if g.core.model.User.guildData:hasGuild() and g.core.model.User.mineData:isGathering() then
		self.m_gatherEffComp:addEffectSpine({
			isLoop = true,
			name = "eff_ui_mine_going"
		})
		self.m_gatherController:setSelectedIndex(1)

		local var_10_0 = g.core.model.User.mineData:getGatherCityId()

		if var_10_0 > 0 then
			local var_10_1 = g.core.model.User.mineData:getCityObjById(var_10_0)

			self.m_gatherGuildName:setText(g.core.lang:get(307517, {
				name = g.core.config.mine_map_info.get(var_10_0).name
			}))

			local var_10_2 = 0
			local var_10_3 = var_10_1:getGuildData()

			if var_10_3 and var_10_3.id == g.core.model.User.guildData:getGuildId() and var_10_1:isCityOccu() then
				var_10_2 = 1

				if var_10_1:isCityUnique() then
					var_10_2 = 2
				end
			end

			self.m_gatherStateController:setSelectedIndex(var_10_2)
		end
	end
end

function MineMainLayer:_updateCurPower()
	self.m_forceComp:updateView({
		max = self._maxPower,
		cur = g.core.model.User.mineData:getCurPower()
	})
end

function MineMainLayer:_onAssembleBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.mine.view.pop.MineGatherPop").new(), {
		touchDisappear = true
	})
end

function MineMainLayer:_onRankBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.mine.view.pop.MineRankPop").new(), {
		touchDisappear = true
	})
end

function MineMainLayer:_onShopBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.MINE
	})
end

function MineMainLayer:_onTaskBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.mine.view.pop.MineTaskPop").new(), {
		touchDisappear = true
	})
end

function MineMainLayer:_onFightResultBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.mine.view.pop.MineFightResultPop").new(), {
		touchDisappear = true
	})
end

function MineMainLayer:_onRcvMineInfo(arg_17_1, arg_17_2, arg_17_3)
	if arg_17_3.ret == g.core.network.proto.RET_MINE_ACTIVITY_STATUS_NOT_SAME or arg_17_3.status ~= MineConst.TIME_STAGE.NORMAL and arg_17_3.status ~= MineConst.TIME_STAGE.TOTAL_WAR then
		if not self._firstEnterWithReq then
			g.core.module.ModuleManager:tip(g.core.lang:get(307536))
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

			self._firstEnterWithReq = true
		end

		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_assembleBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})

	self._ownCity = g.core.model.User.mineData:getOwnCity()

	self.m_bgComp:updateLandView()

	if self._isFirstEnter then
		self._isFirstEnter = false
	end

	self.m_infoComp:updateTimeStage()
	self:_updateCountDown()

	if self._countdownSchedule then
		self:cancelSchedule(self._countdownSchedule)
	end

	self._countdownSchedule = self:newSchedule(handler(self, self._updateCountDown), 1)

	self:_updateCurPower()
	self:_updateGatherState()
end

function MineMainLayer:_onAnimEnterFinish()
	self.m_bgComp:setTouchable(true)
end

function MineMainLayer:_onRcvMoveCity()
	if not self._moveSchedule then
		self:cancelSchedule(self._moveSchedule)

		self._moveSchedule = nil
	end

	self.m_arrowComp:setVisible(false)

	self._moveSchedule = self:newSchedule(handler(self, self._moveWithMainRole), 0)
end

function MineMainLayer:_updateCountDown()
	self.m_infoComp:updateCountDown()
	self.m_bgComp:checkShieldInTime()
	self.m_shieldBtn:onCD()

	if g.core.model.User.mineData:getSeasonEndTime() - g.core.common.ServerTime:getTime() <= 0 and not self._inReplace then
		self._inReplace = true

		self:newScheduleOnce(function()
			g.core.module.ModuleManager:replaceModuleRoot(g.view.entrance.MINE_RESULT)
		end, 0)
	end
end

function MineMainLayer:_moveToMainRole()
	self.m_bgComp:setTouchable(false)

	local var_22_0 = {
		srcX = self.m_bgComp:getX(),
		srcY = self.m_bgComp:getY()
	}

	var_22_0.time = 1
	var_22_0.interval = 0.02

	self:newScheduleInterval(function(arg_23_0, arg_23_1, arg_23_2)
		var_22_0.interval = arg_23_1

		self:scrollToChapter(var_22_0)

		if arg_23_2 then
			self.m_bgComp:setTouchable(true)
		end
	end, 0, 1)
end

function MineMainLayer:scrollToChapter(arg_24_1)
	self:_updatePlayerArrow()

	local var_24_0, var_24_1, var_24_2, var_24_3

	if arg_24_1 then
		var_24_0 = arg_24_1.srcX or 0

		if arg_24_1 then
			var_24_1 = arg_24_1.srcY or 0

			if arg_24_1 then
				var_24_2 = arg_24_1.time or 1

				if arg_24_1 then
					var_24_3 = arg_24_1.interval or 0.02
				end
			end
		end
	end

	local var_24_4 = self.m_bgComp:getMainRolePos()
	local var_24_5, var_24_6 = self:_checkPosition(display.width / 2 - var_24_4.x, display.height / 2 - var_24_4.y)
	local var_24_8, var_24_9, var_24_10 = self:_checkPosition(self.m_bgComp:getX() + var_24_3 * (var_24_5 - var_24_0) / var_24_2, self.m_bgComp:getY() + var_24_3 * (var_24_6 - var_24_1) / var_24_2)

	self.m_bgComp:setPosition(var_24_8, var_24_9)
	self.m_bgCompObj:setPositionZ(var_24_10)
end

function MineMainLayer:_moveWithMainRole()
	local var_25_0 = self.m_bgComp:getMainRolePos()
	local var_25_1, var_25_2, var_25_3 = self:_checkPosition(display.width / 2 - var_25_0.x, display.height / 2 - var_25_0.y)

	self.m_bgComp:setPosition(var_25_1, var_25_2)
	self.m_bgCompObj:setPositionZ(var_25_3)
end

function MineMainLayer:_updateEdge()
	local var_26_0 = self.m_bgComp:getHeight()
	local var_26_1 = var_26_0 * (1 - math.cos((math.rad(MineConst.X_ROTATE))))

	self._upEdge = -var_26_1 / 2 + ({
		90,
		-140
	})[self._scaleIndex]
	self._downEdge = -(var_26_0 - display.height - var_26_1 / 2) + ({
		-150,
		-50
	})[self._scaleIndex]
	self._leftEdge = ({
		400,
		-70
	})[self._scaleIndex]
	self._rightEdge = -(self.m_bgComp:getWidth() - display.width) + ({
		-300,
		120
	})[self._scaleIndex]
end

function MineMainLayer:_onTouchBegin(arg_27_1)
	arg_27_1:captureTouch()

	local var_27_0 = arg_27_1:getInput():getPosition()

	self._curTouchX = var_27_0.x
	self._curTouchY = var_27_0.y
end

function MineMainLayer:_onTouchMove(arg_28_1)
	local var_28_0 = arg_28_1:getInput():getPosition()

	self:_moveMap(var_28_0.x - self._curTouchX, var_28_0.y - self._curTouchY)

	self._curTouchX = var_28_0.x
	self._curTouchY = var_28_0.y
end

function MineMainLayer:_moveMap(arg_29_1, arg_29_2)
	local var_29_0 = self.m_bgComp:getPosition()
	local var_29_1 = math.max(math.min(var_29_0.y + arg_29_2 * 1.1, self._upEdge), self._downEdge)

	self.m_bgComp:setPosition(math.min(self._leftEdge, math.max(var_29_0.x + arg_29_1 * 1.1, self._rightEdge)), var_29_1)
	self.m_bgCompObj:setPositionZ(self.m_bgCompObj:getPositionZ() - (var_29_1 - var_29_0.y) * math.tan((math.rad(MineConst.X_ROTATE))))
	self:_updatePlayerArrow()
end

function MineMainLayer:_localToCity(arg_30_1)
	if arg_30_1 <= 0 then
		return
	end

	local var_30_0, var_30_1 = self.m_bgComp:getMapPosByCityId(arg_30_1)
	local var_30_2, var_30_3, var_30_4 = self:_checkPosition(display.width / 2 - var_30_0, display.height / 2 - var_30_1)

	if self._isFirstEnter then
		local var_30_5, var_30_6, var_30_7 = self:_checkPosition(var_30_2, var_30_3 - 130)

		self.m_bgComp:setPosition(var_30_5, var_30_6)
		self.m_bgCompObj:setPositionZ(var_30_7)

		local var_30_8 = {
			srcX = var_30_5,
			srcY = var_30_6
		}

		var_30_8.time = 0.6
		var_30_8.interval = 0.02

		self:newScheduleInterval(function(arg_31_0, arg_31_1, arg_31_2)
			var_30_8.interval = arg_31_1

			self:scrollToChapter(var_30_8)
		end, 0, 0.6)
	else
		self.m_bgComp:setPosition(var_30_2, var_30_3)
		self.m_bgCompObj:setPositionZ(var_30_4)
	end
end

function MineMainLayer:_checkPosition(arg_32_1, arg_32_2)
	local var_32_0 = math.min(self._upEdge, math.max(arg_32_2, self._downEdge))

	return math.min(self._leftEdge, math.max(arg_32_1, self._rightEdge)), var_32_0, (self:_getZcoordByY(var_32_0))
end

function MineMainLayer:_getZcoordByY(arg_33_1)
	return -(((MineMainLayer.MAP_HEIGHT - display.height) / 2 + arg_33_1) * math.tan((math.rad(MineConst.X_ROTATE))))
end

function MineMainLayer:_updatePlayerArrow()
	local var_34_0 = self.m_bgComp:getMainPlayer()

	if var_34_0 then
		local var_34_1, var_34_2, var_34_3 = self:_isShowArrowComp((self:globalToLocal(var_34_0:localToGlobal(cc.p(0, 0)))))

		self.m_arrowComp:setVisible(var_34_1)

		if var_34_2 then
			self.m_arrowComp:setAniRotate(var_34_2)
		end
	end
end

function MineMainLayer:_isShowArrowComp(arg_35_1)
	if not cc.rectContainsPoint(cc.rect(0, 0, self:getWidth(), self:getHeight()), arg_35_1) then
		local var_35_1 = self:getHeight() / 2

		return true, math.radian2angle((cc.pToAngleSelf(cc.pSub(arg_35_1, cc.p(0, var_35_1))))) + 50, cc.p(self:getWidth() - 150, var_35_1)
	else
		return false
	end
end

function MineMainLayer:_onRcvBuyPower(arg_36_1, arg_36_2, arg_36_3)
	g.core.module.ModuleManager:tip(g.core.lang:get(307525, {
		num = arg_36_3.num,
		name = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_RESOURCE,
			value = g.core.common.Goods.RESOURCE.TYPE_FORCES
		}).name
	}))
	self:_updateCurPower()
end

function MineMainLayer:_onRcvAttackFinish()
	self:_updateCurPower()
end

function MineMainLayer:_onRcvPowerNotify()
	self:_updateCurPower()
end

function MineMainLayer:_onRcvShopping(arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = g.core.config.shop_score_info.get(arg_39_3.info.id)

	if var_39_0.type == g.core.common.Goods.TYPE_RESOURCE and (var_39_0.value == g.core.common.Goods.RESOURCE.TYPE_GRAIN or var_39_0.value == g.core.common.Goods.RESOURCE.TYPE_ARMY_TOKEN) then
		g.core.module.ModuleManager:tip(g.core.lang:get(307526, {
			name = var_39_0.name,
			num = var_39_0.size * arg_39_3.info.num
		}))
	end
end

function MineMainLayer:_onClickSelfIcon()
	self:_moveToMainRole()
end

function MineMainLayer:onUnload()
	if not self._isFinish then
		g.core.network.GameNetProxy:send_C2S_Mine_Leave({})
	end
end

return MineMainLayer
