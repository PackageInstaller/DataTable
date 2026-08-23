local WeddingActivityPop = class("WeddingActivityPop", require("app.fairyGUI.weddingActivity.UI_WeddingActivityPop"), function()
	return fgui.GComponent:create({
		resName = "WeddingActivityPop",
		pkgPath = "ui/weddingActivity/weddingActivity",
		pkgName = "weddingActivity"
	})
end)

function WeddingActivityPop:ctor()
	self._actData = g.core.model.User.weddingActivityData:getFrontActData()
	self._giftList = nil
	self._timer = nil

	self:_initPop()
	self:showAtCenter()
	self.m_mask:addClickListener(handler(self, self._onClosePopView))
	g.core.model.User.functionUnlockData:saveUnlockedFunc(self._actData.functionId)
	require("app.core.common.Provider"):clearProviderByKey("C2S_WeddingActivity_GetInfo")
	self.m_enterTransition:play()
	self.m_effBg:addEffectSpine({
		isLoop = true,
		anim = "play",
		name = "eff_ui_weddingActivity_bg"
	})
end

function WeddingActivityPop:_initPop()
	self.m_taskBtn:addClickListener(handler(self, self._onTaskBtnClicked))
	self.m_taskList:setVirtual(self)
	self.m_taskList:setItemRenderer(handler(self, self._onRenderTaskItem))
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardItem))
	self.m_itemList:setVirtual(self)
	self.m_itemList:setItemRenderer(handler(self, self._onRenderActivityItem))
end

function WeddingActivityPop:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEDDING_ACTIVITY_NOTIFY, handler(self, self._updateTaskList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEDDING_ACTIVITY_TASKAWARD, handler(self, self._onGetTaskAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._recvChargeInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, handler(self, self._recvGetRecharge), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
end

function WeddingActivityPop:onLoad()
	self:_addCustomListener()
	self:_updateView()
end

function WeddingActivityPop:onUnload()
	self:_onStopTimer()
end

function WeddingActivityPop:_updateTaskList()
	self.m_taskList:setNumItems(#self._actData.taskList)
	self:_checkTaskBtn()
end

function WeddingActivityPop:_updateAwardList()
	self.m_awardList:setNumItems(#self._actData.awards)
end

function WeddingActivityPop:_updateItemList()
	self:_getAndSortGiftDataList()
	self.m_itemList:setNumItems(#self._giftList)
end

function WeddingActivityPop:_getAndSortGiftDataList()
	self._giftList = g.core.model.User.giftData:getGiftListByShopTypeValue(g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GIFT, g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WEDDING_ACTIVITY, handler(self, self._filterActivityGift)) or {}

	if self._giftList == nil or #self._giftList < 1 then
		self._giftList = g.core.model.User.giftData:getGiftListByShopTypeValue(g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GIFT, g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WEDDING_ACTIVITY, handler(self, self._filterActivityGift))
	end

	table.sort(self._giftList, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0.times - arg_11_0.buyTimes

		if (arg_11_0.times - arg_11_0.buyTimes) * (arg_11_1.times - arg_11_1.buyTimes) == 0 then
			if var_11_0 ~= arg_11_1.times - arg_11_1.buyTimes then
				return var_11_0 ~= 0
			elseif arg_11_0.times * arg_11_1.times == 0 then
				return arg_11_0.times == 0
			end
		end

		return arg_11_0.recharge_money < arg_11_1.recharge_money
	end)
end

function WeddingActivityPop:_filterActivityGift(arg_12_1)
	return self._actData.actId == arg_12_1.activity_id
end

function WeddingActivityPop:_updateView()
	self:_updateAwardList()
	self:_updateItemList()
	self:_updateTaskList()
	self:_onStartTimer()
end

function WeddingActivityPop:_checkTaskBtn()
	if self._actData.getAward then
		self.m_taskStateController:setSelectedIndex(2)
	elseif g.core.model.User.weddingActivityData:isCanGetTaskAward({
		id = self._actData.actId
	}) then
		self.m_taskStateController:setSelectedIndex(1)
	else
		self.m_taskStateController:setSelectedIndex(0)
	end
end

function WeddingActivityPop:_onRenderTaskItem(arg_15_1, arg_15_2)
	arg_15_2:updateTask(self._actData.taskList[arg_15_1 + 1])
end

function WeddingActivityPop:_onRenderAwardItem(arg_16_1, arg_16_2)
	arg_16_2:updateIcon(self._actData.awards[arg_16_1 + 1])
end

function WeddingActivityPop:_onRenderActivityItem(arg_17_1, arg_17_2)
	arg_17_2:updateCell(self._giftList[arg_17_1 + 1])
end

function WeddingActivityPop:_onStartTimer()
	self._timer = self._timer or self:newSchedule(handler(self, self._onTimerUpdate), 1)

	self:_onTimerUpdate()
end

function WeddingActivityPop:_onStopTimer()
	if self._timer then
		self:cancelSchedule(self._timer)
	end

	self._timer = nil
end

function WeddingActivityPop:_onTimerUpdate()
	local var_20_0, var_20_1, var_20_2, var_20_3 = g.core.common.ServerTime:getLeftTimeParts(self._actData.openTime + self._actData.holdTime)

	if var_20_0 > 0 then
		self.m_timeTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(430802, {
			day = var_20_0,
			hour = var_20_1,
			min = var_20_2
		}))
	elseif var_20_1 > 0 then
		self.m_timeTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(430803, {
			hour = var_20_1,
			min = var_20_2
		}))
	elseif var_20_2 > 0 then
		self.m_timeTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(430804, {
			min = var_20_2
		}))
	elseif var_20_3 > 0 then
		self.m_timeTxt:setText(g.core.lang:get(107078) .. g.core.lang:get(430805, {
			sec = var_20_3
		}))
	elseif var_20_3 == 0 then
		self:_onStopTimer()
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function WeddingActivityPop:_onTaskBtnClicked()
	if self.m_taskStateController:getSelectedIndex() == 1 then
		g.core.network.GameNetProxy:send_C2S_WeddingActivity_TaskAward({
			id = self._actData.actId
		})
	else
		g.view.entrance.ModuleGotoProxy:gotoModule(g.core.config.wedding_activity_info.get(self._actData.actId).route_id)
	end
end

function WeddingActivityPop:_onGetTaskAward(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	g.core.module.ModuleManager:awardSummary(arg_22_4.awards)
	self.m_taskBtn:setVisible(false)
	self:_updateView()
end

function WeddingActivityPop:_recvChargeInfo(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_4.gift and arg_23_4.gift.awards then
		g.core.module.ModuleManager:awardSummary(arg_23_4.gift.awards)
		self:_updateItemList()
	end

	if not g.core.model.User.weddingActivityData:isOpen(self._actData.actId) then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function WeddingActivityPop:_recvGetRecharge(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if g.core.model.User.weddingActivityData:isOpen(self._actData.actId) then
		self:_updateItemList()
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function WeddingActivityPop:_onCrossDayUpdate()
	if not g.core.model.User.weddingActivityData:isOpen(self._actData.actId) then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	self:_updateView()
end

function WeddingActivityPop:_onClosePopView()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function WeddingActivityPop:onCancelCallback()
	self.m_backTransition:play(handler(self, self.closeWeddingActivityPop))
end

function WeddingActivityPop:closeWeddingActivityPop()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return WeddingActivityPop
