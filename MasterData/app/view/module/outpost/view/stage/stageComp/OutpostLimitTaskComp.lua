local var_0_1 = g.core.model.User.outpostData
local OutpostLimitTaskComp = class("OutpostLimitTaskComp", require("app.fairyGUI.outpost.UI_OutpostLimitTaskComp"))

function OutpostLimitTaskComp:ctor()
	self._tickTimer = nil

	self:addClickListener(handler(self, self._onSelfClicked))
	self.m_effNode:addEffectSpine({
		isLoop = true,
		name = "eff_ui_outpost_tasklimitglow"
	})
	self.m_iconComp:setIcon(g.core.common.Path:getRoleHeadIcon(300230))
end

function OutpostLimitTaskComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_SYNCTASK, self.updateTaskComp, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETTASKAWARD, self.updateTaskComp, self)
	self:updateTaskComp()
end

function OutpostLimitTaskComp:updateTaskComp()
	local var_3_0 = var_0_1:getTaskData()

	if var_3_0:isTriggerLimit() then
		self.m_isTriggerController:setSelectedIndex(1)

		if not self._tickTimer and var_3_0:getLimitPassEndTime() - g.core.common.ServerTime:getTime() > 0 then
			self._tickTimer = self:newSchedule(handler(self, self._tickTime), 1)

			self:_tickTime()
		end
	else
		self:_cancelTickTimer()
		self.m_isTriggerController:setSelectedIndex(0)
	end
end

function OutpostLimitTaskComp:_tickTime()
	local var_4_0 = var_0_1:getTaskData():getLimitPassEndTime() - g.core.common.ServerTime:getTime()

	self.m_timeTxt:setText(g.core.common.ServerTime:secondToHMSString(var_4_0))

	if var_4_0 <= 0 then
		self:_cancelTickTimer()
		self.m_timeTxt:setVisible(false)
	else
		self.m_timeTxt:setVisible(true)
	end
end

function OutpostLimitTaskComp:_cancelTickTimer()
	if self._tickTimer then
		self:cancelSchedule(self._tickTimer)
	end

	self._tickTimer = nil
end

function OutpostLimitTaskComp:onUnload()
	self._tickTimer = nil
end

function OutpostLimitTaskComp:_onSelfClicked()
	if not var_0_1:getTaskData():isTriggerLimit() then
		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.task.OutpostLimitTimeTaskPop").new()))
end

return OutpostLimitTaskComp
