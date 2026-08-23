local RecruitLeaderRewardCell = class("RecruitLeaderRewardCell", require("app.fairyGUI.recruitKnight.UI_RecruitLeaderRewardCell"))
local var_0_1 = require("app.fairyGUI.recruitKnight.UI_RecruitLeaderRewardCell").StateCtrl

function RecruitLeaderRewardCell:ctor()
	self.m_takeRewardBtn:addClickListener(handler(self, self._onClickClaim))
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._renderRewardItem))
end

function RecruitLeaderRewardCell:updateItem(arg_2_1, arg_2_2)
	self._info = arg_2_1
	self._actId = arg_2_2

	self.m_processTxt:setText(math.min(arg_2_1.cur, arg_2_1.target) .. "/" .. arg_2_1.target)
	self.m_timesTxt:setText(arg_2_1.target)
	self.m_rewardList:setNumItems(#arg_2_1.awards)

	local var_2_0 = var_0_1.page0

	if arg_2_1.state == "match" then
		var_2_0 = var_0_1.page1
	elseif arg_2_1.state == "got" then
		var_2_0 = var_0_1.page2
	end

	self.m_stateController:setSelectedIndex(var_2_0)
end

function RecruitLeaderRewardCell:_renderRewardItem(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._info.awards[arg_3_1 + 1])
end

function RecruitLeaderRewardCell:_onClickClaim()
	if self._info.state ~= "match" then
		return
	end

	g.core.network.GameNetProxy:send_C2S_NewRecruit_ProgressAward({
		recruit_id = self._actId,
		award_id = self._info.cfg.id
	})
end

return RecruitLeaderRewardCell
