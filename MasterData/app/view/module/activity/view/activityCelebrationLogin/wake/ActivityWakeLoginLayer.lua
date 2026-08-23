local var_0_0 = g.core.model.User.activityCelebrationLoginData
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.event.EventManager
local var_0_4 = g.core.module.ModuleManager
local ActivityWakeLoginLayer = class("ActivityWakeLoginLayer", require("app.fairyGUI.activity.UI_ActivityWakeLoginLayer"), function()
	return fgui.GComponent:create({
		resName = "ActivityWakeLoginLayer",
		pkgPath = "ui/activity/activity",
		isFullScreen = true,
		pkgName = "activity"
	}, ...)
end)

function ActivityWakeLoginLayer:ctor(arg_2_1)
	self:addBg("bg/celebrationLogin/bg_huanxingzhilv.jpg")
	self.m_topBarComp:setResInfoById(75002)

	self._functionId = g.core.const.ConstMgr.FUNCTION_TYPE.WAKE_LOGIN or arg_2_1.param.function_id
	self._activityId = var_0_0:getActivityIdByFunction(self._functionId)
	self._svrId = var_0_0:getSvrIdByActivityId(self._activityId)
	self._dailyRewardArr = {}
	self._cumulateRewardArr = {}

	self.m_dailyList:setVirtual()
	self.m_dailyList:setItemRenderer(handler(self, self._onRenderDailyList))
	self.m_cumulateList:setVirtual()
	self.m_cumulateList:doFairyBatching(false)
	self.m_cumulateList:setItemRenderer(handler(self, self._onRenderCumulateList))
	self.m_previewBtn:addClickListener(handler(self, self._onClickPreviewBtn))
end

function ActivityWakeLoginLayer:onLoad()
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_CELEBRATION_LOGIN_GETINFO, handler(self, self._onRecvGetInfo), self)
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_CELEBRATION_LOGIN_SIGNREWARD, handler(self, self._onRecvDailyReward), self)
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_CELEBRATION_LOGIN_DRAWGIFT, handler(self, self._onRecvCumulateReward), self)
	var_0_2:addEventListener(var_0_1.EVENT_CROSS_DAY_NOTIFY, handler(self, self._crossDayNotify), self)
	self.m_enterTransition:play()
	self.m_effBg:addEffectSpine({
		anim = "play",
		name = "eff_ui_activityWake_bgglow",
		isLoop = true
	})
	g.core.network.GameNetProxy:send_C2S_CelebrationLogin_GetInfo({
		id = self._svrId
	})
	g.core.model.User.functionUnlockData:saveUnlockedFunc(self._functionId)
end

function ActivityWakeLoginLayer:_scrollToMinCumulateDay()
	local var_4_0 = #self._cumulateRewardArr - 1

	for iter_4_0, iter_4_1 in ipairs(self._cumulateRewardArr) do
		if not iter_4_1.reward then
			var_4_0 = iter_4_0 - 1

			break
		end
	end

	self.m_cumulateList:scrollToView(var_4_0, false)
end

function ActivityWakeLoginLayer:_scrollToMinDailyDay()
	self.m_dailyList:scrollToView(math.min(math.max(0, var_0_0:getSignInDaysByActId(self._activityId) - 1), var_0_0:getCelebrationLoginInfo(self._activityId).days), false)
end

function ActivityWakeLoginLayer:_onRenderCumulateList(arg_6_1, arg_6_2)
	arg_6_2:updateCumulateCell(self._cumulateRewardArr[arg_6_1 + 1])
end

function ActivityWakeLoginLayer:_onRenderDailyList(arg_7_1, arg_7_2)
	arg_7_2:updateDailyCell(self._dailyRewardArr[arg_7_1 + 1])
end

function ActivityWakeLoginLayer:_onRecvGetInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4.login.id == self._svrId then
		self._dailyRewardArr = var_0_0:getDailyRewardArrByActId(self._activityId)

		self.m_dailyList:setNumItems(#self._dailyRewardArr)
		self:_scrollToMinDailyDay()

		self._cumulateRewardArr = var_0_0:getCumulateRewardArrByActId(self._activityId)

		self.m_cumulateList:setNumItems(#self._cumulateRewardArr)
		self:_scrollToMinCumulateDay()

		local var_8_0 = var_0_0:getSignInDaysByActId(self._activityId)

		self.m_dayTxt:setText(var_8_0)

		if var_0_0:hasDailyRewardCanReceive(self._activityId) and not var_0_0:isDaySign(self._svrId, var_8_0 + 1) then
			var_0_0:setSignRewardSendKey(self._svrId, var_8_0 + 1)
		end
	end
end

function ActivityWakeLoginLayer:_onRecvDailyReward(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = arg_9_4.awards or {}

	self:_updateReward()
	var_0_4:awardSummary(var_9_0, nil, nil, nil, nil)
end

function ActivityWakeLoginLayer:_updateReward()
	self.m_dayTxt:setText((var_0_0:getSignInDaysByActId(self._activityId)))
	self.m_dailyList:setNumItems(#self._dailyRewardArr)
	self.m_cumulateList:setNumItems(#self._cumulateRewardArr)
end

function ActivityWakeLoginLayer:popKnightShow(arg_11_1)
	var_0_4:awardSummary(arg_11_1.awards, nil, nil, nil, handler(self, self._onUpdateCumulateList))
end

function ActivityWakeLoginLayer:_onRecvCumulateReward(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = {}

	table.insert(var_12_0, arg_12_4.awards[1])

	if arg_12_4.awards[1].type == g.core.common.Goods.TYPE_FRAGMENT then
		table.insert(var_12_0, {
			type = arg_12_4.gift.award_type + 10000,
			value = arg_12_4.gift.award_value,
			size = arg_12_4.gift.award_size
		})
	end

	self:popKnightShow({
		awards = var_12_0
	})
end

function ActivityWakeLoginLayer:_onUpdateCumulateList()
	self.m_cumulateList:setNumItems(#self._cumulateRewardArr)
	self:_scrollToMinCumulateDay()
end

function ActivityWakeLoginLayer:_onClickPreviewBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.activity.view.activityCelebrationLogin.wake.ActivityWakePreviewPop").new({
		activityId = self._activityId
	}), {
		touchDisappear = true
	})
end

function ActivityWakeLoginLayer:_crossDayNotify()
	return
end

return ActivityWakeLoginLayer
