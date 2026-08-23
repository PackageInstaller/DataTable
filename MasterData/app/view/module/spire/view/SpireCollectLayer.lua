local var_0_0 = g.core.const.ConstMgr.SpireConst
local var_0_1 = g.core.model.User.spireData
local var_0_2 = g.core.model.User.bagData
local var_0_3 = g.core.model.User.shopData
local var_0_4 = g.core.config.play_num_info
local SpireCollectLayer = class("SpireCollectLayer", require("app.fairyGUI.spire.UI_SpireCollectLayer"), function()
	return fgui.GComponent:create({
		resName = "SpireCollectLayer",
		pkgPath = "ui/spire/spire",
		isFullScreen = true,
		pkgName = "spire"
	}, ...)
end)

function SpireCollectLayer:ctor(arg_2_1)
	self._addItemList = {}
	self._itemList = {}
	self._haveQuickTime = true

	self:_initListView()
	self:_initBtn()
	self:_initView()
end

function SpireCollectLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRE_IDLEINFO, handler(self, self._onRecvIdleInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRE_IDLEAWARD, handler(self, self._onRecvIdleAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self.updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRE_FASTIDLE, handler(self, self._onRecvFastIdle), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BUY_COMMON_PLAY_NUM, handler(self, self._onRcvBuyPlayNum), self)
	g.core.network.GameNetProxy:send_C2S_Spire_IdleInfo({})
	self:updateView()
	self.m_enterTransition:play()
end

function SpireCollectLayer:onUnload()
	if self._timeSchedule then
		self:cancelSchedule(self._timeSchedule)

		self._timeSchedule = nil
	end
end

function SpireCollectLayer:_initBtn()
	self.m_quickAwardBtn:addClickListener(handler(self, self._onQuickAwardBtnClick))
	self.m_getAwardBtn:addClickListener(handler(self, self._onGetAwardBtnClick))
end

function SpireCollectLayer:_initListView()
	self.m_addItemList:setVirtual()
	self.m_addItemList:setItemRenderer(handler(self, self._onRenderAddItemList))
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onRenderItemList))
end

function SpireCollectLayer:_onRenderAddItemList(arg_7_1, arg_7_2)
	arg_7_2:updateComp(self._addItemList[arg_7_1 + 1], false)
end

function SpireCollectLayer:_onRenderItemList(arg_8_1, arg_8_2)
	if self._itemList[arg_8_1 + 1] then
		arg_8_2:getChild("showItem"):updateIcon(self._itemList[arg_8_1 + 1])
		arg_8_2:getController("isNull"):setSelectedIndex(1)
	else
		arg_8_2:getController("isNull"):setSelectedIndex(0)
	end
end

function SpireCollectLayer:_initView(arg_9_1)
	self:addBg("bg/spire/bg_shmc_guaji.jpg")
	self.m_topBarComp:setResInfoById(var_0_0.MAIN_TOP_BAR_ID)
	self.m_titleEff:addEffectSpine({
		anim = "play",
		name = "eff_ui_spire_boxtitle",
		isLoop = true
	})
	self.m_itemList:setNumItems(var_0_0.IDEL_AWARD_SHOW_NUM)
	self.m_tipTxt:setText(g.core.lang:get(432017, {
		time = math.floor(g.core.config.spire_parameter_info.get(var_0_0.PARAMETER_IDS.IDLE_SPEED_TIME).parameter / 3600)
	}))
end

function SpireCollectLayer:updateView()
	if not g.core.model.User.spireData:isActivityOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	self._addItemList, self._itemList = var_0_1:calculateIdleAwardList()

	self:checkIdleWaitTime()
	self.m_isAddItemController:setSelectedIndex(#self._addItemList > 0 and 0 or 1)
	self.m_isRewardController:setSelectedIndex(#self._itemList > 0 and 0 or 1)
	self.m_addItemList:setNumItems(#self._addItemList)
	self.m_itemList:setNumItems(var_0_0.IDEL_AWARD_SHOW_NUM)

	local var_10_0 = var_0_1:getIdleStartTime()
	local var_10_1 = g.core.config.spire_parameter_info.get(var_0_0.PARAMETER_IDS.IDLE_TIME_MAX).parameter

	self.m_curTimetext:setText(g.core.common.ServerTime:secondToHMSString(math.min(var_10_0 == 0 and 0 or math.abs(g.core.common.ServerTime:getLeftSeconds(var_10_0)), var_10_1)))
	self.m_totalTimeText:setText("/" .. g.core.common.ServerTime:secondToHMSString(var_10_1))
	self:updateTimesView()

	self._timeSchedule = self._timeSchedule or self:newSchedule(handler(self, self._updateTimer), 1)
end

function SpireCollectLayer:checkIdleWaitTime()
	if var_0_1:getIdleStartTime() + g.core.config.spire_parameter_info.get(var_0_0.PARAMETER_IDS.IDLE_NOT_SHOW_TIME).parameter > g.core.common.ServerTime:getTime() then
		self._itemList = {}
	end
end

function SpireCollectLayer:_updateTimer()
	local var_12_0 = var_0_1:getIdleStartTime()

	self.m_curTimetext:setText(g.core.common.ServerTime:secondToHMSString(math.min(var_12_0 == 0 and 0 or math.abs(g.core.common.ServerTime:getLeftSeconds(var_12_0)), g.core.config.spire_parameter_info.get(var_0_0.PARAMETER_IDS.IDLE_TIME_MAX).parameter)))

	self._addItemList, self._itemList = var_0_1:calculateIdleAwardList()

	self:checkIdleWaitTime()
	self.m_isRewardController:setSelectedIndex(#self._itemList > 0 and 0 or 1)
	self.m_itemList:setNumItems(var_0_0.IDEL_AWARD_SHOW_NUM)
end

function SpireCollectLayer:updateTimesView()
	local var_13_0 = g.core.config.play_num_info.get(var_0_0.IDLE_SPEED_TYPE)
	local var_13_1 = g.core.model.User.shopData:getLeftCount(var_0_0.IDLE_SPEED_TYPE)
	local var_13_2 = g.core.model.User.shopData:getPlayBuyCount(var_0_0.IDLE_SPEED_TYPE)
	local var_13_3 = g.core.model.User.shopData:getBuyNum(var_13_0.buy_vip_num)

	self._haveQuickTime = true

	if var_13_3 <= var_13_2 then
		self._haveQuickTime = false

		self.m_isFreeController:setSelectedIndex(2)
	elseif var_13_1 == 0 then
		self.m_resComp:updateByTVS({
			type = var_13_0.price_type,
			value = var_13_0.price_value,
			size = g.core.model.User.shopData:getBuyPrice(var_13_0.price_add_id, var_13_2 + 1)
		})
		self.m_isFreeController:setSelectedIndex(1)
	else
		self.m_isFreeController:setSelectedIndex(0)
	end

	local var_13_4 = var_13_0.reset + var_13_3

	self.m_lastCount:setText(g.core.lang:get((var_13_3 <= var_13_2 or nil) and 308030, {
		num = var_13_3 - var_13_2 + var_13_1,
		maxCount = var_13_4
	}))
end

function SpireCollectLayer:_onRecvIdleInfo(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self:updateView()
end

function SpireCollectLayer:_onRecvIdleAward(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	g.core.module.ModuleManager:awardSummary(arg_15_4.awards)
	self:updateView()
end

function SpireCollectLayer:_onRcvBuyPlayNum(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if var_0_3:getLeftCount(var_0_0.IDLE_SPEED_TYPE) > 0 then
		g.core.network.GameNetProxy:send_C2S_Spire_FastIdle({})
	end
end

function SpireCollectLayer:_onRecvFastIdle(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	g.core.module.ModuleManager:awardSummary(arg_17_4.awards)
	self:updateView()
end

function SpireCollectLayer:_onModuleExit()
	self:updateTimesView()
end

function SpireCollectLayer:_onQuickAwardBtnClick()
	if not var_0_1:isActivityOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))

		return
	end

	if #self._addItemList == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432009))

		return
	end

	if not self._haveQuickTime then
		g.core.module.ModuleManager:tip(g.core.lang:get(432029))

		return
	end

	local var_19_0 = var_0_0.IDLE_SPEED_TYPE

	if var_0_3:getLeftCount(var_0_0.IDLE_SPEED_TYPE) > 0 then
		g.core.network.GameNetProxy:send_C2S_Spire_FastIdle({})

		return
	end

	local var_19_1 = var_0_4.get(var_19_0)
	local var_19_2 = var_0_2:getOwnNum(var_19_1.price_type, var_19_1.price_value)

	if var_19_2 < var_0_3:getBuyPrice(var_19_1.price_add_id, var_0_3:getPlayBuyCount(var_19_0) + 1) then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_19_1.price_type,
			value = var_19_1.price_value,
			size = var_19_2
		})
	else
		g.core.network.GameNetProxy:send_C2S_BuyCommonPlayNum({
			num = 1,
			id = var_19_0
		})
	end
end

function SpireCollectLayer:_onGetAwardBtnClick()
	if not var_0_1:isActivityOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))

		return
	end

	if #self._addItemList == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432009))

		return
	end

	local var_20_0 = 0

	for iter_20_0, iter_20_1 in ipairs(self._itemList or {}) do
		var_20_0 = var_20_0 + iter_20_1.size
	end

	if var_20_0 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432028))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Spire_IdleAward({})
end

return SpireCollectLayer
