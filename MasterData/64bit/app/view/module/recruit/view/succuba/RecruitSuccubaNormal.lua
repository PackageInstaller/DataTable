local RecruitSuccubaNormal = class("RecruitSuccubaNormal", require("app.fairyGUI.recruitSuccuba.UI_RecruitSuccubaNormal"))
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.recruitData
local var_0_3 = g.core.const.ConstMgr.RecruitConst
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

function RecruitSuccubaNormal:ctor()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_NORMAL_SUCCUBA)
	self:_addListeners()
	self:_init()
end

function RecruitSuccubaNormal:_addListeners()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
	self.m_selTargetBtn:addClickListener(handler(self, self._onSelTargetBtnClick))
	require("app.view.module.recruit.const.RecruitFuncCfg").addBtnTip(self, var_0_3.RECRUIT_TAB_TYPE.SUCCUBA_TAB)

	if g.core.utils.Rule.matchChannelAndLv() then
		self.m_detailBtn:setVisible(false)
	end
end

function RecruitSuccubaNormal:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._cfg.id,
		type = var_0_3.RECRUIT_TYPE.RECRUIT_SUCCUBA,
		tabType = self._tabType
	}), {
		touchDisappear = true
	})
end

function RecruitSuccubaNormal:_onSelTargetBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.recruit.view.succuba.RecruitSuccubaWishPop").new({
		wishRuleId = self._cfg.wish_rule_id,
		cfg = self._cfg
	})))
end

function RecruitSuccubaNormal:_onRecruitOneBtnClick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	if not var_0_2:isHasSuccubaNormalNum(1, self._cfg.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(431304))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		return
	end

	if not self._ignoreFull and var_0_2:checkIsWishFull(100096, var_0_3.RECRUIT_TYPE.RECRUIT_SUCCUBA) then
		local var_5_0 = g.core.lang:get(108719) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_5_0,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitOneTimes),
			onCheck = function(arg_6_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_6_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitOneTimes()
	end
end

function RecruitSuccubaNormal:_doRecruitOneTimes()
	local var_7_0, var_7_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_7_2 = g.core.model.User.recruitData:getBuyHelper()

	var_7_2:setRecruitType(self._cfg.type)
	var_7_2:setRecruitId(self._cfg.id)
	var_7_2:setRecruitNum(1)

	local var_7_3 = var_7_2:getCurBuyItemInfo()

	self.m_recruitOneBtn:_onDoingClick(var_7_3, {
		num = 1,
		itemInfo = var_7_3,
		recruitType = self._cfg.type,
		consumeType = var_7_1.requestType
	}, 1, 0)
end

function RecruitSuccubaNormal:_onRecruitGetTaskAward(arg_8_1, arg_8_2, arg_8_3)
	g.core.module.ModuleManager:awardSummary(arg_8_3.awards)
end

function RecruitSuccubaNormal:_onRecruitTenBtnClick()
	if not var_0_2:isHasSuccubaNormalNum(10, self._cfg.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(431304))

		return
	end

	if not self._ignoreFull and var_0_2:checkIsWishFull(100096, var_0_3.RECRUIT_TYPE.RECRUIT_SUCCUBA) then
		local var_9_0 = g.core.lang:get(108719) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_9_0,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitTenTimes),
			onCheck = function(arg_10_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_10_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitTenTimes()
	end
end

function RecruitSuccubaNormal:_doRecruitTenTimes()
	local var_11_0, var_11_1 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)
	local var_11_2 = g.core.model.User.recruitData:getBuyHelper()

	var_11_2:setRecruitNum(10)
	var_11_2:setRecruitType(self._cfg.type)
	var_11_2:setRecruitId(self._cfg.id)

	local var_11_3 = var_11_2:getCurBuyItemInfo()

	self.m_recruitTenBtn:_onDoingClick(var_11_3, {
		itemInfo = var_11_3,
		recruitType = self._cfg.type,
		consumeType = var_11_1.requestType,
		num = 10
	}, 1, 0)
end

function RecruitSuccubaNormal:_reqRecruitNetWork(arg_12_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self._cfg.id,
		consume_type = arg_12_1.consumeType,
		num = arg_12_1.num
	})
end

function RecruitSuccubaNormal:_init()
	self._cfg = var_0_2:getRecruitKnightCfgById(100096)

	local var_13_0 = var_0_2:getDisplayInfoById(100096)
	local var_13_1 = var_0_2:getSuccubaNormalWish()
	local var_13_2 = 0

	if next(var_13_1) then
		var_13_2 = var_13_1[1].r_value
	else
		var_13_2 = var_0_2:getSuccubaTotalNormalWishItems()[1].value

		self:_sendFirstWish(var_13_2)
	end

	for iter_13_0, iter_13_1 in ipairs(var_13_0.displays) do
		iter_13_1.knightBgId = var_13_2
		iter_13_1.knight_id = var_13_2

		self["m_knightBtn" .. iter_13_0]:updateComp(iter_13_1)
	end

	self.m_effectNode:addEffectSpine({
		name = "eff_ui_succubaRecruit_mainLayer"
	})
	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
end

function RecruitSuccubaNormal:_sendFirstWish(arg_14_1)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Luck({
		id = self._cfg.id,
		wish = {
			{
				pos = 1,
				r_type = g.core.common.Goods.TYPE_FRAGMENT,
				r_value = arg_14_1
			}
		}
	})
end

function RecruitSuccubaNormal:onLoad()
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onRecruitGetTaskAward, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, self.onResetWishState, self)
	self.m_selTargetBtn:updateSuccubaWish()
	self.m_recruitOneBtn:addAutoBuyCompListener()
	self.m_recruitTenBtn:addAutoBuyCompListener()
end

function RecruitSuccubaNormal:onResetWishState()
	self.m_selTargetBtn:updateSuccubaWish()

	local var_16_0 = var_0_2:getDisplayInfoById(100096)
	local var_16_1 = var_0_2:getSuccubaNormalWish()
	local var_16_2 = 0

	if next(var_16_1) then
		var_16_2 = var_16_1[1].r_value
	else
		var_16_2 = var_0_2:getSuccubaTotalNormalWishItems()[1].value

		self:_sendFirstWish(var_16_2)
	end

	for iter_16_0, iter_16_1 in ipairs(var_16_0.displays) do
		iter_16_1.knightBgId = var_16_2
		iter_16_1.knight_id = var_16_2

		self["m_knightBtn" .. iter_16_0]:updateComp(iter_16_1)
	end
end

function RecruitSuccubaNormal:playRecruitAction(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	if arg_17_5 then
		return
	end

	self._recruitContent = arg_17_1

	if self._isContinue then
		self._isContinue = false
	else
		g.core.module.ModuleManager:pushPopup((require("app.view.module.recruit.view.succuba.RecruitSuccubaMoviePop").new({
			cb = handler(self, self.onMoviePlayFinish),
			closeCb = handler(self, self._onCloseAward)
		})))
	end
end

function RecruitSuccubaNormal:_onCloseAward()
	self._isContinue = false
end

function RecruitSuccubaNormal:onMoviePlayFinish()
	self._content = self._recruitContent

	local var_19_0, var_19_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_19_2, var_19_3 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)

	g.core.module.ModuleManager:pushPopup(require("app.view.module.recruit.view.succuba.RecruitSuccubaNormalRewardPop").new({
		oneCost = var_19_1,
		tenCost = var_19_3,
		awards = self._recruitContent.awards,
		cfg = self._cfg
	}), {
		touchDisappear = false,
		ignoreTouch = true
	})
	self:updateView()

	self._recruitContent = nil
end

function RecruitSuccubaNormal:updateView()
	self:_updateRecruitNum()
	self:_updateCost()
end

function RecruitSuccubaNormal:setLuckTimeText(arg_21_1, arg_21_2)
	self._curLuckText = arg_21_1
	self._maxLuckText = arg_21_2
end

function RecruitSuccubaNormal:_updateRecruitNum()
	return
end

function RecruitSuccubaNormal:_updateCost()
	local var_23_0, var_23_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)

	self.m_recruitOneBtn:updateView({
		isCanRecruit = var_23_0,
		goods = var_23_1
	})

	local var_23_2, var_23_3 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_23_2,
		goods = var_23_3
	})
end

function RecruitSuccubaNormal:getTitleTip()
	return g.core.lang:get(108032, {
		num = 10,
		quality = g.core.lang:get(108035),
		tip = g.core.lang:get(108037)
	})
end

function RecruitSuccubaNormal:playShow()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitEvent = true

	self:updateView()
	self:setVisible(true)
	self.m_enterTransition:play(handler(self, self.onEnd))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_HIGH_UI_SHOW)
end

function RecruitSuccubaNormal:onEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	self._waitEvent = false
end

function RecruitSuccubaNormal:playHide(arg_27_1)
	self.m_backTransition:play(arg_27_1)
end

function RecruitSuccubaNormal:onUnload()
	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end
end

function RecruitSuccubaNormal:updateByCfg(arg_29_1)
	self._tabType = arg_29_1.ownerType
end

return RecruitSuccubaNormal
