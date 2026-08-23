local var_0_0 = g.core.const.ConstMgr.CrossServerArenaConst
local CrossServerArenaRecordCell = class("CrossServerArenaRecordCell", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaRecordCell"))

function CrossServerArenaRecordCell:ctor()
	self._battleId = nil

	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
	self:_initBtn()
end

function CrossServerArenaRecordCell:_initBtn()
	self.m_recordBtn:addClickListener(handler(self, self._onRecordClick))
end

function CrossServerArenaRecordCell:updateCell(arg_3_1, arg_3_2)
	if not arg_3_1 then
		return
	end

	self._recordData = arg_3_1

	self.m_leftUserComp:updateUserInfo(arg_3_1.attacker, arg_3_1.is_win)
	self.m_rightUserComp:updateUserInfo(arg_3_1.defender, not arg_3_1.is_win)

	local var_3_0, var_3_1 = self:_relateToMe(arg_3_1.attacker, arg_3_1.defender)

	if var_3_0 then
		if var_3_1 then
			if arg_3_1.is_win then
				self.m_challengeController:setSelectedIndex(var_0_0.CTRL_RECORD_TYPE.ATTACK_WIN)
			else
				self.m_challengeController:setSelectedIndex(var_0_0.CTRL_RECORD_TYPE.ATTACK_LOSE)
			end
		elseif arg_3_1.is_win then
			self.m_challengeController:setSelectedIndex(var_0_0.CTRL_RECORD_TYPE.DEFEND_WIN)
		else
			self.m_challengeController:setSelectedIndex(var_0_0.CTRL_RECORD_TYPE.DEFEND_LOSE)
		end
	elseif arg_3_1.is_win then
		self.m_challengeController:setSelectedIndex(var_0_0.CTRL_RECORD_TYPE.ATTACK_WIN)
	else
		self.m_challengeController:setSelectedIndex(var_0_0.CTRL_RECORD_TYPE.ATTACK_LOSE)
	end

	local var_3_4 = math.abs(arg_3_1.atker_rank - arg_3_1.defer_rank)

	self._battleId = arg_3_1.battle_id

	self.m_rankText:setText(arg_3_1.is_win and (arg_3_2 == var_0_0.CTRL_RECORD_TYPE.WHOLE and g.core.lang:get(302505) .. "+" .. var_3_4 or arg_3_1.attacker.id == g.core.model.User:getId() and g.core.lang:get(302505) .. "+" .. var_3_4 or g.core.lang:get(302505) .. "-" .. var_3_4) or g.core.lang:get(302506))
end

function CrossServerArenaRecordCell:_relateToMe(arg_4_1, arg_4_2)
	local var_4_0
	local var_4_2

	if arg_4_1.id == g.core.model.User:getId() then
		var_4_0 = true
		var_4_2 = true
	elseif arg_4_2.id == g.core.model.User:getId() then
		var_4_0 = true
		var_4_2 = false
	else
		var_4_0 = false
		var_4_2 = false
	end

	return var_4_0, var_4_2
end

function CrossServerArenaRecordCell:_onRecordClick()
	if not self._battleId then
		return
	end

	g.core.network.GameNetProxy:send_C2S_GetBattleVideo({
		battle_id = self._battleId
	})
end

return CrossServerArenaRecordCell
