local GmPassCardConst = require("app.view.module.newPassCard.const.GmPassCardConst")
local var_0_1 = {
	GmPassCardConst.TASK_TYPE.DAILY,
	GmPassCardConst.TASK_TYPE.WEEKLY,
	GmPassCardConst.TASK_TYPE.ROUND
}
local var_0_2 = g.core.model.User.gmPassCardData
local var_0_3 = g.core.common.ServerTime
local PassCardNewContentComp = class("PassCardNewContentComp", require("app.fairyGUI.newPassCard.UI_PassCardNewContentComp"))

function PassCardNewContentComp:ctor()
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self.onItemRenderer))
	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self.onTaskRenderer))
	self.m_itemList:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onListScroll))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabClickChanged))
	self.m_taskTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTaskTypeClickChanged))

	self._curTaskType = GmPassCardConst.TASK_TYPE.DAILY
	self._isFirstEnter = true

	self.m_previewBtn:addClickListener(handler(self, self.onClickPreviewBtn))
	self.m_upgradeBtn:addClickListener(handler(self, self.onClickUpgradeBtn))
	self.m_oneKeyRewardBtn:addClickListener(handler(self, self._onOneKeyRewardClick))
end

function PassCardNewContentComp:onLoad()
	self:_onListScroll()
	self.m_isPayController:setSelectedIndex(var_0_2:isRecharge() and 1 or 0)
	self:updateTaskTime()
	self:newSchedule(handler(self, self.updateTaskTime), 1)
end

function PassCardNewContentComp:updatePassCardComp()
	local var_3_0 = false

	if self.m_tabController:getSelectedIndex() == 0 then
		self.m_discountTxt:setText(var_0_2:getActivityCfg().ratio .. "%")

		self._rewardCfgLists = var_0_2:getCurPassCardCfg()

		self.m_itemList:setNumItems(#self._rewardCfgLists)

		var_3_0 = var_0_2:isNeedShowOneKey() > 1

		self:_onListScroll()
	else
		var_3_0 = #var_0_2:getAllCanRewardTaskIds() > 2

		self.m_taskTypeController:setSelectedIndex(self._curTaskType - 1)

		self._curTaskList = var_0_2:getTaskByResetType(self._curTaskType)

		self.m_taskList:setNumItems(#self._curTaskList)
	end

	self.m_oneKeyRewardBtn:setVisible(var_3_0)
	self.m_isPayController:setSelectedIndex(var_0_2:isRecharge() and 1 or 0)

	if self._isFirstEnter and var_0_2:getPassCardLv() > 0 then
		self._isFirstEnter = false

		self.m_itemList:scrollToView(var_0_2:getMinCanRewardLv() - 1)
	end

	self:updateRedPoint()
end

function PassCardNewContentComp:updateRedPoint()
	for iter_4_0 = 1, 3 do
		self["m_tab" .. iter_4_0]:setTaskType(var_0_1[iter_4_0])
	end

	self.m_tabGift:checkRedPoint()
	self.m_tabTask:checkRedPoint()
end

function PassCardNewContentComp:_onTabClickChanged()
	self:updatePassCardComp()

	if var_0_2:getPassCardLv() > 0 then
		self.m_itemList:scrollToView(var_0_2:getPassCardLv() - 1)
	end
end

function PassCardNewContentComp:_onTaskTypeClickChanged()
	self:updateTaskTime()

	self._curTaskType = self.m_taskTypeController:getSelectedIndex() + 1
	self._curTaskList = var_0_2:getTaskByResetType(self._curTaskType)

	self.m_taskList:setNumItems(#self._curTaskList)
end

function PassCardNewContentComp:updateTaskTime()
	if self._curTaskType == GmPassCardConst.TASK_TYPE.DAILY then
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
	elseif self._curTaskType == GmPassCardConst.TASK_TYPE.WEEKLY then
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

function PassCardNewContentComp:onItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updatePassCardCell(self._rewardCfgLists[arg_8_1 + 1], arg_8_1, var_0_2:isRecharge())
end

function PassCardNewContentComp:onTaskRenderer(arg_9_1, arg_9_2)
	arg_9_2:updatePassCardNewTask(self._curTaskList[arg_9_1 + 1])
end

function PassCardNewContentComp:_onListScroll()
	local var_10_0 = self.m_itemList:numChildren()

	if var_10_0 >= 8 then
		var_10_0 = 8
	end

	local var_10_1 = var_0_2:getNextBigAwardCfg((self.m_itemList:getChildAt(var_10_0 - 1):getCurLevel()))

	if var_10_1 then
		self:updateBigAward(var_10_1)
	end
end

function PassCardNewContentComp:updateBigAward(arg_11_1)
	self.m_nextBigFreeReward:updateIcon({
		type = arg_11_1.free_type,
		value = arg_11_1.free_value,
		size = arg_11_1.free_size
	})
	self.m_nextBigFreeReward:updateState(arg_11_1, false)
	self.m_nextBigPayReward:updateIcon({
		type = arg_11_1.pay_type,
		value = arg_11_1.pay_value,
		size = arg_11_1.pay_size
	})
	self.m_nextBigPayReward:updateState(arg_11_1, true)
	self.m_nextLvTxt:setText(g.core.utils.Number.getFormatNum(2, arg_11_1.level))
end

function PassCardNewContentComp:onClickPreviewBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.newPassCard.view.PassCardNewPreviewPop").new(), {
		touchDisappear = true
	})
end

function PassCardNewContentComp:onClickUpgradeBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.newPassCard.view.PassCardNewBuyPop").new(), {
		touchDisappear = true
	})
end

function PassCardNewContentComp:_onOneKeyRewardClick()
	if self.m_tabController:getSelectedIndex() == 0 then
		g.core.network.GameNetProxy:send_C2S_PasscardActivity_LevelAward({
			lv = 0,
			type = 0
		})
	else
		local var_14_0 = {}

		var_14_0.ids = var_0_2:getAllCanRewardTaskIds()

		g.core.network.GameNetProxy:send_C2S_PasscardActivity_TaskAward(var_14_0)
	end
end

return PassCardNewContentComp
