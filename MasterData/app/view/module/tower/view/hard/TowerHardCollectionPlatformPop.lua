local var_0_0 = g.core.config.play_num_info
local var_0_1 = g.core.config.parameter_info
local var_0_2 = g.core.model.User.shopData
local var_0_3 = g.core.model.User.towerHardData
local var_0_4 = g.core.model.User.bagData
local var_0_5 = g.core.common.ServerTime
local var_0_6 = g.core.module.ModuleManager
local var_0_7 = g.core.const.ConstMgr
local var_0_8 = g.core.lang
local TowerHardCollectionPlatformPop = class("TowerHardCollectionPlatformPop", require("app.fairyGUI.tower.UI_TowerHardCollectionPlatformPop"), function()
	return fgui.GComponent:create({
		resName = "TowerHardCollectionPlatformPop",
		pkgPath = "ui/tower/tower",
		isFullScreen = true,
		pkgName = "tower"
	}, ...)
end)

function TowerHardCollectionPlatformPop:ctor()
	self._addItemList = {}

	self:initView()
end

function TowerHardCollectionPlatformPop:initView()
	self.m_addItemList:setVirtual()
	self.m_addItemList:setItemRenderer(handler(self, self._onRendererAddItemList))
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onRendererRewardItemList))
	self.m_accelerateBtn:addClickListener(handler(self, self._onClickAccelerateBtn))
	self.m_getAward:addClickListener(handler(self, self._onClickGetAwardBtn))
	self.m_resComp:setTitleNormalColor(2)
	self.m_huawenLoader:setURL("pic/base_new/pic_yht_huawen.png")

	local var_3_0, var_3_1 = var_0_3:getHangUpTimeHours()

	self.m_TotalTime:setText("/" .. var_0_5:secondToHMSString(var_3_1 * 3600))
	self.m_tipTxt:setText(var_0_8:get(308026, {
		num = math.floor(var_0_1.get(var_0_7.PARAMETER_CONST.TOWER_FIGHT_HARD_HANGUP_ACCELERATE).parameter / 3600)
	}))
end

function TowerHardCollectionPlatformPop:_onClickAccelerateBtn()
	if #var_0_3:getQuickHangupReward() == 0 then
		var_0_6:tip(g.core.lang:get(308028))

		return
	end

	if not var_0_2:getResetCost(var_0_7.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT) then
		var_0_6:tip(g.core.lang:get(308027))

		return
	end

	local var_4_0 = var_0_7.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT

	if var_0_2:getLeftCount(var_0_7.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT) > 0 then
		g.core.network.GameNetProxy:send_C2S_Tower_HangupQuickAward({
			count = 1,
			play_type = 2
		})

		return
	end

	local var_4_1 = var_0_0.get(var_4_0)
	local var_4_2 = var_0_4:getOwnNum(var_4_1.price_type, var_4_1.price_value)

	if var_4_2 < var_0_2:getBuyPrice(var_4_1.price_add_id, var_0_2:getPlayBuyCount(var_4_0) + 1) then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_4_1.price_type,
			value = var_4_1.price_value,
			size = var_4_2
		})
	else
		g.core.network.GameNetProxy:send_C2S_BuyCommonPlayNum({
			num = 1,
			id = var_4_0
		})
	end
end

function TowerHardCollectionPlatformPop:_onClickGetAwardBtn()
	if var_0_3:canGetHangupReward() then
		g.core.network.GameNetProxy:send_C2S_Tower_HangupAward({
			play_type = 2
		})
	else
		var_0_6:tip(g.core.lang:get(308025))
	end
end

function TowerHardCollectionPlatformPop:_onRendererAddItemList(arg_6_1, arg_6_2)
	arg_6_2:update(self._addItemList[arg_6_1 + 1], false)
end

function TowerHardCollectionPlatformPop:_onRendererRewardItemList(arg_7_1, arg_7_2)
	if self._rewardList[arg_7_1 + 1] then
		self._rewardList[arg_7_1 + 1].scaleIndex = 2

		arg_7_2:getChild("showItem"):updateIcon(self._rewardList[arg_7_1 + 1])
		arg_7_2:getController("isNull"):setSelectedIndex(1)
	else
		arg_7_2:getController("isNull"):setSelectedIndex(0)
	end
end

function TowerHardCollectionPlatformPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_HANGUPAWARD, self._onRecHangUpReward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self.updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_HANGUPQUICKAWARD, self._onRcvQuickReward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BUY_COMMON_PLAY_NUM, self._onRcvBuyPlayNum, self)

	if var_0_3:getHangupTimeData() > 0 and self._hangupTimer == nil then
		self._hangupTimer = g.core.common.Scheduler:newSchedule(handler(self, self._updateHangupTime), 1)
	end

	self:_updateHangupTime()
	self:updateView()
end

function TowerHardCollectionPlatformPop:_updateHangupTime()
	self.m_curTime:setText(var_0_5:secondToHMSString((var_0_3:getCurRealHangupTimeAndProgress())))
end

function TowerHardCollectionPlatformPop:_onRecHangUpReward(arg_10_1, arg_10_2, arg_10_3)
	self:updateView()
end

function TowerHardCollectionPlatformPop:_onRcvBuyPlayNum(arg_11_1, arg_11_2, arg_11_3)
	if var_0_2:getLeftCount(var_0_7.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT) > 0 then
		g.core.network.GameNetProxy:send_C2S_Tower_HangupQuickAward({
			count = 1,
			play_type = 2
		})
	end
end

function TowerHardCollectionPlatformPop:_onRcvQuickReward(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 then
		var_0_6:awardSummary(arg_12_3.awards, true)
		self:updateView()
	end
end

function TowerHardCollectionPlatformPop:updateView()
	self:updateCapacity()
	self:updateRewardList()
	self:updateAccelerateView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function TowerHardCollectionPlatformPop:updateAccelerateView()
	local var_14_0 = var_0_0.get(var_0_7.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT)
	local var_14_1 = var_0_2:getLeftCount(var_0_7.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT)
	local var_14_2 = var_0_2:getPlayBuyCount(var_0_7.ShopConst.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT)
	local var_14_3 = var_0_2:getBuyNum(var_14_0.buy_vip_num)

	if var_14_3 <= var_14_2 then
		self.m_isFreeController:setSelectedIndex(2)
	elseif var_14_1 == 0 then
		self.m_resComp:updateByTVS({
			type = var_14_0.price_type,
			value = var_14_0.price_value,
			size = var_0_2:getBuyPrice(var_14_0.price_add_id, var_14_2 + 1)
		})
		self.m_isFreeController:setSelectedIndex(1)
	else
		self.m_isFreeController:setSelectedIndex(0)
	end

	local var_14_4 = var_14_0.reset + var_14_3

	self.m_lastCount:setText(var_0_8:get((var_14_3 <= var_14_2 or nil) and 308030, {
		num = var_14_3 - var_14_2 + var_14_1,
		maxCount = var_14_4
	}))
end

function TowerHardCollectionPlatformPop:updateRewardList()
	local var_15_0 = var_0_3:getHangUpRewardData()

	self._rewardList = var_15_0

	if #var_15_0 == 0 then
		self.m_isRewardController:setSelectedIndex(1)
	else
		self.m_itemList:setNumItems(math.max(#self._rewardList, 4))
		self.m_isRewardController:setSelectedIndex(0)
	end
end

function TowerHardCollectionPlatformPop:updateCapacity()
	self._addItemList = {}

	local var_16_0, var_16_1 = var_0_3:getHangUpTimeHours()
	local var_16_2 = {}

	for iter_16_0, iter_16_1 in pairs((var_0_3:getCapacityData())) do
		for iter_16_2 = 1, table.nums(iter_16_1) do
			if var_16_2[iter_16_1[iter_16_2].type .. "_" .. iter_16_1[iter_16_2].value] ~= nil then
				self._addItemList[var_16_2[iter_16_1[iter_16_2].type .. "_" .. iter_16_1[iter_16_2].value]].curSize = self._addItemList[var_16_2[iter_16_1[iter_16_2].type .. "_" .. iter_16_1[iter_16_2].value]].curSize + iter_16_1[iter_16_2].size
				self._addItemList[var_16_2[iter_16_1[iter_16_2].type .. "_" .. iter_16_1[iter_16_2].value]].addSize = self._addItemList[var_16_2[iter_16_1[iter_16_2].type .. "_" .. iter_16_1[iter_16_2].value]].addSize + iter_16_1[iter_16_2].size
			else
				table.insert(self._addItemList, {
					size = 0,
					type = iter_16_1[iter_16_2].type,
					value = iter_16_1[iter_16_2].value,
					curSize = iter_16_1[iter_16_2].size,
					addSize = iter_16_1[iter_16_2].size,
					onceTime = var_16_0
				})

				var_16_2[iter_16_1[iter_16_2].type .. "_" .. iter_16_1[iter_16_2].value] = #self._addItemList
			end
		end
	end

	if #self._addItemList == 0 then
		self.m_isAddItemController:setSelectedIndex(1)
	else
		self.m_addItemList:setNumItems(math.max(#self._addItemList, 4))
		self.m_isAddItemController:setSelectedIndex(0)
	end
end

function TowerHardCollectionPlatformPop:onUnload()
	if self._hangupTimer ~= nil then
		g.core.common.Scheduler:cancelSchedule(self._hangupTimer)

		self._hangupTimer = nil
	end
end

return TowerHardCollectionPlatformPop
