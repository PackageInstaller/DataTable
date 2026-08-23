local ElderGuildRankCell = class("ElderGuildRankCell", require("app.fairyGUI.elderBoss.UI_ElderGuildRankCell"))

function ElderGuildRankCell:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end

function ElderGuildRankCell:_onAwardListRenderer(arg_2_1, arg_2_2)
	arg_2_2:updateIcon((g.core.common.Goods:convert(self._awardDict.data[arg_2_1 + 1])))
end

function ElderGuildRankCell:updateView(arg_3_1, arg_3_2, arg_3_3)
	self.m_hasBgController:setSelectedIndex(arg_3_3 % 2)

	self._awardDict = g.core.common.RankAward:getAwardByTypeAndRank(arg_3_2, arg_3_1.rank)

	self.m_awardList:setNumItems(#(self._awardDict.data or {}))
	self.m_rankTxt:updateRankIndex({
		rank = arg_3_1.rank
	})
	self.m_scoreTxt:setText(arg_3_1.score)

	if arg_3_1.id == g.core.model.User.guildData:getGuildId() then
		self.m_isSelfGuildController:setSelectedIndex(1)
	else
		self.m_isSelfGuildController:setSelectedIndex(0)
	end

	local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_3_1.id)

	if var_3_0 then
		self.m_guildLoader:setURL((g.core.common.Path:getGuildMidIconById(var_3_0.icon)))
		self.m_guildNameTxt:setText(var_3_0.name)
		self.m_serverNameTxt1:setText(var_3_0.server_name)
	end
end

return ElderGuildRankCell
