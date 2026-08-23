local GuildWarSeasonRewardCell = class("GuildWarSeasonRewardCell", require("app.fairyGUI.guildWar.UI_GuildWarSeasonRewardCell"))

function GuildWarSeasonRewardCell:ctor()
	self._rewardList = nil

	self.m_iconList:setVirtual()
	self.m_iconList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function GuildWarSeasonRewardCell:_onRenderAwardList(arg_2_1, arg_2_2)
	self._rewardList[arg_2_1 + 1].scaleIndex = 4
	self._rewardList[arg_2_1 + 1].hideNum = false

	arg_2_2:updateIcon(self._rewardList[arg_2_1 + 1])
end

function GuildWarSeasonRewardCell:update(arg_3_1)
	local var_3_0

	if arg_3_1 then
		var_3_0 = arg_3_1.rewardData or {}

		if not next(var_3_0) then
			return
		end
	end

	local var_3_1 = var_3_0.minRank

	if var_3_0.minRank ~= var_3_0.maxRank then
		var_3_1 = var_3_1 .. "-" .. var_3_0.maxRank
	end

	self.m_indexRank:setTitle(var_3_1)
	self.m_indexRank:setCtrlState("rank", {
		index = 0
	})

	self._rewardList = var_3_0.data

	self.m_iconList:setNumItems(#self._rewardList)
end

return GuildWarSeasonRewardCell
