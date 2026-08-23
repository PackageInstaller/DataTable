local RecruitPreciousComp = class("RecruitPreciousComp", require("app.fairyGUI.recruitPrecious.UI_RecruitPreciousComp"))
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.recruitData
local var_0_3 = g.core.const.ConstMgr.RecruitConst
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

function RecruitPreciousComp:ctor()
	self._clickTenEnable = true
	self._clickOneEnable = true
	self._actData = nil
	self._wishInfos = {}

	self:_addListeners()
	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
end

function RecruitPreciousComp:_addListeners()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
	self.m_giftBtn:addClickListener(handler(self, self._onGiftBtnClicked))
	require("app.view.module.recruit.const.RecruitFuncCfg").addBtnTip(self, var_0_3.RECRUIT_TAB_TYPE.PRECIOUS_TAB)
end

function RecruitPreciousComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._cfg.id,
		type = var_0_3.RECRUIT_TYPE.PRECIOUS,
		tabType = self._tabType,
		title = g.core.lang:get(108475)
	}), {
		touchDisappear = true
	})
end

function RecruitPreciousComp:_onKnightTwoBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitKnightShowTimePop").new({
		knightId = 400040,
		justShow = true
	}))
end

function RecruitPreciousComp:_onRecruitOneBtnClick()
	if not self._clickOneEnable then
		return
	end

	self._clickOneEnable = false

	self:newScheduleOnce(handler(self, self._changeClickOneEnable), 1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	local var_5_0, var_5_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_5_2 = g.core.model.User.recruitData:getBuyHelper()

	var_5_2:setRecruitType(self._cfg.type)
	var_5_2:setRecruitId(self:_getRecruitNetId())
	var_5_2:setRecruitNum(1)

	local var_5_3 = var_5_2:getCurBuyItemInfo()
	local var_5_4 = {
		num = 1,
		itemInfo = var_5_3,
		recruitType = self._cfg.type,
		consumeType = var_5_1.requestType,
		recruitId = self:_getRecruitNetId()
	}

	if self:_isFree() then
		var_5_4.consumeType = 0
		var_5_4.itemInfo = nil
		var_5_3 = nil
	end

	self.m_recruitOneBtn:_onDoingClick(var_5_3, var_5_4, 1, 0)
end

function RecruitPreciousComp:_changeClickOneEnable()
	self._clickOneEnable = true
end

function RecruitPreciousComp:_onRecruitGetTaskAward(arg_7_1, arg_7_2, arg_7_3)
	g.core.module.ModuleManager:awardSummary(arg_7_3.awards)
end

function RecruitPreciousComp:_onRecruitTenBtnClick()
	if not self._clickTenEnable then
		return
	end

	self._clickTenEnable = false

	self:newScheduleOnce(handler(self, self._changeClickTenEnable), 1)

	local var_8_0, var_8_1 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)
	local var_8_2 = g.core.model.User.recruitData:getBuyHelper()

	var_8_2:setRecruitNum(10)
	var_8_2:setRecruitType(self._cfg.type)
	var_8_2:setRecruitId(self:_getRecruitNetId())

	local var_8_3 = var_8_2:getCurBuyItemInfo()

	self.m_recruitTenBtn:_onDoingClick(var_8_3, {
		itemInfo = var_8_3,
		recruitType = self._cfg.type,
		consumeType = var_8_1.requestType,
		num = 10,
		recruitId = self:_getRecruitNetId()
	}, 1, 0)
end

function RecruitPreciousComp:_changeClickTenEnable()
	self._clickTenEnable = true
end

function RecruitPreciousComp:_isFree()
	local var_10_0 = self.m_isLimitController:getSelectedIndex() == 0 and 1 or 0
	local var_10_1 = var_0_2:getDrawInfo((self:_getRecruitNetId()))

	return ((var_10_1 or nil) and var_10_1:getLeftFreeTimes()) > 0
end

function RecruitPreciousComp:_reqRecruitNetWork(arg_11_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self:_getRecruitNetId(),
		consume_type = arg_11_1.consumeType,
		num = arg_11_1.num
	})
end

function RecruitPreciousComp:init(arg_12_1)
	if arg_12_1.activityData then
		self:_initActivityData(arg_12_1.activityData)
	else
		self:_initNormalPrecious(arg_12_1.id)
	end
end

function RecruitPreciousComp:_initNormalPrecious(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(var_0_2:getDisplayInfoById(arg_13_1).displays) do
		self["m_suitBtn" .. iter_13_0]:updateComp(iter_13_1, false, true)
	end

	self._cfg = var_0_2:getRecruitKnightCfgById(arg_13_1)

	self.m_hideGiftController:setSelectedIndex(1)

	local var_13_0 = require("app.view.module.recruit.const.RecruitLimitCommonUIPreciousCfg").getUICfg(self._cfg.id)

	if var_13_0 then
		self.m_titleLoader:setURL(var_13_0.titleRes)
	end
end

function RecruitPreciousComp:_initActivityData(arg_14_1)
	self._actData = arg_14_1

	local var_14_0 = self._actData:getInfo()
	local var_14_1 = var_14_0.sub_activity_id or self._actData:getActivityValue()

	self._cfg = var_0_2:getRecruitKnightCfgById(var_14_1)

	for iter_14_0, iter_14_1 in ipairs(var_0_2:getDisplayInfoById(var_14_1).displays) do
		self["m_suitBtn" .. iter_14_0]:updateComp(iter_14_1, false, true)
	end

	self.m_hideGiftController:setSelectedIndex(var_14_0.recharge_gift_close)

	local var_14_2 = require("app.view.module.recruit.const.RecruitLimitCommonUIPreciousCfg").getUICfg(self._cfg.id)

	if var_14_2 then
		self.m_titleLoader:setURL(var_14_2.titleRes)
	else
		assert(false, "can not find precious uiCfg,the recruit id is : " .. self._cfg.id)
	end
end

function RecruitPreciousComp:onLoad()
	self._clickOneEnable = true
	self._clickTenEnable = true

	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onRecruitGetTaskAward, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self.updateView), self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD, self._updateGiftRedPoint, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_STORY_END, handler(self, self._onStoryEnd), self)
	self:_updateGiftRedPoint()
	self.m_recruitOneBtn:addAutoBuyCompListener()
	self.m_recruitTenBtn:addAutoBuyCompListener()
	self.m_recruitOneBtn:setTouchable(true)
	self.m_recruitTenBtn:setTouchable(true)
end

function RecruitPreciousComp:receiveCompEvent(arg_16_1, arg_16_2)
	if arg_16_1 == "clickWish" then
		return false
	elseif arg_16_1 == "doRecruitContinue" then
		if arg_16_2.num > 1 then
			self:_onRecruitTenBtnClick()
		else
			self:_onRecruitOneBtnClick()
		end

		return true
	end

	return false
end

function RecruitPreciousComp:updateView()
	self._wishInfos = g.core.model.User.recruitData:getWishInfo(var_0_3.RECRUIT_TYPE.PRECIOUS)

	self:_updateLuck()
	self:_updateRecruitNum()

	if self._actData then
		local var_17_0, var_17_1, var_17_2, var_17_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getFinishTime()))

		if var_17_0 < 32 then
			self:_updateTime()
			self:_onStartTimeSchedule()
			self.m_isLimitController:setSelectedIndex(1)
			self:_updateCost()
		else
			self:_updateCost()
			self:_onStopTimeSchedule()
			self.m_isLimitController:setSelectedIndex(0)
		end
	end
end

function RecruitPreciousComp:setLuckTimeText(arg_18_1, arg_18_2)
	self._curLuckText = arg_18_1
	self._maxLuckText = arg_18_2
end

function RecruitPreciousComp:_updateRecruitNum()
	return
end

function RecruitPreciousComp:_updateCost()
	local var_20_0, var_20_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_20_2 = {
		isCanRecruit = var_20_0
	}
	local var_20_3 = self:_getRecruitNetId()
	local var_20_4 = self.m_isLimitController:getSelectedIndex() == 0
	local var_20_5 = var_20_4 and 1 or 0
	local var_20_6 = var_0_2:getDrawInfo(var_20_3)

	if var_20_6 then
		var_20_5 = var_20_6:getLeftFreeTimes()
	end

	if var_20_4 then
		var_20_2.redId = 760
		var_20_2.redParam = {
			recruitId = var_20_3
		}
	end

	var_20_2.freeNum = var_20_5
	var_20_2.goods = var_20_1

	self.m_recruitOneBtn:updateView(var_20_2)

	local var_20_7, var_20_8 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_20_7,
		goods = var_20_8
	})
	self.m_recruitOneBtn:setTouchable(true)
	self.m_recruitTenBtn:setTouchable(true)
end

function RecruitPreciousComp:getTitleTip()
	return g.core.lang:get(108032, {
		num = 10,
		quality = g.core.lang:get(108035),
		tip = g.core.lang:get(108037)
	})
end

function RecruitPreciousComp:playShow()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitEvent = true

	self.m_isLimitController:setSelectedIndex(0)
	self:updateView()
	self:setVisible(true)
	self.m_enterTransition:play(handler(self, self.onEnd))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_HIGH_UI_SHOW)

	local var_22_0

	if self.m_isLimitController:getSelectedIndex() == 0 then
		g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_PRECIOUS)

		var_22_0 = {}
	end

	var_22_0.redPointComp = self.m_giftBtn:getChild("redPointComp")
	var_22_0.customData = {
		recruitId = self._cfg.id
	}

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, var_22_0)
end

function RecruitPreciousComp:onEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)

	self._waitEvent = false
end

function RecruitPreciousComp:playHide(arg_24_1)
	self.m_backTransition:play(arg_24_1)
end

function RecruitPreciousComp:_updateLuck()
	local var_25_0 = var_0_2:getGuaranteedInfos(var_0_3.RECRUIT_TYPE.PRECIOUS, false)

	if var_25_0 then
		self._curLuckText:setText(var_25_0.totalTimes - var_25_0.times)
		self._maxLuckText:setText("/" .. var_25_0.totalTimes)
	end
end

function RecruitPreciousComp:onUnload()
	self:_onStopTimeSchedule()

	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end
end

function RecruitPreciousComp:updateByCfg(arg_27_1)
	self._tabType = arg_27_1.ownerType
end

function RecruitPreciousComp:_onGiftBtnClicked()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.recruit.view.recruitPrecious.RecruitPreciousGiftPop").new({
		title = g.core.lang:get(108476),
		activityValue = self._cfg.id,
		shopValue = g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.PRECIOUS_RECRUIT,
		openCheckFunc = handler(self, function(arg_29_0)
			return arg_29_0._actData:getInfo().finish_time > g.core.common.ServerTime:getTime()
		end)
	})))
end

function RecruitPreciousComp:_updateGiftRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_giftBtn:getChild("redPointComp"),
		customData = {}
	})
end

function RecruitPreciousComp:_getRecruitNetId()
	local var_31_0 = self._cfg.id

	if self._actData then
		var_31_0 = self._actData:getActivityId()

		if not self._actData:getInfo().sub_activity_id then
			var_31_0 = self._actData:getActivityValue()
		end
	end

	return var_31_0
end

function RecruitPreciousComp:_onStartTimeSchedule()
	self._timeSchedule = self._timeSchedule or self:newSchedule(handler(self, self._updateTime), 1)
end

function RecruitPreciousComp:_onStopTimeSchedule()
	self._timeSchedule = nil
end

function RecruitPreciousComp:_updateTime()
	local var_34_0, var_34_1, var_34_2, var_34_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getFinishTime()))
	local var_34_4 = var_34_0 > 0 and string.format(g.core.lang:get(108052), var_34_0, var_34_1, var_34_2, var_34_3) or var_34_1 > 0 and string.format(g.core.lang:get(108051), var_34_1, var_34_2, var_34_3) or var_34_2 > 0 and string.format(g.core.lang:get(108050), var_34_2, var_34_3) or string.format(g.core.lang:get(108049), var_34_3)

	self.m_timeTxt:setText(g.core.lang:get(108048, {
		timeTip = var_34_4
	}))

	if var_34_0 + var_34_1 + var_34_2 + var_34_3 <= 0 then
		self:dispatchCompEvent("limitTimeEnd")
	end
end

function RecruitPreciousComp:playRecruitAction(arg_35_1, arg_35_2, arg_35_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._content = arg_35_1
	self._highQuality = 0

	for iter_35_0 = 1, #arg_35_1.awards do
		local var_35_0 = g.core.common.Goods:convert(arg_35_1.awards[iter_35_0])

		self._highQuality = math.max(self._highQuality, var_35_0.quality)
		arg_35_1.awards[iter_35_0].quality = var_35_0.quality
		arg_35_1.awards[iter_35_0].id = iter_35_0
		arg_35_1.awards[iter_35_0].isNew = g.core.model.User.recruitData:checkIsNewPrecious(arg_35_1.awards[iter_35_0].value)
	end

	self:updateView()
	self:_goToRewardLayer({
		content = arg_35_1,
		awards = arg_35_1.awards
	})
end

function RecruitPreciousComp:_goToRewardLayer(arg_36_1)
	self:setVisible(true)

	local var_36_0 = clone(arg_36_1.content)

	var_36_0.cfg = self._cfg
	var_36_0.quality = arg_36_1.quality

	local var_36_1 = require("app.view.module.recruit.view.recruitPrecious.RecruitPreciousRewardPop").new(var_36_0)

	self:addListen(var_36_1)
	g.core.module.ModuleManager:pushPopup(var_36_1, {
		touchDisappear = false
	})
end

function RecruitPreciousComp:_onStoryEnd()
	if self:isVisible() then
		self:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
		end, 0.2)
	end
end

return RecruitPreciousComp
