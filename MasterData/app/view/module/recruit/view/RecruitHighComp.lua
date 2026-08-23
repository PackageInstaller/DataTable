local RecruitHighComp = class("RecruitHighComp", require("app.fairyGUI.recruitKnight.UI_RecruitHighComp"))
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.recruitData
local var_0_3 = g.core.const.ConstMgr.RecruitConst
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

function RecruitHighComp:ctor()
	self._wishInfos = {}

	self:_addListeners()
	self:_init()
end

function RecruitHighComp:_addListeners()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
	require("app.view.module.recruit.const.RecruitFuncCfg").addBtnTip(self, var_0_3.RECRUIT_TAB_TYPE.KNIGHT_TAB)

	if g.core.utils.Rule.matchChannelAndLv() and not g.core.platform.ServerListProxy:isTesting() then
		self.m_detailBtn:setVisible(false)
	end
end

function RecruitHighComp:_init()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_ADVANCE_PIC) then
		for iter_3_0, iter_3_1 in ipairs(var_0_2:getDisplayInfoById(100002).displays) do
			self["m_knightBtn" .. iter_3_0]:updateComp(iter_3_1)
		end
	else
		for iter_3_2, iter_3_3 in ipairs({
			{
				knightBgId = 600120,
				x = 0,
				knight_id = 600120,
				y = 0
			},
			{
				knightBgId = 510010,
				x = 0,
				knight_id = 510010,
				y = 0
			}
		}) do
			self["m_knightBtn" .. iter_3_2]:updateComp(iter_3_3)
		end
	end

	self:addListen(self.m_wishComp)
	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))

	self._cfg = var_0_2:getRecruitKnightCfgById(100002)

	self.m_effectNode:addEffectSpine({
		name = "eff_ui_recruit_mainLayer"
	})
end

function RecruitHighComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._cfg.id,
		type = var_0_3.RECRUIT_TYPE.PREMIUM,
		tabType = self._tabType
	}), {
		touchDisappear = true
	})
end

function RecruitHighComp:_onKnightTwoBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitKnightShowTimePop").new({
		knightId = 400040,
		justShow = true
	}))
end

function RecruitHighComp:_onRecruitOneBtnClick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	if not var_0_2:isHasAdvRecruitNum(1, self._cfg.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(108471))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		return
	end

	if not self._ignoreFull and var_0_2:checkIsFull(self._cfg) then
		local var_6_0 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_6_0,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitOneTimes),
			onCheck = function(arg_7_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_7_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitOneTimes()
	end
end

function RecruitHighComp:_doRecruitOneTimes()
	local var_8_0, var_8_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_8_2 = g.core.model.User.recruitData:getBuyHelper()

	var_8_2:setRecruitType(self._cfg.type)
	var_8_2:setRecruitId(self._cfg.id)
	var_8_2:setRecruitNum(1)

	local var_8_3 = var_8_2:getCurBuyItemInfo()
	local var_8_4 = {
		num = 1,
		itemInfo = var_8_3,
		recruitType = var_0_3.RECRUIT_TYPE.PREMIUM,
		consumeType = var_8_1.requestType
	}

	if self:_isFree() then
		var_8_4.consumeType = 0
		var_8_4.itemInfo = nil
		var_8_3 = nil
	end

	self.m_recruitOneBtn:_onDoingClick(var_8_3, var_8_4, 1, 0)
end

function RecruitHighComp:_onRecruitGetTaskAward(arg_9_1, arg_9_2, arg_9_3)
	g.core.module.ModuleManager:awardSummary(arg_9_3.awards)
end

function RecruitHighComp:_onRecruitTenBtnClick()
	if not var_0_2:isHasAdvRecruitNum(10, self._cfg.id) then
		local var_10_0 = g.core.config.parameter_info.get(15009).parameter

		g.core.module.ModuleManager:tip(g.core.lang:get(108471))

		return
	end

	if not self._ignoreFull and var_0_2:checkIsFull(self._cfg) then
		local var_10_2 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_10_2,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitTenTimes),
			onCheck = function(arg_11_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_11_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitTenTimes()
	end
end

function RecruitHighComp:_doRecruitTenTimes()
	local var_12_0, var_12_1 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)
	local var_12_2 = g.core.model.User.recruitData:getBuyHelper()

	var_12_2:setRecruitNum(10)
	var_12_2:setRecruitType(self._cfg.type)
	var_12_2:setRecruitId(self._cfg.id)

	local var_12_3 = var_12_2:getCurBuyItemInfo()

	self.m_recruitTenBtn:_onDoingClick(var_12_3, {
		itemInfo = var_12_3,
		recruitType = var_0_3.RECRUIT_TYPE.PREMIUM,
		consumeType = var_12_1.requestType,
		num = 10
	}, 1, 0)
end

function RecruitHighComp:_isFree()
	local var_13_0 = g.core.config.recruit_knight_cost_gain_info.get(var_0_3.RECRUIT_TYPE.PREMIUM)

	if var_13_0.daily_free_times - var_0_2:getAdvanceFreeNum() > 0 and var_13_0.daily_free_interval <= g.core.common.ServerTime:getTime() - var_0_2:getAdvanceFreeTime() then
		return true
	end

	return false
end

function RecruitHighComp:_reqRecruitNetWork(arg_14_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self._cfg.id,
		consume_type = arg_14_1.consumeType,
		num = arg_14_1.num
	})
end

function RecruitHighComp:onLoad()
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._resRecruit, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onRecruitGetTaskAward, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self.updateView), self)
	self.m_recruitOneBtn:addAutoBuyCompListener()
	self.m_recruitTenBtn:addAutoBuyCompListener()
end

function RecruitHighComp:receiveCompEvent(arg_16_1, arg_16_2)
	if arg_16_1 == "clickWish" then
		self:addPopup(require("app.view.module.recruit.view.pop.RecruitKnightWishPop").new(var_0_3.RECRUIT_TYPE.PREMIUM, self._cfg.id))

		return true
	end

	return false
end

function RecruitHighComp:_resRecruit()
	return
end

function RecruitHighComp:updateView()
	self._wishInfos = g.core.model.User.recruitData:getWishInfo(var_0_3.RECRUIT_TYPE.PREMIUM)

	self.m_wishComp:updateComp(self._wishInfos, var_0_3.RECRUIT_TYPE.PREMIUM)
	self:_updateLuck()
	self:_updateRecruitNum()
	self:_updateCost()
	self.m_titleComp:setCtrlState("getSSR", {
		index = (g.core.model.User.recruitData:isGetAdvanceRecruitFirstSSR() or nil) and 1
	})
end

function RecruitHighComp:setLuckTimeText(arg_19_1, arg_19_2)
	self._curLuckText = arg_19_1
	self._maxLuckText = arg_19_2
end

function RecruitHighComp:_updateRecruitNum()
	return
end

function RecruitHighComp:_updateCost()
	local var_21_0, var_21_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)

	self.m_recruitOneBtn:updateView({
		isCanRecruit = var_21_0,
		isFree = self:_isFree(),
		goods = var_21_1
	})

	local var_21_2, var_21_3 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_21_2,
		goods = var_21_3
	})
end

function RecruitHighComp:getTitleTip()
	return g.core.lang:get(108032, {
		num = 10,
		quality = g.core.lang:get(108035),
		tip = g.core.lang:get(108037)
	})
end

function RecruitHighComp:playShow()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitEvent = true

	self:updateView()
	self:setVisible(true)
	self.m_enterTransition:play(handler(self, self.onEnd))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_HIGH_UI_SHOW)
end

function RecruitHighComp:onEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	self._waitEvent = false
end

function RecruitHighComp:playHide(arg_25_1)
	self.m_backTransition:play(arg_25_1)
end

function RecruitHighComp:_updateLuck()
	local var_26_0 = var_0_2:getGuaranteedInfos(var_0_3.RECRUIT_TYPE.PREMIUM, false)

	if var_26_0 then
		self._curLuckText:setText(var_26_0.totalTimes - var_26_0.times)
		self._maxLuckText:setText("/" .. var_26_0.totalTimes)
	end
end

function RecruitHighComp:onUnload()
	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end
end

function RecruitHighComp:updateByCfg(arg_28_1)
	self._tabType = arg_28_1.ownerType
end

function RecruitHighComp:onContinueRecruit(arg_29_1)
	self._ignoreFull = true

	if arg_29_1 == 1 then
		self:_onRecruitOneBtnClick()
	elseif arg_29_1 == 10 then
		self:_onRecruitTenBtnClick()
	end

	self._ignoreFull = false
end

return RecruitHighComp
