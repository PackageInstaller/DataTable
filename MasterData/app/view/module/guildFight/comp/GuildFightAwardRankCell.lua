local var_0_0 = g.core.model.User.GuildFightData
local GuildFightAwardRankCell = class("GuildFightAwardRankCell", require("app.fairyGUI.guildFight.UI_GuildFightAwardRankCell"))

function GuildFightAwardRankCell:ctor()
	self._awardListData = {}

	self.m_awardList:setVirtual()
	self.m_awardList:doFairyBatching(false)
	self.m_awardList:setItemRendererAsync(handler(self, self._onAwardListRenderer))
end

function GuildFightAwardRankCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1.index or 0

	if var_2_0 % 2 == 0 then
		self.m_bg:setVisible(true)
	else
		self.m_bg:setVisible(false)
	end

	self.m_rankController:setSelectedIndex(0)

	if var_2_0 == 1 or var_2_0 == 2 or var_2_0 == 3 then
		self.m_rankController:setSelectedIndex(var_2_0)

		self._awardListData = var_0_0:getRankAward(var_2_0)
	else
		local var_2_1 = var_0_0:getRankAwardData(var_2_0)

		if var_2_1.min_rank == var_2_1.max_rank then
			self.m_rankTxt:setText(var_2_0)
		else
			self.m_rankTxt:setText(var_2_1.min_rank .. "-" .. var_2_1.max_rank)
		end

		self._awardListData = var_0_0:getRankAward(var_2_1.min_rank)
	end

	self.m_awardList:setNumItems(#self._awardListData)
end

function GuildFightAwardRankCell:_onAwardListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awardListData[arg_3_1 + 1])
end

return GuildFightAwardRankCell
