local HomeCultivationCell = class("HomeCultivationCell", require("app.fairyGUI.home.UI_HomeCultivationCell"))
local var_0_1 = g.core.common.Path
local var_0_2 = {
	[g.core.const.ConstMgr.FUNCTION_TYPE.ECHO_LAB] = 443,
	[g.core.const.ConstMgr.FUNCTION_TYPE.GENE] = 5000001
}

function HomeCultivationCell:ctor(arg_1_1)
	self._isDevelop = false
	self._isUnlock = false

	self:addClickListener(handler(self, self._onClick))
end

function HomeCultivationCell:updateFuncStatus(arg_2_1)
	if arg_2_1.function_id == 0 then
		self._isDevelop = true
		self._isUnlock = false

		self.m_developBg:setURL(var_0_1:getHomeExpandIconPath("pic_yanfazhong"))
	else
		self._routeId = arg_2_1.source_route
		self._isDevelop = false

		self.m_funcName:setText(g.core.config.function_info.get(arg_2_1.function_id).name)

		if g.core.common.ModuleUnlock:isModuleUnlock(arg_2_1.function_id) then
			self._isUnlock = true

			self.m_funcBg:setURL(var_0_1:getHomeExpandIconPath(arg_2_1.pic))
		else
			self._isUnlock = false

			self.m_unlockTxt:setText(g.core.common.ModuleUnlock:getUnlockTxt(arg_2_1.function_id))
			self.m_funcBg:setURL(var_0_1:getHomeExpandIconPath(arg_2_1.pic .. "_1"))
		end
	end

	self.m_isDevelopController:setSelectedIndex(self._isDevelop and 1 or 0)
	self.m_isUnlockController:setSelectedIndex(self._isUnlock and 1 or 0)

	if var_0_2[arg_2_1.function_id] then
		self.m_redPointComp:setId(var_0_2[arg_2_1.function_id])
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	else
		self.m_redPointComp:setVisible(false)
	end
end

function HomeCultivationCell:_onClick()
	if self._isDevelop then
		g.core.module.ModuleManager:tip(g.core.lang:get(303026))
	elseif self._isUnlock then
		if self._routeId > 0 then
			g.view.entrance.ModuleGotoProxy:gotoModule(self._routeId)
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(100540))
	end
end

return HomeCultivationCell
