local IslandStaticCharaUnit = class("IslandStaticCharaUnit", import(".IslandSceneUnit"))

function IslandStaticCharaUnit:SetupBt()
	if not self.behaviourTreeOwner then
		return
	end

	if not self:GetView():IsInit() then
		self.behaviourTreeOwner.graph.blackboard:SetVariableValue("working", true)
	end

	IslandStaticCharaUnit.super.SetupBt(self)

	return
end

return IslandStaticCharaUnit
