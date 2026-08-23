local MysteryBossHurtRankCell = class("MysteryBossHurtRankCell", require("app.fairyGUI.mystery.UI_MysteryBossHurtRankCell"))

function MysteryBossHurtRankCell:ctor()
	self._userId = 0
end

function MysteryBossHurtRankCell:updateCell(arg_2_1)
	if arg_2_1.user_id ~= self._userId then
		self.m_enterTransition:play()
	end

	self._userId = arg_2_1.user_id

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._userId)

	if var_2_0 then
		self.m_userIcon:updateAsUser(var_2_0)
		self.m_userNameTxt:setText(var_2_0.name)
		self.m_fightValueTxt:setText(arg_2_1.damage)
	end

	self.m_userIcon:setVisible(checkbool(var_2_0))
	self.m_userNameTxt:setVisible(checkbool(var_2_0))
	self.m_fightValueTxt:setVisible(checkbool(var_2_0))
end

return MysteryBossHurtRankCell
