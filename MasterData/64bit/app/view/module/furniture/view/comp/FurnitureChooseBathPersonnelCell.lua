local var_0_0 = g.core.model.User
local var_0_1 = g.core.common.Path
local FurnitureChooseBathPersonnelCell = class("FurnitureChooseBathPersonnelCell", require("app.fairyGUI.furniture.UI_FurnitureChooseBathPersonnelCell"))

function FurnitureChooseBathPersonnelCell:updateCell(arg_1_1)
	if not arg_1_1 or arg_1_1 == 0 then
		self:setTouchable(false)
		self.m_checkInController:setSelectedIndex(0)

		return
	end

	self:setTouchable(true)

	local var_1_0 = var_0_0.knightsData:getKnightById(arg_1_1)

	self.m_nameTxt:setText(var_1_0:getName())
	self.m_knightIconLoader:setURL(var_0_1:getKnightIconById(var_1_0:getResInfo().icon_id), true)

	local var_1_1 = var_1_0:getMobilityVal()

	if var_1_1 <= 0 then
		self.m_actionNullController:setSelectedIndex(1)
	else
		self.m_actionNullController:setSelectedIndex(0)
	end

	self.m_mobilityCircleBarComp:setCurMax(var_1_1, (var_1_0:getMaxMobility()))
	self.m_checkInController:setSelectedIndex(1)
end

return FurnitureChooseBathPersonnelCell
