local ElderUserRankCell = class("ElderUserRankCell", require("app.fairyGUI.elderBoss.UI_ElderUserRankCell"))

function ElderUserRankCell:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end

function ElderUserRankCell:_onAwardListRenderer(arg_2_1, arg_2_2)
	arg_2_2:updateIcon((g.core.common.Goods:convert(self._awardDict.data[arg_2_1 + 1])))
end

function ElderUserRankCell:updateView(arg_3_1, arg_3_2, arg_3_3)
	self.m_hasBgController:setSelectedIndex(arg_3_3 % 2)

	self._awardDict = g.core.common.RankAward:getAwardByTypeAndRank(arg_3_2, arg_3_1.rank)

	self.m_awardList:setNumItems(#(self._awardDict.data or {}))
	self.m_rankTxt:updateRankIndex({
		rank = arg_3_1.rank
	})
	self.m_scoreTxt:setText(arg_3_1.score)

	if arg_3_1.id == g.core.model.User:getId() then
		self.m_isSelfController:setSelectedIndex(1)
	else
		self.m_isSelfController:setSelectedIndex(0)
	end

	local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_3_1.id)

	if var_3_0 then
		self.m_userHeadComp:updateAsUser(var_3_0)
		self.m_lvText:setText(g.core.lang:get(2052, {
			level = var_3_0.level
		}))
		self.m_nameText:setText(var_3_0.name)
		self.m_serverNameTxt:setText(var_3_0.server_name)
		self.m_powerText:setText(var_3_0.fight_value)
	end
end

return ElderUserRankCell
