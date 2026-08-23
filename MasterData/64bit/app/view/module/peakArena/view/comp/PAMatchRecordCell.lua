local var_0_1 = {
	ATTACK_WIN = 1,
	ATTACK_LOST = 0,
	DEFENCE_WIN = 3,
	DEFENCE_LOST = 2
}
local var_0_2 = g.core.model.User.snapShotCacheData
local var_0_3 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER
local var_0_4 = g.core.model.User
local PAMatchRecordCell = class("PAMatchRecordCell", require("app.fairyGUI.peakArena.UI_PAMatchRecordCell"))

function PAMatchRecordCell:ctor()
	self._battleId = nil
	self._sid = nil

	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
	self:_initBtn()
end

function PAMatchRecordCell:_initBtn()
	self.m_recordBtn:addClickListener(handler(self, self._onRecordClick))
end

function PAMatchRecordCell:updateCell(arg_3_1, arg_3_2)
	self._battleId = arg_3_1.battle_id
	self._sid = arg_3_1.sid

	local var_3_0 = arg_3_1.is_win
	local var_3_1

	if arg_3_1.attacker == var_0_4:getId() then
		local var_3_2 = var_0_2:getSnapShot(var_0_3, arg_3_1.attacker)

		if arg_3_1.defender_robot_id > 0 then
			local var_3_3 = var_0_2:getDataSnapShotTemplate(var_0_3, arg_3_1.defender_robot_id) or var_0_2:getSnapShot(var_0_3, arg_3_1.defender)

			if var_3_2 then
				self.m_leftUserComp:updateUserInfo(var_3_2, var_3_0, arg_3_1.attacker_score)
			end

			if var_3_3 then
				self.m_rightUserComp:updateUserInfo(var_3_3, not var_3_0, arg_3_1.defender_score)
			end
		end

		var_3_1 = var_3_0 and var_0_1.ATTACK_WIN or var_0_1.ATTACK_LOST
	else
		local var_3_4 = var_0_2:getSnapShot(var_0_3, arg_3_1.defender)

		if arg_3_1.defender_robot_id > 0 then
			local var_3_5 = var_0_2:getDataSnapShotTemplate(var_0_3, arg_3_1.defender_robot_id) or var_0_2:getSnapShot(var_0_3, arg_3_1.attacker)

			if var_3_4 then
				self.m_leftUserComp:updateUserInfo(var_3_4, not var_3_0, arg_3_1.defender_score)
			end

			if var_3_5 then
				self.m_rightUserComp:updateUserInfo(var_3_5, var_3_0, arg_3_1.attacker_score)
			end
		end

		var_3_1 = var_3_0 and var_0_1.DEFENCE_LOST or var_0_1.DEFENCE_WIN
	end

	self.m_challengeController:setSelectedIndex(var_3_1)
	self.m_scoreChangeTxt:setText(arg_3_1.chg_score > 0 and g.core.lang:get(307024, {
		score = arg_3_1.chg_score
	}) or arg_3_1.chg_score == 0 and g.core.lang:get(307063) or g.core.lang:get(307030, {
		score = arg_3_1.chg_score
	}))
end

function PAMatchRecordCell:_onRecordClick()
	if not self._battleId then
		return
	end

	dump(g.core.model.User.peakArenaData:getRecordByBattleId(self._battleId))
	g.core.model.User.peakArenaData:cacheRecordBattleId(self._battleId)
	g.core.network.GameNetProxy:send_C2S_GetBattleVideo({
		battle_id = self._battleId,
		tp = g.core.network.proto.PEAK_ARENA
	})
end

return PAMatchRecordCell
