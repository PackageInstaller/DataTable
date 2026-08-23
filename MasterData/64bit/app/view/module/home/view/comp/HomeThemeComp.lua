local var_0_0 = g.core.config.activity_theme_display_info
local var_0_1 = 1
local var_0_2 = g.core.common.ServerTime
local HomeThemeComp = class("HomeThemeComp", require("app.fairyGUI.home.UI_HomeThemeComp"))

function HomeThemeComp:ctor()
	self._themeActivityArr = nil
	self._cdTimer = nil
	self._exeTimerLastTime = var_0_2:getTime()

	self:_initList()
end

function HomeThemeComp:_initList()
	self.m_themeActivityList:setIniter()
	self.m_themeActivityList:setItemRenderer(handler(self, self._onThemeActivityRenderer))
	self.m_themeActivityList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickThemeActivity))
end

function HomeThemeComp:_onThemeActivityRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._themeActivityArr[arg_3_1 + 1])
end

function HomeThemeComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_GETINFO, self._onCustomActivityInfoRec, self)
	self:updateThemeActivity()
end

function HomeThemeComp:onUnload()
	if self._cdTimer then
		self:cancelSchedule(self._cdTimer)

		self._cdTimer = nil
	end
end

function HomeThemeComp:_onCustomActivityInfoRec()
	self:updateThemeActivity()
end

function HomeThemeComp:updateThemeActivity()
	self._themeActivityArr = g.core.model.User.themeData:getThemeEntranceActivityDataList()

	g.core.model.User.themeData:startAllOpenTheme((g.core.model.User.themeData:getThemeActivityDataList()))
	self.m_themeActivityList:setNumItems(#self._themeActivityArr)
	self.m_themeActivityList:resizeToFit(#self._themeActivityArr)

	if not self._cdTimer and #self._themeActivityArr > 0 then
		self._cdTimer = self:newSchedule(handler(self, self._onCD), var_0_1)
	end
end

function HomeThemeComp:_onCD()
	local var_8_0 = var_0_2:getTime()

	if var_8_0 - self._exeTimerLastTime < var_0_1 then
		return
	end

	self._exeTimerLastTime = var_8_0

	for iter_8_0, iter_8_1 in ipairs((self.m_themeActivityList:getChildren())) do
		iter_8_1:updateCD()
	end
end

function HomeThemeComp:_onClickThemeActivity(arg_9_1)
	local var_9_0 = self._themeActivityArr[arg_9_1:getDataValue() + 1]

	if var_9_0.getOpenActivityData then
		var_9_0 = var_9_0:getOpenActivityData()
	end

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0:getConfigActivityValue()
	local var_9_2 = var_0_0.get(var_9_1)

	if var_9_2 then
		local var_9_3, var_9_4 = g.view.entrance.ModuleGotoProxy:getModule(var_9_2.route_id)

		g.core.model.User.themeData:changeClickBtnSound(var_9_1)

		if not g.core.module.ModuleManager:isCurModule(var_9_3) then
			g.core.model.User.themeData:startOpenUIByActiveData(var_9_0)
			g.view.entrance.ModuleGotoProxy:gotoModule(var_9_2.route_id)
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(1143))
		end
	end
end

return HomeThemeComp
