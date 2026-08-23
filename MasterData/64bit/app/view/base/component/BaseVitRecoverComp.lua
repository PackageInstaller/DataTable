local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.model.User.resourceData
local BaseVitRecoverComp = class("BaseVitRecoverComp", require("app.fairyGUI.base_new.UI_BaseVitRecoverComp"))

function BaseVitRecoverComp:ctor()
	self._cfg = g.core.model.User.resourceData:getRecoverCfg(g.core.common.Goods.RESOURCE.TYPE_STAMINA)
end

function BaseVitRecoverComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECOVER_STEP, self._onRecoverStep, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_RESOURCE, handler(self, self.updateVitRecover), self)
	self:updateVitRecover()
end

function BaseVitRecoverComp:_onRecoverStep(arg_3_1, arg_3_2)
	if arg_3_2.info.value == var_0_1.RESOURCE.TYPE_STAMINA then
		self.m_nextCountText:setText((var_0_0:secondToHMSString(arg_3_2.nextCountdown)))
		self.m_allCountText:setText((var_0_0:secondToHMSString(arg_3_2.fullCountdown)))
	elseif arg_3_2.info.value == var_0_1.RESOURCE.TYPE_OUTPOST_VIT then
		self:updateOutpostVitTip()
	end
end

function BaseVitRecoverComp:updateVitRecover()
	if ((g.core.model.User.activityLifeTimeCardData:isSubscription() or nil) and self._cfg.privi_time_limit) <= var_0_2:getVit() then
		self.m_isMaxVitController:setSelectedIndex(1)
	else
		self.m_isMaxVitController:setSelectedIndex(0)
	end
end

function BaseVitRecoverComp:updateOutpostVitRecover()
	self:cancelAllSchedule()
	self:newSchedule(handler(self, self.updateOutpostVitTip), 1)
	self.m_isMaxVitController:setSelectedIndex(2)
	self:updateOutpostVitTip()
end

function BaseVitRecoverComp:updateOutpostTodayPoint()
	self.m_isMaxVitController:setSelectedIndex(2)
	self.m_outpostAttr:setText(g.core.lang:get(432676, {
		num = g.core.model.User.outpostData:getTodayPoint()
	}))
end

function BaseVitRecoverComp:updateOutpostVitTip()
	self.m_outpostAttr:setText(g.core.lang:get(432667, {
		time = var_0_0:secondToHMSString(var_0_0:getTodayZeroTime() - var_0_0:getTime())
	}))
end

return BaseVitRecoverComp
