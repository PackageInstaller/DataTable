local IslandStrollNpcUnit = class("IslandStrollNpcUnit", import(".IslandDressupNpcUnit"))

function IslandStrollNpcUnit:SetupBt()
	if not self.behaviourTreeOwner then
		return
	end

	LuaHelper.NodeCanvasSetIntVariableValue(self.behaviourTreeOwner, "pathId", (self.data:GetPath()))
	IslandStrollNpcUnit.super.SetupBt(self)

	return
end

return IslandStrollNpcUnit
