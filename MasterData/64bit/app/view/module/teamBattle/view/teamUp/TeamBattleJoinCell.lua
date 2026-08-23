local TeamBattleJoinCell = class("TeamBattleJoinCell", require("app.fairyGUI.teamBattle.UI_TeamBattleJoinCell"))

function TeamBattleJoinCell:ctor()
	self.m_joinBtn:addClickListener(handler(self, self._onClickJoin))
end

function TeamBattleJoinCell:updateCell(arg_2_1)
	self._info = arg_2_1

	self.m_userIcon2:setVisible(false)
	self.m_userIcon3:setVisible(false)

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.members) do
		self["m_userIcon" .. iter_2_0]:setVisible(true)

		if arg_2_1.snapShotDic[iter_2_1] then
			if iter_2_0 == 1 then
				self.m_captainName:setText(g.core.lang:get(427120, {
					name = arg_2_1.snapShotDic[iter_2_1].name
				}))
			end

			self["m_userIcon" .. iter_2_0]:updateAsUser(arg_2_1.snapShotDic[iter_2_1])
		else
			g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, iter_2_1)
		end
	end

	self.m_teamName:setText(arg_2_1.name)

	local var_2_0 = {}

	var_2_0.level = arg_2_1.level_limit or 1

	self.m_joinLevelTxt:setText(g.core.lang:get(427006, var_2_0))
end

function TeamBattleJoinCell:_onClickJoin()
	if #self._info.members > 2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(427125))

		return
	end

	g.core.network.GameNetProxy:send_C2S_TeamBattle_JoinTeam({
		team_id = self._info.id
	})
end

return TeamBattleJoinCell
