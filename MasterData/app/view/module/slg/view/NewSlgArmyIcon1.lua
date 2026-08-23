local NewSlgArmyIcon1 = class("NewSlgArmyIcon1")

function NewSlgArmyIcon1:ctor()
	self._typeCtrl = self:getController("type")
	self._typeColor = self:getController("color")
end

function NewSlgArmyIcon1:updateView(arg_2_1)
	self._typeCtrl:setSelectedIndex((arg_2_1 or nil) and (arg_2_1.armyType or 0))
	self._typeColor:setSelectedIndex((arg_2_1 or nil) and (arg_2_1.color or 0))
end

return NewSlgArmyIcon1
