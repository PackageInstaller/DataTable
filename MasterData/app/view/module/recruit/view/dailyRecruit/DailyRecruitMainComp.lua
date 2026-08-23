local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.bagData
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.config.recruit_knight_cost_gain_info
local var_0_4 = g.core.config.recruit_knight_info
local var_0_5 = g.core.model.User.recruitData
local var_0_6 = g.view.entrance.ModuleGotoProxy
local var_0_7 = g.core.const.ConstMgr.DailyRecruitConst
local DrawKnight = require("app.view.common.DrawKnight")
local DailyRecruitMainComp = class("DailyRecruitMainComp", require("app.fairyGUI.recruitDaily.UI_DailyRecruitMainComp"))

function DailyRecruitMainComp:ctor()
	self._costGood = {}
	self._content = nil
	self._lastProgressTimes = 0
	self._lastShowId = 0
	self._isNeedCheckProgressChange = false
	self._schedule = nil

	self:initView()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_RECRUIT)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_NsAssistant)
end

function DailyRecruitMainComp:initView()
	self.m_bgLoader:setURL("bg/dailyRecruit/bg_zm_daily_main.jpg")
	self.m_tipBtn:addClickListener(handler(self, self._onClickTipBtn))
	self.m_oneBtn:addClickListener(handler(self, self._onClickOneRecruitBtn))
	self.m_tenBtn:addClickListener(handler(self, self._onClickTenRecruitBtn))
	self.m_levelBtn:addClickListener(handler(self, self._onClickLevelBtn))
	self.m_levelMaxBtn:addClickListener(handler(self, self._onClickLevelBtn))
	self.m_previewBtn:addClickListener(handler(self, self._onClickPreviewBtn))

	local var_2_0 = var_0_3.get(var_0_4.get(var_0_5:getDailyRecruitInfo().recruit_knight_id).single_summon_cost)

	self._costGood = var_0_2:convert({
		type = var_2_0.cost_type_1,
		value = var_2_0.cost_value_1
	})

	self.m_oneBtn:setIcon(self._costGood.icon)
	self.m_tenBtn:setIcon(self._costGood.icon)
	self.m_showSpine:addChild((DrawKnight.new({
		scale = 1,
		resId = 70002001,
		isShowBg = false
	})))
	self.m_effectLight:addEffectSpine({
		anim = "play",
		name = "eff_ui_dailyRecruit_light",
		remove = true,
		isLoop = false
	})
	self.m_effectBtn:addEffectSpine({
		anim = "play",
		name = "eff_ui_dailyRecruit_btn",
		remove = true,
		isLoop = false
	})

	local var_2_1 = 0
	local var_2_2 = var_0_0:getTime()

	for iter_2_0, iter_2_1 in pairs((var_0_1:getList(var_0_2.TYPE_EXPIRABLE_ITEM))) do
		if iter_2_1.base_id == self._costGood.value and var_2_2 < iter_2_1.expire_time then
			var_2_1 = var_2_1 == 0 and iter_2_1.expire_time or math.min(var_2_1, iter_2_1.expire_time)
		end
	end

	if var_2_1 > 0 then
		self.m_bubbleComp:setBubbleText((g.core.lang:get(410007, {
			timeStr = var_0_0:getTimeStrSimple(var_2_1 - var_2_2)
		})))
	else
		self.m_bubbleComp:setVisible(false)
	end
end

function DailyRecruitMainComp:_onClickTipBtn()
	var_0_6:gotoModule(var_0_7.RouteMail)
end

function DailyRecruitMainComp:_onClickOneRecruitBtn()
	local var_4_0 = var_0_5:getDailyRecruitInfo().recruit_knight_id
	local var_4_1, var_4_2 = var_0_5:getgenRecruitConsume(var_0_4.get(var_4_0).single_summon_cost)

	if var_4_1 then
		self:_reqRecruitNetWork(var_4_0, var_4_2.requestType, var_0_7.RecruitCount1)
	else
		var_0_6:gotoModuleBySource({
			type = var_4_2.type,
			value = var_4_2.value
		})
	end
end

function DailyRecruitMainComp:_onClickTenRecruitBtn()
	local var_5_0 = var_0_5:getDailyRecruitInfo().recruit_knight_id
	local var_5_1, var_5_2 = var_0_5:getgenRecruitConsume(var_0_4.get(var_5_0).ten_summon_cost)

	if var_5_1 then
		self:_reqRecruitNetWork(var_5_0, var_5_2.requestType, var_0_7.RecruitCount10)
	else
		var_0_6:gotoModuleBySource({
			type = var_5_2.type,
			value = var_5_2.value
		})
	end
end

function DailyRecruitMainComp:_reqRecruitNetWork(arg_6_1, arg_6_2, arg_6_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = arg_6_1,
		consume_type = arg_6_2,
		num = arg_6_3
	})
end

function DailyRecruitMainComp:_onClickPreviewBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.recruit.view.dailyRecruit.DailyRecruitPreviewPop").new(), {
		touchDisappear = true
	})
end

function DailyRecruitMainComp:_onClickLevelBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.recruit.view.dailyRecruit.DailyRecruitLevelAwardPop").new(), {
		touchDisappear = true
	})
end

function DailyRecruitMainComp:startSchedule()
	self._schedule = self._schedule or self:newSchedule(handler(self, self._onUpdateCostView), 1)
end

function DailyRecruitMainComp:stopSchedule()
	if self._schedule then
		self:cancelSchedule(self._schedule)
	end

	self._schedule = nil
end

function DailyRecruitMainComp:_onUpdateCostView()
	self:updateView()
	self:dispatchCompEvent("update_topBar_res")
end

function DailyRecruitMainComp:playShow()
	self.m_enterTransition:play()
	self:updateView()
	self:updateCurProgress()
	self:setVisible(true)
	self:startSchedule()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function DailyRecruitMainComp:playHide(arg_13_1)
	self:setVisible(false)
	self:stopSchedule()
	arg_13_1()
end

function DailyRecruitMainComp:getTitleTip()
	return ""
end

function DailyRecruitMainComp:updateView()
	local var_15_0 = var_0_1:getOwnNum(self._costGood.type, self._costGood.value)

	if var_15_0 >= var_0_7.RecruitCount10 then
		g.core.model.User.redPointData:recordTodayKey(var_0_7.RecordKey, true)
	end

	self.m_oneBtn:getController("isEnough"):setSelectedIndex(var_15_0 >= var_0_7.RecruitCount1 and 1 or 0)
	self.m_tenBtn:getController("isEnough"):setSelectedIndex(var_15_0 >= var_0_7.RecruitCount10 and 1 or 0)
end

function DailyRecruitMainComp:playRecruitAction(arg_16_1, arg_16_2, arg_16_3)
	self.m_oneBtn:setTouchable(true)
	self.m_tenBtn:setTouchable(true)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_WAIT)

	self._content = arg_16_1

	g.core.module.ModuleManager:pushPopup(require("app.view.module.recruit.view.dailyRecruit.DailyRecruitEffectPop").new(arg_16_1.awards), {
		touchDisappear = false,
		ignoreTouch = true
	})

	self._isNeedCheckProgressChange = true

	self:updateView()
end

function DailyRecruitMainComp:receiveParentCompEvent(arg_17_1, arg_17_2)
	if arg_17_1 == "DailyRecruit_EffectPop_End" then
		self:playRewardPop(arg_17_2.awards)

		return true
	elseif arg_17_1 == "DailyRecruit_RewardPop_End" then
		if self._isNeedCheckProgressChange then
			self._isNeedCheckProgressChange = false

			self:showProgressChange()
		end

		return true
	end
end

function DailyRecruitMainComp:showProgressChange()
	if self._lastShowId == 0 then
		return
	end

	local var_18_0 = g.core.config.daily_recruit_info.get(self._lastShowId)
	local var_18_1, var_18_2 = var_0_5:getDailyRecruitProgressValue(var_18_0.level, self._lastProgressTimes)
	local var_18_3 = var_0_5:getDailyRecruitProgressValue(var_18_0.level, (var_0_5:getDailyRecruitTotalTimes()))

	self.m_levelBtn:updateLevelBtnView(var_18_0.level, var_18_3, var_18_0)
	self.m_levelBtn:setProgress(var_18_3, var_18_2, var_18_1, (var_18_3 - var_18_1) / var_18_2)

	if var_0_5:getDailyRecruitId() ~= self._lastShowId then
		self:newScheduleOnce(handler(self, self._showLevelUpPop), (var_18_3 - var_18_1) / var_18_2)
	elseif self._content and self._content.daily_lv_awards then
		g.core.module.ModuleManager:awardSummary(self._content.daily_lv_awards, nil, nil, nil, handler(self, self.updateCurProgress))

		self._content = nil
	else
		self:updateCurProgress()
	end
end

function DailyRecruitMainComp:updateCurProgress()
	if not self or not self.m_isFullLevelController then
		return
	end

	local var_19_0 = var_0_5:getDailyRecruitInfo()

	if var_0_5:isDailyRecruitMaxLevel() then
		self.m_isFullLevelController:setSelectedIndex(1)
		self.m_levelMaxBtn:setTitle(g.core.lang:get(100535, {
			lv = var_19_0.level
		}))
	else
		self.m_isFullLevelController:setSelectedIndex(0)

		local var_19_1, var_19_2 = var_0_5:getDailyRecruitProgressValue(var_19_0.level, var_0_5:getDailyRecruitTotalTimes())

		self.m_levelBtn:updateLevelBtnView(var_19_0.level, var_19_1, var_19_0)
		self.m_levelBtn:setProgress(var_19_1, var_19_2)
	end

	self._lastProgressTimes = var_0_5:getDailyRecruitTotalTimes()
	self._lastShowId = var_0_5:getDailyRecruitInfo().id
end

function DailyRecruitMainComp:_showLevelUpPop()
	local var_20_0 = {}

	var_20_0.touchDisappear = true
	var_20_0.hideContinue = true
	var_20_0.blackOpacity = 0.7
	var_20_0.withoutAni = true
	var_20_0.ignoreTouch = true

	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		autoDisappear = false,
		compData = {
			lastInfo = g.core.config.daily_recruit_info.get(self._lastShowId),
			curInfo = var_0_5:getDailyRecruitInfo()
		},
		title = g.core.lang:get(410004),
		func = handler(self, self.updateCurProgress),
		showComp = fgui.UIPackage:createObject("recruitDaily", "DailyRecruitLevelUpComp")
	}), var_20_0)
end

function DailyRecruitMainComp:playRewardPop(arg_21_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.recruit.view.dailyRecruit.DailyRecruitRewardPop").new(arg_21_1), {
		touchDisappear = true
	})
end

function DailyRecruitMainComp:onLoad()
	if g.core.platform.ServerListProxy:isTesting() then
		self.m_showSpine:setVisible(false)
	end
end

return DailyRecruitMainComp
