local ValentinesDayVoteLevelRewardCell = class("ValentinesDayVoteLevelRewardCell", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteLevelRewardCell"))
local var_0_1 = g.core.model.User.valentinesDayVoteData

function ValentinesDayVoteLevelRewardCell:ctor()
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListItemRender))
	self.m_rewardBtn:addClickListener(handler(self, self._onRewardClick))
end

function ValentinesDayVoteLevelRewardCell:updateView(arg_2_1)
	self._struct = arg_2_1

	self.m_lvText:setText(self._struct:getCfg().id)

	self._rewardList = self._struct:getRewardList()

	self.m_awardList:setNumItems(#self._rewardList)

	local var_2_0 = var_0_1:getCurLevel()
	local var_2_1 = 0

	if self._struct:isGetReward() then
		var_2_1 = 2
	elseif var_2_0 < self._struct:getCfg().id then
		var_2_1 = 0
	elseif var_2_0 >= self._struct:getCfg().id then
		var_2_1 = 1
	end

	self.m_taskProcessText:setText(var_2_0 .. "/" .. self._struct:getCfg().id)
	self.m_typeController:setSelectedIndex(var_2_1)
end

function ValentinesDayVoteLevelRewardCell:_onAwardListItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._rewardList[arg_3_1 + 1])
end

function ValentinesDayVoteLevelRewardCell:_onRewardClick()
	g.core.network.GameNetProxy:send_C2S_Support_VoteAward({
		id = self._struct:getCfg().id
	})
end

return ValentinesDayVoteLevelRewardCell
