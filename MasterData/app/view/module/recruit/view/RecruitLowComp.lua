local RecruitLowComp = class("RecruitLowComp", require("app.fairyGUI.recruit.UI_RecruitLowComp"))
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.recruitData
local var_0_3 = g.core.const.ConstMgr.RecruitConst

function RecruitLowComp:ctor(arg_1_1)
	self._displayInfo = nil

	self:_addListeners()
	self:_init()
end

function RecruitLowComp:_addListeners()
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_recruitOneBtn:addClickListener(handler(self, self._onRecruitOneBtnClick))
	self.m_recruitTenBtn:addClickListener(handler(self, self._onRecruitTenBtnClick))
end

function RecruitLowComp:_onDetailBtnClick()
	self:addPopup(require("app.view.module.recruit.view.RecruitPreviewPop").new(var_0_3.FUNC_TYPE.LOW), {
		touchDisappear = true
	})
end

function RecruitLowComp:_onRecruitOneBtnClick()
	local var_4_0, var_4_1 = var_0_2:getgenRecruitConsume(var_0_3.ACTION_TYPE.LOW_ONE)

	if self:_isFree() then
		self.m_recruitOneBtn:setTouchable(false)
		self.m_recruitTenBtn:setTouchable(false)
		self:_reqRecruitNetWork(var_0_3.FUNC_TYPE.LOW, 0, 1)
	elseif var_4_0 then
		self.m_recruitOneBtn:setTouchable(false)
		self.m_recruitTenBtn:setTouchable(false)
		self:_reqRecruitNetWork(var_0_3.FUNC_TYPE.LOW, var_4_1.requestType, 1)
	else
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_4_1.type,
			value = var_4_1.value,
			size = var_4_1.curItemNum
		})
	end
end

function RecruitLowComp:_onRecruitTenBtnClick()
	if not var_0_2:isHasGenRecruitNum(10, var_0_2:getRecruitKnightCfg(var_0_3.FUNC_TYPE.LOW).id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(108007))

		return
	end

	local var_5_0, var_5_1 = var_0_2:getgenRecruitConsume(var_0_3.ACTION_TYPE.LOW_TEN)

	if var_5_0 then
		self.m_recruitOneBtn:setTouchable(false)
		self.m_recruitTenBtn:setTouchable(false)
		self:_reqRecruitNetWork(var_0_3.FUNC_TYPE.LOW, var_5_1.requestType, 10)
	else
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_5_1.type,
			value = var_5_1.value,
			size = var_5_1.curItemNum
		})
	end
end

function RecruitLowComp:_isFree()
	local var_6_0 = g.core.config.recruit_knight_cost_gain_info.get(var_0_3.RECRUIT_TYPE.Base)

	if var_6_0.daily_free_times - var_0_2:getGenerialFreeNum() > 0 and var_6_0.daily_free_interval <= g.core.common.ServerTime:getTime() - var_0_2:getGenerialFreeTime() then
		return true
	end

	return false
end

function RecruitLowComp:_reqRecruitNetWork(arg_7_1, arg_7_2, arg_7_3)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = var_0_2:getRecruitKnightCfg(arg_7_1).id,
		consume_type = arg_7_2,
		num = arg_7_3
	})
end

function RecruitLowComp:_init()
	local var_8_0 = var_0_2:getDisplayInfoByType(var_0_3.RECRUIT_TYPE.Base)
	local var_8_1 = cc.size(1087, 696)
	local var_8_2 = cc.p(1334 - var_8_1.width, 750 - var_8_1.height)
	local var_8_3 = self:getSize()

	for iter_8_0, iter_8_1 in ipairs(var_8_0.displays) do
		self["m_knightBtn" .. iter_8_0]:updateComp(iter_8_1)
	end

	self._displayInfo = var_8_0

	self.m_qualityText:setText(g.core.lang:get(108035))
end

function RecruitLowComp:onLoad()
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._resRecruit, self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._resRecruit, self)
	self.m_recruitOneBtn:setTouchable(true)
	self.m_recruitTenBtn:setTouchable(true)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
	self:updateView()
end

function RecruitLowComp:_resRecruit()
	return
end

function RecruitLowComp:updateView()
	local var_11_0 = var_0_2:getGuaranteedInfos(var_0_3.RECRUIT_TYPE.Base, false)

	if var_11_0 then
		self.m_timesText:setText(var_11_0.times)
	end

	self:_updateRecruitNum()
	self:_updateCost()
end

function RecruitLowComp:_updateRecruitNum()
	return
end

function RecruitLowComp:_updateCost()
	local var_13_0, var_13_1 = var_0_2:getgenRecruitConsume(var_0_3.ACTION_TYPE.LOW_ONE)

	self.m_recruitOneBtn:updateView({
		isCanRecruit = var_13_0,
		goods = var_13_1,
		isFree = self:_isFree()
	})

	local var_13_2, var_13_3 = var_0_2:getgenRecruitConsume(var_0_3.ACTION_TYPE.LOW_TEN)

	self.m_recruitTenBtn:updateView({
		isCanRecruit = var_13_2,
		goods = var_13_3
	})
	self.m_recruitOneBtn:setTouchable(true)
	self.m_recruitTenBtn:setTouchable(true)
end

function RecruitLowComp:getTitleTip()
	return g.core.lang:get(108032, {
		num = self._displayInfo.cfg.param_1,
		quality = g.core.lang:get(108035),
		tip = g.core.lang:get(108034)
	})
end

function RecruitLowComp:playShow()
	self:setVisible(true)
	self.m_enterTransition:play()
end

function RecruitLowComp:playHide(arg_16_1)
	self.m_backTransition:play(arg_16_1)
end

return RecruitLowComp
