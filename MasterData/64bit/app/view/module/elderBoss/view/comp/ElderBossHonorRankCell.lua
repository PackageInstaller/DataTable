local ElderBossHonorRankCell = class("ElderBossHonorRankCell", require("app.fairyGUI.elderBoss.UI_ElderBossHonorRankCell"))

function ElderBossHonorRankCell:updateCell(arg_1_1)
	self._rankData = arg_1_1

	self.m_numTxt:setText(arg_1_1.score)

	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._rankData.id)

	if var_1_0 then
		self.m_userIcon:updateAsUser(var_1_0)
		self.m_nameTxt:setText(var_1_0.name)
	end
end

return ElderBossHonorRankCell
