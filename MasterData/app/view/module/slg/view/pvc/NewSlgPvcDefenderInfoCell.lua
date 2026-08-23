local NewSlgPvcDefenderInfoCell = class("NewSlgPvcDefenderInfoCell")

function NewSlgPvcDefenderInfoCell:ctor()
	self._compArmyIcon = self:getChild("Comp_armyIcon")
	self._txtAuthority = self:getChild("Txt_authority")
	self._txtHp = self:getChild("Txt_hp")
end

function NewSlgPvcDefenderInfoCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._compArmyIcon:updateView({
		armyType = arg_2_1.troop_type
	})
	self._txtAuthority:setText(arg_2_1.authority)
	self._txtHp:setText(arg_2_1.troops)
end

return NewSlgPvcDefenderInfoCell
