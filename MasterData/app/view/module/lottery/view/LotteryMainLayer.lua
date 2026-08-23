local LotteryConst = require("app.view.module.lottery.const.LotteryConst")
local LotteryMainLayer = class("LotteryMainLayer", require("app.fairyGUI.lottery.UI_LotteryMainLayer"), function()
	return fgui.GComponent:create({
		resName = "LotteryMainLayer",
		pkgPath = "ui/lottery/lottery",
		isFullScreen = true,
		pkgName = "lottery"
	}, ...)
end)

function LotteryMainLayer:ctor()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.LOTTERY)

	self._poolInfo = nil
	self._baseInfo = nil
	self._needRandom = true
	self._oneKeying = false

	self:addListen(self.m_layoutComp)
	self.m_taskBtn:addClickListener(handler(self, self._onTaskBtnClick))
	self.m_turnBtn:addClickListener(handler(self, self._onTurnBtnClick))
	self.m_checkBtn:addClickListener(handler(self, self._onCheckBtnClick))
	self.m_bigRewardIcon:addClickListener(handler(self, self._onBigIconClick))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyClick))
	self.m_topBarComp:setResInfoById(317)
	self:addBg("bg/activity/bg_yinghuomizang_main.jpg", false, nil, 1)
	self.m_qiehuanTransition:setHook("switch", handler(self, self._onEnterNextBackEnd))
	g.core.model.User.lotteryData:saveNewActivity()
end

function LotteryMainLayer:receiveCompEvent(arg_3_1, arg_3_2)
	if arg_3_1 == "drawLottery" then
		g.core.network.GameNetProxy:send_C2S_Lottery_Draw({
			grid_id = arg_3_2.pos
		})

		return true
	elseif arg_3_1 == "rareAwardShow" then
		g.core.module.ModuleManager:awardSummary(arg_3_2.awards, nil, nil, nil, handler(self, self._showNextRoundTip))

		return true
	end

	return false
end

function LotteryMainLayer:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._reqInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_LOTTERY_GETINFO, handler(self, self._updateLayer), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_LOTTERY_DRAW, handler(self, self._onDrawReward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_LOTTERY_NEXT_POOL, handler(self, self._onEnterNext), self)
end

function LotteryMainLayer:onLoad()
	self:_addCustomListener()
	self:_updateLayer()
	self.m_enterTransition:play(handler(self, self._playLayerEffect))
	self.m_layoutComp:playCellEnterAction()
end

function LotteryMainLayer:onUnload()
	self:_onStopTimeSchedule()
end

function LotteryMainLayer:_updateLayer()
	self._baseInfo = g.core.model.User.lotteryData:getCurBaseInfo()
	self._poolInfo = g.core.model.User.lotteryData:getCurPoolInfo()

	self.m_roundText:setText(self._poolInfo.cfg.round)
	self.m_bigRewardIcon:setURL((g.core.common.Path:getIconByTypeValue(self._poolInfo.dropInfo.rareAward.type, self._poolInfo.dropInfo.rareAward.value)))
	self.m_bigRewardNumText:setText(g.core.lang:get(107073, {
		num = self._poolInfo.dropInfo.rareAward.size
	}))
	self.m_miniIcon:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_RESOURCE, LotteryConst.COST_ID, true)))
	self.m_tipNumText:setText(g.core.lang:get(112540, {
		target = 1,
		cur = g.core.model.User.resourceData:getResourceById(LotteryConst.COST_ID)
	}))

	if self._poolInfo.cfg.next_pool == 0 then
		self.m_isMaxRoundController:setSelectedIndex(1)
	else
		self:_updateEnterNextReward()
		self.m_isMaxRoundController:setSelectedIndex(0)
	end

	if g.core.model.User.lotteryData:getRareGridID() > 0 then
		self.m_rewardStateController:setSelectedIndex(1)
	else
		self.m_rewardStateController:setSelectedIndex(0)
	end

	self.m_layoutComp:updateComp(self._poolInfo.mapInfo, self._needRandom)

	if self._baseInfo.activityInfo.end_time - g.core.common.ServerTime:getTime() > 0 then
		self:_onStartTimeSchedule()
		self:_updateTime()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_taskBtn:getChild("redPointComp")
		})
	else
		self:newScheduleOnce(handler(self, function(arg_8_0)
			g.core.module.ModuleManager:popAllPopup()
			g.core.module.ModuleManager:onlyPopSelfByDisplay(arg_8_0)
		end), 0.5)
	end

	self._needRandom = false
end

function LotteryMainLayer:_updateEnterNextReward()
	local var_9_0 = g.core.config.lottery_pool_info.get(self._poolInfo.cfg.next_pool)
	local var_9_1 = {
		type = var_9_0.first_reward_type,
		value = var_9_0.first_reward_value,
		size = var_9_0.first_reward_size
	}

	self.m_nextMiniIcon:setURL((g.core.common.Path:getIconByTypeValue(var_9_1.type, var_9_1.value, true)))
	self.m_nextTipNumText:setText(var_9_1.size)
end

function LotteryMainLayer:_onStartTimeSchedule()
	self._timeSchedule = self._timeSchedule or self:newSchedule(handler(self, self._updateTime), 1)
end

function LotteryMainLayer:_onStopTimeSchedule()
	if self._timeSchedule then
		self:cancelSchedule(self._timeSchedule)
	end

	self._timeSchedule = nil
end

function LotteryMainLayer:_updateTime()
	local var_12_0 = self._baseInfo.activityInfo.end_time - g.core.common.ServerTime:getTime()

	if var_12_0 > 0 then
		self.m_timeText:setText((g.core.common.ServerTime:getCountDownBySecond(var_12_0)))
	else
		self.m_timeText:setText("")
		self:_onStopTimeSchedule()
		self:_reqInfo()
	end
end

function LotteryMainLayer:_reqInfo()
	g.core.network.GameNetProxy:send_C2S_Lottery_GetInfo({})
end

function LotteryMainLayer:_onBigIconClick()
	g.core.common.GlobalFunc.pushInfoPop(self._poolInfo.dropInfo.rareAward)
end

function LotteryMainLayer:_onTaskBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.lottery.view.LotteryTaskPop").new(self._baseInfo.taskInfoList)))
end

function LotteryMainLayer:_onCheckBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.lottery.view.LotteryPreviewPop").new({
		{
			isRare = true,
			awards = {
				self._poolInfo.dropInfo.rareAward
			}
		},
		{
			awards = self._poolInfo.dropInfo.list
		}
	})))
end

function LotteryMainLayer:_onTurnBtnClick()
	if self.m_rewardStateController:getSelectedIndex() == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(420009))

		return
	end

	self:_reqNextPool()
end

function LotteryMainLayer:_onOneKeyClick()
	self._oneKeying = true

	self.m_layoutComp:setTouchable(false)
	self:_randomDrawLottery()
end

function LotteryMainLayer:_randomDrawLottery()
	if g.core.model.User.resourceData:getResourceById(LotteryConst.COST_ID) > 0 and g.core.model.User.lotteryData:getRandomGridId() > 0 then
		g.core.network.GameNetProxy:send_C2S_Lottery_Draw({
			grid_id = g.core.model.User.lotteryData:getRandomGridId()
		})
	else
		self._oneKeying = false

		self.m_layoutComp:setTouchable(true)

		if g.core.model.User.lotteryData:getRandomGridId() <= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(420010))
		elseif g.core.model.User.resourceData:getResourceById(LotteryConst.COST_ID) <= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(420001))
		end
	end
end

function LotteryMainLayer:_reqNextPool()
	g.core.network.GameNetProxy:send_C2S_Lottery_Next_Pool({})
end

function LotteryMainLayer:_onDrawReward(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	self.m_layoutComp:playRewardEffect(arg_21_4.grid_id, {
		isRare = arg_21_4.is_rare,
		awards = arg_21_4.awards
	})

	if arg_21_4.is_rare then
		self._oneKeying = false

		self.m_layoutComp:setTouchable(true)
		self.m_mask:setVisible(true)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_YHC_CHOUKA_DIANJI_2)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			startAction = true,
			baseShowReward = arg_21_4.awards
		})
		self:_updateLayer()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_YHC_CHOUKA_DIANJI_1)
	end

	if self._oneKeying then
		self:_randomDrawLottery()
	end
end

function LotteryMainLayer:_onEnterNext(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	self.m_qiehuanTransition:play(function()
		g.core.module.ModuleManager:awardSummary(arg_22_4.awards)
	end)
end

function LotteryMainLayer:_onEnterNextBackEnd()
	self._needRandom = true

	self:_updateLayer()
	self.m_layoutComp:playCellEnterAction()
end

function LotteryMainLayer:_showNextRoundTip()
	self.m_mask:setVisible(false)
	self:_updateLayer()

	if g.core.model.User.lotteryData:getTurnTipFlag() then
		return
	end

	local var_25_0 = g.core.lang:get(420006)
	local var_25_1 = g.core.lang:get(420003)

	if self.m_isMaxRoundController:getSelectedIndex() == 1 then
		var_25_0 = g.core.lang:get(420007)
		var_25_1 = g.core.lang:get(420008)
	end

	local var_25_2 = false

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		singleButton = true,
		title = var_25_0,
		desc = var_25_1,
		tip = {
			txt = g.core.lang:get(108045)
		},
		onCheck = function(arg_26_0)
			var_25_2 = arg_26_0
		end,
		onConfirm = function()
			g.core.model.User.lotteryData:setTurnTipFlag(var_25_2)
		end
	}), {
		touchDisappear = true
	})
end

function LotteryMainLayer:_playLayerEffect()
	self.m_layerIdle:removeAllEffect()
	self.m_layerIdle:addEffectSpine({
		anim = "layer",
		name = "eff_ui_lottery_idle"
	})
end

return LotteryMainLayer
