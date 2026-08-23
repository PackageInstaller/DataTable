local var_0_0 = g.core.model.User.activityCelebrationLoginData
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.common.ServerTime
local var_0_5 = g.core.module.ModuleManager
local ActivityCelebrationLoginComp = class("ActivityCelebrationLoginComp", require("app.fairyGUI.activity.UI_ActivityCelebrationLoginComp"))

function ActivityCelebrationLoginComp:ctor()
	self._activityId = 0
	self._svrId = 0
	self._dailyRewardArr = {}
	self._cumulateRewardArr = {}

	self.m_dailyList:setVirtual()
	self.m_dailyList:setItemRenderer(handler(self, self._onRenderDailyList))
	self.m_cumulateList:setVirtual()
	self.m_cumulateList:doFairyBatching(false)
	self.m_cumulateList:setItemRenderer(handler(self, self._onRenderCumulateList))
	self.m_previewBtn:addClickListener(handler(self, self._onClickPreviewBtn))

	self._cdHandler = nil
	self._expireTime = 0
end

function ActivityCelebrationLoginComp:onLoad()
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_CELEBRATION_LOGIN_GETINFO, handler(self, self._onRecvGetInfo), self)
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_CELEBRATION_LOGIN_SIGNREWARD, handler(self, self._onRecvDailyReward), self)
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_CELEBRATION_LOGIN_DRAWGIFT, handler(self, self._onRecvCumulateReward), self)
	var_0_3:addEventListener(var_0_2.EVENT_CROSS_DAY_NOTIFY, handler(self, self._crossDayNotify), self)
end

function ActivityCelebrationLoginComp:updateComp(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if not arg_3_4 then
		self.m_enterTransition:play()
	end

	self._activityId = arg_3_1
	self._svrId = var_0_0:getSvrIdByActivityId(arg_3_1)

	g.core.network.GameNetProxy:send_C2S_CelebrationLogin_GetInfo({
		id = self._svrId
	})

	local var_3_0 = var_0_0:getCelebrationLoginInfo(arg_3_1)

	self._expireTime = var_0_0:getRewardEndTimeByActId(arg_3_1)

	self.m_bgLoader:setURL(var_0_1:getCelebrationLoginImage("pic_hd_znqqd_bg", self._activityId))
	self.m_banner:setURL(var_0_1:getCelebrationLoginImage(var_3_0.pic, self._activityId))
	self.m_dayBgLoader:setURL(var_0_1:getCelebrationLoginImage("pic_hd_znqqd_leijidi", self._activityId))
	self.m_timeBgLoader:setURL(var_0_1:getCelebrationLoginImage("pic_hd_znqqd_timebg", self._activityId))
	self.m_sloganLoader:setURL(var_0_1:getCelebrationLoginMulLangImage(var_3_0.slogan, self._activityId))
	self.m_titleLoader:setURL(var_0_1:getCelebrationLoginMulLangImage("txt_hd_znqqd_title", self._activityId))
	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_3_0.function_id)
end

function ActivityCelebrationLoginComp:_scrollToMinCumulateDay()
	local var_4_0 = #self._cumulateRewardArr - 1

	for iter_4_0, iter_4_1 in ipairs(self._cumulateRewardArr) do
		if not iter_4_1.reward then
			var_4_0 = iter_4_0 - 1

			break
		end
	end

	self.m_cumulateList:scrollToView(var_4_0, false)
end

function ActivityCelebrationLoginComp:_scrollToMinDailyDay()
	self.m_dailyList:scrollToView(math.min(math.max(0, var_0_0:getSignInDaysByActId(self._activityId) - 1), var_0_0:getCelebrationLoginInfo(self._activityId).days), false)
end

function ActivityCelebrationLoginComp:_onRenderCumulateList(arg_6_1, arg_6_2)
	arg_6_2:updateCumulateCell(self._cumulateRewardArr[arg_6_1 + 1])
end

function ActivityCelebrationLoginComp:_onRenderDailyList(arg_7_1, arg_7_2)
	arg_7_2:updateDailyCell(self._dailyRewardArr[arg_7_1 + 1])
end

function ActivityCelebrationLoginComp:_onRecvGetInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = arg_8_4.login.id

	if arg_8_4.login.id == self._svrId then
		self._dailyRewardArr = var_0_0:getDailyRewardArrByActId(self._activityId)

		self.m_dailyList:setNumItems(#self._dailyRewardArr)
		self:_scrollToMinDailyDay()

		self._cumulateRewardArr = var_0_0:getCumulateRewardArrByActId(self._activityId)

		self.m_cumulateList:setNumItems(#self._cumulateRewardArr)
		self:_scrollToMinCumulateDay()

		local var_8_1 = var_0_0:getSignInDaysByActId(self._activityId)

		self.m_dayTxt:setText(var_8_1)
		self:_updateLeftTime()

		self._cdHandler = self._cdHandler or self:newSchedule(handler(self, self._updateLeftTime), 1)

		if var_0_0:hasDailyRewardCanReceive(self._activityId) and not var_0_0:isDaySign(self._svrId, var_8_1 + 1) then
			var_0_0:setSignRewardSendKey(self._svrId, var_8_1 + 1)
			self:newScheduleOnce(function()
				g.core.network.GameNetProxy:send_C2S_CelebrationLogin_SignReward({
					id = var_8_0
				})
			end)
		end
	end
end

function ActivityCelebrationLoginComp:_onRecvDailyReward(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = arg_10_4.awards or {}

	self:_updateReward()
	require("app.view.module.show.ShowFactory"):awardSummary(var_10_0, nil, nil, nil, nil, {
		blackOpacity = 0.7,
		hideContinue = false,
		touchDisappear = true,
		withoutAni = false
	})
end

function ActivityCelebrationLoginComp:_updateReward()
	self.m_dayTxt:setText((var_0_0:getSignInDaysByActId(self._activityId)))
	self.m_dailyList:setNumItems(#self._dailyRewardArr)
	self.m_cumulateList:setNumItems(#self._cumulateRewardArr)
end

function ActivityCelebrationLoginComp:popKnightShow(arg_12_1)
	var_0_5:awardSummary(arg_12_1.awards, nil, nil, nil, handler(self, self._onUpdateCumulateList))
end

function ActivityCelebrationLoginComp:_onRecvCumulateReward(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = {}

	table.insert(var_13_0, arg_13_4.awards[1])

	if arg_13_4.awards[1].type == g.core.common.Goods.TYPE_FRAGMENT then
		table.insert(var_13_0, {
			type = arg_13_4.gift.award_type + 10000,
			value = arg_13_4.gift.award_value,
			size = arg_13_4.gift.award_size
		})
	end

	self:popKnightShow({
		awards = var_13_0
	})
end

function ActivityCelebrationLoginComp:_onUpdateCumulateList()
	self.m_cumulateList:setNumItems(#self._cumulateRewardArr)
	self:_scrollToMinCumulateDay()
end

function ActivityCelebrationLoginComp:_onClickPreviewBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.activity.view.activityCelebrationLogin.ActivityCelebrationLoginPreviewPop").new({
		activityId = self._activityId
	}), {
		touchDisappear = true
	})
end

function ActivityCelebrationLoginComp:_updateLeftTime()
	local var_16_0, var_16_1, var_16_2, var_16_3 = var_0_4:getLeftTimeParts(self._expireTime)

	self.m_timeTxt:setText(var_16_0 > 0 and g.core.lang:get(427503, {
		day = var_16_0,
		hour = var_16_1
	}) or g.core.lang:get(427502, {
		hour = var_16_1,
		min = var_16_2,
		sec = var_16_3
	}))
end

function ActivityCelebrationLoginComp:_crossDayNotify()
	if var_0_4:getTime() >= self._expireTime then
		var_0_5:popAllPopup()

		return
	end
end

function ActivityCelebrationLoginComp:onUnload()
	if self._cdHandler then
		self:cancelSchedule(self._cdHandler)

		self._cdHandler = nil
	end
end

return ActivityCelebrationLoginComp
