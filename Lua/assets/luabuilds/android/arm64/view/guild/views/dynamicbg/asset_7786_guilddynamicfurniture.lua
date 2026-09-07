local GuildDynamicFurniture = class("GuildDynamicFurniture")

GuildDynamicFurniture.INTERACTION_MODE_SIT = 1

function GuildDynamicFurniture:Ctor(arg_1_1)
	self._go = arg_1_1.go
	self._tf = GetOrAddComponent(arg_1_1.go, typeof(RectTransform))
	self.size = arg_1_1.size
	self.path = arg_1_1.path
	self.offset = arg_1_1.offset
	self.mode = arg_1_1.mode
	self.interactionDir = arg_1_1.interactionDir or 1
	self.interactionPosition = arg_1_1.interactionPosition

	self:SetPosition(arg_1_1.grid)

	self.islock = false

	return
end

function GuildDynamicFurniture:SetPosition(arg_2_1)
	local var_2_0 = arg_2_1:GetLocalPosition()

	self._tf.localPosition = Vector3(var_2_0.x + self.offset.x, var_2_0.y + self.offset.y, 0)
	self.grid = arg_2_1

	for iter_2_0, iter_2_1 in ipairs((self:GetOccupyGrid())) do
		iter_2_1:Lock()
	end

	return
end

function GuildDynamicFurniture:GetOccupyGrid()
	local var_3_0 = {}

	for iter_3_0 = 0, self.size.x - 1 do
		for iter_3_1 = 0, self.size.y - 1 do
			table.insert(var_3_0, self.path[self.grid.position.x + iter_3_0][self.grid.position.y + iter_3_1])
		end
	end

	return var_3_0
end

function GuildDynamicFurniture:Lock()
	self.islock = true

	return
end

function GuildDynamicFurniture:Unlock()
	self.islock = false

	return
end

function GuildDynamicFurniture:BeLock()
	return self.islock == true
end

function GuildDynamicFurniture:GetInterActionPos()
	return self.interactionPosition
end

function GuildDynamicFurniture:GetInterActionMode()
	return self.mode
end

function GuildDynamicFurniture:SetAsLastSibling()
	self._tf:SetAsLastSibling()

	return
end

function GuildDynamicFurniture:GetInteractionDir()
	return self.interactionDir
end

function GuildDynamicFurniture:Dispose()
	return
end

return GuildDynamicFurniture
