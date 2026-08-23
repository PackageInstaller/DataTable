local var_0_0 = g.core.const.ConstMgr.GuildBossConst
local GuildBossRankCell = class("GuildBossRankCell", require("app.fairyGUI.guildBoss.UI_GuildBossRankCell"))

function GuildBossRankCell:ctor()
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
end

function GuildBossRankCell:updatePersonCell(arg_2_1)
	self:_setRank(arg_2_1.rankData.rank)
	self.m_scoreTxt:setText(arg_2_1.rankData.score)

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.rankData.id)

	if var_2_0 then
		local var_2_1 = var_2_0.name

		if arg_2_1.bossInfo and arg_2_1.bossInfo.type == var_0_0.TYPE_CROSS_SERVER and string.len(var_2_0.server_name) > 0 then
			var_2_1 = var_2_1 .. "（" .. var_2_0.server_name .. "）"

			self.m_styleController:setSelectedIndex(1)
		else
			self.m_styleController:setSelectedIndex(0)
		end

		self.m_nameTxt:setText(var_2_1)
	else
		self.m_styleController:setSelectedIndex(0)
		self.m_nameTxt:setText("")
	end
end

function GuildBossRankCell:updateGuildCell(arg_3_1)
	self:_setRank(arg_3_1.rankData.rank)
	self.m_scoreTxt:setText(arg_3_1.rankData.score)

	local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_3_1.rankData.id)

	if var_3_0 then
		local var_3_1 = var_3_0.name

		if arg_3_1.bossInfo and arg_3_1.bossInfo.type == var_0_0.TYPE_CROSS_SERVER and string.len(var_3_0.server_name) > 0 then
			var_3_1 = var_3_1 .. "（" .. var_3_0.server_name .. "）"

			self.m_styleController:setSelectedIndex(1)
		else
			self.m_styleController:setSelectedIndex(0)
		end

		self.m_nameTxt:setText(var_3_1)
	else
		self.m_styleController:setSelectedIndex(0)
		self.m_nameTxt:setText("")
	end
end

function GuildBossRankCell:_setRank(arg_4_1)
	if arg_4_1 <= 0 then
		self.m_rankController:setSelectedIndex(0)
		self.m_title:setText(g.core.lang:get(306508))
	elseif arg_4_1 <= 3 then
		self.m_rankController:setSelectedIndex(arg_4_1)
	else
		self.m_rankController:setSelectedIndex(0)
		self.m_title:setText(arg_4_1)
	end

	if arg_4_1 % 2 == 0 then
		self.m_bg:setVisible(true)
	else
		self.m_bg:setVisible(false)
	end
end

return GuildBossRankCell
