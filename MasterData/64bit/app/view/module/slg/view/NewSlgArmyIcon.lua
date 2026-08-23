local NewSlgArmyIcon = class("NewSlgArmyIcon")

function NewSlgArmyIcon:ctor()
	self._armyTypeCtrl = self:getController("army_type")
	self._levelTxt = self:getChild("lvTxt")
end

function NewSlgArmyIcon:updateView(arg_2_1)
	self._armyTypeCtrl:setSelectedIndex((arg_2_1 or nil) and (arg_2_1.armyType or 0))

	if arg_2_1.level then
		self:setCtrlState("showLevel", {
			index = 1
		})
		self._levelTxt:setText(arg_2_1.level)
	else
		self:setCtrlState("showLevel", {
			index = 0
		})
	end
end

return NewSlgArmyIcon
