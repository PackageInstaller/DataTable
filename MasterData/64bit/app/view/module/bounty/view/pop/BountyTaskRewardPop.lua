local BountyTaskRewardPop = class("BountyTaskRewardPop", require("app.fairyGUI.bounty.UI_BountyTaskRewardPop"), function()
	return fgui.GComponent:create({
		resName = "BountyTaskRewardPop",
		pkgPath = "ui/bounty/bounty",
		pkgName = "bounty"
	})
end)

function BountyTaskRewardPop:ctor()
	self._selectIdx = 0

	self:_initPop()
	self:showAtCenter()
end

function BountyTaskRewardPop:_initPop()
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClick))
	self.m_rewardList:setVirtual(self)
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_tabList:setSelectedIndex(self._selectIdx)
end

function BountyTaskRewardPop:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_TASKAWARD, handler(self, self.s2C_Bounty_TaskAward), self)
end

function BountyTaskRewardPop:onLoad()
	self:_addCustomListener()
	self:_updateView()
end

function BountyTaskRewardPop:_updateView()
	self._taskList = {}

	for iter_6_0, iter_6_1 in ipairs((g.core.model.User.bountyData:getTaskList())) do
		if iter_6_1:getRefreshType() == self._selectIdx + 1 then
			self._taskList[#self._taskList + 1] = iter_6_1
		end
	end

	table.sort(self._taskList, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0:canReceive()
		local var_7_1

		if var_7_0 ~= arg_7_1:canReceive() then
			do return var_7_0 end

			var_7_1 = arg_7_1:getReceiveTimes() > 0
		end

		if arg_7_0:getReceiveTimes() > 0 ~= var_7_1 then
			return var_7_1
		end

		return arg_7_0:getOrder() < arg_7_1:getOrder()
	end)
	self.m_rewardList:setNumItems(#self._taskList)
	self:_updateTabRed()
end

function BountyTaskRewardPop:_updateTabRed()
	for iter_8_0, iter_8_1 in ipairs((self.m_tabList:getChildren())) do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = iter_8_1:getChild("redPointComp"),
			customData = {
				type = self.m_tabList:itemIndexToChildIndex(iter_8_0)
			}
		})
	end
end

function BountyTaskRewardPop:_onTabListClick()
	self._selectIdx = self.m_tabList:getSelectedIndex()

	self:_updateView()
end

function BountyTaskRewardPop:_onRenderAwardList(arg_10_1, arg_10_2)
	arg_10_2:updateRewardCell(self._taskList[arg_10_1 + 1])
end

function BountyTaskRewardPop:receiveCompEvent(arg_11_1, arg_11_2)
	if arg_11_1 == "getAward" then
		self:_sendAwardGetMsg(arg_11_2.taskId)

		return true
	end
end

function BountyTaskRewardPop:_sendAwardGetMsg(arg_12_1)
	g.core.network.GameNetProxy:send_C2S_Bounty_TaskAward({
		task_id = arg_12_1
	})
end

function BountyTaskRewardPop:s2C_Bounty_TaskAward(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = {
		showNow = true
	}
	local var_13_1 = {}

	var_13_1.awards = arg_13_4.awards or {}
	var_13_0.award = var_13_1

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, var_13_0)
	self:_updateView()
end

return BountyTaskRewardPop
