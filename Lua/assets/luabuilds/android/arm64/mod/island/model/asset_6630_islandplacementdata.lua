local IslandPlacementData = class("IslandPlacementData")

function IslandPlacementData:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.position = Vector2(arg_1_1.x or 0, arg_1_1.y or 0)
	self.dir = arg_1_1.dir or 0

	return
end

function IslandPlacementData:GetPosition()
	return self.position
end

function IslandPlacementData:GetRotation()
	return Vector3(0, self.dir * 90, 0)
end

function IslandPlacementData:IsSame(arg_4_1)
	if not arg_4_1 then
		return false
	end

	return self.position.x == arg_4_1.position.x and self.position.y == arg_4_1.position.y and self.dir == arg_4_1.dir
end

return IslandPlacementData
