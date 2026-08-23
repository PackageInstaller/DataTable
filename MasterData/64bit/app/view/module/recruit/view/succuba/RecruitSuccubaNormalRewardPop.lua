local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.recruitData
local var_0_3 = g.core.const.ConstMgr.RecruitConst
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")
local RecruitSuccubaNormalRewardPop = class("RecruitSuccubaNormalRewardPop", require("app.fairyGUI.recruitSuccuba.UI_RecruitSuccubaNormalRewardPop"), function()
	return fgui.GComponent:create({
		isFullScreen = false,
		pkgPath = "ui/recruitSuccuba/recruitSuccuba",
		resName = "RecruitSuccubaNormalRewardPop",
		pkgName = "recruitSuccuba"
	}, ...)
end)

function RecruitSuccubaNormalRewardPop:ctor(arg_2_1)
	self:showAtCenter()

	self._goodList = {}
	self._popGoodList = {}
	self._curPopIndex = 0
	self._isPlaying = true
	self._isClose = false
	self._recruitCfg = arg_2_1.cfg

	self.m_effHolder:setPosition(cc.p(self.m_effHolder:getPosition().x, 750 + (display.height - 750) / 2))
	self:initShowList(arg_2_1.awards)

	self._param = arg_2_1

	self:initView()
	self.m_effHolder:addEffectSpine({
		anim = "play",
		isLoop = true,
		name = "eff_ui_succubaRecruit_bgglow"
	})
end

function RecruitSuccubaNormalRewardPop:onLoad()
	if self.m_continueBtn:isVisible() then
		self.m_continueBtn:addAutoBuyCompListener()
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._resRecruit, self)
end

function RecruitSuccubaNormalRewardPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RECRUIT_REWARD_REMOVED)
end

function RecruitSuccubaNormalRewardPop:initView()
	self.m_closeBtn:addClickListener(handler(self, self._onClickClose))
	self.m_continueBtn:addClickListener(handler(self, self._onClickContinue))
	self:_updateCost()
	self:_onUpdateTipText()
	AutoBuyComp.bindComp(self.m_continueBtn)
	self.m_continueBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._sendContinue))
end

function RecruitSuccubaNormalRewardPop:_onUpdateTipText()
	local var_6_0 = var_0_1:getCostInfoId(self._param.cfg.type, #self._param.awards)

	if var_6_0 == 0 then
		self.m_rewardTxt:setText("")

		return
	end

	local var_6_1 = g.core.config.recruit_knight_cost_gain_info.get(var_6_0)
	local var_6_2 = g.core.common.Goods:convert({
		value = var_6_1.gain_value,
		type = var_6_1.gain_type,
		size = var_6_1.gain_size
	})

	self.m_rewardTxt:setText(g.core.lang:get(108046, {
		num = var_6_2.size,
		name = var_6_2.name
	}))
end

function RecruitSuccubaNormalRewardPop:_updateCost()
	local var_7_0

	if #self._goodList > 1 then
		local var_7_2

		var_7_2, var_7_0 = var_0_1:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)
	else
		local var_7_4

		var_7_4, var_7_0 = var_0_1:getgenRecruitConsume(self._recruitCfg.single_summon_cost)
	end

	self.m_costIcon:setIcon((g.core.common.Path:getIconByTypeValue(var_7_0.type, var_7_0.value, true)))
	self.m_costNumText:setText(g.core.lang:get(400501, {
		num = var_7_0.size
	}))

	if g.core.model.User.bagData:getOwnNum(var_7_0.type, var_7_0.value) < var_7_0.size then
		self.m_costNumText:setColor(g.core.common.Color.A4)
	else
		self.m_costNumText:setColor(g.core.common.Color.A6)
	end
end

function RecruitSuccubaNormalRewardPop:_onClickClose()
	if not self._isClose then
		self._isClose = true

		self:dispatchCompEvent("DailyRecruit_RewardPop_End")
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function RecruitSuccubaNormalRewardPop:_onClickContinue()
	if not var_0_1:isHasSuccubaNormalNum(g.core.model.User.recruitData:getBuyHelper():getRecruitNum(), self._recruitCfg.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(431304))

		return
	end

	if var_0_1:checkIsWishFull(100096, var_0_3.RECRUIT_TYPE.RECRUIT_SUCCUBA) then
		local var_9_0 = g.core.lang:get(108719) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_9_0,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doContinue),
			onCheck = function(arg_10_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_10_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doContinue()
	end
end

function RecruitSuccubaNormalRewardPop:_doContinue()
	local var_11_0 = g.core.model.User.recruitData:getBuyHelper()
	local var_11_1 = g.core.model.User.recruitData:getDrawInfo(var_11_0:getRecruitId())
	local var_11_2 = var_11_1:getCfg()
	local var_11_3 = var_11_0:getRecruitNum()
	local var_11_4

	if var_11_3 == 1 then
		var_11_4 = "single_summon_cost"
	elseif var_11_3 <= 10 then
		var_11_4 = "ten_summon_cost"
	elseif var_11_3 == 20 then
		var_11_4 = "twenty_summon_cost"
	end

	local var_11_5, var_11_6 = var_0_1:getgenRecruitConsume(var_11_2[var_11_4])
	local var_11_7 = var_11_0:getCurBuyItemInfo()
	local var_11_8 = {
		itemInfo = var_11_7,
		recruitType = var_11_0:getRecruitType(),
		consumeType = var_11_6.requestType,
		num = var_11_3,
		recruitId = var_11_0:getRecruitId()
	}

	if var_11_3 <= var_11_1:getLeftFreeTimes() then
		var_11_8.consumeType = 0
		var_11_7 = nil
	end

	self.m_continueBtn:_onDoingClick(var_11_7, var_11_8, 1, 0)
	self:dispatchCompEvent("doRecruitContinue", {
		num = var_11_3
	})
end

function RecruitSuccubaNormalRewardPop:_sendContinue(arg_12_1)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = arg_12_1.recruitId,
		consume_type = arg_12_1.consumeType,
		num = arg_12_1.num
	})
end

function RecruitSuccubaNormalRewardPop:_resRecruit(arg_13_1, arg_13_2, arg_13_3)
	if not self:isVisible() then
		return
	end

	self._param.awards = arg_13_3.awards

	self:initShowList(self._param.awards)
	self:_updateCost()
end

function RecruitSuccubaNormalRewardPop:initShowList(arg_14_1)
	for iter_14_0 = 1, #arg_14_1 do
		local var_14_0 = var_0_0:convert(arg_14_1[iter_14_0])

		if var_14_0.type == var_0_0.TYPE_FRAGMENT then
			-- block empty
		else
			-- block empty
		end

		var_14_0.showIndex = iter_14_0
		self._goodList[iter_14_0] = var_14_0
	end

	self:showReward()
end

function RecruitSuccubaNormalRewardPop:showReward()
	self._popGoodList = {}
	self._curPopIndex = 0

	self:showAwardView()
	self.m_enterTransition:play()
end

function RecruitSuccubaNormalRewardPop:showAwardView()
	if #self._goodList == 1 then
		self.m_numController:setSelectedIndex(0)
		self.m_reward:updateRewardComp(self._goodList[1])
		self.m_reward:playEnterTran()

		self._isPlaying = false

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SingleJiesuan_CN)
	else
		self.m_numController:setSelectedIndex(1)

		for iter_16_0 = 1, 10 do
			local var_16_0 = self["m_reward" .. iter_16_0]

			self.m_enterTransition:setHook(tostring(iter_16_0), function()
				var_16_0:setVisible(true)
				var_16_0:playEnterTran()
			end)
			self["m_reward" .. iter_16_0]:setVisible(false)
			self["m_reward" .. iter_16_0]:updateRewardComp(self._goodList[iter_16_0])
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_MutipleJiesuan_CN)
	end
end

function RecruitSuccubaNormalRewardPop:updateRewardComp()
	return
end

return RecruitSuccubaNormalRewardPop
