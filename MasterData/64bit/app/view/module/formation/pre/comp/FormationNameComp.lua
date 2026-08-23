local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.common.ModuleUnlock
local FormationNameComp = class("FormationNameComp", require("app.fairyGUI.formation.UI_FormationNameComp"))

function FormationNameComp:ctor()
	self._isUnlock = false

	self:addClickListener(handler(self, self._onClickBtn))
	self.m_lockBg:addClickListener(handler(self, self._onClickLockBg))
end

function FormationNameComp:_onClickBtn()
	if self._isUnlock then
		self:dispatchCompEvent("Open_Formation_Usage_Pop")
	end
end

function FormationNameComp:_onClickLockBg()
	local var_3_0, var_3_1 = var_0_1:getModuleUnlockLevelAndComment(var_0_0.FORMATION_PRE)

	g.core.module.ModuleManager:tip(var_3_1)
end

function FormationNameComp:setIsUnlock(arg_4_1)
	self._isUnlock = arg_4_1 == true

	self.m_isUnlockController:setSelectedIndex(arg_4_1 and 1 or 0)
end

function FormationNameComp:updateComp(arg_5_1, arg_5_2)
	self:setName(arg_5_1)
	self:setIsMain(arg_5_2)
end

function FormationNameComp:setIsMain(arg_6_1)
	self.m_isMainController:setSelectedIndex(arg_6_1 and 1 or 0)
end

function FormationNameComp:setName(arg_7_1)
	self.m_nameText:setText(arg_7_1, nil, true)
end

return FormationNameComp
