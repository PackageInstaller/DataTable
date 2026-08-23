local GuildWarFightRewardCell = class("GuildWarFightRewardCell", require("app.fairyGUI.guildWar.UI_GuildWarFightRewardCell"))

function GuildWarFightRewardCell:ctor()
	self._rewardList = nil

	self.m_iconList:setVirtual()
	self.m_iconList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function GuildWarFightRewardCell:_onRenderAwardList(arg_2_1, arg_2_2)
	self._rewardList[arg_2_1 + 1].scaleIndex = 4
	self._rewardList[arg_2_1 + 1].hideNum = false

	arg_2_2:updateIcon(self._rewardList[arg_2_1 + 1])
end

function GuildWarFightRewardCell:update(arg_3_1)
	self.m_indexRank:setTitle(arg_3_1.index + 1)
	self.m_indexRank:setCtrlState("rank", {
		index = 0
	})

	if arg_3_1 then
		self._rewardList = arg_3_1.rewardData or {}
	end

	self.m_iconList:setNumItems(#self._rewardList)
end

return GuildWarFightRewardCell
