local var_0_0 = g.core.model.User.mysteryBossData
local MysteryBossIconComp = class("MysteryBossIconComp", require("app.fairyGUI.mystery.UI_MysteryBossIconComp"))

function MysteryBossIconComp:updateBossIcon(arg_1_1)
	self.m_iconLoader:setIcon(g.core.common.Path:getRoleHeadIcon(var_0_0:getBossDataById(arg_1_1):getBossMonsterInfo().res_id))
end

return MysteryBossIconComp
