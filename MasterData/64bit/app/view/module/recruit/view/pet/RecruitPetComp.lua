local RecruitPetComp = class("RecruitPetComp", require("app.fairyGUI.recruitPet.UI_RecruitPetComp"))
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.recruitData
local var_0_3 = g.core.const.ConstMgr.RecruitConst
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

function RecruitPetComp:ctor()
	self._wishInfos = {}

	self:_addListeners()
	self:_init()
end

function RecruitPetComp:_addListeners()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
	require("app.view.module.recruit.const.RecruitFuncCfg").addBtnTip(self, var_0_3.RECRUIT_TAB_TYPE.PET_TAB)
end

function RecruitPetComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new({
		id = self._cfg.id,
		type = var_0_3.RECRUIT_TYPE.PET_BASE,
		tabType = self._tabType,
		title = g.core.lang:get(108434)
	}), {
		touchDisappear = true
	})
end

function RecruitPetComp:_onKnightTwoBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitKnightShowTimePop").new({
		knightId = 400040,
		justShow = true
	}))
end

function RecruitPetComp:_onRecruitOneBtnClick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	if not var_0_2:isHasRecruitNum(1, self._cfg.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(108007, {
			num = g.core.config.parameter_info.get(15009).parameter
		}))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		return
	end

	if not self._ignoreFull and var_0_2:checkIsFull(self._cfg) then
		local var_5_1 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_5_1,
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

function RecruitPetComp:_doRecruitOneTimes()
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

function RecruitPetComp:_onRecruitGetTaskAward(arg_8_1, arg_8_2, arg_8_3)
	g.core.module.ModuleManager:awardSummary(arg_8_3.awards)
end

function RecruitPetComp:_onRecruitTenBtnClick()
	if not var_0_2:isHasRecruitNum(10, self._cfg.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(108007, {
			num = g.core.config.parameter_info.get(15009).parameter
		}))

		return
	end

	if not self._ignoreFull and var_0_2:checkIsFull(self._cfg) then
		local var_9_1 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_9_1,
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

function RecruitPetComp:_doRecruitTenTimes()
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

function RecruitPetComp:_isFree()
	local var_12_0 = g.core.config.recruit_knight_cost_gain_info.get(self._cfg.single_summon_cost)

	if var_12_0.daily_free_times - var_0_2:getAdvanceFreeNum() > 0 and var_12_0.daily_free_interval <= g.core.common.ServerTime:getTime() - var_0_2:getAdvanceFreeTime() then
		return true
	end

	return false
end

function RecruitPetComp:_reqRecruitNetWork(arg_13_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = self._cfg.id,
		consume_type = arg_13_1.consumeType,
		num = arg_13_1.num
	})
end

function RecruitPetComp:_init()
	for iter_14_0, iter_14_1 in ipairs(var_0_2:getDisplayInfoById(100012).displays) do
		self["m_knightBtn" .. iter_14_0]:updateComp(iter_14_1, false, true)
	end

	self._cfg = var_0_2:getRecruitKnightCfgById(100012)

	AutoBuyComp.bindComp(self.m_recruitOneBtn)
	self.m_recruitOneBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
	AutoBuyComp.bindComp(self.m_recruitTenBtn)
	self.m_recruitTenBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._reqRecruitNetWork))
end

function RecruitPetComp:onLoad()
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onRecruitGetTaskAward, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_LUCK, handler(self, self.updateView), self)
	self.m_recruitOneBtn:addAutoBuyCompListener()
	self.m_recruitTenBtn:addAutoBuyCompListener()
end

function RecruitPetComp:receiveCompEvent(arg_16_1, arg_16_2)
	if arg_16_1 == "clickWish" then
		self:addPopup(require("app.view.module.recruit.view.pop.RecruitKnightWishPop").new(var_0_3.RECRUIT_TYPE.PET_BASE, self._cfg.id))

		return true
	end

	return false
end

function RecruitPetComp:updateView()
	self._wishInfos = g.core.model.User.recruitData:getWishInfo(var_0_3.RECRUIT_TYPE.PET_BASE)

	self.m_rightBigLoader:setURL("pic/recruit/pet/bg_yzsl_red4.png")
	self.m_leftBigLoader:setURL("pic/recruit/pet/bg_yzsl_red3.png")
	self.m_leftLoader:setURL("pic/recruit/pet/bg_yzsl_red5.png")
	self.m_rightLoader:setURL("pic/recruit/pet/bg_yzsl_red6.png")
	self:_updateLuck()
	self:_updateRecruitNum()
	self:_updateCost()
end

function RecruitPetComp:setLuckTimeText(arg_18_1, arg_18_2)
	self._curLuckText = arg_18_1
	self._maxLuckText = arg_18_2
end

function RecruitPetComp:_updateRecruitNum()
	return
end

function RecruitPetComp:_updateCost()
	local var_20_0, var_20_1 = var_0_2:getgenRecruitConsume(self._cfg.single_summon_cost)

	self.m_recruitOneBtn:updateView({
		isCanRecruit = var_20_0,
		isFree = self:_isFree(),
		goods = var_20_1
	})

	local var_20_2, var_20_3 = var_0_2:getgenRecruitConsume(self._cfg.ten_summon_cost)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_20_2,
		goods = var_20_3
	})
end

function RecruitPetComp:getTitleTip()
	return g.core.lang:get(108032, {
		num = 10,
		quality = g.core.lang:get(108035),
		tip = g.core.lang:get(108037)
	})
end

function RecruitPetComp:playShow()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitEvent = true

	self:updateView()
	self:setVisible(true)
	self.m_enterTransition:play(handler(self, self.onEnd))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_HIGH_UI_SHOW)
end

function RecruitPetComp:onEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	self._waitEvent = false
end

function RecruitPetComp:playHide(arg_24_1)
	self.m_backTransition:play(arg_24_1)
end

function RecruitPetComp:_updateLuck()
	local var_25_0 = var_0_2:getGuaranteedInfos(var_0_3.RECRUIT_TYPE.PET_BASE, false)

	if var_25_0 then
		self._curLuckText:setText(var_25_0.totalTimes - var_25_0.times)
		self._maxLuckText:setText("/" .. var_25_0.totalTimes)
	end
end

function RecruitPetComp:onUnload()
	if self._waitEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitEvent = false
	end
end

function RecruitPetComp:updateByCfg(arg_27_1)
	self._tabType = arg_27_1.ownerType
end

function RecruitPetComp:playRecruitAction(arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	if arg_28_5 then
		return
	end

	self._content = arg_28_1
	self._highQuality = 0

	local var_28_0 = true

	for iter_28_0 = 1, #arg_28_1.awards do
		local var_28_1 = g.core.common.Goods:convert(arg_28_1.awards[iter_28_0])
		local var_28_2 = math.min(2, var_28_1.quality)

		if arg_28_1.awards[iter_28_0].type == g.core.common.Goods.TYPE_PET then
			arg_28_1.awards[iter_28_0].isNew = g.core.model.User.recruitData:checkIsNewPet(arg_28_1.awards[iter_28_0].value)
			var_28_2 = var_28_1.quality
			var_28_0 = false
		end

		self._highQuality = math.max(self._highQuality, var_28_2)
		arg_28_1.awards[iter_28_0].quality = var_28_1.quality
		arg_28_1.awards[iter_28_0].id = iter_28_0
	end

	if var_28_0 then
		self._highQuality = math.min(2, self._highQuality)
	end

	arg_28_3:playShow("PetTouchSpineComp", {
		quality = self._highQuality,
		content = self._content
	}, handler(self, self._goToRewardLayer), handler(self, self._goToRewardLayer))
end

function RecruitPetComp:_goToRewardLayer(arg_29_1)
	local var_29_0 = clone(arg_29_1.content)

	var_29_0.cfg = self._cfg
	var_29_0.matchQuality = self._cfg.gacha_display_quality

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_PET_REWARD, var_29_0)
end

function RecruitPetComp:onContinueRecruit(arg_30_1)
	self._ignoreFull = true

	if arg_30_1 == 1 then
		self:_onRecruitOneBtnClick()
	elseif arg_30_1 == 10 then
		self:_onRecruitTenBtnClick()
	end

	self._ignoreFull = false
end

return RecruitPetComp
