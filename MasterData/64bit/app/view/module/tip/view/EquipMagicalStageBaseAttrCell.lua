local EquipMagicalStageBaseAttrCell = class("EquipMagicalStageBaseAttrCell", require("app.fairyGUI.tip.UI_EquipMagicalStageBaseAttrCell"))

function EquipMagicalStageBaseAttrCell:updateCell(arg_1_1, arg_1_2)
	self.m_curAttr:updateAttr({
		type = arg_1_1.type,
		value = arg_1_1.value
	})
	self.m_nextAttr:setText(arg_1_2.value)
end

return EquipMagicalStageBaseAttrCell
