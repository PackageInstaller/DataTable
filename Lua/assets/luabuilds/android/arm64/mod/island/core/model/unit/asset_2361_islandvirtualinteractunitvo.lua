local IslandVirtualInteractUnitVO = class("IslandVirtualInteractUnitVO", import(".IslandInteractUnitVO"))

function IslandVirtualInteractUnitVO:Ctor(arg_1_1)
	IslandVirtualInteractUnitVO.super.super.Ctor(self, arg_1_1)

	self.config = pg.island_interact_point[self.modelId]
	self.behaviourTree = self.config.bt
	self.slots = {}

	for iter_1_0 = 1, self.config.slot_cnt do
		table.insert(self.slots, InteractSlot.New(iter_1_0, self.id))
	end

	self:InitTimlineInfo()

	return
end

function IslandVirtualInteractUnitVO:GetAssetPath()
	return nil
end

function IslandVirtualInteractUnitVO:GetPlayerParentPath(arg_3_1)
	if self.config.player_parent_path == "" or arg_3_1 > #self.config.player_parent_path then
		return nil
	end

	return self.config.player_parent_path[arg_3_1]
end

return IslandVirtualInteractUnitVO
