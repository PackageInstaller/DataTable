local IslandSystemNpcUnit = class("IslandSystemNpcUnit", import(".IslandNpcUnit"))

function IslandSystemNpcUnit:SetupBt()
	if not self.behaviourTreeOwner then
		return
	end

	if not self:GetView():IsInit() then
		self.behaviourTreeOwner.graph.blackboard:SetVariableValue("working", true)
	end

	IslandSystemNpcUnit.super.SetupBt(self)

	return
end

return IslandSystemNpcUnit
