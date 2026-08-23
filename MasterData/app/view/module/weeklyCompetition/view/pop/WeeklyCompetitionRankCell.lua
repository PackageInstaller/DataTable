local WeeklyCompetitionRankCell = class("WeeklyCompetitionRankCell", (require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionRankCell")))

function WeeklyCompetitionRankCell:ctor()
	self._info = nil

	self:_initList()
end

function WeeklyCompetitionRankCell:_initList()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_awardList:doFairyBatching(false)
end

function WeeklyCompetitionRankCell:updateCell(arg_3_1, arg_3_2, arg_3_3)
	self._info = {
		rankInfo = arg_3_1,
		awards = arg_3_2 or {}
	}

	if arg_3_1.id then
		local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_3_1.id)

		if var_3_0 then
			local var_3_1 = var_3_0.guild_name

			if not var_3_0.guild_name or var_3_1 == "" then
				var_3_1 = g.core.lang:get(1012)
			end

			self.m_guildNameTxt:setText(var_3_1)
			self.m_userNameText:setText(var_3_0.name)
			self.m_scoreIcon:setURL(arg_3_3:getScoreIconUrl())
			self.m_scoreText:setText(arg_3_1.score)
			self.m_iconComp:updateAsUser(var_3_0)
			self.m_isEmptyController:setSelectedIndex(0)
		else
			self.m_isEmptyController:setSelectedIndex(1)
		end
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end

	self.m_awardList:setNumItems(#self._info.awards)
	self.m_indexRank:updateRankIndex(arg_3_1)
	self.m_isShowBgController:setSelectedIndex(arg_3_1.rank % 2)
end

function WeeklyCompetitionRankCell:_onAwardItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._info.awards[arg_4_1 + 1])
end

return WeeklyCompetitionRankCell
