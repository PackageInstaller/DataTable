local RecruitArtifactComp = class("RecruitArtifactComp", require("app.fairyGUI.recruitArtifact.UI_RecruitArtifactComp"))
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.recruitData
local var_0_3 = g.core.const.ConstMgr.RecruitConst
local var_0_4 = g.core.common.ServerTime
local RecruitFuncCfg = require("app.view.module.recruit.const.RecruitFuncCfg")
local var_0_6 = g.core.model.User.activityMonthCardData
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

function RecruitArtifactComp:ctor()
	self._remainTime = nil
	self._startTime = nil
	self._schedulerHandler = nil
	self._wishInfos = {}

	self:_addListeners()
	self:_init()
end

function RecruitArtifactComp:_addListeners()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
	self.m_groupClickComp:addClickListener(handler(self, self._hideUpDetail))
	self.m_upGroupBtn:addClickListener(handler(self, self._showDetail))
	RecruitFuncCfg.addBtnTip(self, var_0_3.RECRUIT_TAB_TYPE.ARTIFACT_TAB)
end

function RecruitArtifactComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		title = g.core.lang:get(108412),
		id = self._cfg.id,
		type = var_0_3.RECRUIT_TYPE.ARTIFACT_BASE,
		tabType = self._tabType
	}), {
		touchDisappear = true
	})
end

function RecruitArtifactComp:_onKnightTwoBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitKnightShowTimePop").new({
		knightId = 400040,
		justShow = true
	}))
end

function RecruitArtifactComp:_onRecruitOneBtnClick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	local var_5_0 = var_0_2:getDrawInfo(nil, var_0_3.RECRUIT_TYPE.ARTIFACT_BASE)
	local var_5_1 = var_5_0:getDailyLimitNum()

	if var_5_0:getDailyCount() >= var_5_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108414, {
			num = var_5_1
		}))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		return
	end

	if var_0_2:checkIsFull(self._cfg) then
		local var_5_3 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_5_3,
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

function RecruitArtifactComp:_doRecruitOneTimes()
	local var_7_0, var_7_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_7_2 = g.core.model.User.recruitData:getBuyHelper()

	var_7_2:setRecruitType(self._cfg.type)
	var_7_2:setRecruitId(self._cfg.id)
	var_7_2:setRecruitNum(1)

	local var_7_3 = var_7_2:getCurBuyItemInfo()
	local var_7_4 = {
		num = 1,
		itemInfo = var_7_3,
		recruitType = self._cfg.type,
		consumeType = var_7_1.requestType
	}

	if self:_isFree() then
		var_7_4.consumeType = 0
		var_7_4.itemInfo = nil
		var_7_3 = nil
	end

	self.m_recruitOneBtn:_onDoingClick(var_7_3, var_7_4, 1, 0)
end

function RecruitArtifactComp:_onRecruitGetTaskAward(arg_8_1, arg_8_2, arg_8_3)
	g.core.module.ModuleManager:awardSummary(arg_8_3.awards)
end

function RecruitArtifactComp:_onRecruitTenBtnClick()
	local var_9_0 = var_0_2:getDrawInfo(nil, var_0_3.RECRUIT_TYPE.ARTIFACT_BASE)
	local var_9_1 = var_9_0:getDailyLimitNum()

	if var_9_1 < var_9_0:getDailyCount() + 10 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108414, {
			num = var_9_1
		}))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		return
	end

	if var_0_2:checkIsFull(self._cfg) then
		local var_9_3 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_9_3,
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

function RecruitArtifactComp:_doRecruitTenTimes()
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

function RecruitArtifactComp:_isFree()
	local var_12_0, var_12_1 = var_0_2:getArtifactFreeNumAndRecTime()

	return var_12_0 > 0
end

function RecruitArtifactComp:_reqRecruitNetWork(arg_13_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self._cfg.id,
		consume_type = arg_13_1.consumeType,
		num = arg_13_1.num
	})
end

function RecruitArtifactComp:_init()
	local var_14_0 = var_0_2:getDisplayInfoById(100007)

	for iter_14_0, iter_14_1 in ipairs(var_14_0.displays) do
		self["m_knightBtn" .. iter_14_0]:updateComp(iter_14_1)
	end

	self.m_leftBg:setURL("pic/recruit/showArtifact/pic_zm_ygcz_wq_1_3.png")
	self:addListen(self.m_wishComp)

	self._cfg = var_0_2:getRecruitKnightCfgById(100007)
	self._displayCfg = var_14_0

	self.m_arrowNode:addEffectSpine({
		anim = "play2",
		name = "eff_ui_recruitPrimary_qianwang",
		isLoop = true
	})
	self.m_detailGroupComp:setHideFunc(handler(self, self._hideUpDetail))
	self:_showDetail()
	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
end

function RecruitArtifactComp:onLoad()
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._resRecruit, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onRecruitGetTaskAward, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self.updateView), self)
	self.m_recruitOneBtn:addAutoBuyCompListener()
	self.m_recruitTenBtn:addAutoBuyCompListener()
end

function RecruitArtifactComp:receiveCompEvent(arg_16_1, arg_16_2)
	if arg_16_1 == "clickWish" then
		self:addPopup(require("app.view.module.recruit.view.pop.RecruitArtifactWishPop").new(var_0_3.RECRUIT_TYPE.ARTIFACT_BASE, self._cfg.id))

		return true
	end

	return false
end

function RecruitArtifactComp:_resRecruit()
	return
end

function RecruitArtifactComp:updateView()
	self._wishInfos = g.core.model.User.recruitData:getWishInfo(var_0_3.RECRUIT_TYPE.ARTIFACT_BASE)

	self.m_wishComp:updateComp(self._wishInfos, var_0_3.RECRUIT_TYPE.ARTIFACT_BASE)
	self:_updateRecruitNum()
	self:_updateCost()
	self.m_minimumText:setText(g.core.model.User.recruitData:getGuaranteedInfos(var_0_3.RECRUIT_TYPE.ARTIFACT_BASE).times)
	self.m_detailGroupComp:updateComp((g.core.model.User.recruitData:getWishMembersByRecruitType(var_0_3.RECRUIT_TYPE.ARTIFACT_BASE)))

	if self.m_detailGroupComp:getUpListNum() > 0 then
		self.m_openWishController:setSelectedIndex(1)
	else
		self.m_openWishController:setSelectedIndex(0)
	end

	local var_18_0 = g.core.model.User.recruitData:getLimitNearTime()

	if var_18_0 > 0 then
		self:newScheduleOnce(handler(self, self._syncWishInfo), var_18_0 - g.core.common.ServerTime:getTime())
	end
end

function RecruitArtifactComp:updateWishMiniRed()
	self.m_wishComp:refreshRed()
end

function RecruitArtifactComp:setLuckTimeText(arg_20_1, arg_20_2)
	self._curLuckText = arg_20_1
	self._maxLuckText = arg_20_2
end

function RecruitArtifactComp:_updateRecruitNum()
	return
end

function RecruitArtifactComp:_updateCost()
	self:_cancelCountdown()

	local var_22_0, var_22_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_22_2 = {
		isCanRecruit = var_22_0
	}
	local var_22_3, var_22_4 = var_0_2:getArtifactFreeNumAndRecTime()

	var_22_2.freeNum = var_22_3
	var_22_2.goods = var_22_1
	var_22_2.redId = 615

	self.m_recruitOneBtn:updateView(var_22_2)

	local var_22_5, var_22_6 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_22_5,
		goods = var_22_6
	})
	self.m_countDown:setVisible(false)

	if var_0_2:isFreeDrawEnable(var_0_3.RECRUIT_TYPE.ARTIFACT_BASE, g.core.const.ConstMgr.RechargeConst.PRIVILEGE_TYPE.ARTIFACT_FREE_NUM) then
		self._remainTime = var_0_2:getArtifactFreeDrawRefreshTime()
		self._startTime = var_0_4:getTime()

		if self._remainTime == nil or self._remainTime == 0 then
			self.m_countDown:setVisible(false)
			self:_cancelCountdown()
		else
			self.m_countDown:setVisible(true)

			self._schedulerHandler = g.core.common.Scheduler:newCountdown(self._remainTime, 1, handler(self, self._updateCountDown), handler(self, self._countDownFinish), nil)
		end
	end
end

function RecruitArtifactComp:_checkPrivilege()
	return (var_0_6:isPrivilegeActivatedByIndex(2))
end

function RecruitArtifactComp:_updateCountDown()
	local var_24_0 = self._remainTime + self._startTime - var_0_4:getTime()

	self.m_countDownTxt:setText(g.core.lang:get(108436, {
		time = var_0_4:secondToDHMString(var_24_0)
	}))

	if var_24_0 and var_24_0 < 1 then
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
		end, 2)
	end
end

function RecruitArtifactComp:_countDownFinish()
	self.m_countDown:setVisible(false)
end

function RecruitArtifactComp:getTitleTip()
	return g.core.lang:get(108032, {
		num = 10,
		quality = g.core.lang:get(108035),
		tip = g.core.lang:get(108037)
	})
end

function RecruitArtifactComp:playShow()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitEvent = true

	self:updateView()
	self:setVisible(true)
	self.m_enterTransition:play(handler(self, self.onEnd))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_ARTIFACT_UI_SHOW)
end

function RecruitArtifactComp:onEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	self._waitEvent = false
end

function RecruitArtifactComp:playHide(arg_30_1)
	self.m_backTransition:play(arg_30_1)
end

function RecruitArtifactComp:onUnload()
	self:_cancelCountdown()

	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end
end

function RecruitArtifactComp:_cancelCountdown()
	if self._schedulerHandler then
		g.core.common.Scheduler:cancelCountdown(self._schedulerHandler)

		self._schedulerHandler = nil
	end
end

function RecruitArtifactComp:updateByCfg(arg_33_1)
	self._tabType = arg_33_1.ownerType
end

function RecruitArtifactComp:playRecruitAction(arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	if arg_34_5 then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._content = arg_34_1
	self._highQuality = 0

	for iter_34_0 = 1, #arg_34_1.awards do
		local var_34_0 = g.core.common.Goods:convert(arg_34_1.awards[iter_34_0])

		self._highQuality = math.max(self._highQuality, var_34_0.quality)
		arg_34_1.awards[iter_34_0].isNew = g.core.model.User.recruitData:checkIsNewArtifact(arg_34_1.awards[iter_34_0].value)
		arg_34_1.awards[iter_34_0].quality = var_34_0.quality
		arg_34_1.awards[iter_34_0].id = iter_34_0
	end

	arg_34_3:playShow("ArtifactTouchSpineComp", {
		quality = self._highQuality,
		content = self._content
	}, handler(self, self._goToRewardLayer), handler(self, self._goToRewardLayer))
end

function RecruitArtifactComp:_onUserClick(arg_35_1, arg_35_2)
	if not arg_35_1 then
		return
	end

	if arg_35_1[1].id == "loop" then
		arg_35_2:jump()
	end
end

function RecruitArtifactComp:_goToRewardLayer(arg_36_1)
	local var_36_0 = clone(arg_36_1.content)

	var_36_0.cfg = self._cfg
	var_36_0.matchQuality = self._cfg.gacha_display_quality

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_ARTIFACT_REWARD, var_36_0)
end

function RecruitArtifactComp:_hideUpDetail()
	self.m_detailGroupComp:playHide(handler(self, self._hideUpDetailCtr))
end

function RecruitArtifactComp:_hideUpDetailCtr()
	self.m_showUpDetailController:setSelectedIndex(0)
end

function RecruitArtifactComp:_showDetail()
	self.m_showUpDetailController:setSelectedIndex(1)
	self.m_detailGroupComp:playShow(handler(self, self._hideUpDetailCtr))
end

function RecruitArtifactComp:_syncWishInfo()
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
end

function RecruitArtifactComp:onContinueRecruit(arg_41_1)
	if arg_41_1 == 1 then
		self:_onRecruitOneBtnClick()
	elseif arg_41_1 == 10 then
		self:_onRecruitTenBtnClick()
	end
end

return RecruitArtifactComp
