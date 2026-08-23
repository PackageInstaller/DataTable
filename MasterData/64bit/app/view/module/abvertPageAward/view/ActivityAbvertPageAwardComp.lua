local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.const.ConstMgr.AbvertPageAwardConst
local var_0_2 = g.core.model.User.abvertPageAwardData
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.event.EventManager
local ActivityAbvertPageAwardComp = class("ActivityAbvertPageAwardComp", require("app.fairyGUI.activity.UI_ActivityAbvertPageAwardComp"))

function ActivityAbvertPageAwardComp:ctor()
	self._activityId = 0
	self._endTime = 0

	self.m_getAwardBtn:addClickListener(handler(self, self._onClickGetAwards))
end

function ActivityAbvertPageAwardComp:onLoad()
	var_0_4:addEventListener(var_0_3.EVENT_NET_S2C_ABVERT_PAGE_AWARD_AWARD, handler(self, self._onRecvAbvertPageAeward), self)
	var_0_4:addEventListener(var_0_3.EVENT_CROSS_DAY_NOTIFY, handler(self, self._crossDayNotify), self)
	g.core.network.GameNetProxy:send_C2S_AbvertPageAward_GetInfo({})
end

function ActivityAbvertPageAwardComp:updateComp(arg_3_1)
	if arg_3_1 then
		self.m_openTransition:play()
	else
		self.m_enterTransition:play()
	end

	self._actId = var_0_2:getCurActId()
	self._templateId = var_0_2:getOpenScreenTemplate(self._actId)
	self._actData = var_0_2:getAbvertPageAwardServerData(self._actId)
	self._awardArray = var_0_2:getAbvertPageAwardArray(self._actId)
	self._endTime = self._actData.end_time

	self:_updateCountDown()

	self._cdHandler = self._cdHandler or self:newSchedule(handler(self, function()
		self:_updateCountDown()
	end), 1)

	self:_updateBtnState()

	for iter_3_0 = 1, var_0_1.AWARD_MAX_COUT do
		self["m_award" .. iter_3_0]:setVisible(false)

		if self._awardArray[iter_3_0] then
			self["m_award" .. iter_3_0]:setVisible(true)
			self["m_award" .. iter_3_0]:updateAwardIcon(self._awardArray[iter_3_0])
		end
	end

	self.m_roleBgLoader:setURL(g.core.common.Path:getAbvertPageAwardRoleBg("pic_abvertPageAward_" .. self._templateId))
end

function ActivityAbvertPageAwardComp:_updateBtnState()
	self._actData = var_0_2:getAbvertPageAwardServerData(self._actId)
	self._isCanAward = var_0_2:isCanGetAward()

	self.m_getAwardBtn:setGrayed(not self._isCanAward)
	self.m_getAwardBtn:setTouchable(self._isCanAward)

	if self._isCanAward then
		self.m_getAwardBtn:setTitle(g.core.lang:get(431202))
		self.m_timeTxt:setVisible(true)
	else
		self.m_getAwardBtn:setTitle(g.core.lang:get(431203))
		self.m_timeTxt:setVisible(false)
	end
end

function ActivityAbvertPageAwardComp:_updateCountDown()
	self.m_timeTxt:setText(g.core.lang:get(431201) .. var_0_0:getLeftDHMFormat(self._endTime))
end

function ActivityAbvertPageAwardComp:_onClickGetAwards()
	if self._isCanAward then
		g.core.network.GameNetProxy:send_C2S_AbvertPageAward_Award({
			act_id = self._actData.id
		})
	end
end

function ActivityAbvertPageAwardComp:_onRecvAbvertPageAeward(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_8_4.awards, true)
	end

	self:_updateBtnState()
end

function ActivityAbvertPageAwardComp:playEnterAni()
	self.m_openTransition:play()
end

function ActivityAbvertPageAwardComp:_crossDayNotify()
	if var_0_0:getTime() >= self._endTime then
		g.core.module.ModuleManager:popAllPopup()

		return
	end
end

function ActivityAbvertPageAwardComp:onUnload()
	if self._cdHandler then
		self:cancelSchedule(self._cdHandler)

		self._cdHandler = nil
	end
end

return ActivityAbvertPageAwardComp
