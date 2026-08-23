local HomeSevenDayBtn = class("HomeSevenDayBtn", require("app.fairyGUI.home.UI_HomeSevenDayBtn"))
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.signActivityData
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE

function HomeSevenDayBtn:ctor()
	self._activityInfo = nil

	self:addClickListener(handler(self, self._onClick))
end

function HomeSevenDayBtn:onLoad()
	if self._activityInfo then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				actValue = self._activityInfo.activity_value,
				functionId = self._activityInfo.function_id
			}
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_newRedPointComp,
			customData = {
				actValue = self._activityInfo.activity_value,
				functionId = self._activityInfo.function_id
			}
		})
	end
end

function HomeSevenDayBtn:updateCell(arg_3_1)
	self.m_effectComp:removeAllEffect()

	local var_3_0 = g.core.config.activity_enter_info.get(arg_3_1.id)

	self._activityInfo = var_3_0

	if arg_3_1.id ~= 999 then
		if g.core.platform.PlatformProxy:isDmmPC() and var_3_0.icon == "icon_main_touzi" then
			var_3_0.icon = "icon_main_ciyuanmaoyi"
		end

		self:setIcon(var_0_1:getActivityIcon(var_3_0.icon))
		self.m_bg:setURL(var_0_1:getActivityBg(var_3_0.bg))
		self:setTitle(var_3_0.remark)
	else
		local var_3_1 = var_0_2:getSignSvrDataBySubId(arg_3_1.id)

		self:setIcon(var_0_1:getActivityIcon(var_0_2:getLoginResInfoById(var_3_1.icon_id).res_id))
		self.m_bg:setURL(var_0_1:getActivityBg(var_0_2:getLoginResInfoById(var_3_1.back_id).res_id))
		self:setTitle(var_0_2:getLoginNameInfoByNameId(var_3_1.name_id).name)
	end

	self.m_activityTimeStateController:setSelectedIndex(0)

	if var_3_0.function_id == var_0_3.HANDBOOK_COMPETITION or var_3_0.function_id == var_0_3.CULTIVATE_ACTIVITY then
		self.m_typeController:setSelectedIndex(1)
		self.m_activityTimeStateController:setSelectedIndex(self:getStateCont(var_3_0))
	else
		self.m_typeController:setSelectedIndex(0)
	end

	self.m_redPointComp:setId(var_3_0.red_point_id)
	self.m_newRedPointComp:setId(var_3_0.red_point_id)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			actValue = var_3_0.activity_value,
			functionId = var_3_0.function_id
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_newRedPointComp,
		customData = {
			actValue = var_3_0.activity_value,
			functionId = var_3_0.function_id
		}
	})
	self.m_redPointTypeController:setSelectedIndex(0)
end

function HomeSevenDayBtn:getStateCont(arg_4_1)
	if arg_4_1.function_id == var_0_3.HANDBOOK_COMPETITION then
		local var_4_0 = g.core.model.User.commonCompetitionDataManager:getDataById(arg_4_1.activity_value)

		if var_4_0 and var_4_0:getActivityData() then
			return var_4_0:getActivityData():getActivityState() == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.END and 1 or 0
		else
			return 0
		end
	elseif arg_4_1.function_id == var_0_3.CULTIVATE_ACTIVITY then
		if g.core.model.User.cultivateDataMgr:getCultivateData(arg_4_1.activity_value):isInNormalOpenTime() then
			return 0
		else
			return 1
		end
	end
end

function HomeSevenDayBtn:_onClick()
	if not self._activityInfo then
		return
	end

	if not g.core.model.User.homeData:getActivityOpenStatus(self._activityInfo) then
		g.core.module.ModuleManager:tip(g.core.lang:get(100530))
		self:dispatchCompEvent("EVENT_HOME_ACTIVITY_UPDATE")

		return
	end

	local var_5_0 = g.view.entrance.ModuleGotoProxy
	local var_5_1, var_5_2 = g.view.entrance.ModuleGotoProxy:getModule(self._activityInfo.route_id)

	require("app.view.module.home.common.HomeModuleAutoPopup").clearPopList()

	if not g.core.module.ModuleManager:isCurModule(var_5_1) then
		var_5_0:gotoModule(self._activityInfo.route_id, nil, nil, self._activityInfo)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(1143))
	end
end

return HomeSevenDayBtn
