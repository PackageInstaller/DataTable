local NewSlgArmyNameComp = class("NewSlgArmyNameComp")

function NewSlgArmyNameComp:ctor()
	self._typeCtrl = self:getController("type")
end

function NewSlgArmyNameComp:updateView(arg_2_1)
	self._typeCtrl:setSelectedIndex((arg_2_1 or nil) and (arg_2_1.armyType or 0))
end

return NewSlgArmyNameComp
