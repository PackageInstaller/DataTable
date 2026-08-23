local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")
local RecruitNewLimitComp = class("RecruitNewLimitComp", require("app.fairyGUI.recruitKnight.UI_RecruitNewLimitComp"))
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.model.User.recruitData
local var_0_4 = g.core.const.ConstMgr.RecruitConst

function RecruitNewLimitComp:ctor()
	self._wishInfos = {}
	self._effLoop = nil

	self:init()
end

function RecruitNewLimitComp:init(arg_2_1)
	self._cfg = g.core.model.User.recruitData:getRecruitKnightCfgById(100030)
	self._recruitType = self._cfg.type
	self._displayCfg = g.core.model.User.recruitData:getDisplayInfoById(100030)

	self:_addListeners()
	self:_initKnightTipBtn()

	local var_2_0 = g.core.config.recruit_knight_wish_rule_info.get(self._cfg.wish_rule_id)

	self.m_raioText:setText(var_2_0.value / 100)

	if var_2_0.function_id > 0 then
		self.m_wishComp:setVisible((g.core.common.ModuleUnlock:isModuleUnlock(var_2_0.function_id)))
	end
end

function RecruitNewLimitComp:_addListeners()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
	self.m_luckBtn:addClickListener(handler(self, self._onClickedLuck))
	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	require("app.view.module.recruit.const.RecruitFuncCfg").addBtnTip(self, var_0_4.RECRUIT_TAB_TYPE.KNIGHT_TAB)
end

function RecruitNewLimitComp:_initKnightTipBtn()
	local var_4_0 = var_0_3:getDisplayInfoById(self._cfg.id)
	local var_4_1 = table.nums(var_4_0.displays)

	for iter_4_0, iter_4_1 in ipairs(var_4_0.displays) do
		local var_4_2 = self["m_tipKnightBtn" .. iter_4_0]

		if not self["m_tipKnightBtn" .. iter_4_0] then
			break
		end

		var_4_2:updateComp(iter_4_1, var_4_1 == var_0_4.SHOW_SPINE_NUM, true, self._displayCfg.cfg)

		local var_4_3 = self:getChild("tipKnightLoader" .. iter_4_0)

		if var_4_3 then
			var_4_3:setURL(g.core.common.Path:getRecruitShowKnightIconById(iter_4_1.knightBgId))
		end
	end
end

function RecruitNewLimitComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._cfg.id,
		type = var_0_4.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT,
		tabType = self._tabType
	}), {
		touchDisappear = true
	})
end

function RecruitNewLimitComp:_onKnightTwoBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitKnightShowTimePop").new({
		knightId = 400040,
		justShow = true
	}))
end

function RecruitNewLimitComp:_onRecruitOneBtnClick()
	if not next(self._wishInfos) or self._wishInfos[1].r_type == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108653))

		return
	end

	if not self._ignoreFull and g.core.model.User.recruitData:checkIsFull(self._cfg) then
		local var_7_0 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_7_0,
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

function RecruitNewLimitComp:_doRecruitOneTimes()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	local var_9_0, var_9_1 = var_0_3:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_9_2 = g.core.model.User.recruitData:getBuyHelper()

	var_9_2:setRecruitType(var_0_4.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT)
	var_9_2:setRecruitId(self._cfg.id)
	var_9_2:setRecruitNum(1)

	local var_9_3 = var_9_2:getCurBuyItemInfo()
	local var_9_4 = {
		num = 1,
		itemInfo = var_9_3,
		recruitType = var_0_4.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT,
		consumeType = var_9_1.requestType
	}

	if self:_isFree() then
		var_9_4.consumeType = 0
		var_9_4.itemInfo = nil
		var_9_3 = nil
	end

	self.m_recruitOneBtn:_onDoingClick(var_9_3, var_9_4, 1, 0)
end

function RecruitNewLimitComp:_onRecruitGetTaskAward(arg_10_1, arg_10_2, arg_10_3)
	g.core.module.ModuleManager:awardSummary(arg_10_3.awards)
end

function RecruitNewLimitComp:_onRecruitTenBtnClick()
	if not next(self._wishInfos) or self._wishInfos[1].r_type == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108653))

		return
	end

	if not self._ignoreFull and g.core.model.User.recruitData:checkIsFull(self._cfg) then
		local var_11_0 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_11_0,
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

function RecruitNewLimitComp:_doRecruitTenTimes()
	local var_13_0, var_13_1 = var_0_3:getgenRecruitConsume(self._cfg.ten_summon_cost)
	local var_13_2 = g.core.model.User.recruitData:getBuyHelper()

	var_13_2:setRecruitNum(10)
	var_13_2:setRecruitType(var_0_4.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT)
	var_13_2:setRecruitId(self._cfg.id)

	local var_13_3 = var_13_2:getCurBuyItemInfo()

	self.m_recruitTenBtn:_onDoingClick(var_13_3, {
		itemInfo = var_13_3,
		recruitType = var_0_4.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT,
		consumeType = var_13_1.requestType,
		num = 10
	}, 1, 0)
end

function RecruitNewLimitComp:_isFree()
	local var_14_0 = g.core.config.recruit_knight_cost_gain_info.get(var_0_4.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT)

	if var_14_0.daily_free_times - var_0_3:getAdvanceFreeNum() > 0 and var_14_0.daily_free_interval <= g.core.common.ServerTime:getTime() - var_0_3:getAdvanceFreeTime() then
		return true
	end

	return false
end

function RecruitNewLimitComp:_reqRecruitNetWork(arg_15_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self._cfg.id,
		consume_type = arg_15_1.consumeType,
		num = arg_15_1.num
	})
end

function RecruitNewLimitComp:onLoad()
	self._clickOneEnable = true
	self._clickTenEnable = true

	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._resRecruit, self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onRecruitGetTaskAward, self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self.updateView), self)
	self.m_recruitOneBtn:addAutoBuyCompListener()
	self.m_recruitTenBtn:addAutoBuyCompListener()
end

function RecruitNewLimitComp:receiveCompEvent(arg_17_1, arg_17_2)
	if arg_17_1 == "clickWish" then
		self:addPopup(require("app.view.module.recruit.view.pop.RecruitKnightNewLimitWishPop").new(var_0_4.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT, self._cfg.id))

		return true
	end

	return false
end

function RecruitNewLimitComp:_resRecruit()
	return
end

function RecruitNewLimitComp:updateView()
	self._wishInfos = g.core.model.User.recruitData:getWishInfo(self._recruitType, self._cfg.id) or {}

	self.m_wishComp:updateComp(self._wishInfos, self._recruitType)
	self:_updateLuck()
	self:_updateRecruitNum()
	self:_updateCost()
end

function RecruitNewLimitComp:setLuckTimeText(arg_20_1, arg_20_2)
	self._curLuckText = arg_20_1
	self._maxLuckText = arg_20_2
end

function RecruitNewLimitComp:_updateRecruitNum()
	return
end

function RecruitNewLimitComp:_updateCost()
	local var_22_0, var_22_1 = var_0_3:getgenRecruitConsume(self._cfg.single_summon_cost)

	self.m_recruitOneBtn:updateView({
		isCanRecruit = var_22_0,
		isFree = self:_isFree(),
		goods = var_22_1
	})

	local var_22_2, var_22_3 = var_0_3:getgenRecruitConsume(self._cfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_22_2,
		goods = var_22_3
	})
end

function RecruitNewLimitComp:getTitleTip()
	return g.core.lang:get(108032, {
		num = 10,
		quality = g.core.lang:get(108035),
		tip = g.core.lang:get(108037)
	})
end

function RecruitNewLimitComp:playShow()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitEvent = true

	self:updateView()
	self.m_enterTransition:play(handler(self, self.onEnd))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_HIGH_UI_SHOW)
	self:setVisible(true)
end

function RecruitNewLimitComp:onEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	self._waitEvent = false
end

function RecruitNewLimitComp:playHide(arg_26_1)
	self.m_backTransition:play(arg_26_1)
end

function RecruitNewLimitComp:_updateLuck()
	local var_27_0 = var_0_3:getGuaranteedInfos(var_0_4.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT, false)

	if var_27_0 then
		self.m_curLuckText:setText(var_27_0.totalTimes - var_27_0.times)
		self.m_maxLuckText:setText("/" .. var_27_0.totalTimes)
		self.m_prog:setSize(cc.size((var_27_0.totalTimes - var_27_0.times) / var_27_0.totalTimes * 192, 4))
	end

	local var_27_1 = g.core.model.User.recruitData:getWishInfos(g.core.model.User.recruitData:getDrawInfo(self._cfg.id, nil, true), self._cfg.id).curTimes

	self.m_extLuckText:setText(var_27_1)
	self.m_luckIcon:setVisible(var_27_1 > 0)

	if self.m_effLoop then
		self.m_effLoop:setVisible(var_27_1 > 0)

		self._effLoop = self._effLoop or self.m_effLoop:addEffectSpine({
			isLoop = true,
			name = "eff_ui_recruitKnight_guarantee"
		})
	end
end

function RecruitNewLimitComp:onUnload()
	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end
end

function RecruitNewLimitComp:updateByCfg(arg_29_1)
	self._tabType = arg_29_1.ownerType
end

function RecruitNewLimitComp:_onClickedLuck()
	local var_30_0 = require("app.view.base.component.HelpPop").new
	local var_30_1 = {}

	var_30_1.id = 499

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new(var_30_1), {
		touchDisappear = true
	})
end

function RecruitNewLimitComp:onContinueRecruit(arg_31_1)
	self._ignoreFull = true

	if arg_31_1 == 1 then
		self:_onRecruitOneBtnClick()
	elseif arg_31_1 == 10 then
		self:_onRecruitTenBtnClick()
	end

	self._ignoreFull = false
end

function RecruitNewLimitComp:setLimitLuckTimeText()
	return
end

return RecruitNewLimitComp
