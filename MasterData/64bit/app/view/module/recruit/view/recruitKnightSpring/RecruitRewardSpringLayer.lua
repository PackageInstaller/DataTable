local RecruitRewardSpringLayer = class("RecruitRewardSpringLayer", require("app.fairyGUI.recruitKnightSpring.UI_RecruitRewardSpringLayer"), function()
	return fgui.GComponent:create({
		resName = "RecruitRewardSpringLayer",
		pkgName = "recruitKnightSpring",
		isFullScreen = true,
		pkgPath = "ui/recruitKnightSpring/recruitKnightSpring"
	}, ...)
end)
local var_0_1 = g.core.model.User.recruitData
local var_0_2 = g.core.const.ConstMgr.RecruitConst
local var_0_5 = g.core.common.Goods
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")

function RecruitRewardSpringLayer:ctor(arg_2_1)
	self._params = arg_2_1
	self._recruitType = arg_2_1.recruit_type
	self._isAdvance = arg_2_1.isAdvance
	self._recruitCfg = arg_2_1.cfg
	self._showRewardIndex = 1
	self._isAnimEnd = false
	self._justShowResult = arg_2_1.justShowResult
	self._hidePop = arg_2_1.hidePop
	self._callBack = arg_2_1.callBack
	self._isShare = arg_2_1.isShare
	self._rewardPos = arg_2_1.pos
	self._matchQuality = arg_2_1.matchQuality or 3

	self:_addListeners()
	self:_init()
	self:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self._onSelfExit))

	local var_2_0 = var_0_2.RECRUIT_TYPE.PRIMARY == self._recruitType

	if var_0_2.RECRUIT_TYPE.PRIMARY == self._recruitType and not arg_2_1.isHideRecruitBtn then
		self.m_canGetPrimaryController:setSelectedIndex(1)
	end

	self._isPrimary = var_2_0

	self.m_tipText:setVisible(not var_2_0 and not self._isShare)
	self.m_shareComp:setVisibleEx(not self._isShare and not var_2_0)

	if not self._isPrimary then
		AutoBuyComp.bindComp(self.m_continueBtn)
		self.m_continueBtn:setAutoBuyCompHandler("clickHandler", handler(self, self._sendContinue))
		self.m_continueBtn:setAutoExchangeEnable(false)
	end
end

function RecruitRewardSpringLayer:_onSelfExit()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_END)
end

function RecruitRewardSpringLayer:_addListeners()
	self:addClickListener(handler(self, self._onOkBtnClick))
	self.m_multRewardShow0Transition:setHook("complete", function()
		self:getView():getTransition("showBtnBox"):play()
	end)
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
	self.m_closeBtn:addClickListener(handler(self, self._onOkBtnClick))
	self.m_continueBtn:addClickListener(handler(self, self._onClickContinueBtn))
	self.m_closeBtn:addClickListener(handler(self, self._onOkBtnClick))
end

function RecruitRewardSpringLayer:_onOkBtnClick()
	if not self._isAnimEnd or self._inShowPop then
		return
	end

	if self._params.isPreLoad then
		self:removeFromParent()
	else
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function RecruitRewardSpringLayer:_onShareClick()
	if not self._isAnimEnd or self._inShowPop then
		return
	end

	local var_7_0 = self.m_tipText:isVisible()

	self.m_shareComp:setVisible(false)
	self.m_tipText:setVisible(false)
	self.m_continueText:setVisible(false)

	local var_7_1 = {}
	local var_7_2 = {}

	for iter_7_0 = 0, 10 do
		local var_7_3, var_7_4 = self["m_itemNode" .. iter_7_0]:getCtrlIndex()

		table.insert(var_7_1, var_7_3)
		table.insert(var_7_2, var_7_4)
		self["m_itemNode" .. iter_7_0]:setCtrlIndex(0, 1)
	end

	local var_7_5 = cc.utils:captureNode(self)

	var_7_5:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_7_5:release()

	for iter_7_1 = 0, 10 do
		self["m_itemNode" .. iter_7_1]:setCtrlIndex(var_7_1[iter_7_1 + 1], var_7_2[iter_7_1 + 1])
	end

	self.m_shareComp:setVisible(true)
	self.m_tipText:setVisible(var_7_0)
	self.m_continueText:setVisible(true)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_0,
		awards = self._params.awards
	})
end

function RecruitRewardSpringLayer:_init()
	local var_8_0 = self:addBg("bg/recruit/bg_zm_juesezhanshi.jpg")

	var_8_0:setOpacity(0)
	var_8_0:runFGAction(fgui.FFadeIn:create(0.4))
	self:_createItems()
	self:_onUpdateTipText()
	self.m_returnBtn:addClickListener(handler(self, self._onReturnBtnClick))
	self.m_reciveBtn:addClickListener(handler(self, self._onReciveBtnClick))
	self:_updateCost()
end

function RecruitRewardSpringLayer:_onUpdateTipText()
	local var_9_0 = var_0_1:getCostInfoId(self._recruitType, #self._params.awards)

	if var_9_0 == 0 then
		self.m_tipText:setText("")

		return
	end

	local var_9_1 = g.core.config.recruit_knight_cost_gain_info.get(var_9_0)
	local var_9_2 = g.core.common.Goods:convert({
		value = var_9_1.gain_value,
		type = var_9_1.gain_type,
		size = var_9_1.gain_size
	})

	self.m_tipText:setText(g.core.lang:get(108046, {
		num = var_9_2.size,
		name = var_9_2.name
	}))
end

function RecruitRewardSpringLayer:onLoad()
	if not self._isPrimary then
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._onS2CNewRecruitRecruit, self)
	end

	self:setVisible(false)
	self:_createKnightPop()

	if self.m_continueBtn:isVisible() then
		self.m_continueBtn:addAutoBuyCompListener()
	end

	if self._params.isPreLoad then
		return
	end

	if not self._isAnimEnd then
		self:_startAction()
	else
		self:setVisible(true)
	end
end

function RecruitRewardSpringLayer:playNewRwd(arg_11_1)
	self._params.awards = arg_11_1
	self._isAnimEnd = false
	self._hidePop = false

	self:_createItems()
	self:_updateCost()
	self:_onUpdateTipText()
	self:_startAction()
end

function RecruitRewardSpringLayer:playShow()
	self:_startAction()
	self:setVisible(true)
end

function RecruitRewardSpringLayer:_startAction()
	for iter_13_0 = 0, 10 do
		self:getChild("itemNode" .. iter_13_0):setOpacity(0)
	end

	self:getView():getTransition("hideBtnBox"):play()
	self:_updateRewardList()

	if self._params.num == 1 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_JIESUAN_SINGLE)
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_JIESUAN_TEN)
	end
end

function RecruitRewardSpringLayer:_createKnightPop()
	if self._knightPop then
		return
	end

	self._knightPop = require("app.view.base.infoPop.KnightShowTimePop").new(nil, nil, true)

	self:addChild(self._knightPop)

	self._inShowPop = false

	self._knightPop:setVisible(self._inShowPop)
end

function RecruitRewardSpringLayer:_createItems()
	self._items = {}

	for iter_15_0 = 1, #self._params.awards do
		local var_15_0 = self:getChild("itemNode" .. iter_15_0)

		if #self._params.awards == 1 then
			var_15_0 = self:getChild("itemNode0")
		end

		local var_15_1 = var_15_0

		var_15_0:updateView(self._params.awards[iter_15_0], self._isShare)

		self._items[iter_15_0] = var_15_1
	end
end

function RecruitRewardSpringLayer:_removeAllItems()
	return
end

function RecruitRewardSpringLayer:_updateRewardList()
	if self._params.num == 1 then
		self.m_isTenController:setSelectedIndex(0)
		self:_onOneCardShow()
	else
		self.m_isTenController:setSelectedIndex(1)

		self._showRewardIndex = 0

		self:_showAllKnightPop()
	end

	self:setVisible(true)
end

function RecruitRewardSpringLayer:_playOneKnightShowTime()
	self._inShowPop = false

	self._knightPop:setVisible(self._inShowPop)
	self.m_multRewardShow0Transition:play(handler(self, self._playOneKnightShowEnd))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_KNIGHT_ONE_REWARD_SHOW)
end

function RecruitRewardSpringLayer:_playOneKnightShowEnd()
	self.m_itemNode0.playEffectSpineAction(self.m_itemNode0, self.m_itemNode0)
	self:_onAllAnimEnd()
end

function RecruitRewardSpringLayer:_onOneCardShow()
	if self._params.awards[1].type == var_0_5.TYPE_KNIGHT then
		if not self._hidePop then
			local var_20_0 = self._isPrimary and not self._rewardPos and not self._isShare

			self._knightPop:updatePop({
				knightId = self._params.awards[1].value,
				isNew = self._params.awards[1].isNew,
				hideFrag = var_20_0,
				callBack = handler(self, self._playOneKnightShowTime)
			})

			self._inShowPop = true

			self._knightPop:setVisible(self._inShowPop)
			self._knightPop:playNextKnight()
		else
			self:_playOneKnightShowTime()
		end
	else
		self:showNextReward()
	end
end

function RecruitRewardSpringLayer:showNextReward()
	self._showRewardIndex = self._showRewardIndex + 1

	if self._showRewardIndex > #self._params.awards then
		self:getView():getTransition("showBtnBox"):play()
		self:_onAllAnimEnd()

		return
	end

	self._items[self._showRewardIndex]:updateView(self._params.awards[self._showRewardIndex], self._isShare)
end

function RecruitRewardSpringLayer:_showAllKnightPop()
	local var_22_0 = {}

	if not self._hidePop then
		local var_22_1 = g.core.config.parameter_info.get(var_0_2.KNIGHT_NEW_SHOW_LIMIT_QUALITY_ID).parameter

		for iter_22_0, iter_22_1 in ipairs(self._params.awards) do
			local var_22_2 = var_0_5:convert(iter_22_1)
			local var_22_3 = iter_22_1.isNew and var_22_1 <= var_22_2.quality

			if iter_22_1.type == var_0_5.TYPE_KNIGHT and (var_22_3 or var_22_2.quality >= self._matchQuality) then
				table.insert(var_22_0, {
					knightId = iter_22_1.value,
					quality = var_22_2.quality,
					isNew = var_22_3,
					hideFrag = iter_22_1.hideFrag
				})
			end
		end
	end

	local function var_22_4()
		self._inShowPop = false

		self._knightPop:setVisible(self._inShowPop)
		self:runFGAction((fgui.FSequence:create(fgui.FDelayTime:create(0.025), fgui.FCallFunc:create(function()
			self:showNextKnightShowPop()
		end))))
	end

	self._showRewardIndex = #self._params.awards

	if #var_22_0 > 0 then
		self._knightPop:updatePop({
			callBack = var_22_4
		}, var_22_0)

		self._inShowPop = true

		self._knightPop:setVisible(self._inShowPop)
		self._knightPop:playNextKnight()
	else
		self:showNextKnightShowPop()
	end
end

function RecruitRewardSpringLayer:showNextKnightShowPop()
	self._showRewardIndex = self._showRewardIndex + 1

	if self._showRewardIndex > #self._params.awards then
		self:_showAllItem()

		return
	end

	local var_25_0 = self._params.awards[self._showRewardIndex]

	if self._params.awards[self._showRewardIndex].type == var_0_5.TYPE_KNIGHT then
		if not var_25_0.isNew then
			if var_0_5:convert(self._params.awards[self._showRewardIndex]).quality >= self._matchQuality then
				local var_25_1 = {
					knightId = var_25_0.value
				}

				function var_25_1.callBack()
					self._inShowPop = false

					self._knightPop:setVisible(self._inShowPop)
					self:runFGAction((fgui.FSequence:create(fgui.FDelayTime:create(0.025), fgui.FCallFunc:create(function()
						self:showNextKnightShowPop()
					end))))
				end

				var_25_1.hideFrag = var_25_0.hideFrag
				var_25_1.isNew = var_25_0.isNew

				self._knightPop:updatePop(var_25_1)

				self._inShowPop = true

				self._knightPop:setVisible(self._inShowPop)
				self._knightPop:playNextKnight()

				goto label_25_0
			end
		end
	end

	self:showNextKnightShowPop()

	::label_25_0::
end

function RecruitRewardSpringLayer:_showAllItem()
	local var_28_0 = self.m_multRewardShow1Transition
	local var_28_1 = g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_KNIGHT_TEN_REWARD_SHOW

	if self._params.num == 1 then
		var_28_0 = self.m_multRewardShow0Transition
		var_28_1 = g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_KNIGHT_ONE_REWARD_SHOW
	end

	var_28_0:play(handler(self, self._onAllAnimEnd))
	g.core.sound.SoundManager:playSound(var_28_1)
end

function RecruitRewardSpringLayer:_onAllAnimEnd()
	for iter_29_0, iter_29_1 in ipairs(self._items) do
		iter_29_1:showRewardChangeAnim()
	end

	g.core.model.User.UserTitleData:checkScorePush()

	self._isAnimEnd = true
end

function RecruitRewardSpringLayer:onUnload()
	self:_removeAllItems()

	if self._callBack then
		self._callBack()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RECRUIT_REWARD_REMOVED)
end

function RecruitRewardSpringLayer:_onReturnBtnClick()
	g.core.module.ModuleManager:popComponent()
end

function RecruitRewardSpringLayer:_onReciveBtnClick()
	local var_32_0 = self._rewardPos
	local var_32_1 = g.core.lang:get(108441) or ""

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(108438),
		desc = var_32_1,
		onConfirm = function()
			g.core.module.ModuleManager:popComponent()
			g.core.network.GameNetProxy:send_C2S_NewRecruit_NoviceTenAward({
				pos = var_32_0
			})
		end
	}), {
		touchDisappear = true
	})
end

function RecruitRewardSpringLayer:_updateCost()
	if not self._recruitCfg or self._justShowResult then
		self.m_isHideBtnGroupController:setSelectedIndex(1)

		return
	end

	local var_34_0

	if #self._params.awards > 1 then
		local var_34_2

		var_34_2, var_34_0 = var_0_1:getgenRecruitConsume(self._recruitCfg.ten_summon_cost)
	else
		local var_34_4

		var_34_4, var_34_0 = var_0_1:getgenRecruitConsume(self._recruitCfg.single_summon_cost)
	end

	self.m_costIcon:setIcon((g.core.common.Path:getIconByTypeValue(var_34_0.type, var_34_0.value, true)))
	self.m_costNumText:setText(g.core.lang:get(400501, {
		num = var_34_0.size
	}))

	if g.core.model.User.bagData:getOwnNum(var_34_0.type, var_34_0.value) < var_34_0.size then
		self.m_costNumText:setColor(g.core.common.Color.A4)
	else
		self.m_costNumText:setColor(g.core.common.Color.A6)
	end

	self.m_isHideBtnGroupController:setSelectedIndex(0)
end

function RecruitRewardSpringLayer:_onClickContinueBtn()
	if not self._isAnimEnd or self._inShowPop then
		return
	end

	local var_35_0 = g.core.model.User.recruitData:getBuyHelper()
	local var_35_1 = g.core.model.User.recruitData:getDrawInfo(var_35_0:getRecruitId())
	local var_35_2 = var_35_1:getDailyLimitNum()

	if var_35_2 - var_35_1:getDailyCount() < var_35_0:getRecruitNum() then
		g.core.module.ModuleManager:tip((g.core.lang:get(108413, {
			name = g.core.model.User.recruitData:getDisplayInfoById(self._recruitCfg.id).cfg.name,
			num = var_35_2
		})))

		return
	end

	if var_0_1:checkIsFull(self._recruitCfg) then
		local var_35_4 = g.core.lang:get(108608) or ""

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = var_35_4,
			tip = {
				txt = g.core.lang:get(108045)
			},
			onConfirm = handler(self, self._doContinue),
			onCheck = function(arg_36_0)
				g.core.model.User.recruitData:setIgnoreFragTip(arg_36_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:_doContinue()
	end
end

function RecruitRewardSpringLayer:_doContinue()
	local var_37_0 = g.core.model.User.recruitData:getBuyHelper()
	local var_37_1 = g.core.model.User.recruitData:getDrawInfo(var_37_0:getRecruitId())
	local var_37_2 = var_37_1:getCfg()
	local var_37_3 = var_37_0:getRecruitNum()
	local var_37_4

	if var_37_3 == 1 then
		var_37_4 = "single_summon_cost"
	elseif var_37_3 <= 10 then
		var_37_4 = "ten_summon_cost"
	elseif var_37_3 == 20 then
		var_37_4 = "twenty_summon_cost"
	end

	local var_37_5, var_37_6 = var_0_1:getgenRecruitConsume(var_37_2[var_37_4])
	local var_37_7 = var_37_0:getCurBuyItemInfo(var_37_2.id)
	local var_37_8 = {
		itemInfo = var_37_7,
		recruitType = var_37_0:getRecruitType(),
		consumeType = var_37_6.requestType,
		num = var_37_3,
		recruitId = var_37_0:getRecruitId()
	}

	if var_37_3 <= var_37_1:getLeftFreeTimes() then
		var_37_8.consumeType = 0
		var_37_7 = nil
	end

	self.m_continueBtn:_onDoingClick(var_37_7, var_37_8, 1, 0)
	self:dispatchCompEvent("doRecruitContinue", {
		num = var_37_0:getRecruitNum()
	})
end

function RecruitRewardSpringLayer:_sendContinue(arg_38_1)
	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		recruit_type = arg_38_1.recruitId,
		consume_type = arg_38_1.consumeType,
		num = arg_38_1.num
	})
end

function RecruitRewardSpringLayer:_onS2CNewRecruitRecruit(arg_39_1, arg_39_2, arg_39_3)
	if not self:isVisible() then
		return
	end

	local var_39_0 = arg_39_3.awards

	for iter_39_0 = 1, #arg_39_3.awards do
		local var_39_1 = var_0_5:convert(var_39_0[iter_39_0])

		var_39_0[iter_39_0].isNew = g.core.model.User.recruitData:checkIsNew(var_39_0[iter_39_0].value)
		var_39_0[iter_39_0].id = iter_39_0
	end

	self:playNewRwd(var_39_0)
end

return RecruitRewardSpringLayer
