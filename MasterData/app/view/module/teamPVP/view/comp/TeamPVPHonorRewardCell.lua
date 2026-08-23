local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.common.Path
local TeamPVPHonorRewardCell = class("TeamPVPHonorRewardCell", require("app.fairyGUI.teamPVP.UI_TeamPVPHonorRewardCell"))

function TeamPVPHonorRewardCell:ctor()
	self._rewardData = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
end

function TeamPVPHonorRewardCell:updateCell(arg_2_1, arg_2_2, arg_2_3)
	self.m_hasBgController:setSelectedIndex(arg_2_2 % 2 == 0 and 1 or 0)

	self._rewardData = arg_2_1 or {}

	self.m_rewardList:setNumItems(#self._rewardData)

	local var_2_0 = var_0_0:getTitleInfoByBaseId(arg_2_3)

	if var_2_0 then
		self.m_rankLoader:setURL(var_0_1:getTeamPVPBadge128(var_2_0.title_res))
		self.m_nameTxt:setText(var_2_0.title)
		self.m_honorNum:setText(var_2_0.limit)
	end
end

function TeamPVPHonorRewardCell:_onRenderRewardList(arg_3_1, arg_3_2)
	arg_3_2:updateIcon((g.core.common.Goods:convert(self._rewardData[arg_3_1 + 1])))
end

return TeamPVPHonorRewardCell
