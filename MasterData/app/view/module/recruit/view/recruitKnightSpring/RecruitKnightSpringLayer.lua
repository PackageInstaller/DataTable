local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local var_0_1 = g.core.const.ConstMgr.RecruitConst
local var_0_2 = g.core.service.ServiceManager:getServiceByName("BioTeamInviteFloatService")
local var_0_3 = g.core.const.ConstMgr.QUALITY_TYPE
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")
local RecruitKnightSpringLayer = class("RecruitKnightSpringLayer", require("app.fairyGUI.recruitKnightSpring.UI_RecruitKnightSpringLayer"), function()
	return fgui.GComponent:create({
		resName = "RecruitKnightSpringLayer",
		pkgPath = "ui/recruitKnightSpring/recruitKnightSpring",
		isFullScreen = true,
		pkgName = "recruitKnightSpring"
	}, ...)
end)
local var_0_6 = g.core.event.EventManager
local var_0_7 = g.core.common.Goods
local RecruitFuncCfg = require("app.view.module.recruit.const.RecruitFuncCfg")
local var_0_9 = g.core.const.ConstMgr.SpineConst
local var_0_10 = g.core.const.ConstMgr.SoundConst

function RecruitKnightSpringLayer:ctor(arg_2_1)
	self:_initData()

	self._isShowReward = false
	self._wishInfos = {}
	self._effLoop = nil
	self._autoBuyList = {}
	self._animWaitCount = 0

	self:_initLayer()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.2)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_RECRUIT_SPRING)
end

function RecruitKnightSpringLayer:_initData()
	self._actData = g.core.model.User.recruitData:getSpringRecruitData()

	local var_4_0 = self._actData:getActivityId()

	if not self._actData:getInfo().sub_activity_id then
		self._actId = self._actData:getActivityValue()
	end

	local var_4_1 = self._actData:getInfo().sub_activity_id or self._actData:getActivityValue()

	self._id = var_4_1
	self._recruitCfg = g.core.model.User.recruitData:getRecruitKnightCfgById(var_4_1)
	self._recruitType = self._recruitCfg.type
	self._displayCfg = g.core.model.User.recruitData:getDisplayInfoById(var_4_1)
	self._typeIdx = g.core.const.ConstMgr.RecruitConst.RECRUIT_LIMIT_INDEX[var_4_1].ctrlIdx or 0

	self.m_typeController:setSelectedIndex(self._typeIdx)
end

function RecruitKnightSpringLayer:_initLayer()
	self:addBg("bg/recruit/" .. self._displayCfg.cfg.bg, true, nil, 1)
	self:updateTopRes()
	self.m_luckBtn:addClickListener(handler(self, self._onClickedLuck))
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
	self.m_giftBtn:addClickListener(handler(self, self._onClickGiftBtn))

	self._recruitTipTxt = require("app.view.module.recruit.const.RecruitFuncCfg").addBtnTip(self, var_0_1.RECRUIT_TAB_TYPE.KNIGHT_TAB)

	self.m_raioText:setText(self._displayCfg.cfg.param_1)
	self:_initKnightTipBtn()
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._renderAwardItem))
	self.m_awardList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onAwardListClickItem))
	self.m_awardList:doFairyBatching(false)
	self.m_ssrComp:setRewardEntrance(g.view.entrance.RECRUIT_REWARD_SPRING)
	self:_initBuyComp()
	g.core.resource.ResourceManager:addSpineCache(var_0_9.TYPE.RES_EFFECT, var_0_9.RECRUIT_RES_EFFECT_CACHE)
end

function RecruitKnightSpringLayer:_initBuyComp()
	local var_6_0 = g.core.model.User.recruitData:getBuyHelper()

	AutoBuyComp.setDefaultConfirmTxtInfo(var_6_0:getTextInfo())
	AutoBuyComp.setDefaultHandler("checkFlagHandler", handler(var_6_0, var_6_0._checkTipPop))
	AutoBuyComp.setDefaultHandler("setFlagHandler", handler(var_6_0, var_6_0._setCheckTipFlag))
	AutoBuyComp.setDefaultHandler("checkExFlagHandler", handler(g.core.model.User.recruitData, g.core.model.User.recruitData.getRecruitAutoChangeTipFlag))
	AutoBuyComp.setDefaultHandler("setExFlagHandler", handler(var_6_0, var_6_0._setCheckTipFlagEx))
	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	self.m_recruitOneBtn:setAutoExchangeEnable(false)
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	self.m_recruitTenBtn:setAutoExchangeEnable(false)
end

function RecruitKnightSpringLayer:_renderAwardItem(arg_7_1, arg_7_2)
	local var_7_0 = g.core.model.User.recruitData:getDrawInfo(self._actId):getProgressAwardList()

	arg_7_2:updateItem(var_7_0[arg_7_1 + 1], var_7_0[arg_7_1 + 1 - 1], var_7_0[arg_7_1 + 1 + 1])
end

function RecruitKnightSpringLayer:_onAwardListClickItem(arg_8_1)
	local var_8_0 = g.core.model.User.recruitData:getDrawInfo(self._actId):getProgressAwardList()[arg_8_1:getDataValue() + 1]

	if var_8_0.state ~= "got" and var_8_0.state ~= "none" then
		g.core.network.GameNetProxy:send_C2S_NewRecruit_ProgressAward({
			recruit_id = self._actId,
			award_id = var_8_0.cfg.id
		})
	else
		g.core.common.GlobalFunc.pushInfoPop(var_8_0.awards[1])
	end
end

function RecruitKnightSpringLayer:_initKnightTipBtn()
	local var_9_0 = g.core.model.User.recruitData:getDisplayInfoById(self._recruitCfg.id)
	local var_9_1 = table.nums(var_9_0.displays)

	for iter_9_0, iter_9_1 in ipairs(var_9_0.displays) do
		local var_9_2 = self["m_tipKnightBtn" .. iter_9_0]

		if not self["m_tipKnightBtn" .. iter_9_0] then
			break
		end

		var_9_2:updateComp(iter_9_1, var_9_1 == var_0_1.SHOW_SPINE_NUM, true, self._displayCfg.cfg, "recruitKnightSpring")
	end
end

function RecruitKnightSpringLayer:_onClickGiftBtn()
	g.core.model.User.giftData:refreshInTime()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.ShopActivityGiftPop").new({
		activityValue = self._recruitCfg.id,
		shopValue = g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.RECRUIT_SPRING,
		openCheckFunc = handler(self, handler(self, self.checkRecruitTime)),
		title = self.m_giftBtn:getTitle()
	})))
end

function RecruitKnightSpringLayer:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._recruitCfg.id,
		type = var_0_1.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING,
		tabType = self._tabType,
		actId = self._actId
	}), {
		touchDisappear = true
	})
end

function RecruitKnightSpringLayer:_onStartTimeSchedule()
	self._timeSchedule = self._timeSchedule or self:newSchedule(handler(self, self._updateTime), 1)
end

function RecruitKnightSpringLayer:_onStopTimeSchedule()
	self._timeSchedule = nil
end

function RecruitKnightSpringLayer:_onRecruitOneBtnClick()
	if not next(self._wishInfos) or self._wishInfos[1].r_type == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108702))

		return
	end

	local var_14_0 = g.core.model.User.recruitData:getDrawInfo(self._actId)
	local var_14_1 = var_14_0:getDailyLimitNum()

	if var_14_1 - var_14_0:getDailyCount() < 1 then
		g.core.module.ModuleManager:tip((g.core.lang:get(108413, {
			name = self._displayCfg.cfg.name,
			num = var_14_1
		})))

		return
	end

	if not self._ignoreFull and g.core.model.User.recruitData:checkIsFull(self._recruitCfg) then
		local var_14_3 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_14_3,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitOneTimes),
			onCheck = function(arg_15_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_15_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitOneTimes()
	end
end

function RecruitKnightSpringLayer:_doRecruitOneTimes()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	local var_16_0, var_16_1 = g.core.model.User.recruitData:getgenRecruitConsume(self._recruitCfg.single_summon_cost)
	local var_16_2 = g.core.model.User.recruitData:getBuyHelper()

	var_16_2:setRecruitType(self._recruitCfg.type)
	var_16_2:setRecruitId(self._actId)
	var_16_2:setRecruitNum(1)

	local var_16_3 = var_16_2:getCurBuyItemInfo(self._recruitCfg.id)
	local var_16_4 = {
		num = 1,
		itemInfo = var_16_3,
		recruitType = self._recruitCfg.type,
		consumeType = var_16_1.requestType
	}

	if self:_isFree() then
		var_16_4.consumeType = 0
		var_16_4.itemInfo = nil
		var_16_3 = nil
	end

	self.m_recruitOneBtn:_onDoingClick(var_16_3, var_16_4, 1, 0)
end

function RecruitKnightSpringLayer:_onRecruitTenBtnClick()
	if not next(self._wishInfos) or self._wishInfos[1].r_type == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108702))

		return
	end

	local var_17_0 = g.core.model.User.recruitData:getDrawInfo(self._actId)
	local var_17_1 = var_17_0:getDailyLimitNum()

	if var_17_1 - var_17_0:getDailyCount() < 10 then
		g.core.module.ModuleManager:tip((g.core.lang:get(108413, {
			name = self._displayCfg.cfg.name,
			num = var_17_1
		})))

		return
	end

	if not self._ignoreFull and g.core.model.User.recruitData:checkIsFull(self._recruitCfg) then
		local var_17_3 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_17_3,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doRecruitTenTimes),
			onCheck = function(arg_18_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_18_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doRecruitTenTimes()
	end
end

function RecruitKnightSpringLayer:_doRecruitTenTimes()
	local var_19_0, var_19_1 = g.core.model.User.recruitData:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)
	local var_19_2 = g.core.model.User.recruitData:getBuyHelper()

	var_19_2:setRecruitNum(10)
	var_19_2:setRecruitType(self._recruitCfg.type)
	var_19_2:setRecruitId(self._actId)

	local var_19_3 = var_19_2:getCurBuyItemInfo(self._recruitCfg.id)

	self.m_recruitTenBtn:_onDoingClick(var_19_3, {
		itemInfo = var_19_3,
		recruitType = self._recruitCfg.type,
		consumeType = var_19_1.requestType,
		num = 10
	}, 1, 0)
end

function RecruitKnightSpringLayer:_reqRecruitNetWork(arg_20_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self._actId,
		consume_type = arg_20_1.consumeType,
		num = arg_20_1.num
	})
end

function RecruitKnightSpringLayer:_refreshUI()
	if not self:checkRecruitTime() then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	self:_updateView()
end

function RecruitKnightSpringLayer:_updateView()
	self._wishInfos = g.core.model.User.recruitData:getWishInfo(self._recruitType, self._actId) or {}

	self.m_wishComp:updateComp(self._wishInfos, self._recruitType)
	self:_updateLuck()
	self:_updateCost()
	self:_updateTime()
	self:_updateBoxAwardList()
end

function RecruitKnightSpringLayer:_updateTime()
	local var_23_0, var_23_1, var_23_2, var_23_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getFinishTime()))
	local var_23_4 = var_23_0 > 0 and string.format(g.core.lang:get(108052), var_23_0, var_23_1, var_23_2, var_23_3) or var_23_1 > 0 and string.format(g.core.lang:get(108051), var_23_1, var_23_2, var_23_3) or var_23_2 > 0 and string.format(g.core.lang:get(108050), var_23_2, var_23_3) or string.format(g.core.lang:get(108049), var_23_3)

	self.m_timeTxt:setText(g.core.lang:get(108048, {
		timeTip = var_23_4
	}))

	if var_23_0 + var_23_1 + var_23_2 + var_23_3 <= 0 then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function RecruitKnightSpringLayer:_updateCost()
	local var_24_0, var_24_1 = g.core.model.User.recruitData:getgenRecruitConsume(self._recruitCfg.single_summon_cost)

	self.m_recruitOneBtn:updateView({
		isCanRecruit = var_24_0,
		isFree = self:_isFree(),
		goods = var_24_1
	})

	local var_24_2, var_24_3 = g.core.model.User.recruitData:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_24_2,
		goods = var_24_3
	})
end

function RecruitKnightSpringLayer:_updateLuck()
	local var_25_0 = g.core.model.User.recruitData:getGuaranteedInfos(var_0_1.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING, false, nil, self._recruitCfg.id)

	if var_25_0 then
		self.m_curLuckText:setText(var_25_0.totalTimes - var_25_0.times)
		self.m_maxLuckText:setText("/" .. var_25_0.totalTimes)
		self.m_prog:setSize(cc.size((var_25_0.totalTimes - var_25_0.times) / var_25_0.totalTimes * 192, 4))
	end

	local var_25_1 = g.core.model.User.recruitData:getDrawInfo(self._actId, nil, true)
	local var_25_2 = g.core.model.User.recruitData:getWishInfos(var_25_1, self._recruitCfg.id).curTimes

	self.m_drawTimeText:setText(var_25_1:getDailyLimitNum() - var_25_1:getDailyCount())
	self.m_extLuckText:setText(var_25_2)

	if self.m_effLoop then
		self.m_effLoop:setVisible(var_25_2 > 0)

		self._effLoop = self._effLoop or self.m_effLoop:addEffectSpine({
			isLoop = true,
			name = "eff_ui_recruitKnightSpring_guarantee"
		})
	end
end

function RecruitKnightSpringLayer:updateAwardList()
	return
end

function RecruitKnightSpringLayer:checkRecruitTime()
	return self._actData:getFinishTime() > g.core.common.ServerTime:getTime()
end

function RecruitKnightSpringLayer:_checkOpenRecruit()
	if not self:checkRecruitTime() then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function RecruitKnightSpringLayer:_isFree()
	local var_29_0 = g.core.config.recruit_knight_cost_gain_info.get(var_0_1.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING)

	if var_29_0.daily_free_times - g.core.model.User.recruitData:getAdvanceFreeNum() > 0 and var_29_0.daily_free_interval <= g.core.common.ServerTime:getTime() - g.core.model.User.recruitData:getAdvanceFreeTime() then
		return true
	end

	return false
end

function RecruitKnightSpringLayer:_getMovieList()
	local var_30_0 = {}

	if (self._content.recruit_type == var_0_1.RECRUIT_TYPE.Base and "daily" or "night") == "night" then
		if self._actionsParams.numStr == "Ten" then
			local var_30_2 = {
				sound = var_0_10.Sound.RECRUIT_RAINY
			}

			var_30_2.moduleName = "recruit"
			var_30_2.movieName = "nightRecruitEnter_1334x870_2300"
			var_30_2.id = "enter"
			var_30_2.canJump = true
			var_30_2.fullScreenState = 2

			table.insert(var_30_0, var_30_2)

			local var_30_3 = {}

			var_30_3.moduleName = "recruit"
			var_30_3.movieName = "nightPush_1334x870_834"
			var_30_3.id = "push"
			var_30_3.canJump = true
			var_30_3.fullScreenState = 2

			table.insert(var_30_0, var_30_3)
		else
			local var_30_4 = {
				sound = var_0_10.Sound.RECRUIT_SUNNY
			}

			var_30_4.moduleName = "recruit"
			var_30_4.movieName = "dailyRecruitEnter_1334x870_2300"
			var_30_4.id = "enter"
			var_30_4.canJump = true
			var_30_4.fullScreenState = 2

			table.insert(var_30_0, var_30_4)

			local var_30_5 = {}

			var_30_5.moduleName = "recruit"
			var_30_5.movieName = "dailyPush_1334x870_834"
			var_30_5.id = "push"
			var_30_5.canJump = true
			var_30_5.fullScreenState = 2

			table.insert(var_30_0, var_30_5)
		end
	end

	local var_30_6 = "Blue"
	local var_30_7 = var_0_10.Sound.RECRUIT_TUIJING_BLUE

	if self._highQuality == var_0_3.SR then
		var_30_6 = "Violet"
		var_30_7 = var_0_10.Sound.RECRUIT_TUIJING_PURPLE
	elseif self._highQuality == var_0_3.SSR then
		var_30_6 = "Golden"
		var_30_7 = var_0_10.Sound.RECRUIT_TUIJING_ORANGE
	elseif self._highQuality == var_0_3.UR then
		var_30_6 = "Phantomcolor"
	end

	local var_30_8 = {
		sound = var_30_7
	}

	var_30_8.moduleName = "recruit"
	var_30_8.movieName = "recruit" .. self._actionsParams.numStr .. var_30_6 .. self._actionsParams.sizeStrs[self._highQuality]
	var_30_8.id = "show"
	var_30_8.canJump = true
	var_30_8.autoRemove = false
	var_30_8.fullScreenState = 2
	var_30_8.events = {
		shadowShow = {
			handler = handler(self, self._onShowShadow)
		},
		playEffect = {
			handler = handler(self, self._onPlayPassEffect)
		}
	}

	table.insert(var_30_0, var_30_8)

	return var_30_0
end

function RecruitKnightSpringLayer:_onUserClick(arg_31_1)
	if not arg_31_1 then
		return
	end

	if arg_31_1[1].id == "loop" then
		self.m_moveComp:jump()
	end
end

function RecruitKnightSpringLayer:_addCustomListener()
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO, self._updateView, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._doRecruit, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_NOVICETENRECRUIT, self._doRecruit, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACTIVITY_COMMON_GETINFOSERVER, self._refreshUI, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_UPDATEINFO, self._refreshUI, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_CUSTOM_ACTIVITY_START_PREVIEW, self._refreshUI, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_QUARTER_MINUTE_NOTIFY, handler(self, self._checkOpenRecruit), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS, handler(self, self._updateCost), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self._updateView), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_PROGRESSAWARD, handler(self, self._onRecruitGetBoxAward), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_RECRUIT_REWARD_REMOVED, handler(self, self._onRewardLayerOnRemoved), self)
end

function RecruitKnightSpringLayer:onLoad()
	self:_updateRedPoint()

	if var_0_2 and var_0_2.judgeIsRefuseBioInviteIfEnterModule then
		var_0_2:judgeIsRefuseBioInviteIfEnterModule()
	end

	self:_addCustomListener()

	if not self:checkRecruitTime() then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	self:_isRequestNetWork()
	self:_onStartTimeSchedule()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	self.m_enterTransition:play()

	self._awardEffect = self.m_effBg:addEffectSpine({
		remove = true,
		name = "eff_ui_recruitKnightSpring_bg",
		isLoop = false
	})
end

function RecruitKnightSpringLayer:_isRequestNetWork()
	if not g.core.model.User.recruitData:hasData() then
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
	elseif g.core.model.User.recruitData:isExpired() then
		g.core.model.User.recruitData:resetExpired()
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
	else
		self:_updateView()
	end
end

function RecruitKnightSpringLayer:_doRecruit(arg_35_1, arg_35_2, arg_35_3)
	if self._actionsParams then
		return
	end

	if arg_35_3.awards == nil then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))

		return
	end

	local var_35_0 = g.core.model.User.recruitData:getBuyHelper()

	if arg_35_3.recruitTypeNet then
		var_35_0:setRecruitType(g.core.model.User.recruitData:getRecruitCfgByIdOrActId(arg_35_3.recruitTypeNet).type)
		var_35_0:setRecruitId(arg_35_3.recruitTypeNet)
		var_35_0:setRecruitNum(#arg_35_3.awards)
	else
		var_35_0:setRecruitType(nil)
		var_35_0:setRecruitId(nil)
		var_35_0:setRecruitNum(0)
	end

	if DebugCommon.getDebugGlobalValueByKey("recruit_jump_effect") then
		local var_35_1 = 0

		for iter_35_0 = 1, #arg_35_3.awards do
			local var_35_2 = var_0_7:convert(arg_35_3.awards[iter_35_0])

			if not var_35_2.is_frag then
				var_35_1 = math.max(var_35_1, var_35_2.quality)
			end
		end

		if var_35_1 < g.core.const.ConstMgr.QUALITY_TYPE.SSR then
			if self._currentComp then
				self._currentComp:playShow()
			end

			g.core.module.ModuleManager:tip("recruit_end")

			return
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_WAIT)

	if not self._isShowReward then
		self.m_topBarComp:playHideAction()
	end

	self._recruitTipTxt:setVisible(false)
	self:newScheduleOnce(handler(self, self._updateView), 0.5)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._content = arg_35_3
	self._highQuality = 0

	for iter_35_1 = 1, #arg_35_3.awards do
		self._highQuality = math.max(self._highQuality, var_0_7:convert(arg_35_3.awards[iter_35_1]).quality)
		arg_35_3.awards[iter_35_1].isNew = g.core.model.User.recruitData:checkIsNew(arg_35_3.awards[iter_35_1].value)
		arg_35_3.awards[iter_35_1].id = iter_35_1
	end

	if self._isShowReward then
		self.m_topBarComp:playShowAction()

		if self._rewardComp then
			self._rewardComp:playNewRwd(arg_35_3.awards)
		else
			self.m_ssrComp:playNewRwd(arg_35_3.awards)
		end

		return
	end

	self:_preLoadNextLayer()

	self._actionsParams = RecruitFuncCfg:getRecruitActionParams(arg_35_3.recruit_type, arg_35_3.num)

	self.m_moveComp:setMovieList(self:_getMovieList(), handler(self, self._moviePlayEnd), handler(self, self._onUserClick))
	self.m_moveComp:setPreLoadEnable(true)
	self.m_moveComp:playShow()
end

function RecruitKnightSpringLayer:_onShowShadow()
	return
end

function RecruitKnightSpringLayer:_onPlayPassEffect()
	self:_moviePlayEnd()
end

function RecruitKnightSpringLayer:_moviePlayEnd()
	if self._actionsParams then
		self._actionsParams = nil

		self.m_moveComp:setPlayEndNormal(true)

		if self._recruitCfg.gacha_display_quality <= self._highQuality then
			self.m_moveComp:playHide()
			self.m_ssrComp:resume()
			self:newScheduleOnce(handler(self, self._clearMoiveComp), 0.4)
		else
			self:_clearMoiveComp()
			self:_goToRewardLayer()
		end
	end
end

function RecruitKnightSpringLayer:_clearMoiveComp()
	self.m_moveComp:clearKeepCriSpites()
end

function RecruitKnightSpringLayer:_goToRewardLayer()
	self:_onActionEnd()
	self._rewardComp:playShow()
	self.m_topBarComp:playShowAction()
	self._recruitTipTxt:setVisible(true)
end

function RecruitKnightSpringLayer:_onActionEnd()
	self.m_moveComp:playHide()
	self:_clearMoiveComp()

	self._playEffect = false
end

function RecruitKnightSpringLayer:_onRecruitGetBoxAward(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	self:_updateBoxAwardList()
	g.core.module.ModuleManager:awardSummary(arg_42_4.awards)
end

function RecruitKnightSpringLayer:_updateBoxAwardList()
	local var_43_0 = g.core.model.User.recruitData:getDrawInfo(self._actId):getProgressAwardList()

	self.m_awardList:setNumItems(#var_43_0)

	local var_43_1 = 0

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		if iter_43_1.state == "match" then
			var_43_1 = iter_43_0 - 1

			break
		end
	end

	if var_43_1 > 0 then
		self.m_awardList:scrollToView(var_43_1)
	end
end

function RecruitKnightSpringLayer:onUnload()
	if self._animWaitCount and self._animWaitCount > 0 then
		for iter_44_0 = 1, self._animWaitCount do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end

		self._animWaitCount = 0
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
	self:_onStopTimeSchedule()
end

function RecruitKnightSpringLayer:onRemoved()
	g.core.resource.ResourceManager:removeSpineCache(var_0_9.TYPE.RES_EFFECT, var_0_9.RECRUIT_RES_EFFECT_CACHE)
end

function RecruitKnightSpringLayer:receiveCompEvent(arg_46_1, arg_46_2)
	if arg_46_1 == "update_topBar_res" then
		self.m_topBarComp:updateResource(true)

		return true
	elseif arg_46_1 == "clickWish" then
		self:addPopup(require("app.view.module.recruit.view.pop.RecruitKnightSpringWishPop").new(var_0_1.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING, self._actId))

		return true
	elseif arg_46_1 == "doRecruitContinue" then
		self:_onContinueRecruit(arg_46_2.num)

		return true
	end
end

function RecruitKnightSpringLayer:_onClickedLuck()
	local var_47_0 = g.core.const.ConstMgr.RecruitConst.RECRUIT_LIMIT_INDEX[self._id].luckHelpId or 0

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = var_47_0
	}), {
		touchDisappear = true
	})
end

function RecruitKnightSpringLayer:updateTopRes()
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.RecruitConst.RECRUIT_LIMIT_INDEX[self._id].topId or 0)
	self.m_topBarComp:setTitle(self._displayCfg.cfg.name)
end

function RecruitKnightSpringLayer:_preLoadNextLayer()
	if self._recruitCfg.gacha_display_quality <= self._highQuality then
		self._content.isHideRecruitBtn = false
		self._content.cfg = self._recruitCfg
		self._content.justShowResult = false

		self.m_ssrComp:updateComp(self._content, nil, self._recruitCfg.gacha_display_quality)
		self.m_ssrComp:pause()

		self._rewardComp = nil
	else
		local var_49_0 = clone(self._content)

		var_49_0.isPreLoad = true
		var_49_0.callBack = handler(self, self.onLoad)
		var_49_0.cfg = self._recruitCfg
		var_49_0.matchQuality = self._recruitCfg.gacha_display_quality
		self._rewardComp = require("app.view.module.recruit.view.recruitKnightSpring.RecruitRewardSpringLayer").new(var_49_0)

		self:addChild(self._rewardComp)
		self._rewardComp:setVisible(false)
	end
end

function RecruitKnightSpringLayer:_updateRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_giftBtn,
		customData = {}
	})
end

function RecruitKnightSpringLayer:_onContinueRecruit(arg_51_1)
	self._isShowReward = true
end

function RecruitKnightSpringLayer:_onRewardLayerOnRemoved()
	self.m_topBarComp:playShowAction()

	self._isShowReward = false
end

return RecruitKnightSpringLayer
