local PetKnightIconComp = class("PetKnightIconComp", require("app.fairyGUI.recruitPet.UI_PetKnightIconComp"))

function PetKnightIconComp:ctor()
	self._knightId = nil
end

function PetKnightIconComp:updateComp(arg_2_1, arg_2_2)
	self._knightId = g.core.config.knight_info.get(arg_2_1).advance_id

	self.m_knightIcon:getChild("icon"):setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_KNIGHT, self._knightId)))
end

return PetKnightIconComp
