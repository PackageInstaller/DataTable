local var_0_0 = g.core.model.User.h5ActivityData
local md5 = require("cocos.framework.extends.md5")
local H5ActivityConst = require("app.view.module.H5Activity.const.H5ActivityConst")
local HomeH5Btn = class("HomeH5Btn", require("app.fairyGUI.home.UI_HomeH5Btn"))

function HomeH5Btn:ctor()
	self:addClickListener(handler(self, self.onClick))
end

function HomeH5Btn:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self.onRefreshRedPoint, self)
	self:onRefreshRedPoint()
end

function HomeH5Btn:onRefreshRedPoint()
	if self._activityData and self._activityData.info then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				actId = self._activityData.info.activity_id
			}
		})
	end
end

function HomeH5Btn:updateH5Btn(arg_4_1)
	self._activityData = arg_4_1

	self.m_time_styleController:setSelectedIndex(arg_4_1.timeStyle)
	self.m_redPointComp:setId(arg_4_1.redId)
	self:onRefreshRedPoint()
	self:updateShowState()
end

function HomeH5Btn:updateShowState()
	if not self._activityData then
		return
	end

	local var_5_0 = self._activityData.info

	if self._activityData.info.icon then
		self:setIcon("pic/h5Activity/" .. var_5_0.icon .. ".png")
	elseif var_5_0.icon_path then
		self:setIcon(var_5_0.icon_path)
	end

	if self._activityData.state == H5ActivityConst.ACTIVITY_STATE.PREVIEW then
		self.m_stateController:setSelectedIndex(0)
	else
		local var_5_1, var_5_2, var_5_3, var_5_4 = g.core.common.ServerTime:getLeftTimeParts(var_5_0.end_time)

		self.m_stateController:setSelectedIndex(1)

		if var_5_1 > 0 or var_5_2 > 0 then
			self.m_timeTxt:setText(g.core.lang:get(1051, {
				day = g.core.utils.Number.getFormatNum(2, var_5_1),
				hour = g.core.utils.Number.getFormatNum(2, var_5_2)
			}))
			self.m_time1Txt:setText(g.core.lang:get(1051, {
				day = g.core.utils.Number.getFormatNum(2, var_5_1),
				hour = g.core.utils.Number.getFormatNum(2, var_5_2)
			}))
			self.m_time2Txt:setText(g.core.lang:get(1051, {
				day = g.core.utils.Number.getFormatNum(2, var_5_1),
				hour = g.core.utils.Number.getFormatNum(2, var_5_2)
			}))
		else
			self.m_timeTxt:setText(g.core.lang:get(1289))
			self.m_time1Txt:setText(g.core.lang:get(1289))
			self.m_time2Txt:setText(g.core.lang:get(1289))
		end
	end
end

function HomeH5Btn:onClick()
	if not self._activityData then
		return
	end

	local var_6_0 = self._activityData.info

	if self._activityData.info.activity_type and var_6_0.activity_type >= 3 then
		var_0_0:saveTodayClickState(var_6_0.activity_id .. "_" .. var_6_0.activity_type)
	else
		var_0_0:saveTodayClickState(var_6_0.activity_id)
	end

	self:onRefreshRedPoint()

	if var_6_0.url then
		local var_6_1 = var_6_0.url

		if var_6_0.no_login == 0 then
			var_6_1 = var_6_1 .. "?" .. self:getLinkParams()
		end

		g.core.platform.PlatformProxy:openURL(var_6_1)
	elseif var_6_0.goto_module then
		g.core.module.ModuleManager:pushModule(var_6_0.goto_module)
	end
end

function HomeH5Btn:getLinkParams()
	local var_7_0 = g.core.platform.PlatformProxy:justGetLinkParamString(self._activityData.info.activity_id)
	local var_7_1 = md5.new()

	var_7_1:update(var_7_0 .. "95235e2f39dfa132b26388f53d1f99ab")

	return var_7_0 .. "&" .. "sign=" .. md5.tohex(var_7_1:finish())
end

return HomeH5Btn
