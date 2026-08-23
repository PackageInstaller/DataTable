local var_0_0 = g.core.const.ConstMgr.RecruitConst
local var_0_1 = g.core.model.User.recruitData
local var_0_2 = g.core.common.ServerTime
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")
local RecruitUniteTokenComp = class("RecruitUniteTokenComp", require("app.fairyGUI.recruitUniteToken.UI_RecruitUniteTokenComp"))

function RecruitUniteTokenComp:ctor()
	self._schedulerHandler = nil
	self._remainTime = nil
	self._startTime = nil

	self:_initView()
	self.m_recruitOneBtn:setTitle(g.core.lang:get(108107))
	self.m_recruitTenBtn:setTitle(g.core.lang:get(108108))
	self.m_detailBtn:addClickListener(handler(self, self._onUniteTokenPreviewClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOnce))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTen))

	self.m_recruitTwentyBtn = self:getChild("recruitTwentyBtn")

	if self.m_recruitTwentyBtn then
		self.m_recruitTwentyBtn:setTitle(g.core.lang:get(108428))
		self.m_recruitTwentyBtn:addClickListener(handler(self, self._onRecruitTwenty))
	end

	self.m_stateController = self:getController("state")

	require("app.view.module.recruit.const.RecruitFuncCfg").addBtnTip(self, var_0_0.RECRUIT_TAB_TYPE.UNITE_TAB)
end

function RecruitUniteTokenComp:_cancelCountDown()
	if self._schedulerHandler then
		g.core.common.Scheduler:cancelSchedule(self._schedulerHandler)

		self._schedulerHandler = nil
	end
end

function RecruitUniteTokenComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, handler(self, self._resRecruit), self)

	if self.m_recruitTwentyBtn then
		self._btnPos = self._btnPos or {
			self.m_recruitOneBtn:getPosition(),
			self.m_recruitTenBtn:getPosition()
		}

		if var_0_1:isOpenTwentyRecruit(self._cfg) then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(0)
		end
	end

	self.m_recruitOneBtn:addAutoBuyCompListener()
	self.m_recruitTwentyBtn:addAutoBuyCompListener()
	self.m_recruitTenBtn:addAutoBuyCompListener()
end

function RecruitUniteTokenComp:onUnload()
	self:_cancelCountDown()

	self._remainTime = nil
	self._startTime = nil
end

function RecruitUniteTokenComp:_resRecruit(arg_5_1, arg_5_2, arg_5_3)
	if self.m_recruitTwentyBtn then
		if var_0_1:isOpenTwentyRecruit(self._cfg) then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(0)
		end
	end
end

function RecruitUniteTokenComp:_initView()
	local var_6_0 = var_0_1:getDisplayInfoById(100011)

	for iter_6_0, iter_6_1 in ipairs(var_6_0.displays) do
		self["_uniteTokenId" .. iter_6_0] = iter_6_1.knight_id

		if self["m_uniteTokenBtn" .. iter_6_0] then
			self["m_uniteTokenBtn" .. iter_6_0]:updateBtnView(iter_6_1)
		end
	end

	if #var_6_0.displays > 1 then
		local var_6_1 = self.m_uniteTokenBtn2:getChild("icon")

		var_6_1:setX(var_6_1:getX() + 200)
	end

	self._cfg = var_0_1:getRecruitKnightCfgById(100011)

	self:_updateRecruitBtn()
	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	AutoBuyComp.bindComp(self.m_recruitTwentyBtn)
	self.m_recruitTwentyBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
end

function RecruitUniteTokenComp:_updateCountDown()
	if not self._remainTime then
		return
	end

	local var_7_0 = self._startTime + self._remainTime - var_0_2:getTime()

	self.m_countDownTxt:setText(g.core.lang:get(108436, {
		time = var_0_2:secondToDHMString(var_7_0)
	}))
	self.m_countDown:setVisible(self._remainTime and self._remainTime > 0)

	if var_7_0 and var_7_0 < 1 then
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
		end, 2)
	end
end

function RecruitUniteTokenComp:updateByCfg(arg_9_1)
	self._tabType = arg_9_1.ownerType
end

function RecruitUniteTokenComp:_updateRecruitBtn()
	local var_10_0, var_10_1 = var_0_1:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_10_2 = {
		isCanRecruit = var_10_0,
		goods = var_10_1
	}
	local var_10_3, var_10_4 = var_0_1:getUniteTokenFreeNumAndRecTime()

	var_10_2.freeNum = var_10_3 > 0 and 1 or 0
	var_10_2.redId = 406

	self.m_recruitOneBtn:updateView(var_10_2)

	local var_10_5, var_10_6 = var_0_1:getgenRecruitConsume(self._cfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_10_5,
		goods = var_10_6
	})

	if self.m_recruitTwentyBtn then
		local var_10_7, var_10_8 = var_0_1:getgenRecruitConsume(self._cfg.twenty_summon_cost)

		self.m_recruitTwentyBtn:updateView({
			isCanRecruit = var_10_7,
			goods = var_10_8
		})
	end

	self.m_countDown:setVisible(false)

	self._remainTime = var_0_1:getUniteTokenFreeDrawRefreshTime()
	self._startTime = var_0_2:getTime()

	if self._remainTime == nil or self._remainTime == 0 then
		self.m_countDown:setVisible(false)
		self:_cancelCountDown()
	else
		self.m_countDown:setVisible(true)

		self._schedulerHandler = g.core.common.Scheduler:newSchedule(handler(self, self._updateCountDown), 1)
	end
end

function RecruitUniteTokenComp:_updateView()
	self._remainTime = var_0_1:getUniteTokenFreeDrawRefreshTime()
	self._startTime = var_0_2:getTime()

	self:_updateRecruitBtn()
	self:_updateLuck()
end

function RecruitUniteTokenComp:_onRecruitOnce()
	if not self._ignoreFull and g.core.model.User.recruitData:checkIsFull(self._cfg) then
		local var_12_1 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_12_1,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitOnce),
			onCheck = function(arg_13_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_13_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitOnce()
	end
end

function RecruitUniteTokenComp:_doRecruitOnce()
	local var_14_0, var_14_1 = var_0_1:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_14_2 = g.core.model.User.recruitData:getBuyHelper()

	var_14_2:setRecruitType(self._cfg.type)
	var_14_2:setRecruitId(self._cfg.id)
	var_14_2:setRecruitNum(1)

	local var_14_3 = var_14_2:getCurBuyItemInfo()
	local var_14_4 = {
		num = 1,
		itemInfo = var_14_3,
		recruitType = self._cfg.type,
		consumeType = var_14_1.requestType
	}

	if self:_isFree(1) then
		var_14_4.consumeType = 0
		var_14_4.itemInfo = nil
		var_14_3 = nil
	end

	self.m_recruitOneBtn:_onDoingClick(var_14_3, var_14_4, 1, 0)
end

function RecruitUniteTokenComp:_onRecruitTen()
	if not self._ignoreFull and g.core.model.User.recruitData:checkIsFull(self._cfg) then
		local var_15_1 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_15_1,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitTen),
			onCheck = function(arg_16_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_16_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitTen()
	end
end

function RecruitUniteTokenComp:_doRecruitTen()
	local var_17_0, var_17_1 = var_0_1:getgenRecruitConsume(self._cfg.ten_summon_cost)
	local var_17_2 = g.core.model.User.recruitData:getBuyHelper()

	var_17_2:setRecruitNum(5)
	var_17_2:setRecruitType(self._cfg.type)
	var_17_2:setRecruitId(self._cfg.id)

	local var_17_3 = var_17_2:getCurBuyItemInfo()
	local var_17_4 = {
		itemInfo = var_17_3,
		recruitType = self._cfg.type,
		consumeType = var_17_1.requestType,
		num = 5
	}

	if self:_isFree(5) then
		var_17_4.consumeType = 0
		var_17_4.itemInfo = nil
		var_17_3 = nil
	end

	self.m_recruitTenBtn:_onDoingClick(var_17_3, var_17_4, 1, 0)
end

function RecruitUniteTokenComp:_onRecruitTwenty()
	if not self._ignoreFull and g.core.model.User.recruitData:checkIsFull(self._cfg) then
		local var_18_1 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_18_1,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitTwenty),
			onCheck = function(arg_19_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_19_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitTwenty()
	end
end

function RecruitUniteTokenComp:_doRecruitTwenty()
	local var_20_0, var_20_1 = var_0_1:getgenRecruitConsume(self._cfg.twenty_summon_cost)
	local var_20_2 = g.core.model.User.recruitData:getBuyHelper()

	var_20_2:setRecruitNum(20)
	var_20_2:setRecruitType(self._cfg.type)
	var_20_2:setRecruitId(self._cfg.id)

	local var_20_3 = var_20_2:getCurBuyItemInfo()
	local var_20_4 = {
		itemInfo = var_20_3,
		recruitType = self._cfg.type,
		consumeType = var_20_1.requestType,
		num = 20
	}

	if self:_isFree(20) then
		var_20_4.consumeType = 0
		var_20_4.itemInfo = nil
		var_20_3 = nil
	end

	self.m_recruitTenBtn:_onDoingClick(var_20_3, var_20_4, 1, 0)
end

function RecruitUniteTokenComp:_isFree(arg_21_1)
	local var_21_0, var_21_1 = var_0_1:getUniteTokenFreeNumAndRecTime()

	if arg_21_1 <= var_21_0 and g.core.config.recruit_knight_cost_gain_info.get(self._cfg.single_summon_cost).daily_free_interval <= var_0_2:getTime() - var_21_1 then
		return true
	end

	return false
end

function RecruitUniteTokenComp:_onUniteTokenPreviewClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._cfg.id,
		type = var_0_0.RECRUIT_TYPE.UNITE_TOKEN_NORMAL,
		title = g.core.lang:get(108106),
		tabType = self._tabType
	}), {
		touchDisappear = true
	})
end

function RecruitUniteTokenComp:_reqRecruitNetWork(arg_23_1)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self._cfg.id,
		consume_type = arg_23_1.consumeType,
		num = arg_23_1.num
	})
end

function RecruitUniteTokenComp:_getRefreshTime()
	local var_24_0 = var_0_2:getTime()
	local var_24_1 = g.core.config.recruit_knight_cost_gain_info.get(self._cfg.single_summon_cost)
	local var_24_2, var_24_3 = self:getUniteTokenFreeNumAndRecTime()

	if var_24_1.daily_free_interval <= var_24_0 - var_24_3 then
		return 0
	end

	return math.min(var_24_1.daily_free_interval - (var_24_0 - var_24_3), (var_0_2:secondsToTommorrow(var_24_0)))
end

function RecruitUniteTokenComp:playShow()
	self:updateView()
	self:setVisible(true)
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_UNITE_TOKEN_UI_SHOW)
end

function RecruitUniteTokenComp:playHide(arg_26_1)
	self.m_backTransition:play(function()
		self:setVisible(false)
		arg_26_1()
	end)
end

function RecruitUniteTokenComp:updateView()
	self:_updateView()

	if var_0_1:isOpenTwentyRecruit(self._cfg) then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function RecruitUniteTokenComp:getTitleTip()
	return ""
end

function RecruitUniteTokenComp:setLimitLuckTimeText(arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6)
	self._curLuckText = arg_30_1
	self._maxLuckText = arg_30_2
	self._extLuckText = arg_30_3
	self._extLuckIcon = arg_30_4
	self._extLuckLight = arg_30_5
	self._extLuckProg = arg_30_6
end

function RecruitUniteTokenComp:_updateLuck()
	local var_31_0 = var_0_1:getGuaranteedInfos(var_0_0.RECRUIT_TYPE.UNITE_TOKEN_NORMAL, true, true)

	if var_31_0 then
		if self._curLuckText then
			self._curLuckText:setText(var_31_0.totalTimes - var_31_0.times)
		end

		if self._maxLuckText then
			self._maxLuckText:setText("/" .. var_31_0.totalTimes)
		end

		if self._extLuckProg then
			self._extLuckProg:setSize(cc.size((var_31_0.totalTimes - var_31_0.times) / var_31_0.totalTimes * 192, 4))
		end

		if self._extLuckText then
			local var_31_1 = g.core.model.User.recruitData:getGuaranteedInfoByGuaranteedType(var_0_0.RECRUIT_TYPE.UNITE_TOKEN_NORMAL, 7) or {
				times = 0,
				totalTimes = 0
			}
			local var_31_2 = var_31_1.totalTimes - var_31_1.times

			self._extLuckText:setText(var_31_1.totalTimes - var_31_1.times)
			self._extLuckIcon:setVisible(false)

			if self._extLuckLight then
				local var_31_3 = self._extLuckLight

				self._extLuckLight:setVisible(var_31_2 > 0)

				self._effLoop = self._effLoop or var_31_3:addEffectSpine({
					name = "eff_ui_recruit_guarantee",
					isLoop = true
				})
			end
		end
	end
end

function RecruitUniteTokenComp:onContinueRecruit(arg_32_1)
	self._ignoreFull = true

	if arg_32_1 == 1 then
		self:_onRecruitOnce()
	elseif arg_32_1 == 5 then
		self:_onRecruitTen()
	elseif arg_32_1 == 20 then
		self:_onRecruitTwenty()
	end

	self._ignoreFull = false
end

return RecruitUniteTokenComp
