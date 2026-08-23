local var_0_0 = g.core.config.play_num_info
local var_0_1 = g.core.config.parameter_info
local var_0_2 = g.core.model.User.towerHardData
local var_0_3 = g.core.lang
local var_0_4 = g.core.model.User.shopData
local var_0_5 = g.core.model.User.bagData
local var_0_6 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_7 = g.core.event.enum
local var_0_8 = g.core.const.ConstMgr
local var_0_9 = g.core.module.ModuleManager
local TowerHardAccelerateCollectionPop = class("TowerHardAccelerateCollectionPop", require("app.fairyGUI.tower.UI_TowerHardAccelerateCollectionPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/tower/tower",
		resName = "TowerHardAccelerateCollectionPop",
		pkgName = "tower",
		isFullScreen = false
	}, ...)
end)

function TowerHardAccelerateCollectionPop:ctor()
	self._rewardList = {}

	self:showAtCenter()
	self:initView()
end

function TowerHardAccelerateCollectionPop:initView()
	self.m_tipTxt:setText(var_0_3:get(308026, {
		num = math.floor(var_0_1.get(var_0_6.TOWER_FIGHT_HARD_HANGUP_ACCELERATE).parameter / 3600)
	}))
	self.m_selectBtn:addClickListener(handler(self, self._onClickBtn))
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRendererRewardItemList))
end

function TowerHardAccelerateCollectionPop:_onRendererRewardItemList(arg_4_1, arg_4_2)
	self._rewardList[arg_4_1 + 1].nameRow = 1

	arg_4_2:updateIcon(self._rewardList[arg_4_1 + 1])
end

function TowerHardAccelerateCollectionPop:_onClickBtn()
	if #self._rewardList == 0 then
		var_0_9:tip(g.core.lang:get(308028))

		return
	end

	local var_5_0 = var_0_8.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT

	if var_0_4:getLeftCount(var_0_8.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT) > 0 then
		g.core.network.GameNetProxy:send_C2S_Tower_HangupQuickAward({
			count = 1,
			play_type = 2
		})

		return
	end

	local var_5_1 = var_0_0.get(var_5_0)
	local var_5_2 = var_0_4:getPlayBuyCount(var_5_0)
	local var_5_3

	if var_5_2 >= var_0_4:getBuyNum(var_5_1.buy_vip_num) then
		var_0_9:tip(g.core.lang:get(1197))

		do return end

		var_5_3 = var_0_5:getOwnNum(var_5_1.price_type, var_5_1.price_value)
	end

	if var_5_3 < var_0_4:getBuyPrice(var_5_1.price_add_id, var_5_2 + 1) then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_5_1.price_type,
			value = var_5_1.price_value,
			size = var_5_3
		})
	else
		g.core.network.GameNetProxy:send_C2S_BuyCommonPlayNum({
			num = 1,
			id = var_5_0
		})
	end
end

function TowerHardAccelerateCollectionPop:onLoad()
	g.core.event.EventManager:addEventListener(var_0_7.EVENT_NET_S2C_TOWER_HANGUPQUICKAWARD, self._onRcvQuickReward, self)
	g.core.event.EventManager:addEventListener(var_0_7.EVENT_NET_S2C_BUY_COMMON_PLAY_NUM, self._onRcvBuyPlayNum, self)
	g.core.event.EventManager:addEventListener(var_0_7.EVENT_CROSS_DAY_NOTIFY, handler(self, self.updateView), self)
	self:updateView()
end

function TowerHardAccelerateCollectionPop:_onRcvBuyPlayNum(arg_7_1, arg_7_2, arg_7_3)
	if var_0_4:getLeftCount(var_0_8.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT) > 0 then
		g.core.network.GameNetProxy:send_C2S_Tower_HangupQuickAward({
			count = 1,
			play_type = 2
		})
	end
end

function TowerHardAccelerateCollectionPop:_onRcvQuickReward(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3 then
		var_0_9:awardSummary(arg_8_3.awards, true)
		self:updateView()
		self:dispatchCompEvent("TowerHardAccelerateCollectionPop_updateCount")
	end
end

function TowerHardAccelerateCollectionPop:updateView()
	local var_9_0 = var_0_0.get(var_0_8.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT)
	local var_9_1 = var_0_4:getLeftCount(var_0_8.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT)
	local var_9_2 = var_0_4:getPlayBuyCount(var_0_8.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT)
	local var_9_3 = var_0_4:getBuyNum(var_9_0.buy_vip_num)
	local var_9_4 = var_9_0.reset + var_9_3
	local var_9_5 = var_9_3 - var_9_2 + var_9_1
	local var_9_6 = 308009

	if var_9_3 <= var_9_2 then
		self.m_isFreeController:setSelectedIndex(2)

		var_9_6 = 308030
	elseif var_9_1 == 0 then
		self.m_resComp:updateByTVS({
			type = var_9_0.price_type,
			value = var_9_0.price_value,
			size = var_0_4:getBuyPrice(var_9_0.price_add_id, var_9_2 + 1)
		})
		self.m_isFreeController:setSelectedIndex(1)
	else
		self.m_isFreeController:setSelectedIndex(0)
	end

	self.m_lastCount:setText(var_0_3:get(var_9_6, {
		num = var_9_5,
		maxCount = var_9_4
	}))

	self._rewardList = var_0_2:getQuickHangupReward()

	self.m_rewardList:setNumItems(#self._rewardList)
end

return TowerHardAccelerateCollectionPop
