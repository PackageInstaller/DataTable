local ActivityGetStaminaCellPanel = class("ActivityGetStaminaCellPanel", require("app.fairyGUI.activity.UI_ActivityGetStaminaCellContainer"))

function ActivityGetStaminaCellPanel:ctor()
	self._scheduler = nil

	self.getSharedTrans(self, "listCardAUiLeftIn", "CombineBagList", self)
end

function ActivityGetStaminaCellPanel:playCellEnterAni(arg_2_1)
	if arg_2_1 > 0 then
		self:_rmvAniScheduler()

		self._scheduler = g.core.common.Scheduler:newScheduleOnce(handler(self, function()
			self.m_getStaminaCell:playEnterAni()
		end), arg_2_1)
	else
		self.m_getStaminaCell:playEnterAni()
	end
end

function ActivityGetStaminaCellPanel:updateCell(arg_4_1)
	self.m_getStaminaCell:updateCell(arg_4_1)
end

function ActivityGetStaminaCellPanel:onUnload()
	self:_rmvAniScheduler()
end

function ActivityGetStaminaCellPanel:_rmvAniScheduler()
	if self._scheduler then
		g.core.common.Scheduler:cancelSchedule(self._scheduler)

		self._scheduler = nil
	end
end

return ActivityGetStaminaCellPanel
