local var_0_0 = g.core.const.ConstMgr.SpireConst
local var_0_1 = g.core.model.User.spireData
local SpireCollectPop = class("SpireCollectPop", require("app.fairyGUI.spire.UI_SpireCollectPop"), function()
	return fgui.GComponent:create({
		resName = "SpireCollectPop",
		pkgName = "spire"
	}, ...)
end)

function SpireCollectPop:ctor(arg_2_1)
	self:showAtCenter()

	self._rewardList = {}

	self:_initView()
	self:_initBtn()
	self:_initListView()
end

function SpireCollectPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRE_FASTIDLE, handler(self, self._onRecvFastIdle), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BUY_COMMON_PLAY_NUM, handler(self, self._onRcvBuyPlayNum), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self.updateView), self)
	self:updateView()
	self.m_enterTransition:play()
end

function SpireCollectPop:_initBtn()
	self.m_closeBtn:addClickListener(handler(self, self._onCloseBtnClick))
	self.m_collectBtn:addClickListener(handler(self, self._onCollectBtnClick))
end

function SpireCollectPop:_initListView()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
end

function SpireCollectPop:_onRenderRewardList(arg_6_1, arg_6_2)
	arg_6_2:updateIcon(self._rewardList[arg_6_1 + 1])
end

function SpireCollectPop:_initView()
	self.m_tipText:setText(g.core.lang:get(432017, {
		time = math.floor(g.core.config.spire_parameter_info.get(var_0_0.PARAMETER_IDS.IDLE_SPEED_TIME).parameter / 3600)
	}))
end

function SpireCollectPop:updateView()
	local var_8_0 = g.core.config.play_num_info.get(var_0_0.IDLE_SPEED_TYPE)
	local var_8_1 = g.core.model.User.shopData:getLeftCount(var_0_0.IDLE_SPEED_TYPE)
	local var_8_2 = g.core.model.User.shopData:getPlayBuyCount(var_0_0.IDLE_SPEED_TYPE)
	local var_8_3 = g.core.model.User.shopData:getBuyNum(var_8_0.buy_vip_num)
	local var_8_4 = var_8_0.reset + var_8_3
	local var_8_5 = var_8_3 - var_8_2 + var_8_1
	local var_8_6 = 308009

	if var_8_3 <= var_8_2 then
		self.m_isFreeController:setSelectedIndex(2)

		var_8_6 = 308030
	elseif var_8_1 == 0 then
		self.m_resComp:updateByTVS({
			type = var_8_0.price_type,
			value = var_8_0.price_value,
			size = g.core.model.User.shopData:getBuyPrice(var_8_0.price_add_id, var_8_2 + 1)
		})
		self.m_isFreeController:setSelectedIndex(1)
	else
		self.m_isFreeController:setSelectedIndex(0)
	end

	self.m_lastTimeText:setText(g.core.lang:get(var_8_6, {
		num = var_8_5,
		maxCount = var_8_4
	}))

	local var_8_7, var_8_8 = var_0_1:calculateIdleAwardList()
	local var_8_9 = g.core.config.spire_parameter_info.get(var_0_0.PARAMETER_IDS.IDLE_DELTA_TIME).parameter
	local var_8_10 = g.core.config.spire_parameter_info.get(var_0_0.PARAMETER_IDS.IDLE_SPEED_TIME).parameter

	for iter_8_0 = 1, #var_8_7 do
		var_8_7[iter_8_0].size = math.floor(var_8_7[iter_8_0].addSize * (var_8_10 / var_8_9))
	end

	self._rewardList = var_8_7

	self.m_rewardList:setNumItems(#self._rewardList)
end

function SpireCollectPop:_onRecvFastIdle(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.module.ModuleManager:awardSummary(arg_9_4.awards)
	self:updateView()
end

function SpireCollectPop:_onRcvBuyPlayNum(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if g.core.model.User.shopData:getLeftCount(var_0_0.IDLE_SPEED_TYPE) > 0 then
		g.core.network.GameNetProxy:send_C2S_Spire_FastIdle({})
	end
end

function SpireCollectPop:_onCloseBtnClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function SpireCollectPop:_onCollectBtnClick()
	if not var_0_1:isActivityOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))

		return
	end

	if #self._rewardList == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432009))

		return
	end

	local var_12_0 = var_0_0.IDLE_SPEED_TYPE

	if g.core.model.User.shopData:getLeftCount(var_0_0.IDLE_SPEED_TYPE) > 0 then
		g.core.network.GameNetProxy:send_C2S_Spire_FastIdle({})

		return
	end

	local var_12_1 = g.core.config.play_num_info.get(var_12_0)
	local var_12_2 = g.core.model.User.shopData:getPlayBuyCount(var_12_0)
	local var_12_3

	if var_12_2 >= g.core.model.User.shopData:getBuyNum(var_12_1.buy_vip_num) then
		g.core.module.ModuleManager:tip(g.core.lang:get(1197))

		do return end

		var_12_3 = g.core.model.User.bagData:getOwnNum(var_12_1.price_type, var_12_1.price_value)
	end

	if var_12_3 < g.core.model.User.shopData:getBuyPrice(var_12_1.price_add_id, var_12_2 + 1) then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_12_1.price_type,
			value = var_12_1.price_value,
			size = var_12_3
		})
	else
		g.core.network.GameNetProxy:send_C2S_BuyCommonPlayNum({
			num = 1,
			id = var_12_0
		})
	end
end

return SpireCollectPop
