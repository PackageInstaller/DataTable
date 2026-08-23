local RecruitKnightSoulComp = class("RecruitKnightSoulComp", require("app.fairyGUI.recruitKnightSoul.UI_RecruitKnightSoulComp"))
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.recruitData
local var_0_3 = g.core.const.ConstMgr.RecruitConst
local var_0_4 = g.core.common.ServerTime
local RecruitFuncCfg = require("app.view.module.recruit.const.RecruitFuncCfg")
local var_0_6 = g.core.model.User.activityMonthCardData
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

function RecruitKnightSoulComp:ctor()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_KNIGHT_SOUL_BASE)

	self._endTime = 0
	self._startTime = nil
	self._schedulerHandler = nil
	self._wishInfos = {}

	self:_addListeners()
	self:_init()
end

function RecruitKnightSoulComp:_addListeners()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
	self.m_minimumText:enableRich()
end

function RecruitKnightSoulComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		title = g.core.lang:get(108465),
		id = self._cfg.id,
		type = var_0_3.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT,
		tabType = self._tabType
	}), {
		touchDisappear = true
	})
end

function RecruitKnightSoulComp:_onRecruitOneBtnClick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	local var_4_0 = var_0_2:getDrawInfo(nil, var_0_3.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT)
	local var_4_1 = var_4_0:getDailyLimitNum()

	if var_4_0:getDailyCount() >= var_4_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108469, {
			num = var_4_1
		}))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		return
	end

	local var_4_2, var_4_3 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_4_4 = g.core.model.User.recruitData:getBuyHelper()

	var_4_4:setRecruitType(self._cfg.type)
	var_4_4:setRecruitId(self._cfg.id)
	var_4_4:setRecruitNum(1)

	local var_4_5 = var_4_4:getCurBuyItemInfo()
	local var_4_6 = {
		num = 1,
		itemInfo = var_4_5,
		recruitType = self._cfg.type,
		consumeType = var_4_3.requestType
	}

	if self:_isFree() then
		var_4_6.consumeType = 0
		var_4_6.itemInfo = nil
		var_4_5 = nil
	end

	self.m_recruitOneBtn:_onDoingClick(var_4_5, var_4_6, 1, 0)
end

function RecruitKnightSoulComp:_onRecruitGetTaskAward(arg_5_1, arg_5_2, arg_5_3)
	g.core.module.ModuleManager:awardSummary(arg_5_3.awards)
end

function RecruitKnightSoulComp:_onRecruitTenBtnClick()
	local var_6_0 = var_0_2:getDrawInfo(nil, var_0_3.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT)
	local var_6_1 = var_6_0:getDailyLimitNum()

	if var_6_1 < var_6_0:getDailyCount() + 10 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108469, {
			num = var_6_1
		}))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		return
	end

	local var_6_2, var_6_3 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)
	local var_6_4 = g.core.model.User.recruitData:getBuyHelper()

	var_6_4:setRecruitNum(10)
	var_6_4:setRecruitType(self._cfg.type)
	var_6_4:setRecruitId(self._cfg.id)

	local var_6_5 = var_6_4:getCurBuyItemInfo()

	self.m_recruitTenBtn:_onDoingClick(var_6_5, {
		itemInfo = var_6_5,
		recruitType = self._cfg.type,
		consumeType = var_6_3.requestType,
		num = 10
	}, 1, 0)
end

function RecruitKnightSoulComp:_isFree()
	return var_0_2:getDrawInfo(nil, var_0_3.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT):getLeftFreeTimes() > 0
end

function RecruitKnightSoulComp:_reqRecruitNetWork(arg_8_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self._cfg.id,
		consume_type = arg_8_1.consumeType,
		num = arg_8_1.num
	})
end

function RecruitKnightSoulComp:_init()
	local var_9_0 = var_0_2:getDisplayInfoById(100017)

	for iter_9_0, iter_9_1 in ipairs(var_9_0.displays) do
		self.m_soulTipBtn:updateComp(iter_9_1)
	end

	self:addListen(self.m_wishComp)

	self._cfg = var_0_2:getRecruitKnightCfgById(100017)
	self._displayCfg = var_9_0

	RecruitFuncCfg.addBtnTip(self, var_0_3.RECRUIT_TAB_TYPE.KNIGHT_SOUL_TAB)
	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
end

function RecruitKnightSoulComp:onLoad()
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onRecruitGetTaskAward, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self.updateView), self)
	self.m_recruitOneBtn:addAutoBuyCompListener()
	self.m_recruitTenBtn:addAutoBuyCompListener()
end

function RecruitKnightSoulComp:receiveCompEvent(arg_11_1, arg_11_2)
	if arg_11_1 == "clickWish" then
		self:addPopup(require("app.view.module.recruit.view.pop.RecruitKnightSoulWishPop").new(var_0_3.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT, self._cfg.id))

		return true
	elseif arg_11_1 == "doRecruitContinue" then
		if arg_11_2.num > 1 then
			self:_onRecruitTenBtnClick()
		else
			self:_onRecruitOneBtnClick()
		end

		return true
	end

	return false
end

function RecruitKnightSoulComp:updateView()
	self._wishInfos = g.core.model.User.recruitData:getWishInfo(var_0_3.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT)

	self.m_wishComp:updateComp(self._wishInfos, var_0_3.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT)
	self:_updateRecruitNum()
	self:_updateCost()
	self.m_minimumText:setText(g.core.lang:get(108464, {
		time = g.core.model.User.recruitData:getGuaranteedInfos(var_0_3.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT).times
	}), true)

	local var_12_0 = g.core.model.User.recruitData:getLimitNearTime()

	if var_12_0 > 0 then
		self:newScheduleOnce(handler(self, self._syncWishInfo), var_12_0 - g.core.common.ServerTime:getTime())
	end
end

function RecruitKnightSoulComp:updateWishMiniRed()
	self.m_wishComp:refreshRed()
end

function RecruitKnightSoulComp:setLuckTimeText(arg_14_1, arg_14_2)
	self._curLuckText = arg_14_1
	self._maxLuckText = arg_14_2
end

function RecruitKnightSoulComp:_updateRecruitNum()
	return
end

function RecruitKnightSoulComp:_updateCost()
	self:_cancelCountdown()

	local var_16_0, var_16_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_16_2 = {
		isCanRecruit = var_16_0
	}
	local var_16_3 = var_0_2:getDrawInfo(nil, var_0_3.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT):getLeftFreeTimes()

	var_16_2.freeNum = var_16_3
	var_16_2.goods = var_16_1
	var_16_2.redId = 725

	self.m_recruitOneBtn:updateView(var_16_2)

	local var_16_4, var_16_5 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_16_4,
		goods = var_16_5
	})

	if var_16_3 > 0 then
		self.m_countDown:setVisible(false)
		self:_cancelCountdown()

		self._endTime = 0
	else
		local var_16_6 = var_0_4:getTime()
		local var_16_7 = var_0_4:secondsToTommorrow(var_16_6)

		self._endTime = var_16_6 + var_16_7

		self.m_countDown:setVisible(true)

		self._schedulerHandler = g.core.common.Scheduler:newCountdown(var_16_7, 1, handler(self, self._updateCountDown), handler(self, self._countDownFinish), nil)

		self:_updateCountDown()
	end
end

function RecruitKnightSoulComp:_checkPrivilege()
	return (var_0_6:isPrivilegeActivatedByIndex(2))
end

function RecruitKnightSoulComp:_updateCountDown()
	local var_18_0 = self._endTime - var_0_4:getTime()

	self.m_countDownTxt:setText(g.core.lang:get(108436, {
		time = var_0_4:secondToDHMString(var_18_0)
	}))

	if var_18_0 and var_18_0 < 1 then
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
		end, 2)
	end
end

function RecruitKnightSoulComp:_countDownFinish()
	self.m_countDown:setVisible(false)
end

function RecruitKnightSoulComp:getTitleTip()
	return g.core.lang:get(108032, {
		num = 10,
		quality = g.core.lang:get(108035),
		tip = g.core.lang:get(108037)
	})
end

function RecruitKnightSoulComp:playShow(arg_22_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitEvent = true

	self:updateView()
	self:setVisible(true)

	if not arg_22_1 then
		self.m_enterTransition:play(handler(self, self.onEnd))
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_ARTIFACT_UI_SHOW)
end

function RecruitKnightSoulComp:onEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)

	self._waitEvent = false
end

function RecruitKnightSoulComp:playHide(arg_24_1)
	self.m_backTransition:play(arg_24_1)
end

function RecruitKnightSoulComp:onUnload()
	self:_cancelCountdown()

	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end
end

function RecruitKnightSoulComp:_cancelCountdown()
	if self._schedulerHandler then
		g.core.common.Scheduler:cancelCountdown(self._schedulerHandler)

		self._schedulerHandler = nil
	end
end

function RecruitKnightSoulComp:updateByCfg(arg_27_1)
	self._tabType = arg_27_1.ownerType
end

function RecruitKnightSoulComp:playRecruitAction(arg_28_1, arg_28_2, arg_28_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._content = arg_28_1
	self._highQuality = 0

	for iter_28_0 = 1, #arg_28_1.awards do
		local var_28_0 = g.core.common.Goods:convert(arg_28_1.awards[iter_28_0])

		self._highQuality = math.max(self._highQuality, var_28_0.quality)
		arg_28_1.awards[iter_28_0].quality = var_28_0.quality
		arg_28_1.awards[iter_28_0].id = iter_28_0
		arg_28_1.awards[iter_28_0].isNew = g.core.model.User.recruitData:checkIsNewKnightSoul(arg_28_1.awards[iter_28_0].value)
	end

	self:updateView()
	self:_goToRewardLayer({
		quality = self._highQuality,
		content = self._content
	})
end

function RecruitKnightSoulComp:_onUserClick(arg_29_1, arg_29_2)
	if not arg_29_1 then
		return
	end

	if arg_29_1[1].id == "loop" then
		arg_29_2:jump()
	end
end

function RecruitKnightSoulComp:_goToRewardLayer(arg_30_1)
	local var_30_0 = clone(arg_30_1.content)

	var_30_0.cfg = self._cfg
	var_30_0.quality = arg_30_1.quality
	var_30_0.matchQuality = self._cfg.gacha_display_quality

	local var_30_1 = require("app.view.module.recruit.view.knightSoul.KnightSoulRewardLayer").new(var_30_0)

	self:addListen(var_30_1)
	g.core.module.ModuleManager:pushPopup(var_30_1, {
		touchDisappear = false
	})
end

function RecruitKnightSoulComp:_syncWishInfo()
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
end

return RecruitKnightSoulComp
