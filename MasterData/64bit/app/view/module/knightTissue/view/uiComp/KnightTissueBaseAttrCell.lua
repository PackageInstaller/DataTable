local var_0_0 = g.core.model.User.knightTissueData
local var_0_1 = g.core.config.knight_tissue_level_info
local KnightTissueBaseAttrCell = class("KnightTissueBaseAttrCell", require("app.fairyGUI.knightTissue.UI_KnightTissueBaseAttrCell"))

function KnightTissueBaseAttrCell:updateAttrCellInfo(arg_1_1, arg_1_2)
	local var_1_0 = var_0_0:getKnightTissueLevel(arg_1_1)
	local var_1_1 = var_0_0:getTissueMaxLevel(arg_1_1)
	local var_1_2 = var_0_1.get(arg_1_1, (math.min(var_1_0 + 1, var_1_1)))

	self.m_attrNameTxt:setText(g.core.lang:get(111918, {
		name = g.core.config.attribute_info.get(var_1_2["attr_type_" .. arg_1_2]).name
	}))

	if var_1_1 <= var_1_0 then
		self.m_curAttrTxt:setText(g.core.lang:getAttrValue(var_1_2["attr_type_" .. arg_1_2], var_1_2["attr_value_" .. arg_1_2], true))
		self.m_nextAttrTxt:setText(g.core.lang:getAttrValue(var_1_2["attr_type_" .. arg_1_2], var_1_2["attr_value_" .. arg_1_2], true))
	else
		local var_1_3 = var_0_1.get(arg_1_1, var_1_0)

		self.m_curAttrTxt:setText(g.core.lang:getAttrValue(var_1_3["attr_type_" .. arg_1_2], var_1_3["attr_value_" .. arg_1_2], true))
		self.m_nextAttrTxt:setText(g.core.lang:getAttrValue(var_1_2["attr_type_" .. arg_1_2], var_1_2["attr_value_" .. arg_1_2], true))
	end
end

return KnightTissueBaseAttrCell
