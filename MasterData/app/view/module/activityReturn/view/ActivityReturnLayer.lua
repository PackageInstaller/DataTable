local ActivityReturnLayer = class("ActivityReturnLayer", require("app.fairyGUI.activityReturn.UI_ActivityReturnLayer"), function()
	return fgui.GComponent:create({
		resName = "ActivityReturnLayer",
		pkgPath = "ui/activityReturn/activityReturn",
		isFullScreen = true,
		pkgName = "activityReturn"
	}, ...)
end)

function ActivityReturnLayer:ctor(arg_2_1)
	self._cdTimer = nil
	self._firstEnter = true
	self._isShowTask = arg_2_1.route1

	self:_initView()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_RETURN)
end

function ActivityReturnLayer:_initView()
	self.m_topBarComp:setResInfoById(331)
	self:addBg("bg/activityReturn/bg_lyxd_zjm.jpg", false, nil, 1)
	self.m_oneBtn:addClickListener(handler(self, self._onOneBtnClicked))
	self.m_tenBtn:addClickListener(handler(self, self._onTenBtnClicked))
	self.m_wishBtn:addClickListener(handler(self, self._onWishBtnClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskBtnClick))
	self.m_giftBtn:addClickListener(handler(self, self._onGiftBtnClick))
	self.m_detailBtn:addClickListener(handler(self, self._onClickPreview))
	self.m_proList:setVirtual(self)
	self.m_proList:setItemRenderer(handler(self, self._onProItemRender))
	self.m_proList:doFairyBatching(false)
	self.m_skipBox:addClickListener(handler(self, self._onSkipBoxClicked))

	if g.core.model.User.activityReturnData:isShowSkip() then
		self.m_skipBox:setSelected((g.core.model.User.activityReturnData:canSkip()))
		self.m_skipBox:setVisible(true)
	else
		self.m_skipBox:setVisible(false)
	end

	if config.DEBUG_VERSION then
		self.m_mask:addClickListener(handler(self, self._onDebugShowList))
	end

	self.m_gameComp:setSSREffectNode(self.m_effSSR)
	self:_onShowPointSpineEffect()
end

function ActivityReturnLayer:_onProItemRender(arg_4_1, arg_4_2)
	local var_4_0 = {
		pre = self._baseInfo.taskInfo.stageTask[arg_4_1],
		next = self._baseInfo.taskInfo.stageTask[arg_4_1 + 2]
	}

	if var_4_0.pre then
		var_4_0.pre = var_4_0.pre.max
	end

	if var_4_0.next then
		var_4_0.next = var_4_0.next.max
	end

	arg_4_2:updateProItem(self._baseInfo.taskInfo.stageTask[arg_4_1 + 1], var_4_0)
end

function ActivityReturnLayer:_onAddCustomEvent()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RERUN_GETINFO, handler(self, self._onReturnInfoReceive), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RERUN_DRAW, handler(self, self._onReturnDrawReceive), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RERUN_TASKAWARD, handler(self, self._onReturnAwardReceive), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RERUN_CHOOSEAWARD, handler(self, self._updateLayer), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH, handler(self, self._updateLayer), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD, self._updateLayer, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._updateLayer), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onReqInfo), self)
end

function ActivityReturnLayer:_checkTipsGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	local var_6_0 = self.m_wishBtn

	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.RERUN_CHOOSE_AWARD_WEEK_GUIDE) then
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.RERUN_CHOOSE_AWARD_WEEK_GUIDE)
		self:newScheduleOnce(function()
			g.core.service.ServiceManager:getServiceByName("TipGuideService"):reset()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "RERUN_CHOOSE_AWARD_WEEK_GUIDE",
				objects = {
					var_6_0
				}
			})
		end, 0)
	end
end

function ActivityReturnLayer:onLoad()
	self:_onAddCustomEvent()
	self:_onStartTimer()

	if self._firstEnter then
		self:_updateLayer()

		self._firstEnter = false
	else
		self:_onReqInfo()
	end

	self.m_enterTransition:play()
	self.m_effTitle:addEffectSpine({
		remove = true,
		name = "eff_ui_activityReturn_title",
		isLoop = false
	})
	self:_checkTipsGuide()
end

function ActivityReturnLayer:onUnload()
	self:_onStopTimer()
	g.core.model.User.activityReturnData:setBagNewPopEnable(true)
end

function ActivityReturnLayer:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "getStageAward" then
		self:_onReqTasksAward(arg_10_2.idList)

		return true
	elseif arg_10_1 == "showDrawAward" then
		self:_onDrawAwardsShow(arg_10_2.awards, true)

		return true
	elseif arg_10_1 == "updatePointEffectFrame" then
		self:_setPointFrame(arg_10_2.frame)

		return true
	end
end

function ActivityReturnLayer:_updateLayer()
	self._baseInfo = g.core.model.User.activityReturnData:getCurBaseInfo()

	g.core.model.User.activityReturnData:saveCurActivityLocalData()
	self.m_topBarComp:setTitle(self._baseInfo.info.cfg.name)
	self.m_skipBox:setVisible((g.core.model.User.activityReturnData:isShowSkip()))

	if self._firstEnter then
		local var_11_0 = self.m_gameComp:getSize()

		var_11_0.width = self._baseInfo.gameInfo.cfg.area_width
		var_11_0.height = self._baseInfo.gameInfo.cfg.area_height

		self.m_gameComp:setSize(var_11_0)
		self.m_gameComp:updateComp(self._baseInfo.gameInfo)
	end

	self.m_luckText:setText(self._baseInfo.info.cfg.guarantee_times - self._baseInfo.info.curTimes)
	self.m_proList:setNumItems(#self._baseInfo.taskInfo.stageTask)

	local var_11_1

	for iter_11_0, iter_11_1 in ipairs(self._baseInfo.taskInfo.stageTask) do
		if iter_11_1.state == 1 then
			var_11_1 = iter_11_0

			break
		end
	end

	if var_11_1 then
		self.m_proList:scrollToView(var_11_1 - 1, false, true)
	end

	self.m_timesText:setText(self._baseInfo.taskInfo.stageTask[1].cur.num)
	self.m_wishBtn:updateComp(self._baseInfo.info)
	self:_updateBtnCost()
	self:_updateTimer()
	self:_onUpdateRedPoint()

	if self._isShowTask then
		self:_onTaskBtnClick()
	end

	self._isShowTask = false
end

function ActivityReturnLayer:_updateBtnCost()
	local var_12_0 = {}

	var_12_0.isCanRecruit = false
	var_12_0.goods = {
		type = self._baseInfo.info.cfg.recruit_type,
		value = self._baseInfo.info.cfg.recruit_value,
		size = self._baseInfo.info.cfg.recruit_size_1
	}

	self.m_oneBtn:updateView(var_12_0)

	local var_12_1 = {}

	var_12_1.isCanRecruit = false
	var_12_1.goods = {
		type = self._baseInfo.info.cfg.recruit_type,
		value = self._baseInfo.info.cfg.recruit_value,
		size = self._baseInfo.info.cfg.recruit_size_2
	}

	self.m_tenBtn:updateView(var_12_1)
end

function ActivityReturnLayer:_onStartTimer()
	self._cdTimer = self._cdTimer or self:newSchedule(handler(self, self._updateTimer), 60)
end

function ActivityReturnLayer:_onStopTimer()
	if self._cdTimer then
		self:cancelSchedule(self._cdTimer)
	end

	self._cdTimer = nil
end

function ActivityReturnLayer:_updateTimer()
	if self._baseInfo.activityInfo.end_time < g.core.common.ServerTime:getTime() then
		self:_onStopTimer()
		self.m_timeText:setText("")
		self:newScheduleOnce(handler(self, self.replaceToHomeLayer), 0.5)

		return
	end

	local var_15_0, var_15_1, var_15_2, var_15_3 = g.core.common.ServerTime:getLeftTimeParts(self._baseInfo.activityInfo.end_time)

	self.m_timeText:setText(var_15_0 >= 1 and g.core.lang:get(425504, {
		day = var_15_0,
		hour = var_15_1
	}) or g.core.lang:get(425505, {
		hour = var_15_1,
		minute = var_15_2
	}))
end

function ActivityReturnLayer:replaceToHomeLayer()
	self:cancelAllSchedule()
	g.core.module.ModuleManager:popAllPopup()
	g.core.module.ModuleManager:replaceModule(g.view.entrance.HOME)
end

function ActivityReturnLayer:_onReqInfo()
	g.core.network.GameNetProxy:send_C2S_Rerun_GetInfo({})
end

function ActivityReturnLayer:_onReqTasksAward(arg_18_1)
	g.core.network.GameNetProxy:send_C2S_Rerun_TaskAward({
		ids = arg_18_1
	})
end

function ActivityReturnLayer:_onUpdateRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn,
		customData = {}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_giftBtn,
		customData = {}
	})
end

function ActivityReturnLayer:_checkHasChoseAward()
	if not self._baseInfo.info.curAward then
		g.core.module.ModuleManager:tip(g.core.lang:get(425006))

		return false
	end

	return true
end

function ActivityReturnLayer:_onOneBtnClicked()
	if not self:_checkHasChoseAward() then
		return
	end

	if g.core.model.User.bagData:getCountById(self._baseInfo.info.cfg.recruit_type, self._baseInfo.info.cfg.recruit_value) >= self._baseInfo.info.cfg.recruit_size_1 then
		g.core.network.GameNetProxy:send_C2S_Rerun_Draw({
			type = 1
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(425004))
	end
end

function ActivityReturnLayer:_onTenBtnClicked()
	if not self:_checkHasChoseAward() then
		return
	end

	if g.core.model.User.bagData:getCountById(self._baseInfo.info.cfg.recruit_type, self._baseInfo.info.cfg.recruit_value) >= self._baseInfo.info.cfg.recruit_size_2 then
		g.core.network.GameNetProxy:send_C2S_Rerun_Draw({
			type = 2
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(425004))
	end
end

function ActivityReturnLayer:_onWishBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.activityReturn.view.pop.ActivityReturnSelectRolePop").new(self._baseInfo.info)))
end

function ActivityReturnLayer:_onClickPreview()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.activityReturn.view.pop.ActivityReturnPreviewPop").new(self._baseInfo.info, self._baseInfo.gameInfo)))
end

function ActivityReturnLayer:_onTaskBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.activityReturn.view.pop.ActivityReturnTaskPop").new({
		task = self._baseInfo.taskInfo.normalTask,
		activityInfo = self._baseInfo.activityInfo,
		name = self._baseInfo.gameInfo.cfg.task_name
	})))
end

function ActivityReturnLayer:_onGiftBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.shopActivityReturn.shopActivityReturnGiftPop").new({
		route1 = self._baseInfo.info.cfg,
		name = self._baseInfo.gameInfo.cfg.gift_name,
		activityInfo = self._baseInfo.activityInfo
	})))
end

function ActivityReturnLayer:_onSkipBoxClicked(arg_27_1)
	g.core.model.User.activityReturnData:setSkipActionEnable((arg_27_1:getSender():isSelected()))
end

function ActivityReturnLayer:_onReturnInfoReceive(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	self:_updateLayer()
end

function ActivityReturnLayer:_onReturnDrawReceive(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	if g.core.model.User.activityReturnData:canSkip() then
		self:_onDrawAwardsShow(arg_29_4.awards)
	else
		g.core.model.User.activityReturnData:setBagNewPopEnable(false)

		self._lastBgm = g.core.sound.SoundManager:getCurBgm()

		g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_PUZZLE_BGM)
		self.m_hideTransition:play()

		for iter_29_0, iter_29_1 in ipairs(arg_29_4.awards) do
			iter_29_1.quality = self._baseInfo.info.dropQualityMap[table.concat({
				iter_29_1.type,
				iter_29_1.value
			}, "_")]
		end

		self.m_gameComp:playBallGame(arg_29_4.awards)
	end
end

function ActivityReturnLayer:_onReturnAwardReceive(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	local var_30_0 = false

	for iter_30_0, iter_30_1 in ipairs(arg_30_4.ids) do
		if g.core.config.activity_rerun_task_info.get(iter_30_1).task_type == 3 then
			var_30_0 = true

			break
		end
	end

	if not var_30_0 then
		return
	end

	local var_30_1 = {
		showNow = true
	}
	local var_30_2 = {}

	var_30_2.awards = arg_30_4.awards or {}
	var_30_1.award = var_30_2

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, var_30_1)
	self:_updateLayer()
end

function ActivityReturnLayer:_onReturnTaskUpdate(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	self:_updateLayer()
end

function ActivityReturnLayer:_onDrawAwardsShow(arg_32_1, arg_32_2)
	local var_32_0 = {
		ignoreKnight = true,
		awards = arg_32_1
	}

	if arg_32_2 then
		var_32_0.func = handler(self, self._onDrawAwardShowEnd)

		g.core.sound.SoundManager:playMusic(self._lastBgm)

		if require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("rerun_easy") then
			self:_onDrawAwardShowEnd(#arg_32_1)

			return
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		award = var_32_0
	})
	self:_updateLayer()
end

function ActivityReturnLayer:_onDrawAwardShowEnd(arg_33_1)
	self.m_revertTransition:play()
	self.m_effRefresh:addEffectSpine({
		remove = true,
		name = "eff_ui_activityReturn_refresh",
		isLoop = false
	})
	self:_updateLayer()
	g.core.model.User.activityReturnData:setBagNewPopEnable(true)

	if require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("rerun_easy") and type(arg_33_1) == "number" then
		if arg_33_1 == 1 then
			self:newScheduleOnce(handler(self, self._onOneBtnClicked), 0.5)
		else
			self:newScheduleOnce(handler(self, self._onTenBtnClicked), 0.5)
		end
	end
end

function ActivityReturnLayer:_onShowPointSpineEffect()
	self._pointEffect = self._pointEffect or self.m_effPoint:addEffectSpine({
		remove = false,
		name = "eff_ui_activityReturn_pointer"
	})

	self._pointEffect:play(0, 0)
end

function ActivityReturnLayer:_setPointFrame(arg_35_1)
	if self._pointEffect then
		self._pointEffect:play(arg_35_1, arg_35_1)
	end
end

function ActivityReturnLayer:_onDebugShowList()
	self.m_gameComp:onDebugShowList()
end

return ActivityReturnLayer
