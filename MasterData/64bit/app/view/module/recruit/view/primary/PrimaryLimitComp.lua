local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local var_0_1 = g.core.const.ConstMgr.RecruitConst
local var_0_2 = g.core.model.User.recruitData
local PrimaryLimitComp = class("PrimaryLimitComp", require("app.fairyGUI.recruitKnight.UI_PrimaryLimitComp"), RecruitLimitCompBase)

function PrimaryLimitComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, PrimaryLimitComp)
		RecruitLimitCompBase.ctor(self)
	end
end

function PrimaryLimitComp:_initKnightTipBtn()
	local var_2_0 = g.core.model.User.recruitData:getDisplayInfoById(self._recruitCfg.id)
	local var_2_1 = table.nums(var_2_0.displays)

	for iter_2_0, iter_2_1 in ipairs(var_2_0.displays) do
		local var_2_2 = self._subComps["tipKnightBtn" .. iter_2_0]

		if not self._subComps["tipKnightBtn" .. iter_2_0] then
			break
		end

		var_2_2:updateComp(iter_2_1, var_2_1 == var_0_1.SHOW_SPINE_NUM, true, self._displayCfg.cfg)
		self["m_knightIcon" .. iter_2_0]:setIcon((g.core.common.Path:getPrimaryLimitShowKnightIconById(iter_2_1.knight_id)))
	end
end

function PrimaryLimitComp:_initOtherUI()
	self.m_otherKnightIcon1:setURL(g.core.common.Path:getPrimaryLimitShowKnightIconById("l_" .. self._recruitCfg.id))
	self.m_otherKnightIcon2:setURL(g.core.common.Path:getPrimaryLimitShowKnightIconById("r_" .. self._recruitCfg.id))
end

function PrimaryLimitComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, handler(self, self._onExchangeSuc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS, handler(self, self._onExchangeSuc), self)
	RecruitLimitCompBase.onLoad(self)
end

function PrimaryLimitComp:updateView()
	self._type = var_0_1.RECRUIT_TYPE.PRIMARY_LIMIT
	self._id = self:_getRecruitNetId()
	self._wishInfos = g.core.model.User.recruitData:getWishInfo(self._type, self._id)

	self.m_wishMiniComp:updateComp(self._wishInfos, self._type, self._id)

	local var_5_0 = g.core.model.User.recruitData:getDrawInfo(self._id, nil, true)

	self.m_drawTimeText:setText(var_5_0:getTotalLimitNum() - var_5_0:getTotalCount())
	RecruitLimitCompBase.updateView(self)
end

function PrimaryLimitComp:_playShowEndLogic()
	local var_6_0 = g.core.model.User.recruitData:getDrawInfo(self:_getRecruitNetId(), nil, true)

	if var_6_0:getTotalLimitNum() - var_6_0:getTotalCount() <= 0 then
		self:dispatchCompEvent("limitTimeEnd")
	end
end

function PrimaryLimitComp:_onExchangeSuc()
	self:newScheduleOnce(handler(self, self.updateView), 0.5)
end

function RecruitLimitCompBase:_checkIsReachMaxTimes(arg_8_1)
	local var_8_0 = g.core.model.User.recruitData:getDrawInfo((self:_getRecruitNetId()))

	if not var_8_0 then
		return 0
	end

	local var_8_1 = var_8_0:getTotalLimitNum()

	return (var_8_1 < var_8_0:getTotalCount() + arg_8_1 or nil) and var_8_1, (g.core.lang:get(108478, {
		name = self._displayCfg.cfg.name,
		num = var_8_1
	}))
end

function RecruitLimitCompBase:_checkWishHaveSet()
	local var_9_0 = g.core.model.User.recruitData:getDrawInfo(self._id, self._type)

	if self._type == var_0_1.RECRUIT_TYPE.PRIMARY_LIMIT and ((var_9_0 or nil) and var_9_0:getTotalCount()) >= g.core.model.User.recruitData:getWishOpenTimes(self._type, self._id) then
		if self._wishInfos and #self._wishInfos == 0 then
			return false
		else
			return true
		end
	else
		return true
	end
end

function RecruitLimitCompBase:_showOtherPop()
	local var_10_0 = require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		desc = g.core.lang:get(108490),
		confirmText = g.core.lang:get(1083),
		cancelText = g.core.lang:get(108491),
		onConfirm = handler(self, function()
			self:addPopup((require("app.view.module.recruit.view.pop.PrimaryLimitWishPop").new(self._recruitCfg.id)))
		end),
		onCancel = handler(self, self._ignoreSetWish)
	})

	var_10_0:setCancelTouchable(3, g.core.lang:get(108492))
	g.core.module.ModuleManager:pushPopup(var_10_0, {
		touchDisappear = true
	})
end

function RecruitLimitCompBase:_ignoreSetWish()
	self:_onTenBtnClick()
end

function RecruitLimitCompBase:_onTenBtnClick()
	if not self._clickTenEnable then
		return
	end

	local var_13_0, var_13_1 = self:_checkIsReachMaxTimes(self._multiNum)

	if var_13_0 > 0 then
		var_13_1 = var_13_1 or g.core.lang:get(108413, {
			name = self._displayCfg.cfg.name,
			num = var_13_0
		})

		g.core.module.ModuleManager:tip(var_13_1)

		return
	end

	local var_13_2, var_13_3 = var_0_2:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)

	if var_13_2 then
		if self._subComps.recruitOneBtn then
			self._subComps.recruitOneBtn:setTouchable(false)
		end

		self._subComps.recruitTentBtn:setTouchable(false)

		if self._subComps.recruitTwentyBtn then
			self._subComps.recruitTwentyBtn:setTouchable(false)
		end

		self:_reqRecruitNetWork(self._recruitType, var_13_3.requestType, self._multiNum)
	else
		local var_13_4 = self._actData:getActivityId()

		self:dispatchCompEvent("doTipRecruit", {
			type = self._recruitType,
			num = self._multiNum,
			id = (not self._actData:getInfo().sub_activity_id or nil) and self._actData:getActivityValue()
		})
	end
end

return PrimaryLimitComp
