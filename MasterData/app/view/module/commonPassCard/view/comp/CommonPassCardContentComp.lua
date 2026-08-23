local var_0_0 = g.core.const.ConstMgr.CommonPassCardConst
local var_0_1 = g.core.common.Path
local var_0_2 = {
	g.core.const.ConstMgr.CommonPassCardConst.TASK_TYPE.DAILY,
	g.core.const.ConstMgr.CommonPassCardConst.TASK_TYPE.WEEKLY,
	g.core.const.ConstMgr.CommonPassCardConst.TASK_TYPE.ROUND
}
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.model.User.commonPassCardDataMgr
local CommonPassCardContentComp = class("CommonPassCardContentComp", require("app.fairyGUI.commonPassCard.UI_CommonPassCardContentComp"))

function CommonPassCardContentComp:ctor()
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self.onItemRenderer))
	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self.onTaskRenderer))
	self.m_itemList:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onListScroll))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabClickChanged))
	self.m_taskTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTaskTypeClickChanged))

	self._curTaskType = var_0_0.TASK_TYPE.DAILY
	self._isFirstEnter = true

	self.m_previewBtn:addClickListener(handler(self, self.onClickPreviewBtn))
	self.m_upgradeBtn:addClickListener(handler(self, self.onClickUpgradeBtn))
	self.m_oneKeyRewardBtn:addClickListener(handler(self, self._onOneKeyRewardClick))
end

function CommonPassCardContentComp:onLoad()
	self:_onListScroll()
	self.m_isPayController:setSelectedIndex(self._commonPassCardData:isRecharge() and 1 or 0)
	self:updateTaskTime()
	self:newSchedule(handler(self, self.updateTaskTime), 1)
end

function CommonPassCardContentComp:updatePassCardComp(arg_3_1)
	self._actId = arg_3_1
	self._commonPassCardData = var_0_4:getPassCardData(self._actId)

	local var_3_0 = self._commonPassCardData:getActivityCfg().entrance_res

	self.m_newmalIcon:setURL(var_0_1:getCommonPassCardIcon(var_3_0, 1))
	self.m_payIcon:setURL(var_0_1:getCommonPassCardIcon(var_3_0, 2))
	self.m_payIcon2:setURL(var_0_1:getCommonPassCardIcon(var_3_0, 2))

	local var_3_1 = false

	if self.m_tabController:getSelectedIndex() == 0 then
		self.m_discountTxt:setText(self._commonPassCardData:getActivityCfg().ratio .. "%")

		self._rewardCfgLists = self._commonPassCardData:getCurPassCardCfg()

		self.m_itemList:setNumItems(#self._rewardCfgLists)

		var_3_1 = self._commonPassCardData:isNeedShowOneKey() > 1

		self:_onListScroll()
	else
		var_3_1 = #self._commonPassCardData:getAllCanRewardTaskIds() > 2

		self.m_taskTypeController:setSelectedIndex(self._curTaskType - 1)

		self._curTaskList = self._commonPassCardData:getTaskByResetType(self._curTaskType)

		self.m_taskList:setNumItems(#self._curTaskList)
	end

	self.m_oneKeyRewardBtn:setVisible(var_3_1)
	self.m_isPayController:setSelectedIndex(self._commonPassCardData:isRecharge() and 1 or 0)

	local var_3_2 = self._commonPassCardData:getRechargeType()

	if var_3_2 == 2 or var_3_2 == 3 then
		self.m_isPayController:setSelectedIndex(2)
	end

	if self._isFirstEnter and self._commonPassCardData:getPassCardLv() > 0 then
		self._isFirstEnter = false

		self.m_itemList:scrollToView(self._commonPassCardData:getMinCanRewardLv() - 1)
	end

	self:updateRedPoint()
end

function CommonPassCardContentComp:updateRedPoint()
	for iter_4_0 = 1, 3 do
		self["m_tab" .. iter_4_0]:setTaskType(var_0_2[iter_4_0], self._actId)
	end

	self.m_tabGift:checkRedPoint(self._actId)
	self.m_tabTask:checkRedPoint(self._actId)
end

function CommonPassCardContentComp:_onTabClickChanged()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Shenshou_Tag1)
	self:updatePassCardComp(self._actId)

	if self._commonPassCardData:getPassCardLv() > 0 then
		self.m_itemList:scrollToView(self._commonPassCardData:getPassCardLv() - 1)
	end
end

function CommonPassCardContentComp:_onTaskTypeClickChanged()
	self:updateTaskTime()

	self._curTaskType = self.m_taskTypeController:getSelectedIndex() + 1
	self._curTaskList = self._commonPassCardData:getTaskByResetType(self._curTaskType)

	self.m_taskList:setNumItems(#self._curTaskList)
end

function CommonPassCardContentComp:updateTaskTime()
	if self._curTaskType == var_0_0.TASK_TYPE.DAILY then
		local var_7_0, var_7_1, var_7_2, var_7_3 = var_0_3:getLeftTimeParts((var_0_3:getTodayZeroTime()))
		local var_7_4 = g.core.lang:get(422512, {
			day = var_7_0,
			hour = var_7_1,
			min = var_7_2
		})

		self.m_taskTimeTxt:setText(g.core.lang:get(422501, {
			timeTxt = (var_7_0 <= 0 or nil) and g.core.lang:get(422513, {
				hour = var_7_1,
				min = var_7_2,
				sec = var_7_3
			})
		}))
	elseif self._curTaskType == var_0_0.TASK_TYPE.WEEKLY then
		local var_7_5, var_7_6, var_7_7, var_7_8 = var_0_3:getCurWeekCountDown2()
		local var_7_9 = g.core.lang:get(422512, {
			day = var_7_5,
			hour = var_7_6,
			min = var_7_7
		})

		self.m_taskTimeTxt:setText(g.core.lang:get(422501, {
			timeTxt = (var_7_5 <= 0 or nil) and g.core.lang:get(422513, {
				hour = var_7_6,
				min = var_7_7,
				sec = var_7_8
			})
		}))
	end
end

function CommonPassCardContentComp:onItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updatePassCardCell(self._rewardCfgLists[arg_8_1 + 1], arg_8_1, self._commonPassCardData:isRecharge(), self._actId)
end

function CommonPassCardContentComp:onTaskRenderer(arg_9_1, arg_9_2)
	arg_9_2:updatePassCardNewTask(self._curTaskList[arg_9_1 + 1], self._actId)
end

function CommonPassCardContentComp:_onListScroll()
	local var_10_0 = self.m_itemList:numChildren()

	if var_10_0 >= 8 then
		var_10_0 = 8
	end

	local var_10_1 = self._commonPassCardData:getNextBigAwardCfg((self.m_itemList:getChildAt(var_10_0 - 1):getCurLevel()))

	if var_10_1 then
		self:updateBigAward(var_10_1)
	end
end

function CommonPassCardContentComp:updateBigAward(arg_11_1)
	self.m_nextBigFreeReward:updateIcon({
		type = arg_11_1.free_type,
		value = arg_11_1.free_value,
		size = arg_11_1.free_size
	})
	self.m_nextBigFreeReward:updateState(arg_11_1, false, self._actId)
	self.m_nextBigPayReward:updateIcon({
		type = arg_11_1.pay_type,
		value = arg_11_1.pay_value,
		size = arg_11_1.pay_size
	})
	self.m_nextBigPayReward:updateState(arg_11_1, true, self._actId)
	self.m_nextLvTxt:setText(g.core.utils.Number.getFormatNum(2, arg_11_1.level))
end

function CommonPassCardContentComp:onClickPreviewBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.commonPassCard.view.CommonPassCardPreviewPop").new({
		activityId = self._actId
	}), {
		touchDisappear = true
	})
end

function CommonPassCardContentComp:onClickUpgradeBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.commonPassCard.view.CommonPassCardRechargePop").new({
		activityId = self._actId
	}), {
		touchDisappear = true
	})
end

function CommonPassCardContentComp:_onOneKeyRewardClick()
	if self.m_tabController:getSelectedIndex() == 0 then
		g.core.network.GameNetProxy:send_C2S_CommonPasscard_LevelAward({
			type = 0,
			level = 0,
			id = self._actId
		})
	else
		local var_14_0 = {
			id = self._actId
		}

		var_14_0.task_ids = self._commonPassCardData:getAllCanRewardTaskIds()

		g.core.network.GameNetProxy:send_C2S_CommonPasscard_TaskAward(var_14_0)
	end
end

return CommonPassCardContentComp
