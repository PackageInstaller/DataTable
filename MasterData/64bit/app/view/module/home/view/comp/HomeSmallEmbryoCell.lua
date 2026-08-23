local HomeSmallEmbryoCell = class("HomeSmallEmbryoCell", require("app.fairyGUI.home.UI_HomeSmallEmbryoCell"))
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = {
	[g.core.const.ConstMgr.FUNCTION_TYPE.UNITE_TOKEN] = 28,
	[g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT] = 434,
	[g.core.const.ConstMgr.FUNCTION_TYPE.PET_BAG] = 381,
	[g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_SOUL] = 719,
	[g.core.const.ConstMgr.FUNCTION_TYPE.ECHO_LAB] = 443,
	[g.core.const.ConstMgr.FUNCTION_TYPE.PRECIOUS] = 755,
	[g.core.const.ConstMgr.FUNCTION_TYPE.TREE] = 810,
	[g.core.const.ConstMgr.FUNCTION_TYPE.GUILD] = 184,
	[g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE] = 829,
	[g.core.const.ConstMgr.FUNCTION_TYPE.ROLE_SKIN] = 878,
	[g.core.const.ConstMgr.FUNCTION_TYPE.RECYCLE_CULTIVATE] = 883,
	[g.core.const.ConstMgr.FUNCTION_TYPE.SUCCUBA] = 893,
	[g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_MAIN] = 17
}
local var_0_4 = {
	[g.core.const.ConstMgr.FUNCTION_TYPE.OUTPOST] = {
		res = "ui://text_new/txt_zjm_wendingdu",
		isNeedShow = function()
			return g.core.model.User.outpostData:isHasVit()
		end
	}
}

function HomeSmallEmbryoCell:ctor(arg_2_1)
	self._isDevelop = false
	self._isUnlock = false

	self:addClickListener(handler(self, self._onClick))
end

function HomeSmallEmbryoCell:updateFuncStatus(arg_3_1)
	self._funcId = arg_3_1.function_id
	self._routeId = arg_3_1.source_route

	self.m_icon:setURL(var_0_1:getHomeExpandIconPath(arg_3_1.pic))
	self.m_funcName:setText(g.core.config.function_info.get(arg_3_1.function_id).name)

	self._isUnlock = not not g.core.common.ModuleUnlock:isModuleUnlock(arg_3_1.function_id)

	self.m_isUnLockController:setSelectedIndex(self._isUnlock and 0 or 1)
	self.m_enterTransition:play()

	if var_0_3[arg_3_1.function_id] then
		self.m_redPointComp:setId(var_0_3[arg_3_1.function_id])
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	else
		self.m_redPointComp:setVisible(false)
	end

	if var_0_4[arg_3_1.function_id] then
		self.m_redpointLoader:setVisible(var_0_4[arg_3_1.function_id].isNeedShow())
		self.m_redpointLoader:setURL(var_0_4[arg_3_1.function_id].res)
	end
end

function HomeSmallEmbryoCell:_onClick()
	if self._funcId == var_0_2.ALLIANCE then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_gonghuilianmeng)
	elseif self._funcId == var_0_2.SUCCUBA then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Small_01)
	end

	if self._isUnlock then
		if self._routeId > 0 then
			g.view.entrance.ModuleGotoProxy:gotoModule(self._routeId)
		end
	elseif self._funcId == var_0_2.SUCCUBA then
		g.core.module.ModuleManager:tip(g.core.lang:get(431040))
	else
		g.core.module.ModuleManager:tip(g.core.common.ModuleUnlock:getUnlockTxt(self._funcId))
	end
end

return HomeSmallEmbryoCell
