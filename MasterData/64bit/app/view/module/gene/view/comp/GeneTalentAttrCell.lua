local var_0_0 = g.core.config.gene_info
local var_0_1 = g.core.config.talent_skill_info
local var_0_2 = g.core.model.User.geneData
local GeneTalentAttrCell = class("GeneTalentAttrCell", require("app.fairyGUI.gene.UI_GeneTalentAttrCell"))

function GeneTalentAttrCell:updateTalentCell(arg_1_1)
	local var_1_0 = var_0_0.indexOf(arg_1_1)

	self.m_nameTxt:setText(var_1_0.name)
	self.m_attrTxt:setText(var_0_1.get(var_1_0.gene_talent).description)
	self.m_isActivateController:setSelectedIndex(var_0_2:getGeneSrvInfoById(var_1_0.id).is_activate and 1 or 0)
end

return GeneTalentAttrCell
