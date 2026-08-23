local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")
local NewLimitArtifactComp = class("NewLimitArtifactComp", require("app.fairyGUI.recruitArtifact.UI_NewLimitArtifactComp"))
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.model.User.recruitData
local var_0_4 = g.core.const.ConstMgr.RecruitConst

function NewLimitArtifactComp:ctor()
	self._wishInfos = {}
	self._effLoop = nil

	self:init()
end

function NewLimitArtifactComp:init()
	self._cfg = g.core.model.User.recruitData:getRecruitKnightCfgById(100031)
	self._recruitType = self._cfg.type
	self._displayCfg = g.core.model.User.recruitData:getDisplayInfoById(100031)

	self:_addListeners()
	self:_initKnightTipBtn()
	self.m_raioText:setText(g.core.config.recruit_knight_wish_rule_info.get(self._cfg.wish_rule_id).value / 100)
end

function NewLimitArtifactComp:_addListeners()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	require("app.view.module.recruit.const.RecruitFuncCfg").addBtnTip(self, var_0_4.RECRUIT_TAB_TYPE.ARTIFACT_TAB)
end

function NewLimitArtifactComp:_initKnightTipBtn()
	local var_4_0 = var_0_3:getDisplayInfoById(self._cfg.id)
	local var_4_1 = table.nums(var_4_0.displays)

	for iter_4_0, iter_4_1 in ipairs(var_4_0.displays) do
		local var_4_2 = self["m_tipBtn" .. iter_4_0]

		if not self["m_tipBtn" .. iter_4_0] then
			break
		end

		var_4_2:updateComp(iter_4_1, var_4_1 == var_0_4.SHOW_SPINE_NUM, true, self._displayCfg.cfg)

		if self["m_tipBg" .. iter_4_0] then
			self["m_tipBg" .. iter_4_0]:setURL("pic/recruit/newLimit/pic_zm_xszw_" .. iter_4_0 .. ".png")
		end
	end
end

function NewLimitArtifactComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._cfg.id,
		type = var_0_4.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT,
		tabType = self._tabType,
		title = g.core.lang:get(108708)
	}), {
		touchDisappear = true
	})
end

function NewLimitArtifactComp:_onKnightTwoBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitKnightShowTimePop").new({
		knightId = 400040,
		justShow = true
	}))
end

function NewLimitArtifactComp:_onRecruitOneBtnClick()
	if not next(self._wishInfos) or self._wishInfos[1].r_type == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108714))

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

function NewLimitArtifactComp:_doRecruitOneTimes()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	local var_9_0, var_9_1 = var_0_3:getgenRecruitConsume(self._cfg.single_summon_cost)
	local var_9_2 = g.core.model.User.recruitData:getBuyHelper()

	var_9_2:setRecruitType(var_0_4.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT)
	var_9_2:setRecruitId(self._cfg.id)
	var_9_2:setRecruitNum(1)

	local var_9_3 = var_9_2:getCurBuyItemInfo()
	local var_9_4 = {
		num = 1,
		itemInfo = var_9_3,
		recruitType = var_0_4.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT,
		consumeType = var_9_1.requestType
	}

	if self:_isFree() then
		var_9_4.consumeType = 0
		var_9_4.itemInfo = nil
		var_9_3 = nil
	end

	self.m_recruitOneBtn:_onDoingClick(var_9_3, var_9_4, 1, 0)
end

function NewLimitArtifactComp:_onRecruitGetTaskAward(arg_10_1, arg_10_2, arg_10_3)
	g.core.module.ModuleManager:awardSummary(arg_10_3.awards)
end

function NewLimitArtifactComp:_onRecruitTenBtnClick()
	if not next(self._wishInfos) or self._wishInfos[1].r_type == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(108714))

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

function NewLimitArtifactComp:_doRecruitTenTimes()
	local var_13_0, var_13_1 = var_0_3:getgenRecruitConsume(self._cfg.ten_summon_cost)
	local var_13_2 = g.core.model.User.recruitData:getBuyHelper()

	var_13_2:setRecruitNum(10)
	var_13_2:setRecruitType(var_0_4.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT)
	var_13_2:setRecruitId(self._cfg.id)

	local var_13_3 = var_13_2:getCurBuyItemInfo()

	self.m_recruitTenBtn:_onDoingClick(var_13_3, {
		itemInfo = var_13_3,
		recruitType = var_0_4.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT,
		consumeType = var_13_1.requestType,
		num = 10
	}, 1, 0)
end

function NewLimitArtifactComp:_isFree()
	local var_14_0 = g.core.config.recruit_knight_cost_gain_info.get(var_0_4.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT)

	if var_14_0.daily_free_times - var_0_3:getAdvanceFreeNum() > 0 and var_14_0.daily_free_interval <= g.core.common.ServerTime:getTime() - var_0_3:getAdvanceFreeTime() then
		return true
	end

	return false
end

function NewLimitArtifactComp:_reqRecruitNetWork(arg_15_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self._cfg.id,
		consume_type = arg_15_1.consumeType,
		num = arg_15_1.num
	})
end

function NewLimitArtifactComp:onLoad()
	self._clickOneEnable = true
	self._clickTenEnable = true

	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._resRecruit, self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onRecruitGetTaskAward, self)
	var_0_2:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self.updateView), self)
	self.m_recruitOneBtn:addAutoBuyCompListener()
	self.m_recruitTenBtn:addAutoBuyCompListener()
end

function NewLimitArtifactComp:receiveCompEvent(arg_17_1, arg_17_2)
	if arg_17_1 == "clickWish" then
		self:addPopup(require("app.view.module.recruit.view.pop.RecruitNewLimitArtifactWishPop").new(var_0_4.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT, self._cfg.id))

		return true
	end

	return false
end

function NewLimitArtifactComp:_resRecruit()
	return
end

function NewLimitArtifactComp:updateView()
	self._wishInfos = g.core.model.User.recruitData:getWishInfo(self._recruitType, self._cfg.id) or {}

	self.m_wishComp:updateComp(self._wishInfos, self._recruitType)
	self:_updateLuck()
	self:_updateRecruitNum()
	self:_updateCost()
end

function NewLimitArtifactComp:setLuckTimeText(arg_20_1, arg_20_2)
	self._curLuckText = arg_20_1
	self._maxLuckText = arg_20_2
end

function NewLimitArtifactComp:_updateRecruitNum()
	return
end

function NewLimitArtifactComp:_updateCost()
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

function NewLimitArtifactComp:getTitleTip()
	return g.core.lang:get(108032, {
		num = 10,
		quality = g.core.lang:get(108035),
		tip = g.core.lang:get(108037)
	})
end

function NewLimitArtifactComp:playShow()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitEvent = true

	self:updateView()
	self:setVisible(true)
	self.m_enterTransition:play(handler(self, self.onEnd))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_HIGH_UI_SHOW)
end

function NewLimitArtifactComp:onEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	self._waitEvent = false
end

function NewLimitArtifactComp:playHide(arg_26_1)
	self.m_backTransition:play(arg_26_1)
end

function NewLimitArtifactComp:_updateLuck()
	local var_27_0 = var_0_3:getGuaranteedInfos(var_0_4.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT, false)

	if var_27_0 then
		self._curLuckText:setText(var_27_0.totalTimes - var_27_0.times)
		self._maxLuckText:setText("/" .. var_27_0.totalTimes)
	end
end

function NewLimitArtifactComp:onUnload()
	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end
end

function NewLimitArtifactComp:updateByCfg(arg_29_1)
	self._tabType = arg_29_1.ownerType
end

function NewLimitArtifactComp:onContinueRecruit(arg_30_1)
	self._ignoreFull = true

	if arg_30_1 == 1 then
		self:_onRecruitOneBtnClick()
	elseif arg_30_1 == 10 then
		self:_onRecruitTenBtnClick()
	end

	self._ignoreFull = false
end

function NewLimitArtifactComp:playRecruitAction(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	if arg_31_5 then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._content = arg_31_1
	self._highQuality = 0

	for iter_31_0 = 1, #arg_31_1.awards do
		local var_31_0 = g.core.common.Goods:convert(arg_31_1.awards[iter_31_0])

		self._highQuality = math.max(self._highQuality, var_31_0.quality)
		arg_31_1.awards[iter_31_0].isNew = g.core.model.User.recruitData:checkIsNewArtifact(arg_31_1.awards[iter_31_0].value)
		arg_31_1.awards[iter_31_0].quality = var_31_0.quality
		arg_31_1.awards[iter_31_0].id = iter_31_0
	end

	arg_31_3:playShow("ArtifactTouchSpineComp", {
		quality = self._highQuality,
		content = self._content
	}, handler(self, self._goToRewardLayer), handler(self, self._goToRewardLayer))
end

function NewLimitArtifactComp:_goToRewardLayer(arg_32_1)
	local var_32_0 = clone(arg_32_1.content)

	var_32_0.cfg = self._cfg
	var_32_0.matchQuality = self._cfg.gacha_display_quality

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_ARTIFACT_REWARD, var_32_0)
end

return NewLimitArtifactComp
