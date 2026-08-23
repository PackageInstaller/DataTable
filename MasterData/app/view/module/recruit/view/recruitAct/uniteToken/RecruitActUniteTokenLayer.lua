local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local var_0_1 = g.core.const.ConstMgr.RecruitConst
local var_0_2 = g.core.model.User.recruitData
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")
local RecruitActUniteTokenLayer = class("RecruitActUniteTokenLayer", require("app.fairyGUI.recruitActUniteToken.UI_RecruitActUniteTokenLayer"), function()
	return fgui.GComponent:create({
		resName = "RecruitActUniteTokenLayer",
		pkgPath = "ui/recruitActUniteToken/recruitActUniteToken",
		isFullScreen = true,
		pkgName = "recruitActUniteToken"
	}, ...)
end)

function RecruitActUniteTokenLayer:ctor(arg_2_1)
	local var_2_0 = arg_2_1.route3
	local var_2_1

	if not arg_2_1.route3 or var_2_0 == 0 then
		local var_2_2, var_2_3 = g.core.model.User.cultivateDataMgr:getOpenCultivateDataAndId(2)

		self._cultivateId = var_2_3
		var_2_1 = g.core.config.cultivate_activity_info.get(self._cultivateId)
		var_2_0 = g.core.config.source_route_info.get(var_2_1.recruit_route).route_value_3
	else
		self._cultivateId = arg_2_1.route1
		var_2_1 = g.core.config.cultivate_activity_info.get(self._cultivateId)
	end

	self:_initView(var_2_1)
	self.m_topBarComp:setResInfoById(g.core.config.cultivate_activity_display_info.get(var_2_1.id).interface_recruit)

	self._actData = var_0_2:getActDataListByRecruitId(var_2_0)[1]

	local var_2_4 = self._actData:getActivityId()

	if not self._actData:getInfo().sub_activity_id then
		self._actId = self._actData:getActivityValue()
	end

	self._recruitCfg = g.core.config.recruit_knight_info.get(var_2_0)

	local var_2_5 = g.core.config.recruit_knight_cost_gain_info.get((g.core.model.User.recruitData:getCostInfoId(self._recruitCfg.type, 1)))
	local var_2_6 = g.core.common.Goods:convert({
		value = var_2_5.gain_value,
		type = var_2_5.gain_type,
		size = var_2_5.gain_size
	})

	self.m_gainTipText:setText(g.core.lang:get(108494, {
		num = var_2_6.size,
		name = var_2_6.name
	}))

	self._displayCfg = var_0_2:getDisplayInfoById(var_2_0)
	self._drawInfo = g.core.model.User.recruitData:getDrawInfo(var_2_0)
	self._isShowReward = false

	self:_addListeners()

	self._autoBuyList = {}

	self:_initKnightTipBtn()
	self.m_enterTransition:play()
end

function RecruitActUniteTokenLayer:_initView(arg_3_1)
	local var_3_0 = g.core.model.User.cultivateDataMgr:getResDirId(arg_3_1.id)

	self:addBg(table.concat({
		"bg/cultivate/",
		var_3_0,
		"/bg_zm.jpg"
	}), nil, 1)
	self.m_titleLoader:setURL(g.core.common.Path:getCultivateCardMulLangImage("txt_zm_title", var_3_0))
	self.m_rightTipLoader:setURL(g.core.common.Path:getCultivateCardMulLangImage("txt_zm_tishi", var_3_0))
	self.m_rightArrow:setURL(g.core.common.Path:getCultivateCardImage("pic_gw1_libaozs", var_3_0))
	self.m_luckBtn:setIcon(g.core.common.Path:getCultivateCardImage("pic_gw1_xingyunzhi", var_3_0))
	self.m_shopBtn:setIcon(g.core.common.Path:getCultivateCardImage("pic_gw1_libao", var_3_0))
	self.m_shopBtn:getChild("nameBgLoader"):setURL(g.core.common.Path:getCultivateCardImage("pic_gw1_libaodi", var_3_0))
	self:_initBuyComp()
end

function RecruitActUniteTokenLayer:_initBuyComp()
	local var_4_0 = g.core.model.User.recruitData:getBuyHelper()

	AutoBuyComp.setDefaultConfirmTxtInfo(var_4_0:getTextInfo())
	AutoBuyComp.setDefaultHandler("checkFlagHandler", handler(var_4_0, var_4_0._checkTipPop))
	AutoBuyComp.setDefaultHandler("setFlagHandler", handler(var_4_0, var_4_0._setCheckTipFlag))
	AutoBuyComp.setDefaultHandler("checkExFlagHandler", handler(g.core.model.User.recruitData, g.core.model.User.recruitData.getRecruitAutoChangeTipFlag))
	AutoBuyComp.setDefaultHandler("setExFlagHandler", handler(var_4_0, var_4_0._setCheckTipFlagEx))
	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	self.m_recruitOneBtn:setAutoExchangeEnable(false)
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	self.m_recruitTenBtn:setAutoExchangeEnable(false)
	AutoBuyComp.bindComp(self.m_recruitTwentyBtn)
	self.m_recruitTwentyBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	self.m_recruitTwentyBtn:setAutoExchangeEnable(false)
end

function RecruitActUniteTokenLayer:_addListeners()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
	self.m_recruitTwentyBtn:addClickListener(handler(self, self._onRecruitTwentyBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_luckBtn:addClickListener(handler(self, self._onClickedLuck))
end

function RecruitActUniteTokenLayer:_initKnightTipBtn()
	local var_6_0 = var_0_2:getDisplayInfoById(self._recruitCfg.id)
	local var_6_1 = table.nums(var_6_0.displays)

	for iter_6_0, iter_6_1 in ipairs(var_6_0.displays) do
		if not self["m_uniteTokenBtn" .. iter_6_0] then
			break
		end

		self["m_uniteTokenBtn" .. iter_6_0]:updateBtnView(iter_6_1, nil, true)
		self["m_uniteTokenIcon" .. iter_6_0]:setURL((g.core.common.Path:getPicRes(g.core.common.Goods.TYPE_UNITETOKEN, iter_6_1.knight_id)))
	end
end

function RecruitActUniteTokenLayer:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO, self._updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._doRecruit, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD, self._checkShopBtnRedPoint, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECRUIT_REWARD_REMOVED, handler(self, self._onRewardLayerOnRemoved), self)
end

function RecruitActUniteTokenLayer:onLoad()
	self:_addCustomListener()
	self:_isRequestNetWork()
	self:_checkShopBtnRedPoint()
	self.m_recruitOneBtn:addAutoBuyCompListener()
	self.m_recruitTwentyBtn:addAutoBuyCompListener()
	self.m_recruitTenBtn:addAutoBuyCompListener()
end

function RecruitActUniteTokenLayer:onUnload()
	self:_onStopTimeSchedule()
end

function RecruitActUniteTokenLayer:_checkShopBtnRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_shopBtn:getChild("redPointComp"),
		customData = {
			actValue = self._cultivateId
		}
	})
end

function RecruitActUniteTokenLayer:_updateView()
	self:_checkTwentyBtnState()
	self:_updateLuck()
	self:_updateCost()
	self:_updateTime()
end

function RecruitActUniteTokenLayer:_updateLuck()
	local var_12_0 = var_0_2:getGuaranteedInfos(self._recruitCfg.type, true, true, self._recruitCfg.id)

	if var_12_0 then
		self.m_luckText:setText(var_12_0.totalTimes - var_12_0.times)
	else
		self.m_luckText:setText(0)
	end
end

function RecruitActUniteTokenLayer:_updateTime()
	local var_13_0, var_13_1, var_13_2, var_13_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getFinishTime()))
	local var_13_4 = var_13_0 > 0 and string.format(g.core.lang:get(108052), var_13_0, var_13_1, var_13_2, var_13_3) or var_13_1 > 0 and string.format(g.core.lang:get(108051), var_13_1, var_13_2, var_13_3) or var_13_2 > 0 and string.format(g.core.lang:get(108050), var_13_2, var_13_3) or string.format(g.core.lang:get(108049), var_13_3)

	self.m_timeTxt:setText(g.core.lang:get(108048, {
		timeTip = var_13_4
	}))

	if var_13_0 + var_13_1 + var_13_2 + var_13_3 <= 0 then
		self:_onStopTimeSchedule()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function RecruitActUniteTokenLayer:_updateCost()
	local var_14_0, var_14_1 = var_0_2:getgenRecruitConsume(self._recruitCfg.single_summon_cost)

	self.m_recruitOneBtn:updateView({
		isCanRecruit = var_14_0,
		isFree = self:_getFreeTimes() > 0,
		goods = var_14_1
	})

	local var_14_2, var_14_3 = var_0_2:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_14_2,
		goods = var_14_3
	})

	local var_14_4, var_14_5 = var_0_2:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_14_4,
		goods = var_14_5
	})

	local var_14_6, var_14_7 = var_0_2:getgenRecruitConsume(self._recruitCfg.twenty_summon_cost)

	self.m_recruitTwentyBtn:updateView({
		isCanRecruit = var_14_6,
		goods = var_14_7
	})
end

function RecruitActUniteTokenLayer:_onStartTimeSchedule()
	self._timeSchedule = self._timeSchedule or self:newSchedule(handler(self, self._updateTime), 1)
end

function RecruitActUniteTokenLayer:_onStopTimeSchedule()
	self._timeSchedule = nil
end

function RecruitActUniteTokenLayer:receiveCompEvent(arg_17_1, arg_17_2)
	if arg_17_1 == "shopBuySucceed" then
		self:newScheduleOnce(handler(self, function(arg_18_0)
			arg_18_0:_doBuyItemAndRecruit(arg_17_2.type, arg_17_2.num, arg_17_2.itemInfo, arg_17_2.id)
		end), 0.3)

		return true
	elseif arg_17_1 == "update_topBar_res" then
		self.m_topBarComp:updateResource(true)

		return true
	end
end

function RecruitActUniteTokenLayer:_checkTwentyBtnState()
	if var_0_2:isOpenTwentyRecruit(self._recruitCfg) then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function RecruitActUniteTokenLayer:onClickBackBtn()
	self.m_backTransition:play(handler(self, self._onCloseSelf))
end

function RecruitActUniteTokenLayer:_onCloseSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RecruitActUniteTokenLayer:_isRequestNetWork()
	if not g.core.model.User.recruitData:hasData() then
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
	elseif g.core.model.User.recruitData:isExpired() then
		g.core.model.User.recruitData:resetExpired()
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
	else
		self:_updateView()
	end

	self:_onStartTimeSchedule()
end

function RecruitActUniteTokenLayer:_reqRecruitNetWork(arg_23_1)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self._actId,
		consume_type = arg_23_1.consumeType,
		num = arg_23_1.num
	})
end

function RecruitActUniteTokenLayer:_doRecruit(arg_24_1, arg_24_2, arg_24_3)
	if self._actionsParams then
		return
	end

	if arg_24_3.awards == nil then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))

		return
	end

	local var_24_0 = g.core.model.User.recruitData:getBuyHelper()

	if arg_24_3.recruitTypeNet then
		var_24_0:setRecruitType(g.core.model.User.recruitData:getRecruitCfgByIdOrActId(arg_24_3.recruitTypeNet).type)
		var_24_0:setRecruitId(arg_24_3.recruitTypeNet)
		var_24_0:setRecruitNum(#arg_24_3.awards)
	else
		var_24_0:setRecruitType(nil)
		var_24_0:setRecruitId(nil)
		var_24_0:setRecruitNum(0)
	end

	if self._isShowReward then
		self:_updateView()

		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_WAIT)
	self.m_topBarComp:playHideAction()
	self:_onUniteTokenRecruitResult(arg_24_3)
	self.m_topBarComp:playShowAction()
end

function RecruitActUniteTokenLayer:_onUniteTokenRecruitResult(arg_25_1)
	arg_25_1.cfg = self._recruitCfg

	g.core.module.ModuleManager:pushPopup(require("app.view.module.recruit.view.recruitAct.uniteToken.RecruitActUniteTokenShowPop").new(arg_25_1))
	self:_updateView()
end

function RecruitActUniteTokenLayer:_checkIsReachMaxTimes(arg_26_1)
	local var_26_0 = var_0_2:getDrawInfo(self._recruitCfg.id)

	if not var_26_0 then
		return 0
	end

	local var_26_1 = var_26_0:getDailyLimitNum()

	return (var_26_1 < var_26_0:getDailyCount() + arg_26_1 or nil) and var_26_1
end

function RecruitActUniteTokenLayer:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._recruitCfg.id,
		type = self._recruitCfg.type,
		tabType = var_0_1.RECRUIT_TAB_TYPE.UNITE_TAB,
		title = g.core.lang:get(108106)
	}), {
		touchDisappear = true
	})
end

function RecruitActUniteTokenLayer:_onRecruitOneBtnClick()
	local var_28_0, var_28_1 = self:_checkIsReachMaxTimes(1)

	if var_28_0 > 0 then
		var_28_1 = var_28_1 or g.core.lang:get(108413, {
			name = self._displayCfg.cfg.name,
			num = var_28_0
		})

		g.core.module.ModuleManager:tip(var_28_1)

		return
	end

	if var_0_2:checkIsFull(self._recruitCfg) then
		local var_28_3 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_28_3,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitOneTimes),
			onCheck = function(arg_29_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_29_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitOneTimes()
	end
end

function RecruitActUniteTokenLayer:_doRecruitOneTimes()
	local var_30_0, var_30_1 = var_0_2:getgenRecruitConsume(self._recruitCfg.single_summon_cost)
	local var_30_2 = g.core.model.User.recruitData:getBuyHelper()

	var_30_2:setRecruitType(self._recruitCfg.type)
	var_30_2:setRecruitId(self._recruitCfg.id)
	var_30_2:setRecruitNum(1)

	local var_30_3 = var_30_2:getCurBuyItemInfo()
	local var_30_4 = {
		itemInfo = var_30_3,
		recruitType = self._recruitCfg.type,
		consumeType = var_30_1.requestType,
		num = 1
	}

	if 1 <= self:_getFreeTimes() then
		var_30_4.consumeType = 0
		var_30_4.itemInfo = nil
		var_30_3 = nil
	end

	self.m_recruitOneBtn:_onDoingClick(var_30_3, var_30_4, 1, 0)
end

function RecruitActUniteTokenLayer:_getFreeTimes()
	return 0
end

function RecruitActUniteTokenLayer:_onRecruitTenBtnClick()
	local var_32_0, var_32_1 = self:_checkIsReachMaxTimes(5)

	if var_32_0 > 0 then
		var_32_1 = var_32_1 or g.core.lang:get(108413, {
			name = self._displayCfg.cfg.name,
			num = var_32_0
		})

		g.core.module.ModuleManager:tip(var_32_1)

		return
	end

	if var_0_2:checkIsFull(self._recruitCfg) then
		local var_32_3 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_32_3,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitTenTimes),
			onCheck = function(arg_33_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_33_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitTenTimes()
	end
end

function RecruitActUniteTokenLayer:_doRecruitTenTimes()
	local var_34_0, var_34_1 = var_0_2:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)
	local var_34_2 = g.core.model.User.recruitData:getBuyHelper()

	var_34_2:setRecruitNum(5)
	var_34_2:setRecruitType(self._recruitCfg.type)
	var_34_2:setRecruitId(self._recruitCfg.id)

	local var_34_3 = var_34_2:getCurBuyItemInfo()
	local var_34_4 = {
		itemInfo = var_34_3,
		recruitType = self._recruitCfg.type,
		consumeType = var_34_1.requestType,
		num = 5
	}

	if 5 <= self:_getFreeTimes() then
		var_34_4.consumeType = 0
		var_34_4.itemInfo = nil
		var_34_3 = nil
	end

	self.m_recruitTenBtn:_onDoingClick(var_34_3, var_34_4, 1, 0)
end

function RecruitActUniteTokenLayer:_onRecruitTwentyBtnClick()
	local var_35_0, var_35_1 = self:_checkIsReachMaxTimes(20)

	if var_35_0 > 0 then
		if var_35_1 == nil then
			var_35_1 = g.core.lang:get(108413, {
				name = self._displayCfg.cfg.name,
				num = var_35_0
			})
		end

		g.core.module.ModuleManager:tip(var_35_1)

		return
	end

	if var_0_2:checkIsFull(self._recruitCfg) then
		local var_35_3 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_35_3,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitTwentyTimes),
			onCheck = function(arg_36_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_36_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitTwentyTimes()
	end
end

function RecruitActUniteTokenLayer:_doRecruitTwentyTimes()
	local var_37_0, var_37_1 = var_0_2:getgenRecruitConsume(self._recruitCfg.twenty_summon_cost)
	local var_37_2 = g.core.model.User.recruitData:getBuyHelper()

	var_37_2:setRecruitNum(20)
	var_37_2:setRecruitType(self._recruitCfg.type)
	var_37_2:setRecruitId(self._recruitCfg.id)

	local var_37_3 = var_37_2:getCurBuyItemInfo()
	local var_37_4 = {
		itemInfo = var_37_3,
		recruitType = self._recruitCfg.type,
		consumeType = var_37_1.requestType,
		num = 20
	}

	if 20 <= self:_getFreeTimes() then
		var_37_4.consumeType = 0
		var_37_4.itemInfo = nil
		var_37_3 = nil
	end

	self.m_recruitTenBtn:_onDoingClick(var_37_3, var_37_4, 1, 0)
end

function RecruitActUniteTokenLayer:_onShopBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.ShopCultivatePop.ShopCultivateGiftPop").new(self._cultivateId)))
end

function RecruitActUniteTokenLayer:_onClickedLuck()
	local var_39_0 = require("app.view.base.component.HelpPop").new
	local var_39_1 = {}

	var_39_1.id = 410

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new(var_39_1), {
		touchDisappear = true
	})
end

function RecruitActUniteTokenLayer:receiveCompEvent(arg_40_1, arg_40_2)
	if arg_40_1 == "doRecruitContinue" then
		self._isShowReward = true

		if arg_40_2.num == 1 then
			self:_onRecruitOneBtnClick()
		elseif arg_40_2.num == 5 then
			self:_onRecruitTenBtnClick()
		elseif arg_40_2.num == 20 then
			self:_onRecruitTwentyBtnClick()
		end
	end
end

function RecruitActUniteTokenLayer:_onRewardLayerOnRemoved()
	self.m_topBarComp:playShowAction()

	self._isShowReward = false
end

return RecruitActUniteTokenLayer
