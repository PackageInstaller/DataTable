local var_0_0 = g.core.model.User.wushTowerData
local WushTowerCardBagCell = class("WushTowerCardBagCell", require("app.fairyGUI.wushTower.UI_WushTowerCardBagCell"))

function WushTowerCardBagCell:updateCell(arg_1_1, arg_1_2)
	self:setSelected(arg_1_2)
	self.m_cardLoader:setURL((var_0_0:getCardIconByCardId(arg_1_1.id)))
	self.m_cardNumTxt:setText((var_0_0:getCardNumById(arg_1_1.id)))
end

function WushTowerCardBagCell:setSelected(arg_2_1)
	if arg_2_1 ~= self:isSelected() then
		self.m_selectedController:setSelectedIndex(arg_2_1 and 1 or 0)
	end
end

function WushTowerCardBagCell:isSelected()
	return self.m_selectedController:getSelectedIndex() == 1
end

return WushTowerCardBagCell
