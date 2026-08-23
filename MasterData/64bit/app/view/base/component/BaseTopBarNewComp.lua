local BaseTopBarNewComp = class("BaseTopBarNewComp", require("app.fairyGUI.base_new.UI_BaseTopBarComp"))
local var_0_1 = g.core.const.ConstMgr.PushGiftConst

BaseTopBarNewComp.MAX_NUM = 5

local var_0_2 = g.core.config.resouce_interface_info

function BaseTopBarNewComp:ctor()
	self._helpId = 0
	self._homeBtnCallBack = nil

	self:_addListener()
	self:_bangsFit()
	self:_initDefaultRes()
	self.m_helpHideController:setSelectedIndex(1)
	self:playShowAction()
	self.m_returnBtn:setSound()

	self._resPosMap = {}

	self:_initPushGiftBtn()
	self:_initPrimaryDrawBtn()
end

function BaseTopBarNewComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self._onS2COpObject), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._updatePushGiftBtn), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._updatePushGiftBtn), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_AWARD, handler(self, self._updatePushGiftBtn), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_END, self._updateByStoryEnd, self)
	self:updateResource(false)

	if not g.core.battle.BattleProxy:isInBattle() then
		self.m_enterTransition:play()
	end

	g.core.model.User.pushGiftData:checkValidData()
	self:_updatePushGiftBtn()
	self:_updatePrimaryDrawBtn()
end

function BaseTopBarNewComp:onUnload()
	self:_cancelPushGiftSchedule()
end

function BaseTopBarNewComp:setBackHomeBtnShowState(arg_4_1, arg_4_2, arg_4_3)
	self.m_returnBtn:setVisible(arg_4_1)
	self:getChild("title"):setVisible(arg_4_1)

	if arg_4_2 == nil then
		arg_4_2 = arg_4_1
	end

	if arg_4_3 == nil then
		arg_4_3 = arg_4_1
	end

	self.m_homeBtn:setVisible(arg_4_2)
	self.m_helpBtn:setVisible(arg_4_3)
end

function BaseTopBarNewComp:hideHomeBtn()
	self.m_homeHideController:setSelectedIndex(1)
end

function BaseTopBarNewComp:_bangsFit()
	local var_6_0 = cc.Director:getInstance():getSafeAreaRect()

	if var_6_0.x > 0 then
		self:setWidth(self:getWidth() - var_6_0.x)
	end
end

function BaseTopBarNewComp:_initDefaultRes()
	self.m_resComp1:updateResBtn({
		value = 0,
		type = g.core.common.Goods.TYPE_GOLD
	})
	self.m_resComp2:updateResBtn({
		value = g.core.common.Goods.RESOURCE.TYPE_COIN
	})
	self.m_resComp3:updateResBtn({
		value = g.core.common.Goods.RESOURCE.TYPE_STAMINA
	})
end

function BaseTopBarNewComp:_addListener()
	self.m_returnBtn:removeClickListener(3)
	self.m_returnBtn:removeClickListener(1)
	self.m_returnBtn:addClickListener(handler(self, self.checkFullPageExitAnim), 1)
	self.m_homeBtn:addClickListener(handler(self, function()
		if self._homeBtnCallBack then
			self._homeBtnCallBack()
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
		end
	end), 2)
	self.m_helpBtn:addClickListener(handler(self, self._onClickHelpBtn))
end

function BaseTopBarNewComp:updateTopRes(arg_10_1)
	arg_10_1 = arg_10_1 or {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if iter_10_1.type and iter_10_1.value then
			self._resPosMap[iter_10_1.type .. "_" .. iter_10_1.value] = iter_10_0

			self["m_resComp" .. iter_10_0]:updateResBtn(iter_10_1)
		end
	end

	self.m_resCountController:setSelectedIndex(#arg_10_1)
end

function BaseTopBarNewComp:setResInfoById(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = var_0_2.get(arg_11_1)
	local var_11_1 = {}

	for iter_11_0 = 4, 1, -1 do
		if var_11_0["itemline_type" .. iter_11_0] ~= 0 then
			table.insert(var_11_1, {
				type = var_11_0["itemline_type" .. iter_11_0],
				value = var_11_0["itemline_value" .. iter_11_0],
				runChangeAni = arg_11_2
			})
		end
	end

	if arg_11_3 then
		for iter_11_1, iter_11_2 in ipairs(arg_11_3) do
			var_11_1[#var_11_1 + 1] = iter_11_2
		end
	end

	self:updateTopRes(var_11_1)

	if var_11_0.help_id > 0 then
		self:setHelpId(var_11_0.help_id)
	else
		self.m_helpHideController:setSelectedIndex(1)
	end
end

function BaseTopBarNewComp:getResComWorldPos(arg_12_1)
	if arg_12_1 and self._resPosMap[arg_12_1.type .. "_" .. arg_12_1.value] then
		return self["m_resComp" .. (arg_12_1 and self._resPosMap[arg_12_1.type .. "_" .. arg_12_1.value])]:localToGlobal(cc.p(15, 16))
	end
end

function BaseTopBarNewComp:playIconEffect(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1 and self._resPosMap[arg_13_1.type .. "_" .. arg_13_1.value]

	if arg_13_1 and self._resPosMap[arg_13_1.type .. "_" .. arg_13_1.value] and self["m_resComp" .. var_13_0] then
		self["m_resComp" .. var_13_0]:playIconEffect(arg_13_2, arg_13_3)
	end
end

function BaseTopBarNewComp:_onS2COpObject(arg_14_1)
	self:updateResource(true)
end

function BaseTopBarNewComp:updateResource(arg_15_1)
	for iter_15_0 = 1, BaseTopBarNewComp.MAX_NUM do
		self["m_resComp" .. iter_15_0]:updateResNum(arg_15_1)
	end
end

function BaseTopBarNewComp:setReturnCallBack(arg_16_1)
	self.m_returnBtn:removeClickListener(1)
	self.m_returnBtn:removeClickListener(3)
	self.m_returnBtn:addClickListener(function()
		arg_16_1()
	end, 3)
end

function BaseTopBarNewComp:setTopIconGroupVisible(arg_18_1)
	self:getChild("n16"):setVisible(arg_18_1)
end

function BaseTopBarNewComp:setReturnAnimAndCallBack(arg_19_1, arg_19_2, arg_19_3)
	if not arg_19_1 then
		return
	end

	self.m_returnBtn:removeClickListener(1)
	self.m_returnBtn:removeClickListener(3)

	local function var_19_0()
		self:playHideAction()

		if arg_19_3 then
			arg_19_3()
		else
			self:checkFullPageExitAnim()
		end
	end

	if arg_19_2 then
		self.m_returnBtn:addClickListener(function()
			arg_19_1:setHook(arg_19_2, function()
				var_19_0()
			end)
			arg_19_1:play()
			self.m_backTransition:play()
		end, 3)
	else
		self.m_returnBtn:addClickListener(function()
			self.m_backTransition:play()
			arg_19_1:play(function()
				var_19_0()
			end)
		end, 3)
	end
end

function BaseTopBarNewComp:playExitTransition()
	self:checkFullPageExitAnim()
end

function BaseTopBarNewComp:setHomeCallBack(arg_26_1)
	self._homeBtnCallBack = arg_26_1
end

function BaseTopBarNewComp:setHelpId(arg_27_1)
	self._helpId = arg_27_1

	self.m_helpHideController:setSelectedIndex(0)
end

function BaseTopBarNewComp:_onClickHelpBtn()
	if self._helpId and self._helpId > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
			id = self._helpId
		}), {
			touchDisappear = true
		})
	end
end

function BaseTopBarNewComp:setDefaultResNum(arg_29_1)
	if self.m_resCountController then
		self.m_resCountController:setSelectedIndex(arg_29_1)
	end
end

function BaseTopBarNewComp:playHideAction()
	self:stopAllFGActions()
	self.m_enterTransition:stop()
	self.m_backTransition:play()
end

function BaseTopBarNewComp:playShowAction()
	self:stopAllFGActions()
	self.m_backTransition:stop()
	self.m_enterTransition:play()
end

function BaseTopBarNewComp:checkFullPageExitAnim()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)

	if g.core.module.ModuleManager:getPreviousModule() then
		g.core.module.ModuleManager:popModule()
	else
		local var_32_0 = g.core.module.ModuleManager:getCurModule()

		if var_32_0 and var_32_0.module and var_32_0.module.previous then
			g.core.module.ModuleManager:popModule()
		else
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
		end
	end
end

function BaseTopBarNewComp:_initPushGiftBtn()
	self._pushEffect = nil
	self._pushEffectComp = self.m_pushGiftBtn:getChild("effectComp")

	self.m_pushGiftBtn:addClickListener(handler(self, self._onClickPushGiftBtn))

	if self.m_titleHideController:getSelectedIndex() == 0 then
		self:hidePushGift()
	end
end

function BaseTopBarNewComp:_initPrimaryDrawBtn()
	self.m_primaryDrawBtn:addClickListener(handler(self, self._onClickPrimaryDrawBtn))
	self.m_primaryDrawBtn:getChild("redPointCompNew"):setId(self.m_primaryDrawBtn:getChild("redPointComp"):getId())
end

function BaseTopBarNewComp:_onClickPrimaryDrawBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.PRIMARY_RECRUIT)
end

function BaseTopBarNewComp:_updatePrimaryDrawBtn()
	self.m_primaryDrawBtn:setVisible(false)

	local var_36_0 = g.core.module.ModuleManager:getCurModule()

	if not var_36_0 then
		return
	end

	if var_36_0.module == g.view.entrance.DUNGEON and g.core.model.User.recruitData:checkPrimaryBtnIsShow() then
		self.m_primaryDrawBtn:setVisible(true)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_primaryDrawBtn:getChild("redPointCompNew"),
			customData = {
				needRefresh = true
			}
		})
		self:checkPrimaryGuide()
	end
end

function BaseTopBarNewComp:checkPrimaryGuide()
	if self.m_primaryDrawBtn:isVisible() then
		if self.m_primaryDrawBtn:getChild("redPointCompNew"):getRedPointStyle() == 2 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "DUNGEON_PRIMARY_ENTRANCE_GUIDE",
				targetBtn = self.m_primaryDrawBtn
			})
		end
	end
end

function BaseTopBarNewComp:_isSpecialModule()
	local var_38_0 = g.core.module.ModuleManager:getCurModule()

	if not var_38_0 then
		return false
	end

	local var_38_1 = var_38_0.module

	if var_38_0.module == g.view.entrance.DUNGEON or var_38_1 == g.view.entrance.DUNGEON_STAGE or var_38_1 == g.view.entrance.RECRUIT then
		self._hidePushGift = false

		return true
	end

	return false
end

function BaseTopBarNewComp:_updatePushGiftBtn()
	self._isSpecial = self:_isSpecialModule()

	self.m_newPushGiftController:setSelectedIndex(self._isSpecial and 1 or 0)

	local var_39_0 = g.core.model.User.pushGiftData:getHasNew()

	if self._isSpecial then
		var_39_0 = g.core.model.User.pushGiftData:isShowPushGift()
	end

	if var_39_0 and not self._hidePushGift then
		self:_updatePushGiftCountDown()

		self._pushSchedule = self._pushSchedule or self:newSchedule(handler(self, function()
			self:_updatePushGiftCountDown()
		end), 1)
		self._pushEffect = self._pushEffect or self._pushEffectComp:addEffectSpine({
			isLoop = true,
			name = "eff_ui_pushGift_idle",
			scale = 1
		})

		if g.core.model.User.pushGiftData:getTriggerIconState() then
			self.m_pushGiftBtn:getTransition("enterPushGift"):play()
			self._pushEffectComp:addEffectSpine({
				isLoop = false,
				name = "eff_ui_mainlayer_pushGift",
				remove = true,
				scale = 1
			})
			g.core.model.User.pushGiftData:setTriggerIconState(false)
		end

		self.m_pushGiftShowController:setSelectedIndex(1)
	else
		self.m_pushGiftShowController:setSelectedIndex(0)
	end

	if self._isSpecial and var_39_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_pushGiftRedPointComp
		})
	end
end

function BaseTopBarNewComp:_updatePushGiftCountDown()
	local var_41_0 = g.core.model.User.pushGiftData:getShortTimeGift()

	if var_41_0 then
		local var_41_1 = g.core.model.User.pushGiftData:getPushGiftContentInfo(var_41_0.gift_id)

		if not var_41_1 then
			return
		end

		local var_41_2 = var_41_0.create_time + var_41_1.gift_time_limit - g.core.common.ServerTime:getTime()

		if var_41_2 > 0 then
			self.m_pushGiftBtn:getChild("timeTxt"):setVisible(true)
			self.m_pushGiftBtn:getChild("timeTxt"):setText((g.core.common.ServerTime:_secondToString(var_41_2)))
		else
			self:_cancelPushGiftSchedule()
		end
	else
		self:_cancelPushGiftSchedule()
	end
end

function BaseTopBarNewComp:_cancelPushGiftSchedule()
	if self._pushSchedule then
		self:cancelSchedule(self._pushSchedule)

		self._pushSchedule = nil
	end

	self.m_pushGiftShowController:setSelectedIndex(0)
end

function BaseTopBarNewComp:hidePushGift()
	self._hidePushGift = true

	self.m_pushGiftShowController:setSelectedIndex(0)
end

function BaseTopBarNewComp:_updateByStoryEnd(arg_44_1, arg_44_2)
	if arg_44_2.id and arg_44_2.id == var_0_1.FRIST_PUSHGIFT_AVG_ID then
		g.core.model.User.pushGiftData:setFirstPushGiftAvgShow()

		if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.PUSH_GIFT, nil, true) and not g.core.guide.GuideProxy:isGuideRunning() then
			g.core.module.ModuleManager:pushModule(g.view.entrance.PUSH_GIFT)
		end
	end
end

function BaseTopBarNewComp:_onClickPushGiftBtn()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.PUSH_GIFT, nil, true) then
		if g.core.model.User.pushGiftData:isFirstPushGiftAvgShow() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
				id = var_0_1.FRIST_PUSHGIFT_AVG_ID
			})
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.PUSH_GIFT)
		end
	end
end

function BaseTopBarNewComp:getMatchResCompList(arg_46_1)
	dump(arg_46_1)

	local var_46_0 = {}

	for iter_46_0 = 1, 5 do
		for iter_46_1 = 1, #arg_46_1 do
			if self["m_resComp" .. iter_46_0] and self["m_resComp" .. iter_46_0]:isMatchRes(arg_46_1[iter_46_1]) then
				table.insert(var_46_0, self["m_resComp" .. iter_46_0])
			end
		end
	end

	dump(var_46_0)

	return var_46_0
end

function BaseTopBarNewComp:resumeReturnClickLister()
	self.m_returnBtn:removeClickListener(3)
	self.m_returnBtn:removeClickListener(1)
	self.m_returnBtn:addClickListener(handler(self, self.checkFullPageExitAnim), 1)
end

return BaseTopBarNewComp
