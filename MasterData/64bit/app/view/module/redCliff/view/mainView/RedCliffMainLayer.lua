local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.const.ConstMgr.ShopConst
local var_0_5 = g.core.model.User.redCliffData
local var_0_6 = g.core.const.ConstMgr.RedCliffConst
local var_0_7 = g.core.common.ServerTime
local RedCliffMainLayer = class("RedCliffMainLayer", require("app.fairyGUI.redCliff.UI_RedCliffMainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/redCliff/redCliff",
		resName = "RedCliffMainLayer",
		pkgName = "redCliff",
		isFullScreen = true
	}, ...)
end)

function RedCliffMainLayer:ctor()
	self:_initListener()
	self:_initView()

	self._cdHandler = nil
	self._cdHandler2 = nil
	self._isFirstEnter = true

	var_0_0:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.RED_CLIFF)
end

function RedCliffMainLayer:_initView()
	self:addBg("bg/redCliff/bg_hdzb_main.jpg")
	self.m_topBarComp:setResInfoById(var_0_6.TOP_BAR_ID)
end

function RedCliffMainLayer:_initListener()
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_taskBtn:addClickListener(handler(self, self._onClickTaskBtn))
end

function RedCliffMainLayer:_updateView()
	self.m_detailComp:updateDetailView()
	self.m_rightComp:updateRightComp()

	if self._isFirstEnter then
		self.m_rightComp:updateListSelected()
		self.m_rightComp:playPoolCompEnterTransition()

		self._isFirstEnter = false
	else
		self.m_rightComp:refreshListView()
	end
end

function RedCliffMainLayer:_onClickShopBtn()
	var_0_3:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_4.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_4.SHOP_TYPE.RED_CLIFF
	})
end

function RedCliffMainLayer:_onClickRankBtn()
	var_0_3:pushModule(g.view.entrance.RED_CLIFF_RANK_LAYER)
end

function RedCliffMainLayer:_onClickTaskBtn()
	var_0_3:pushPopup((require("app.view.module.redCliff.view.mainView.RedCliffTaskPop").new()))
end

function RedCliffMainLayer:_refreshState()
	self.m_rightComp:updateRightComp()
	self.m_rightComp:refreshListView()
end

function RedCliffMainLayer:onLoad()
	local var_10_0 = var_0_5:getGameStage()

	if var_10_0 == var_0_6.GAME_STAGE.NONE then
		var_0_3:tip(g.core.lang:get(421038))
		self:newScheduleOnce(function()
			var_0_3:switchModuleIntelligent(g.view.entrance.HOME)
		end)

		return
	end

	if var_10_0 == var_0_6.GAME_STAGE.RESULT then
		var_0_3:tip(g.core.lang:get(421038))
		self:newScheduleOnce(function()
			var_0_3:switchModuleIntelligent(g.view.entrance.RED_CLIFF_EXHIBITION_LAYER)
		end)

		return
	end

	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_HAIDAOZHENGBA)
	self.m_enterTransition:play(handler(self, function()
		var_0_0:dispatchEvent(var_0_1.EVENT_GUIDE_READY)

		if not g.core.guide.GuideProxy:isGuideRunning() then
			if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.RED_CLIFF_APPLY_GUIDE) then
				if g.core.model.User.redCliffData:isApply() then
					g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.RED_CLIFF_APPLY_GUIDE)
				else
					self:newScheduleOnce(handler(self, self._checkTipWeakGuide))
				end
			end
		end
	end))
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_CHI_BI_GETINFO, self._onRcvGetInfo, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_CHI_BI_APPLY, self._onRcvApply, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_CHI_BI_ENTERROOM, self._onRcvEnterRoom, self)
	var_0_0:addEventListener(var_0_1.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayNotify, self)
	var_0_0:addEventListener(var_0_1.RED_CLIFF_APPLY_GUIDE, self._checkTipWeakGuide, self)
	var_0_0:dispatchEvent(var_0_1.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
	var_0_2:send_C2S_ChiBi_GetInfo({})
end

function RedCliffMainLayer:onUnload()
	var_0_0:dispatchEvent(var_0_1.EVENT_TICK_WEAK_GUIDE_FINISH)
	self:cancelSchedule(self._cdHandler)

	self._cdHandler = nil

	self:cancelSchedule(self._cdHandler2)

	self._cdHandler2 = nil
end

function RedCliffMainLayer:_checkTipWeakGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	local var_15_0 = var_0_5:getApplyState()

	if var_15_0 == var_0_6.APPLY_STATE.APPLY_ABLE then
		self:newScheduleOnce(function()
			var_0_0:dispatchEvent(var_0_1.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "RED_CLIFF_APPLY_GUIDE",
				objects = {
					self.m_rightComp:getChild("applyBtn")
				}
			})
		end, 0)
	elseif var_15_0 == var_0_6.APPLY_STATE.APPLY_END then
		self:newScheduleOnce(function()
			var_0_0:dispatchEvent(var_0_1.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "RED_CLIFF_APPLY_FAIL_GUIDE",
				objects = {
					self.m_rightComp:getChild("applyBtn")
				}
			})
		end, 0)
	end
end

function RedCliffMainLayer:_onRcvGetInfo(arg_18_1, arg_18_2, arg_18_3)
	self:_updateView()

	if not self._cdHandler then
		local var_18_0 = var_0_5:getCurrentPoolFightTime(var_0_5:getMyPoolId())

		if var_18_0 then
			local var_18_1 = var_0_7:getTime()

			if var_18_1 < var_18_0.startTime then
				self._cdHandler = self:newScheduleOnce(handler(self, self._refreshState), var_18_0.startTime - var_18_1 + 1)
				self._cdHandler2 = self._cdHandler2 or self:newScheduleOnce(handler(self, self._refreshState), var_18_0.endTime - var_18_1 + 1)
			elseif var_18_1 < var_18_0.endTime then
				self._cdHandler = self:newScheduleOnce(handler(self, self._refreshState), var_18_0.endTime - var_18_1 + 1)
			end
		end
	end

	self.m_taskBtn:setVisible(var_0_5:getGameStage() ~= var_0_6.GAME_STAGE.APPLY)
end

function RedCliffMainLayer:_onRcvApply(arg_19_1, arg_19_2, arg_19_3)
	self.m_rightComp:updateRightComp()
	self.m_rightComp:refreshListView()

	if not self._cdHandler then
		local var_19_0 = var_0_5:getCurrentPoolFightTime(var_0_5:getMyPoolId())
		local var_19_1 = var_0_7:getTime()

		if var_19_1 < var_19_0.startTime then
			self._cdHandler = self:newScheduleOnce(handler(self, self._refreshState), var_19_0.startTime - var_19_1 + 1)
			self._cdHandler2 = self._cdHandler2 or self:newScheduleOnce(handler(self, self._refreshState), var_19_0.endTime - var_19_1 + 1)
		elseif var_19_1 < var_19_0.endTime then
			self._cdHandler = self:newScheduleOnce(handler(self, self._refreshState), var_19_0.endTime - var_19_1 + 1)
		end
	end
end

function RedCliffMainLayer:_onRcvEnterRoom(arg_20_1, arg_20_2, arg_20_3)
	g.core.module.ModuleManager:pushModule(g.view.entrance.RED_CLIFF_STAGE)
end

function RedCliffMainLayer:_onCrossDayNotify()
	local var_21_0 = var_0_5:getGameStage()

	if var_21_0 == var_0_6.GAME_STAGE.NONE then
		var_0_3:tip(g.core.lang:get(421038))
		self:newScheduleOnce(function()
			var_0_3:switchModuleIntelligent(g.view.entrance.HOME)
		end)

		return
	end

	if var_21_0 == var_0_6.GAME_STAGE.RESULT then
		var_0_3:tip(g.core.lang:get(421038))
		self:newScheduleOnce(function()
			var_0_3:switchModuleIntelligent(g.view.entrance.RED_CLIFF_EXHIBITION_LAYER)
		end)

		return
	end

	var_0_2:send_C2S_ChiBi_GetInfo({})
end

return RedCliffMainLayer
