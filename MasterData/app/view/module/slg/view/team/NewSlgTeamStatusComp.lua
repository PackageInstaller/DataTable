local NewSlgTeamStatusComp = class("NewSlgTeamStatusComp")

function NewSlgTeamStatusComp:ctor()
	self._txtDesc = self:getChild("Txt_desc")
	self._txtCountDown = self:getChild("Txt_countDown")
	self._teamIndex = nil
	self._endTime = nil
end

function NewSlgTeamStatusComp:onLoad()
	self:newSchedule(handler(self, self._onUpdate), 1)
end

function NewSlgTeamStatusComp:updateView(arg_3_1)
	self._endTime = nil
	self._teamIndex = arg_3_1.teamIndex

	self:_refresh()
	self:_onUpdate()
end

function NewSlgTeamStatusComp:_refresh()
	self._endTime = nil
	self._farmTime = nil

	local var_4_0 = g.core.model.User.newSlgData:getMyTeamByIndex(self._teamIndex)
	local var_4_1 = g.core.model.User.newSlgData:getTeamStateByTeam(var_4_0)
	local var_4_2 = g.core.const.ConstMgr.NewSlgConst

	if var_4_1 then
		if var_4_1 ~= 0 then
			self._endTime = var_4_1.startTime + var_4_1.totalTime
			self._farmTime = var_4_1.farmTime

			if var_4_1.state == var_4_2.TEAM_CLIENT_STATUS_TYPE.FIGHTING then
				local var_4_3 = g.core.model.User.newSlgData:getBattleReportData(var_4_2.BATTLE_TYPE.CITY, var_4_1.targetId, var_4_0.target_point)

				if var_4_3 then
					self._endTime = g.core.common.ServerTime:getTime() + var_4_3:getLastTime()
				end
			end

			self._txtCountDown:setText((g.core.common.ServerTime:getActivityLeftTime(var_4_1.totalTime)))
		else
			self._endTime = nil
		end

		if var_4_1.state1 and (var_4_1.state1 == var_4_2.TEAM_CLIENT_STATUS1_TYPE.FARM_WAIT or var_4_1.state1 == var_4_2.TEAM_CLIENT_STATUS1_TYPE.FARM_DEF) then
			self._endTime = nil
		end

		self._txtDesc:setText(var_4_1.text)
	end
end

function NewSlgTeamStatusComp:_onUpdate()
	local var_5_0 = g.core.common.ServerTime:getTime()

	if self._endTime then
		if self._endTime - var_5_0 >= 0 then
			self._txtCountDown:setText((g.core.common.ServerTime:getActivityLeftTime(self._endTime - var_5_0)))

			return
		end
	end

	if self._farmTime and self._farmTime > 0 then
		self._txtCountDown:setText((g.core.common.ServerTime:secondToHMSString(var_5_0 - self._farmTime)))

		return
	end

	self:_refresh()
end

return NewSlgTeamStatusComp
