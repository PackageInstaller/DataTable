local var_0_0 = g.core.common.Goods
local ActivityPermanentRechargeRewardComp = class("ActivityPermanentRechargeRewardComp", require("app.fairyGUI.activity.UI_ActivityPermanentRechargeRewardComp"))

function ActivityPermanentRechargeRewardComp:ctor()
	self._progress = 0
	self._rewardData = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
end

function ActivityPermanentRechargeRewardComp:updateList(arg_2_1)
	self._rewardData = arg_2_1.rewardData

	self.m_rewardList:setNumItems(#self._rewardData)
end

function ActivityPermanentRechargeRewardComp:_onRenderRewardList(arg_3_1, arg_3_2)
	arg_3_2:updateIcon((var_0_0:convert(self._rewardData[arg_3_1 + 1])))
end

return ActivityPermanentRechargeRewardComp
