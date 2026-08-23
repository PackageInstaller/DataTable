local PubgRankCell = class("PubgRankCell", require("app.fairyGUI.pubg.UI_PubgRankCell"))

function PubgRankCell:ctor()
	return
end

function PubgRankCell:updateCell(arg_2_1, arg_2_2)
	self.m_hasBgController:setSelectedIndex(arg_2_2 % 2)
	self.m_hasPlayerController:setSelectedIndex(checkbool(arg_2_1) and 1 or 0)

	if not arg_2_1 then
		return
	end

	self.m_rankComp:updateRankIndex({
		rank = arg_2_1.rank
	})

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.id)

	if var_2_0 then
		self.m_userHeadComp:updateAsUser(var_2_0)
		self.m_userHeadComp:setVisible(true)
		self.m_levelText:setText(g.core.lang:get(2052, {
			level = var_2_0.level
		}))
		self.m_nameText:setText(var_2_0.name)
		self.m_fightValueText:setText(var_2_0.fight_value)
		self.m_serverText:setText(var_2_0.server_name)
		self.m_scoreText:setText(arg_2_1.score or "")
	else
		self.m_userHeadComp:setVisible(false)
		self.m_levelText:setText("")
		self.m_nameText:setText("")
		self.m_fightValueText:setText("")
		self.m_serverText:setText("")
		self.m_scoreText:setText("")
	end
end

return PubgRankCell
