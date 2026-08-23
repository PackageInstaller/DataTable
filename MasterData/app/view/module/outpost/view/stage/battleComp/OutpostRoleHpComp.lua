local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostRoleHpComp = class("OutpostRoleHpComp", require("app.fairyGUI.outpost.UI_OutpostRoleHpComp"))

function OutpostRoleHpComp:setRoleType(arg_1_1)
	if arg_1_1 == var_0_0.EntityType.Knight then
		self.m_roleTypeController:setSelectedIndex(0)
	elseif arg_1_1 == var_0_0.EntityType.Monster then
		self.m_roleTypeController:setSelectedIndex(1)
	elseif arg_1_1 == var_0_0.EntityType.Boss then
		self.m_roleTypeController:setSelectedIndex(1)
	end
end

function OutpostRoleHpComp:updateHp(arg_2_1)
	self:setValue(arg_2_1 * 100)
end

return OutpostRoleHpComp
