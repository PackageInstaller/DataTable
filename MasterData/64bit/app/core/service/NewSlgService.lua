local NewSlgService = class("NewSlgService")

function NewSlgService:ctor()
	self._schedules = {}

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ADD_SCHEDULE_PARAM, handler(self, self._addSchedule), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_REMOVE_SCHEDULE_PARAM, handler(self, self._removeSchedules), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSCREATETEAM, handler(self, self._onRcvNewSlgBossCreateTeam), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSJOINTEAM, handler(self, self._onRcvNewSlgBossJoinTeam), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSQUICKJOINTEAM, handler(self, self._onRcvNewSlgBossJoinTeam), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSLEAVE, handler(self, self._onRcvNewSlgBossLeaveTeam), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTEAMKICKOUT, handler(self, self._onRcvNewSlgKickOut), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTRANSFERLEADER, handler(self, self._onRcvNewSlgTransfer), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYMARCH, handler(self, self._onRcvCityMarch), self)
end

function NewSlgService:_onRcvNewSlgTransfer()
	g.core.module.ModuleManager:tip(g.core.lang:get(428923))
end

function NewSlgService:_onRcvNewSlgKickOut()
	g.core.module.ModuleManager:tip(g.core.lang:get(428921))
end

function NewSlgService:_onRcvCityMarch()
	g.core.module.ModuleManager:popAllPopup()
end

function NewSlgService:_onRcvNewSlgBossLeaveTeam(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	g.core.module.ModuleManager:popAllPopup()
end

function NewSlgService:_onRcvNewSlgBossCreateTeam(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	g.core.module.ModuleManager:popAllPopup()
	g.core.module.ModuleManager:tip(g.core.lang:get(428914))
	g.core.utils.Tools.newSlgFunc.openBossTeamDetailPop({
		teamId = arg_6_4.team.team_id
	})
end

function NewSlgService:_onRcvNewSlgBossJoinTeam(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:popAllPopup()
	g.core.module.ModuleManager:tip(g.core.lang:get(428915))
	g.core.utils.Tools.newSlgFunc.openBossTeamDetailPop({
		teamId = arg_7_4.team.team_id
	})
end

function NewSlgService:_addSchedule(arg_8_1, arg_8_2, arg_8_3)
	if #self._schedules == 0 and not self._schedulerHandler then
		self._schedulerHandler = g.core.common.Scheduler:newSchedule(handler(self, self._onSchedule), 1)
	end

	local var_8_0 = false

	for iter_8_0, iter_8_1 in ipairs(self._schedules) do
		if iter_8_1.key == arg_8_3.key then
			iter_8_1 = arg_8_3
			var_8_0 = true

			break
		end
	end

	if not var_8_0 then
		table.insert(self._schedules, arg_8_3)
	end
end

function NewSlgService:_removeSchedules(arg_9_1, arg_9_2, arg_9_3)
	if type(arg_9_3) == "string" then
		for iter_9_0, iter_9_1 in ipairs(self._schedules) do
			if iter_9_1.key == arg_9_3 then
				table.remove(self._schedules, iter_9_0)

				break
			end
		end
	elseif type(arg_9_3) == "number" then
		table.remove(self._schedules, arg_9_3)
	end

	if #self._schedules == 0 and self._schedulerHandler then
		g.core.common.Scheduler:cancelSchedule(self._schedulerHandler)

		self._schedulerHandler = nil
	end
end

function NewSlgService:_onSchedule()
	if #self._schedules == 0 then
		return
	end

	local var_10_0 = g.core.common.ServerTime:getTime()

	for iter_10_0, iter_10_1 in ipairs(self._schedules) do
		if iter_10_1.allTime or not iter_10_1.startTime and not iter_10_1.endTime then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, false, iter_10_1)
		elseif iter_10_1.isOnce then
			if iter_10_1.endTime then
				if iter_10_1.startTime <= var_10_0 and var_10_0 <= iter_10_1.endTime then
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, false, iter_10_1)
					self:_removeSchedules(nil, nil, iter_10_0)
				elseif iter_10_1.endTime < var_10_0 then
					self:_removeSchedules(nil, nil, iter_10_0)
				end
			elseif iter_10_1.startTime <= var_10_0 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, false, iter_10_1)
				self:_removeSchedules(nil, nil, iter_10_0)
			end
		elseif iter_10_1.startTime <= var_10_0 and var_10_0 <= iter_10_1.endTime then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, false, iter_10_1)
		elseif iter_10_1.endTime < var_10_0 then
			self:_removeSchedules(nil, nil, iter_10_0)
		end
	end
end

return NewSlgService
