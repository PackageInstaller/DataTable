local IslandSystemVO = class("IslandSystemVO")

function IslandSystemVO:Ctor(arg_1_1)
	self.id = arg_1_1
	self.name = self.id
	self.position = self:GetPosition()
	self.rotation = self:GetRotation()

	return
end

function IslandSystemVO:GetBehaviourTree()
	assert(false, "overwrite me!")

	return
end

function IslandSystemVO:GetType()
	assert(false, "overwrite me!")

	return
end

function IslandSystemVO:GetPosition()
	return Vector3.zero
end

function IslandSystemVO:GetRotation()
	return Vector3.zero
end

return IslandSystemVO
