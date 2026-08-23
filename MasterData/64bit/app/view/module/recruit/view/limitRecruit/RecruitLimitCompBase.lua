local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = {
		super = true,
		__cname = true,
		__supers = true,
		ctor = true,
		bindClassRef = true,
		__newindex = true,
		__index = true,
		create = true,
		new = true
	}

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if not var_1_0[iter_1_0] then
			arg_1_1[iter_1_0] = iter_1_1
		end
	end

	return arg_1_1
end

local function var_0_2(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(rawget(rawget(arg_2_0, "__index"), "__supers") or {}) do
		var_2_0 = var_0_1(arg_2_1, iter_2_1, var_2_0)
	end

	for iter_2_2, iter_2_3 in pairs((var_0_1(arg_2_0, var_2_0))) do
		if not arg_2_1[iter_2_2] then
			arg_2_1[iter_2_2] = iter_2_3
		elseif type(iter_2_3) == "function" and type(arg_2_1[iter_2_2]) == "function" then
			local var_2_1 = arg_2_1
			local var_2_2 = arg_2_2[iter_2_2]
			local var_2_3 = iter_2_3

			arg_2_1[iter_2_2] = (iter_2_2 == "onUnload" or iter_2_2 == "onLoad") and function()
				return var_2_2(var_2_1, ...), (var_2_3(var_2_1, ...))
			end or var_2_2 and var_2_2 or var_2_3
		end
	end
end

local RecruitLimitCompBase = class("RecruitLimitCompBase")
local RecruitFuncCfg = require("app.view.module.recruit.const.RecruitFuncCfg")
local var_0_5 = g.core.event.EventManager
local var_0_6 = g.core.model.User.recruitData
local var_0_7 = g.core.const.ConstMgr.RecruitConst
local ParticleMgr = require("app.core.effect.ParticleMgr")

function RecruitLimitCompBase:bindClassRef(arg_4_1)
	return var_0_2(RecruitLimitCompBase, self, arg_4_1)
end

function RecruitLimitCompBase:ctor()
	self._timeSchedule = nil
	self._timeUpdateEnable = true
	self._singleNum = 1
	self._multiNum = 10
	self._previewTitle = nil

	self:_initSubComps()
	self:_initBuyComp()

	if self.m_wishComp then
		self:addListen(self.m_wishComp)
	end
end

function RecruitLimitCompBase:init(arg_6_1)
	self._actData = arg_6_1

	local var_6_0 = self._actData:getActivityId()

	if not self._actData:getInfo().sub_activity_id then
		self._actId = self._actData:getActivityValue()
	end

	local var_6_1 = arg_6_1:getInfo().sub_activity_id or arg_6_1:getActivityValue()

	self._recruitCfg = var_0_6:getRecruitKnightCfgById(var_6_1)
	self._recruitType = self._recruitCfg.type
	self._displayCfg = var_0_6:getDisplayInfoById(var_6_1)

	self:_iniParticle()
	self:_initUI()
	self:_initTranslation()
	self:_addListeners()
	self:_initKnightTipBtn()

	if self._subComps.recruitTwentyBtn then
		self._btnPos = self._btnPos or {
			self.m_recruitOneBtn:getPosition(),
			self.m_recruitTenBtn:getPosition()
		}

		if var_0_6:isOpenTwentyRecruit(self._cfg) then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(0)
		end
	end
end

function RecruitLimitCompBase:_iniParticle()
	for iter_7_0 = 1, 4 do
		local var_7_0 = self:getChild("effectHolder" .. iter_7_0)

		if var_7_0 then
			var_7_0:addNode(ParticleMgr.getParticle("uiparticle_recruit_spark_" .. iter_7_0))
		end
	end
end

function RecruitLimitCompBase:_initSubComps()
	self._subComps = {}
	self._subComps.detailBtn = self.m_detailBtn
	self._subComps.recruitOneBtn = self.m_recruitOneBtn
	self._subComps.recruitTentBtn = self.m_recruitTenBtn
	self._subComps.recruitTwentyBtn = self.m_recruitTwentyBtn
	self._subComps.timeTxt = self.m_timeTxt
	self._subComps.raioText = self.m_raioText
end

function RecruitLimitCompBase:_initBuyComp()
	if self._subComps.recruitOneBtn then
		AutoBuyComp.bindComp(self._subComps.recruitOneBtn)
		self._subComps.recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	end

	if self._subComps.recruitTentBtn then
		AutoBuyComp.bindComp(self._subComps.recruitTentBtn)
		self._subComps.recruitTentBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	end

	if self._subComps.recruitTwentyBtn then
		AutoBuyComp.bindComp(self._subComps.recruitTwentyBtn)
		self._subComps.recruitTwentyBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	end
end

function RecruitLimitCompBase:_initUI()
	for iter_10_0 = 1, 99 do
		if not self["m_tipKnightBtn" .. iter_10_0] then
			break
		end

		self._subComps["tipKnightBtn" .. iter_10_0] = self["m_tipKnightBtn" .. iter_10_0]
	end

	if self._subComps.raioText then
		self._subComps.raioText:setText(self._displayCfg.cfg.param_1)
	end

	self._previewTitle = self._subComps.detailBtn:getTitle()

	if g.core.config.recruit_knight_wish_rule_info.get(self._recruitCfg.wish_rule_id).function_id > 0 then
		-- block empty
	end

	RecruitFuncCfg.addBtnTip(self, var_0_7.RECRUIT_TAB_TYPE.KNIGHT_TAB)
	self:_initOtherUI()
end

function RecruitLimitCompBase:_initOtherUI()
	return
end

function RecruitLimitCompBase:_initTranslation()
	self._translations = {}
	self._translations.enter = self.m_enterTransition
	self._translations.back = self.m_backTransition
end

function RecruitLimitCompBase:setLuckTimeText(arg_13_1, arg_13_2)
	self._subComps.curLuckText = arg_13_1
	self._subComps.maxLuckText = arg_13_2
end

function RecruitLimitCompBase:setLimitLuckTimeText(arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	self._subComps.curLuckText = arg_14_1
	self._subComps.maxLuckText = arg_14_2
	self._subComps.extLuckText = arg_14_3
	self._subComps.extLuckIcon = arg_14_4
	self._subComps.extLuckLight = arg_14_5
	self._subComps.extLuckProg = arg_14_6
end

function RecruitLimitCompBase:_addListeners()
	self._subComps.detailBtn:addClickListener(handler(self, self._onDetailBtnClick))

	if self._subComps.recruitOneBtn then
		self._subComps.recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	end

	self._subComps.recruitTentBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))

	if self._subComps.recruitTwentyBtn then
		self._subComps.recruitTwentyBtn:addClickListener(handler(self, self._onRecruitTwentyBtnClick))
	end
end

function RecruitLimitCompBase:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._recruitCfg.id,
		type = self._recruitType,
		tabType = self._tabType,
		title = self._previewTitle
	}), {
		touchDisappear = true
	})
end

function RecruitLimitCompBase:_onRecruitOneBtnClick()
	local var_17_0, var_17_1 = self:_checkIsReachMaxTimes(1)

	if var_17_0 > 0 then
		var_17_1 = var_17_1 or g.core.lang:get(108413, {
			name = self._displayCfg.cfg.name,
			num = var_17_0
		})

		g.core.module.ModuleManager:tip(var_17_1)

		return
	end

	if not self._ignoreFull and var_0_6:checkIsFull(self._recruitCfg) then
		local var_17_3 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_17_3,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitOneTimes),
			onCheck = function(arg_18_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_18_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitOneTimes()
	end
end

function RecruitLimitCompBase:_doRecruitOneTimes()
	local var_19_0, var_19_1 = var_0_6:getgenRecruitConsume(self._recruitCfg.single_summon_cost)
	local var_19_2 = g.core.model.User.recruitData:getBuyHelper()

	var_19_2:setRecruitType(self._recruitCfg.type)
	var_19_2:setRecruitId(self:_getRecruitNetId())
	var_19_2:setRecruitNum(self._singleNum)

	local var_19_3 = var_19_2:getCurBuyItemInfo()
	local var_19_4 = {
		itemInfo = var_19_3,
		recruitType = self._recruitType,
		consumeType = var_19_1.requestType,
		num = self._singleNum,
		recruitId = self:_getRecruitNetId()
	}

	if self:_getFreeTimes() > 0 then
		var_19_4.consumeType = 0
		var_19_4.itemInfo = nil
		var_19_3 = nil
	end

	self._subComps.recruitOneBtn:_onDoingClick(var_19_3, var_19_4, 1, 0)
end

function RecruitLimitCompBase:_checkIsReachMaxTimes(arg_20_1)
	local var_20_0 = var_0_6:getDrawInfo(self._recruitCfg.id)

	if not var_20_0 then
		return 0
	end

	local var_20_1 = var_20_0:getDailyLimitNum()

	return (var_20_1 < var_20_0:getDailyCount() + arg_20_1 or nil) and var_20_1
end

function RecruitLimitCompBase:_getFreeTimes()
	return 0
end

function RecruitLimitCompBase:_onRecruitGetTaskAward(arg_22_1, arg_22_2, arg_22_3)
	g.core.module.ModuleManager:awardSummary(arg_22_3.awards)
end

function RecruitLimitCompBase:_onRecruitTenBtnClick()
	local var_23_0, var_23_1 = self:_checkIsReachMaxTimes(self._multiNum)

	if var_23_0 > 0 then
		var_23_1 = var_23_1 or g.core.lang:get(108413, {
			name = self._displayCfg.cfg.name,
			num = var_23_0
		})

		g.core.module.ModuleManager:tip(var_23_1)

		return
	end

	if not self:_checkWishHaveSet() then
		self:_showOtherPop()

		return
	end

	if not self._ignoreFull and var_0_6:checkIsFull(self._recruitCfg) then
		local var_23_3 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_23_3,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitTenTimes),
			onCheck = function(arg_24_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_24_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitTenTimes()
	end
end

function RecruitLimitCompBase:_doRecruitTenTimes()
	local var_25_0, var_25_1 = var_0_6:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)
	local var_25_2 = g.core.model.User.recruitData:getBuyHelper()

	var_25_2:setRecruitType(self._recruitCfg.type)
	var_25_2:setRecruitId(self:_getRecruitNetId())
	var_25_2:setRecruitNum(self._multiNum)

	local var_25_3 = var_25_2:getCurBuyItemInfo()

	self._subComps.recruitTentBtn:_onDoingClick(var_25_3, {
		itemInfo = var_25_3,
		recruitType = self._recruitType,
		consumeType = var_25_1.requestType,
		num = self._multiNum,
		recruitId = self:_getRecruitNetId()
	}, 1, 0)
end

function RecruitLimitCompBase:_onRecruitTwentyBtnClick()
	local var_26_0, var_26_1 = self:_checkIsReachMaxTimes(20)

	if var_26_0 > 0 then
		if var_26_1 == nil then
			var_26_1 = g.core.lang:get(108413, {
				name = self._displayCfg.cfg.name,
				num = var_26_0
			})
		end

		g.core.module.ModuleManager:tip(var_26_1)

		return
	end

	if not self._ignoreFull and var_0_6:checkIsFull(self._recruitCfg) then
		local var_26_3 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_26_3,
			onConfirm = handler(self, self._doRecruitTwentyTimes),
			tip = {
				txt = g.core.lang:get(108045)
			},
			onCheck = function(arg_27_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_27_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitTwentyTimes()
	end
end

function RecruitLimitCompBase:_doRecruitTwentyTimes()
	local var_28_0, var_28_1 = var_0_6:getgenRecruitConsume(self._recruitCfg.twenty_summon_cost)
	local var_28_2 = g.core.model.User.recruitData:getBuyHelper()

	var_28_2:setRecruitType(self._recruitCfg.type)
	var_28_2:setRecruitId(self:_getRecruitNetId())
	var_28_2:setRecruitNum(20)

	local var_28_3 = var_28_2:getCurBuyItemInfo()

	self._subComps.recruitTwentyBtn:_onDoingClick(var_28_3, {
		num = 20,
		itemInfo = var_28_3,
		recruitType = self._recruitType,
		consumeType = var_28_1.requestType,
		recruitId = self:_getRecruitNetId()
	}, 1, 0)
end

function RecruitLimitCompBase:_reqRecruitNetWork(arg_29_1)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = arg_29_1.recruitId,
		consume_type = arg_29_1.consumeType,
		num = arg_29_1.num
	})
end

function RecruitLimitCompBase:_initKnightTipBtn()
	local var_30_0 = var_0_6:getDisplayInfoById(self._recruitCfg.id)
	local var_30_1 = table.nums(var_30_0.displays)

	for iter_30_0, iter_30_1 in ipairs(var_30_0.displays) do
		local var_30_2 = self._subComps["tipKnightBtn" .. iter_30_0]

		if not self._subComps["tipKnightBtn" .. iter_30_0] then
			break
		end

		var_30_2:updateComp(iter_30_1, var_30_1 == var_0_7.SHOW_SPINE_NUM, true, self._displayCfg.cfg, nil, self._recruitType)
	end
end

function RecruitLimitCompBase:onLoad()
	var_0_5:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, handler(self, self._resRecruit), self)
	var_0_5:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onRecruitGetTaskAward, self)
	var_0_5:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self.updateView), self)

	if self._subComps.recruitOneBtn then
		self._subComps.recruitOneBtn:setTouchable(true)
		self._subComps.recruitOneBtn:addAutoBuyCompListener()
	end

	self._subComps.recruitTentBtn:setTouchable(true)
	self._subComps.recruitTentBtn:addAutoBuyCompListener()

	if self._subComps.recruitTwentyBtn then
		self._subComps.recruitTwentyBtn:setTouchable(true)
		self._subComps.recruitTwentyBtn:addAutoBuyCompListener()
	end
end

function RecruitLimitCompBase:onUnload()
	self:_onStopTimeSchedule()
end

function RecruitLimitCompBase:_onStartTimeSchedule()
	if not self._timeSchedule and self._timeUpdateEnable then
		self._timeSchedule = self:newSchedule(handler(self, self._updateTime), 1)
	end
end

function RecruitLimitCompBase:_onStopTimeSchedule()
	self._timeSchedule = nil
end

function RecruitLimitCompBase:_resRecruit()
	if self._subComps.recruitTwentyBtn then
		if var_0_6:isOpenTwentyRecruit(self._cfg) then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(0)
		end
	end
end

function RecruitLimitCompBase:updateView()
	self:_updateLuck()
	self:_updateCost()
	self:_updateTalk()
	self:_updateTime()
end

function RecruitLimitCompBase:_updateLuck()
	local var_37_0 = var_0_6:getGuaranteedInfos(self._recruitType, true, true)

	if var_37_0 then
		if self._subComps.curLuckText then
			self._subComps.curLuckText:setText(var_37_0.totalTimes - var_37_0.times)
		end

		if self._subComps.maxLuckText then
			self._subComps.maxLuckText:setText("/" .. var_37_0.totalTimes)
		end

		if self._subComps.extLuckProg then
			self._subComps.extLuckProg:setSize(cc.size((var_37_0.totalTimes - var_37_0.times) / var_37_0.totalTimes * 192, 4))
		end

		if self._subComps.extLuckText then
			local var_37_1 = g.core.model.User.recruitData:getGuaranteedInfoByGuaranteedType(self._recruitType, 7) or {
				times = 0,
				totalTimes = 0
			}
			local var_37_2 = var_37_1.totalTimes - var_37_1.times

			self._subComps.extLuckText:setText(var_37_1.totalTimes - var_37_1.times)

			if var_37_2 > 0 then
				self._subComps.extLuckIcon:setURL("ui://recruit/btn_zm_baodi_" .. math.max(2, 6 - var_37_2))
			else
				self._subComps.extLuckIcon:setVisible(false)
			end
		end
	end
end

function RecruitLimitCompBase:_updateTime()
	local var_38_0, var_38_1, var_38_2, var_38_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getFinishTime()))
	local var_38_4 = var_38_0 > 0 and string.format(g.core.lang:get(108052), var_38_0, var_38_1, var_38_2, var_38_3) or var_38_1 > 0 and string.format(g.core.lang:get(108051), var_38_1, var_38_2, var_38_3) or var_38_2 > 0 and string.format(g.core.lang:get(108050), var_38_2, var_38_3) or string.format(g.core.lang:get(108049), var_38_3)

	self._subComps.timeTxt:setText(g.core.lang:get(108048, {
		timeTip = var_38_4
	}))

	if var_38_0 + var_38_1 + var_38_2 + var_38_3 <= 0 then
		self:dispatchCompEvent("limitTimeEnd")
	end
end

function RecruitLimitCompBase:_updateCost()
	if self._subComps.recruitOneBtn then
		local var_39_0, var_39_1 = var_0_6:getgenRecruitConsume(self._recruitCfg.single_summon_cost)

		self._subComps.recruitOneBtn:updateView({
			isCanRecruit = var_39_0,
			isFree = self:_getFreeTimes() > 0,
			goods = var_39_1
		})
		self._subComps.recruitOneBtn:setTouchable(true)
	end

	local var_39_2, var_39_3 = var_0_6:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)

	self._subComps.recruitTentBtn:updateView({
		isCanRecruit = var_39_2,
		goods = var_39_3
	})
	self._subComps.recruitTentBtn:setTouchable(true)

	if self._subComps.recruitTwentyBtn then
		local var_39_4, var_39_5 = var_0_6:getgenRecruitConsume(self._recruitCfg.twenty_summon_cost)

		self._subComps.recruitTwentyBtn:updateView({
			isCanRecruit = var_39_4,
			goods = var_39_5
		})
		self._subComps.recruitTwentyBtn:setTouchable(true)
	end
end

function RecruitLimitCompBase:_updateTalk()
	for iter_40_0 = 1, 2 do
		if self["m_talkText" .. iter_40_0] then
			self["m_talkText" .. iter_40_0]:setText(self._displayCfg.cfg["story_lang_" .. iter_40_0])
		end
	end
end

function RecruitLimitCompBase:getTitleTip()
	return ""
end

function RecruitLimitCompBase:playShow()
	self:setVisible(true)
	self:updateView()
	self:_onStartTimeSchedule()

	if self._translations.enter then
		self._translations.enter:play()
	end

	local var_42_0 = self:getChild("recruitTipText")

	if var_42_0 then
		var_42_0:setOpacity(0)
		var_42_0:stopAllFGActions()
		var_42_0:runFGAction(fgui.FFadeIn:create(0.5))
	end

	self:_playShowSound()
	self:_playShowEndLogic()
end

function RecruitLimitCompBase:_playShowEndLogic()
	return
end

function RecruitLimitCompBase:_playShowSound()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_HIGH_UI_SHOW)
end

function RecruitLimitCompBase:playHide(arg_45_1)
	if self._translations.back then
		self._translations.back:play(arg_45_1)
	else
		arg_45_1()
	end
end

function RecruitLimitCompBase:updateByCfg(arg_46_1)
	self._tabType = arg_46_1.ownerType
end

function RecruitLimitCompBase:_getRecruitNetId()
	local var_47_0 = self._recruitCfg.id

	if self._actData then
		var_47_0 = self._actData:getActivityId()

		if not self._actData:getInfo().sub_activity_id then
			var_47_0 = self._actData:getActivityValue()
		end
	end

	return var_47_0
end

function RecruitLimitCompBase:onContinueRecruit(arg_48_1)
	self._ignoreFull = true

	if self._continueRecruit then
		self:_continueRecruit(arg_48_1)

		self._ignoreFull = false

		return
	end

	if arg_48_1 == 1 then
		self:_onRecruitOneBtnClick()
	elseif arg_48_1 == 10 then
		self:_onRecruitTenBtnClick()
	end

	self._ignoreFull = false
end

function RecruitLimitCompBase:_checkWishHaveSet()
	return true
end

function RecruitLimitCompBase:_showOtherPop()
	return
end

return RecruitLimitCompBase
