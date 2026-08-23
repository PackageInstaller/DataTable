local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.bagData
local NewSlgDevelopCostCell = class("NewSlgDevelopCostCell", require("app.fairyGUI.newSlg.UI_NewSlgDevelopCostCell"))

function NewSlgDevelopCostCell:ctor()
	return
end

function NewSlgDevelopCostCell:updateCostCell(arg_2_1)
	local var_2_0 = var_0_0:convert(arg_2_1)
	local var_2_1 = var_0_1:getOwnNum(arg_2_1.type, arg_2_1.value)

	self.m_costTxt:setText(var_2_1 .. "/" .. var_2_0.size)
	self.m_icon:setIcon(var_2_0.icon_mini)
	self.m_isEnoughController:setSelectedIndex(var_2_1 >= var_2_0.size and 1 or 0)
end

return NewSlgDevelopCostCell
