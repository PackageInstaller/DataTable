local var_0_0 = g.core.model.User.guildWarData
local var_0_1 = {
	NOT_REACH = 0,
	RECEIVED = 2,
	AVAILABLE = 1
}
local GuildWarTaskCell = class("GuildWarTaskCell", require("app.fairyGUI.guildWar.UI_GuildWarTaskCell"))

function GuildWarTaskCell:ctor()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardItemRenderer))
	self.m_getBtn:addClickListener(handler(self, self._onGetTaskReward))
end

function GuildWarTaskCell:updateCell(arg_2_1)
	self._data = arg_2_1

	self.m_rewardTitle:setText(arg_2_1.info.name)
	self.m_descTxt:setSingleLine(false)
	self.m_descTxt:setText(arg_2_1.info.description)

	self._awardList = var_0_0:getAchieveAward(arg_2_1.info.id)

	self.m_rewardList:setNumItems(#self._awardList)
	self.m_rewardStateController:setSelectedIndex(arg_2_1.state)

	if arg_2_1.state == 0 then
		self.m_scoreNum:setText(math.min(arg_2_1.curValue, arg_2_1.info.value) .. "/" .. arg_2_1.info.value)
	end
end

function GuildWarTaskCell:_onGetTaskReward()
	if self._data.state == var_0_1.AVAILABLE then
		g.core.network.GameNetProxy:send_C2S_GuildWar_Achieves_Award({
			id = self._data.info.id
		})
	end
end

function GuildWarTaskCell:_onRewardItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._awardList[arg_4_1 + 1])
end

return GuildWarTaskCell
