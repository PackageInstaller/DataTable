local WorldCarryItem = class("WorldCarryItem", import("...BaseEntity"))

WorldCarryItem.Fields = {
	config = "table",
	id = "number",
	offsetRow = "number",
	offsetColumn = "number"
}
WorldCarryItem.EventUpdateOffset = "WorldCarryItem.EventUpdateOffset"

function WorldCarryItem:Setup(arg_1_1)
	self.id = arg_1_1
	self.config = pg.world_carry_item[self.id]

	assert(self.config, "world_carry_item not exist: " .. self.id)

	self.offsetRow = 0
	self.offsetColumn = 0

	return
end

function WorldCarryItem:UpdateOffset(arg_2_1, arg_2_2)
	if self.offsetRow ~= arg_2_1 or self.offsetColumn ~= arg_2_2 then
		self.offsetRow = arg_2_1
		self.offsetColumn = arg_2_2

		self:DispatchEvent(WorldCarryItem.EventUpdateOffset)
	end

	return
end

function WorldCarryItem:GetScale()
	return Vector3(self.config.scale / 100, self.config.scale / 100, 1)
end

function WorldCarryItem:IsAvatar()
	return self.config.enemyicon == 1
end

return WorldCarryItem
