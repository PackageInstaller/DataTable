local var_0_0 = g.core.model.User.activityInviteFriendData
local ActivityMyInviteCodeComp = class("ActivityMyInviteCodeComp", require("app.fairyGUI.activity.UI_ActivityMyInviteCodeComp"))

function ActivityMyInviteCodeComp:ctor()
	self._rewardData = {}
	self._rechargeData = {}

	self:_initView()
end

function ActivityMyInviteCodeComp:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_RECOMMEND_INVITE_AWARD, handler(self, self._onRcvInviteReward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_RECOMMEND_AWARDSTATUSFLUSH, handler(self, self._onAwardStatusFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_RECOMMEND_RECHARGE_GETAWARD, handler(self, self._onRcvRechargeReward), self)
end

function ActivityMyInviteCodeComp:playCutAnimation()
	self.m_cutTransition:play()
end

function ActivityMyInviteCodeComp:playEnterAnimation()
	self.m_enterTransition:play()
end

function ActivityMyInviteCodeComp:_initView()
	self.m_copyBtn:addClickListener(handler(self, self.copyToClipboard))
	self.m_rewardList:setIniter()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardRenderer))
	self.m_rewardList:setItemProvider(handler(self, self._onActivityItemProvider))
	self.m_rechargeList:setIniter()
	self.m_rechargeList:setItemRenderer(handler(self, self._onRechargeRenderer))
	self.m_rechargeList:setItemProvider(handler(self, self._onRechargeItemProvider))
	self.m_typeController:setSelectedIndex(0)
end

function ActivityMyInviteCodeComp:updateView()
	self.m_codeText:setText((var_0_0:getMyInviteCode()))
	self:_updateList()
end

function ActivityMyInviteCodeComp:_updateList()
	self._rewardData = var_0_0:getInviteRewardInfo()

	self.m_rewardList:setNumItems(#self._rewardData + 1)

	self._rechargeData = var_0_0:getInvitationData()

	self.m_rechargeList:setNumItems(#self._rechargeData + 1)
end

function ActivityMyInviteCodeComp:copyToClipboard()
	g.core.module.ModuleManager:tip(g.core.lang:get(109551))
	g.core.platform.PlatformProxy:copyToClipboard((var_0_0:getMyInviteCode()))
end

function ActivityMyInviteCodeComp:_onRewardRenderer(arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		arg_9_2:updateStatus(var_0_0:getInviteNum() > 0)
		arg_9_2:setTitle(g.core.lang:get(407808))
	else
		local var_9_0 = self._rewardData[arg_9_1]
		local var_9_1 = var_0_0:getInviteNum()

		arg_9_2:updateView(self._rewardData[arg_9_1])
		arg_9_2:updateStatus(var_9_1 >= var_9_0.target)
	end
end

function ActivityMyInviteCodeComp:_onRechargeRenderer(arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		arg_10_2:updateStatus(var_0_0:getCumulativeMoney() > 0)
		arg_10_2:setTitle(g.core.lang:get(407809))
	else
		arg_10_2:updateCumulativeCell(self._rechargeData[arg_10_1])
	end
end

function ActivityMyInviteCodeComp:_onRechargeItemProvider(arg_11_1)
	if arg_11_1 == 0 then
		return "ui://activity/ActivityInviteTip"
	else
		return "ui://activity/ActivityCumulativeMoneyComp"
	end
end

function ActivityMyInviteCodeComp:_onActivityItemProvider(arg_12_1)
	if arg_12_1 == 0 then
		return "ui://activity/ActivityInviteTip"
	else
		return "ui://activity/ActivityInviteStepComp"
	end
end

function ActivityMyInviteCodeComp:_onRcvInviteReward(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	g.core.module.ModuleManager:awardSummary(arg_13_4.awards)
	self:_updateList()
end

function ActivityMyInviteCodeComp:_onRcvRechargeReward(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	g.core.module.ModuleManager:awardSummary(arg_14_4.awards)
	self:_updateList()
end

function ActivityMyInviteCodeComp:_onAwardStatusFlush()
	self:_updateList()
end

return ActivityMyInviteCodeComp
