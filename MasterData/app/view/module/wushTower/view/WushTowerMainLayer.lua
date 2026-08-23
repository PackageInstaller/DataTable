local var_0_0 = g.core.model.User.wushTowerData
local var_0_1 = g.core.const.ConstMgr.WushTowerConst
local var_0_2 = g.core.common.ServerTime
local var_0_3 = g.core.config.parameter_info
local var_0_4 = g.core.const.ConstMgr.PARAMETER_CONST
local WushTowerMainLayer = class("WushTowerMainLayer", require("app.fairyGUI.wushTower.UI_WushTowerMainLayer"), function()
	return fgui.GComponent:create({
		resName = "WushTowerMainLayer",
		pkgPath = "ui/wushTower/wushTower",
		isFullScreen = true,
		pkgName = "wushTower"
	}, ...)
end)

function WushTowerMainLayer:ctor()
	self:_initMainLayerUI()
	self:_initRegisterListen()

	if GUIDE_EDIT then
		self.m_guideComp1:setTouchable(true)
		self.m_guideComp2:setTouchable(true)
	else
		self.m_guideComp1:setTouchable(false)
		self.m_guideComp2:setTouchable(false)
	end
end

function WushTowerMainLayer:_initMainLayerUI()
	self._cdScheduler = nil
	self._isResetWushTower = false

	self.m_topBarComp:setResInfoById(var_0_1.WUSHTOWER_MAIN_TOPBAR)

	local var_3_0 = self:addBg(var_0_0:getBackGroundUrlByZoneId(var_0_0:getZoneId(), true), nil, nil, 1)

	var_3_0:setOpacity(50)
	var_3_0:runFGAction(fgui.FFadeIn:create(0.5))
	self.m_depthComp:updateTowerDepth((var_0_0:getZoneId()))
	self.m_enterTransition:play()

	if var_0_0:isWushTowerReset() then
		g.core.module.ModuleManager:tip(g.core.lang:get(408422))
	end
end

function WushTowerMainLayer:_initRegisterListen()
	self.m_bagBtn:addClickListener(handler(self, self._onClickBagBtn))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
	self.m_taskBtn:addClickListener(handler(self, self._onClickTaskBtn))
end

function WushTowerMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_NEXTGRIDS, self._onS2CDeadTowerNextGrids, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_ENTERINFO, self._S2CDeadTowerEnterInfo, self)
	self:_refreshMainLayerUI()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.WUSH_TOWER)
end

function WushTowerMainLayer:_refreshMainLayerUI()
	if var_0_0:isPassZone() then
		if var_0_0:getZoneId() == var_0_0:getMaxZoneId() then
			self.m_isFinishController:setSelectedIndex(1)
			self.m_finishTransition:play()
			self:_updateMainView()
		else
			self.m_isFinishController:setSelectedIndex(0)
			self.m_zoneComp:playBossPassTransition(handler(self, function()
				g.core.network.GameNetProxy:send_C2S_DeadTower_NextGrids({})
			end))
		end
	else
		self:_updateMainView()
	end

	self._cdScheduler = self._cdScheduler or self:newSchedule(handler(self, self._onCheckWushTowerReset), 1)
end

function WushTowerMainLayer:_S2CDeadTowerEnterInfo()
	self:_refreshMainLayerUI()
end

function WushTowerMainLayer:_onS2CDeadTowerNextGrids()
	if var_0_0:isWushTowerHpRecover() then
		g.core.module.ModuleManager:tip(g.core.lang:get(408423))
	end

	self.m_zoneComp:setVisible(false)
	self.m_bgComp:goToNextFloorTrainstion(handler(self, function()
		self.m_zoneComp:setVisible(true)
		self:_updateMainView(true)
		self.m_zoneComp:playEnterTransition()
	end))
end

function WushTowerMainLayer:_updateMainView(arg_11_1)
	if arg_11_1 then
		self.m_depthComp:playRollUpTransition()
	else
		self.m_bgComp:playInTransition()
	end

	self.m_zoneComp:updateZoneStageInfo(arg_11_1)
	self.m_playTimeComp:initView({
		playNum = 999,
		getTimesFunc = function()
			return var_0_0:getChallengeNum()
		end,
		fullTime = var_0_3.get(var_0_4.WUSH_TOWER_FAIL_TIME).parameter
	})
	self:_refreshResetTimeStr()
end

function WushTowerMainLayer:_onClickBagBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.wushTower.view.WushTowerCardBagPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function WushTowerMainLayer:_onClickRankBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.wushTower.view.WushTowerRankPop").new()))
end

function WushTowerMainLayer:_onClickShopBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.WUSH_TOWER
	})
end

function WushTowerMainLayer:_onClickTaskBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.wushTower.view.WushTowerDailyTaskPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function WushTowerMainLayer:_onCheckWushTowerReset()
	if var_0_2:getTime() > var_0_0:getNextResetTime() then
		g.core.network.GameNetProxy:send_C2S_DeadTower_EnterInfo({})

		if self._cdScheduler then
			self:cancelSchedule(self._cdScheduler)

			self._cdScheduler = nil
		end
	else
		self:_refreshResetTimeStr()
	end
end

function WushTowerMainLayer:_refreshResetTimeStr()
	self.m_resetTimeComp:setTitle((var_0_2:secondToHMSString(math.max(0, (g.core.common.ServerTime:getLeftSeconds((var_0_0:getNextResetTime())))))))
end

function WushTowerMainLayer:onUnload()
	g.core.event.EventManager:removeListenerWithTarget(self)

	if self._cdScheduler then
		self:cancelSchedule(self._cdScheduler)

		self._cdScheduler = nil
	end
end

return WushTowerMainLayer
