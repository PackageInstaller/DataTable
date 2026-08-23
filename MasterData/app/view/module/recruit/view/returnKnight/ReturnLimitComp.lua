local ReturnLimitComp = class("ReturnLimitComp", require("app.fairyGUI.recruitKnight.UI_ReturnLimitComp"))
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.recruitData
local var_0_3 = g.core.const.ConstMgr.RecruitConst
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

function ReturnLimitComp:ctor()
	self._wishInfos = {}
	self._effLoop = nil

	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
end

function ReturnLimitComp:init(arg_2_1)
	self._cfg = arg_2_1.recruitCfg
	self._recruitType = self._cfg.type
	self._displayCfg = arg_2_1.displayCfg
	self._endTime = arg_2_1.endTime

	self:_addListeners()
	self:_initKnightTipBtn()

	local var_2_0 = g.core.config.recruit_knight_wish_rule_info.get(self._cfg.wish_rule_id)

	self.m_raioText:setText(var_2_0.value / 100)

	if var_2_0.function_id > 0 then
		self.m_wishComp:setVisible((g.core.common.ModuleUnlock:isModuleUnlock(var_2_0.function_id)))
	end
end

function ReturnLimitComp:_addListeners()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
	self.m_luckBtn:addClickListener(handler(self, self._onClickedLuck))
	require("app.view.module.recruit.const.RecruitFuncCfg").addBtnTip(self, var_0_3.RECRUIT_TAB_TYPE.KNIGHT_TAB)
end

function ReturnLimitComp:_initKnightTipBtn()
	local var_4_0 = var_0_2:getDisplayInfoById(self._cfg.id)
	local var_4_1 = table.nums(var_4_0.displays)

	for iter_4_0, iter_4_1 in ipairs(var_4_0.displays) do
		local var_4_2 = self["m_tipKnightBtn" .. iter_4_0]

		if not self["m_tipKnightBtn" .. iter_4_0] then
			break
		end

		var_4_2:updateComp(iter_4_1, var_4_1 == var_0_3.SHOW_SPINE_NUM, true, self._displayCfg.cfg)

		local var_4_3 = self:getChild("tipKnightLoader" .. iter_4_0)

		if var_4_3 then
			var_4_3:setURL(g.core.common.Path:getRecruitShowKnightIconById(iter_4_1.knightBgId))
		end
	end
end

function ReturnLimitComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._cfg.id,
		type = var_0_3.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT,
		tabType = self._tabType
	}), {
		touchDisappear = true
	})
end

function ReturnLimitComp:_onKnightTwoBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitKnightShowTimePop").new({
		knightId = 400040,
		justShow = true
	}))
end

function ReturnLimitComp:_onRecruitOneBtnClick()
	if not next(self._wishInfos) or self._wishInfos[1].r_type == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108653))

		return
	end

	if not self._ignoreFull and g.core.model.User.recruitData:checkIsFull(self._cfg) then
		local var_7_1 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_7_1,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitOneTimes),
			onCheck = function(arg_8_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_8_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitOneTimes()
	end
end

function ReturnLimitComp:_doRecruitOneTimes()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	local var_9_0, var_9_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_9_2 = g.core.model.User.recruitData:getBuyHelper()

	var_9_2:setRecruitType(self._cfg.type)
	var_9_2:setRecruitId(self._cfg.id)
	var_9_2:setRecruitNum(1)

	local var_9_3 = var_9_2:getCurBuyItemInfo()
	local var_9_4 = {
		num = 1,
		itemInfo = var_9_3,
		recruitType = self._cfg.type,
		consumeType = var_9_1.requestType
	}

	if self:_isFree() then
		var_9_4.consumeType = 0
		var_9_4.itemInfo = nil
		var_9_3 = nil
	end

	self.m_recruitOneBtn:_onDoingClick(var_9_3, var_9_4, 1, 0)
end

function ReturnLimitComp:_onRecruitGetTaskAward(arg_10_1, arg_10_2, arg_10_3)
	g.core.module.ModuleManager:awardSummary(arg_10_3.awards)
end

function ReturnLimitComp:_onRecruitTenBtnClick()
	if not next(self._wishInfos) or self._wishInfos[1].r_type == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108653))

		return
	end

	if not self._ignoreFull and g.core.model.User.recruitData:checkIsFull(self._cfg) then
		local var_11_1 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_11_1,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitTenTimes),
			onCheck = function(arg_12_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_12_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitTenTimes()
	end
end

function ReturnLimitComp:_doRecruitTenTimes()
	local var_13_0, var_13_1 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)
	local var_13_2 = g.core.model.User.recruitData:getBuyHelper()

	var_13_2:setRecruitNum(10)
	var_13_2:setRecruitType(self._cfg.type)
	var_13_2:setRecruitId(self._cfg.id)

	local var_13_3 = var_13_2:getCurBuyItemInfo()

	self.m_recruitTenBtn:_onDoingClick(var_13_3, {
		itemInfo = var_13_3,
		recruitType = self._cfg.type,
		consumeType = var_13_1.requestType,
		num = 10
	}, 1, 0)
end

function ReturnLimitComp:_isFree()
	local var_14_0 = g.core.config.recruit_knight_cost_gain_info.get(var_0_3.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT)

	if var_14_0.daily_free_times - var_0_2:getAdvanceFreeNum() > 0 and var_14_0.daily_free_interval <= g.core.common.ServerTime:getTime() - var_0_2:getAdvanceFreeTime() then
		return true
	end

	return false
end

function ReturnLimitComp:_reqRecruitNetWork(arg_15_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self._cfg.id,
		consume_type = arg_15_1.consumeType,
		num = arg_15_1.num
	})
end

function ReturnLimitComp:onLoad()
	self._clickOneEnable = true
	self._clickTenEnable = true

	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._resRecruit, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onRecruitGetTaskAward, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self.updateView), self)
	self.m_recruitOneBtn:addAutoBuyCompListener()
	self.m_recruitTenBtn:addAutoBuyCompListener()
end

function ReturnLimitComp:receiveCompEvent(arg_17_1, arg_17_2)
	if arg_17_1 == "clickWish" then
		self:addPopup(require("app.view.module.recruit.view.pop.RecruitKnightReturnWishPop").new(var_0_3.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT, self._cfg.id))

		return true
	end

	return false
end

function ReturnLimitComp:_onStartTimeSchedule()
	self._timeSchedule = self._timeSchedule or self:newSchedule(handler(self, self._updateTime), 1)
end

function ReturnLimitComp:_onStopTimeSchedule()
	self._timeSchedule = nil
end

function ReturnLimitComp:_updateTime()
	local var_20_0, var_20_1, var_20_2, var_20_3 = g.core.common.ServerTime:getLeftTimeParts(self._endTime)
	local var_20_4 = var_20_0 > 0 and string.format(g.core.lang:get(108052), var_20_0, var_20_1, var_20_2, var_20_3) or var_20_1 > 0 and string.format(g.core.lang:get(108051), var_20_1, var_20_2, var_20_3) or var_20_2 > 0 and string.format(g.core.lang:get(108050), var_20_2, var_20_3) or string.format(g.core.lang:get(108049), var_20_3)

	self.m_timeTxt:setText(g.core.lang:get(108048, {
		timeTip = var_20_4
	}))

	if var_20_0 + var_20_1 + var_20_2 + var_20_3 <= 0 then
		self:dispatchCompEvent("limitTimeEnd")
	end
end

function ReturnLimitComp:_resRecruit()
	return
end

function ReturnLimitComp:updateView()
	self._wishInfos = g.core.model.User.recruitData:getWishInfo(self._recruitType, self._cfg.id) or {}

	self.m_wishComp:updateComp(self._wishInfos, self._recruitType)
	self:_updateLuck()
	self:_updateRecruitNum()
	self:_updateCost()
	self:_updateTime()
end

function ReturnLimitComp:setLuckTimeText(arg_23_1, arg_23_2)
	self._curLuckText = arg_23_1
	self._maxLuckText = arg_23_2
end

function ReturnLimitComp:_updateRecruitNum()
	return
end

function ReturnLimitComp:_updateCost()
	local var_25_0, var_25_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)

	self.m_recruitOneBtn:updateView({
		isCanRecruit = var_25_0,
		isFree = self:_isFree(),
		goods = var_25_1
	})

	local var_25_2, var_25_3 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_25_2,
		goods = var_25_3
	})
end

function ReturnLimitComp:getTitleTip()
	return g.core.lang:get(108032, {
		num = 10,
		quality = g.core.lang:get(108035),
		tip = g.core.lang:get(108037)
	})
end

function ReturnLimitComp:playShow()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitEvent = true

	self:updateView()
	self.m_enterTransition:play(handler(self, self.onEnd))
	self:_onStartTimeSchedule()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_HIGH_UI_SHOW)
	self:setVisible(true)
end

function ReturnLimitComp:onEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	self._waitEvent = false
end

function ReturnLimitComp:playHide(arg_29_1)
	self.m_backTransition:play(arg_29_1)
end

function ReturnLimitComp:_updateLuck()
	local var_30_0 = var_0_2:getGuaranteedInfos(var_0_3.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT, false)

	if var_30_0 then
		self.m_curLuckText:setText(var_30_0.totalTimes - var_30_0.times)
		self.m_maxLuckText:setText("/" .. var_30_0.totalTimes)
		self.m_prog:setSize(cc.size((var_30_0.totalTimes - var_30_0.times) / var_30_0.totalTimes * 192, 4))
	end

	local var_30_1 = g.core.model.User.recruitData:getWishInfos(g.core.model.User.recruitData:getDrawInfo(self._cfg.id), self._cfg.id).curTimes

	self.m_extLuckText:setText(var_30_1)

	if self.m_effLoop then
		self.m_effLoop:setVisible(var_30_1 > 0)

		self._effLoop = self._effLoop or self.m_effLoop:addEffectSpine({
			isLoop = true,
			name = "eff_ui_recruitKnight_guarantee"
		})
	end
end

function ReturnLimitComp:onUnload()
	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end

	self:_onStopTimeSchedule()
end

function ReturnLimitComp:updateByCfg(arg_32_1)
	self._tabType = arg_32_1.ownerType
end

function ReturnLimitComp:_onClickedLuck()
	local var_33_0 = require("app.view.base.component.HelpPop").new
	local var_33_1 = {}

	var_33_1.id = 357

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new(var_33_1), {
		touchDisappear = true
	})
end

function ReturnLimitComp:onContinueRecruit(arg_34_1)
	self._ignoreFull = true

	if arg_34_1 == 1 then
		self:_onRecruitOneBtnClick()
	elseif arg_34_1 == 10 then
		self:_onRecruitTenBtnClick()
	end

	self._ignoreFull = false
end

return ReturnLimitComp
