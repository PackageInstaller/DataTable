local NewSlgTeamSelectArmyIcon = class("NewSlgTeamSelectArmyIcon")

function NewSlgTeamSelectArmyIcon:ctor()
	self._compIcon = self:getChild("Comp_icon")
	self._isRecCtrl = self:getController("is_rec")
	self._btnCheck = self:getChild("Btn_check")
	self._isSelCtrl = self:getController("is_sel")
	self._armyType = nil
end

function NewSlgTeamSelectArmyIcon:updateView(arg_2_1)
	self._armyType = arg_2_1.armyType

	local var_2_0 = arg_2_1.isMyArmyType

	self._compIcon:updateView({
		armyType = self._armyType
	})
	self._isSelCtrl:setSelectedIndex(var_2_0 and 1 or 0)

	local var_2_1

	for iter_2_0, iter_2_1 in g.core.config.new_slg_army_info.ipairs() do
		if iter_2_1["value" .. arg_2_1.defArmyType] > 0 then
			var_2_1 = iter_2_1

			break
		end
	end

	if var_2_1 and self._armyType == var_2_1.army_type then
		self._isRecCtrl:setSelectedIndex(1)
	end
end

function NewSlgTeamSelectArmyIcon:getArmyType()
	return self._armyType
end

return NewSlgTeamSelectArmyIcon
