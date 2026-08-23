local var_0_0 = g.core.config.outpost_talent_skill_info
local OutpostEquipSuccComp = class("OutpostEquipSuccComp", require("app.fairyGUI.outpost.UI_OutpostEquipSuccComp"))

function OutpostEquipSuccComp:update(arg_1_1)
	if arg_1_1.equipCfg then
		self.m_equipIcon:setURL(g.core.common.Path:getOutpostEquipIcon(arg_1_1.equipCfg.res))
		self.m_title:setText(arg_1_1.equipCfg.name)
		self.m_descTxt:setText(var_0_0.get(arg_1_1.equipCfg.talent_skill).description)
	end
end

return OutpostEquipSuccComp
