local NewSlgS2DefenderEmptyComp = class("NewSlgS2DefenderEmptyComp")

function NewSlgS2DefenderEmptyComp:ctor()
	self._compTips = self:getChild("Comp_tips")
end

function NewSlgS2DefenderEmptyComp:updateView()
	return
end

return NewSlgS2DefenderEmptyComp
