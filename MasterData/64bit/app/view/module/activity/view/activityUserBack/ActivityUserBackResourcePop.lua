local var_0_0 = g.core.model.User.userBackData
local ActivityUserBackResourcePop = class("ActivityUserBackResourcePop", require("app.fairyGUI.activity.UI_ActivityUserBackResourcePop"), function()
	return fgui.GComponent:create({
		pkgName = "activity",
		resName = "ActivityUserBackResourcePop"
	}, ...)
end)

function ActivityUserBackResourcePop:ctor(arg_2_1)
	self:showAtCenter()

	self._curDay = var_0_0:getResourceCanGetMaxDay()
	self._resourceList = {}

	self:_initBtn()
	self:_initListView()
	self:_initView()
end

function ActivityUserBackResourcePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_USER_BACK_GETBACKRES, handler(self, self._onRecvResourceGet), self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_daySelBtn1,
		customData = {
			day = 1
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_daySelBtn2,
		customData = {
			day = 2
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_daySelBtn3,
		customData = {
			day = 3
		}
	})
	self.m_enterTransition:play()
end

function ActivityUserBackResourcePop:onUnload()
	self:clearTimer()
end

function ActivityUserBackResourcePop:_initBtn()
	self.m_closeGraph:addClickListener(handler(self, self._onClosePop))
	self.m_selectDayController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelectDayChange))
end

function ActivityUserBackResourcePop:_initListView()
	self.m_resourceList:setVirtual()
	self.m_resourceList:setItemRenderer(handler(self, self._onRenderResourceList))
end

function ActivityUserBackResourcePop:_onRenderResourceList(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._resourceList[arg_7_1 + 1])
end

function ActivityUserBackResourcePop:_initView(arg_8_1)
	self.m_effTitle:addEffectSpine({
		isLoop = false,
		anim = "play",
		name = "eff_ui_activityUserBack_title"
	})
	self.m_effStar:addEffectSpine({
		isLoop = true,
		anim = "play",
		name = "eff_ui_userBack_star"
	})
	self:clearTimer()

	self._updateSchedule = self:newSchedule(handler(self, function()
		self:_updateCountDown()
	end), 1)

	self:_updateCountDown()
	self.m_selectDayController:setSelectedIndex(self._curDay - 1)
	self:_onSelectDayChange()
	self:_updateSelDayBtnStatus()
end

function ActivityUserBackResourcePop:_updateSelDayBtnStatus()
	for iter_10_0 = 1, 3 do
		self["m_daySelBtn" .. iter_10_0]:getController("isAllGet"):setSelectedIndex(var_0_0:isResourceAllGetByDay(iter_10_0) and 1 or 0)
	end
end

function ActivityUserBackResourcePop:_updateCountDown()
	local var_11_0 = var_0_0:getEndTime() or 0
	local var_11_1

	if var_11_0 <= g.core.common.ServerTime:getTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(404503))
		self:_onClosePop()

		do return end

		var_11_1 = {}
	end

	var_11_1.timeTip = g.core.common.ServerTime:getLeftDHFormat(var_11_0)

	self.m_timeText:setText(g.core.lang:get(107059, var_11_1))
end

function ActivityUserBackResourcePop:clearTimer()
	if self._updateSchedule then
		self:cancelSchedule(self._updateSchedule)

		self._updateSchedule = nil
	end
end

function ActivityUserBackResourcePop:_onRecvResourceGet(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	g.core.module.ModuleManager:awardSummary(arg_13_4.awards)
	self:_onSelectDayChange()
	self:_updateSelDayBtnStatus()
end

function ActivityUserBackResourcePop:_onSelectDayChange()
	local var_14_0 = self.m_selectDayController:getSelectedIndex() + 1

	if not var_0_0:isDayCanGetResource(var_14_0) then
		self.m_selectDayController:setSelectedIndex(self._curDay - 1)
		g.core.module.ModuleManager:tip(g.core.lang:get(407805))

		return
	end

	self._curDay = var_14_0
	self._resourceList = var_0_0:getResourceEventListByDay(var_14_0)

	self.m_resourceList:setNumItems(#self._resourceList)
end

function ActivityUserBackResourcePop:_onClosePop()
	self.m_backTransition:play(handler(self, self._onRemoveSelf))
end

function ActivityUserBackResourcePop:_onRemoveSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ActivityUserBackResourcePop
