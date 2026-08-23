local ElderBossResultRankCell = class("ElderBossResultRankCell", require("app.fairyGUI.elderBoss.UI_ElderBossResultRankCell"))

function ElderBossResultRankCell:updateElement(arg_1_1)
	self:setIcon("ui://elderBoss/icon_ljqs_yuansu_" .. arg_1_1.buff)

	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_1_1.user_id)

	if var_1_0 then
		self.m_userIcon:updateAsUser(var_1_0)
		self.m_nameTxt:setText(var_1_0.name)
		self.m_numTxt:setText(arg_1_1.max_honor)
	end
end

return ElderBossResultRankCell
