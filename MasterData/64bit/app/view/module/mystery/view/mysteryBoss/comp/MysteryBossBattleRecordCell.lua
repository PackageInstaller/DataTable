local MysteryBossBattleRecordCell = class("MysteryBossBattleRecordCell", require("app.fairyGUI.mystery.UI_MysteryBossBattleRecordCell"))

function MysteryBossBattleRecordCell:updateRecordCell(arg_1_1)
	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_1_1.user_id)

	if var_1_0 then
		self.m_userIcon:updateAsUser(var_1_0)

		var_1_0.server_name = (g.core.platform.ServerListProxy:getServerById(var_1_0.sid) or {
			name = ""
		}).name

		self.m_userNameTxt:setText(g.core.lang:get(423501, {
			name = var_1_0.name,
			serverName = var_1_0.server_name
		}))
		self.m_fightValueTxt:setText(var_1_0.fight_value)
		self.m_timeTxt:setText((g.core.common.ServerTime:getTimerBeforeDHM(arg_1_1.time)))
	end
end

return MysteryBossBattleRecordCell
