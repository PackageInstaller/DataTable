local NewSlgBattleReportIconComp = class("NewSlgBattleReportIconComp", require("app.fairyGUI.newSlg.UI_NewSlgBattleReportIconComp"))

function NewSlgBattleReportIconComp:ctor()
	self._teamInfo = nil
	self._finalAuthority = 0
	self._authority_rate_add = 0
	self._authority_rate_dec = 0
end

function NewSlgBattleReportIconComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onRevSnapshot), self)
end

function NewSlgBattleReportIconComp:updateComp(arg_3_1, arg_3_2, arg_3_3)
	self._finalAuthority = 0
	self._authority_rate_add = 0
	self._authority_rate_dec = 0

	self.m_teamIcon:updateIcon(arg_3_1, arg_3_3)
	self.m_fightTextAtk:setText(arg_3_2.finalAuthority)
	self.m_fightTextDef:setText(arg_3_2.finalAuthority)
	self.m_proBar:setMax(arg_3_2.max)
	self.m_proBar:setValue(arg_3_2.cur)
	self.m_proTxt:setText(arg_3_2.cur .. "/" .. arg_3_2.max)

	if arg_3_2.dis < 0 then
		self.m_costTxtAtk:setText(arg_3_2.dis)
		self.m_costTxtDef:setText(arg_3_2.dis)
	else
		self.m_costTxtAtk:setText("")
		self.m_costTxtDef:setText("")
	end

	if arg_3_2.cur == 0 then
		self.m_teamIcon:setCtrlState("showMask", {
			index = 1
		})
	else
		self.m_teamIcon:setCtrlState("showMask", {
			index = 0
		})
	end

	self._teamInfo = arg_3_1

	self:updateUser(arg_3_2.finalAuthority, arg_3_2.authority_rate_add, arg_3_2.authority_rate_dec)
end

function NewSlgBattleReportIconComp:_onRevSnapshot()
	self:updateUser()
end

function NewSlgBattleReportIconComp:updateUser(arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 then
		self._finalAuthority = arg_5_1
	elseif self._finalAuthority ~= 0 then
		arg_5_1 = self._finalAuthority
	end

	if arg_5_2 then
		self._authority_rate_add = arg_5_2
	elseif self._authority_rate_add ~= 0 then
		arg_5_2 = self._authority_rate_add
	end

	if arg_5_3 then
		self._authority_rate_dec = arg_5_3
	elseif self._authority_rate_dec ~= 0 then
		arg_5_3 = self._authority_rate_dec
	end

	self.m_nameTxtAtk:setText("")
	self.m_nameTxtDef:setText("")
	self.m_hasAllianceController:setSelectedIndex(0)
	self.m_fightRatioTypeController:setSelectedIndex(0)

	if self._teamInfo.user then
		if self._teamInfo.user.uid >= 10000 then
			local var_5_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._teamInfo.user.uid)

			if var_5_0 then
				self.m_nameTxtAtk:setText(var_5_0.name)
				self.m_nameTxtDef:setText(var_5_0.name)

				if var_5_0.alliance_id > 0 then
					self.m_hasAllianceController:setSelectedIndex(1)
					self.m_allianceNameAtk:setText(var_5_0.alliance_name)
					self.m_allianceNameDef:setText(var_5_0.alliance_name)
				end

				arg_5_2 = arg_5_2 or 0
				arg_5_3 = arg_5_3 or 0

				local var_5_1 = (arg_5_2 - arg_5_3) / 10

				if (arg_5_2 - arg_5_3) / 10 > 0 then
					local var_5_2 = string.format(g.core.lang:get(429764), math.floor(-var_5_1))

					self.m_fightRatioTxtAtk:setText(var_5_2)
					self.m_fightRatioTxtDef:setText(var_5_2)
					self.m_fightRatioTypeController:setSelectedIndex(2)
				elseif var_5_1 < 0 then
					local var_5_3 = string.format(g.core.lang:get(429763), math.floor(var_5_1))

					self.m_fightRatioTxtAtk:setText(var_5_3)
					self.m_fightRatioTxtDef:setText(var_5_3)
					self.m_fightRatioTypeController:setSelectedIndex(1)
				end
			end
		elseif self._teamInfo.user.robot_id > 0 then
			local var_5_4 = g.core.model.User.snapShotCacheData:getDataSnapShotTemplate(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._teamInfo.user.robot_id)

			self.m_nameTxtAtk:setText(var_5_4.name)
			self.m_nameTxtDef:setText(var_5_4.name)
		end
	end
end

return NewSlgBattleReportIconComp
