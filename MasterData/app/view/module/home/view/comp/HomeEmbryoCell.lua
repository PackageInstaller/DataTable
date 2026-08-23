local HomeEmbryoCell = class("HomeEmbryoCell", require("app.fairyGUI.home.UI_HomeEmbryoCell"))
local var_0_1 = g.core.common.Path
local var_0_2 = {
	[g.core.const.ConstMgr.FUNCTION_TYPE.UNITE_TOKEN] = 28,
	[g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT] = 434,
	[g.core.const.ConstMgr.FUNCTION_TYPE.PET_BAG] = 381,
	[g.core.const.ConstMgr.FUNCTION_TYPE.TREE] = 810
}

function HomeEmbryoCell:ctor(arg_1_1)
	self._isDevelop = false
	self._isUnlock = false

	self:addClickListener(handler(self, self._onClick))
end

function HomeEmbryoCell:updateFuncStatus(arg_2_1)
	if arg_2_1.function_id == 0 then
		self._isDevelop = true
		self._isUnlock = false
	else
		self._routeId = arg_2_1.source_route
		self._isDevelop = false

		self.m_icon:setURL(var_0_1:getHomeExpandIconPath(arg_2_1.pic))
		self.m_funcName:setText(g.core.config.function_info.get(arg_2_1.function_id).name)

		if g.core.common.ModuleUnlock:isModuleUnlock(arg_2_1.function_id) then
			self._isUnlock = true
		else
			self._isUnlock = false

			self.m_unlockTxt:setText(g.core.common.ModuleUnlock:getUnlockTxt(arg_2_1.function_id))
		end
	end

	self.m_isDevelopController:setSelectedIndex(self._isDevelop and 1 or 0)
	self.m_isUnLockController:setSelectedIndex(self._isUnlock and 1 or 0)
	self.m_enterTransition:play()
	self.m_effEnter:addEffectSpine({
		anim = "play",
		name = "eff_ui_homeEmbryoPop_enter",
		remove = true,
		isLoop = false
	})

	if var_0_2[arg_2_1.function_id] then
		self.m_redPointComp:setId(var_0_2[arg_2_1.function_id])
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	else
		self.m_redPointComp:setVisible(false)
	end
end

function HomeEmbryoCell:_onClick()
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

return HomeEmbryoCell
