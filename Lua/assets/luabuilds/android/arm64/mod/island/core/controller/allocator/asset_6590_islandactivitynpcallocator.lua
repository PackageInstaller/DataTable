local IslandActivityNpcAllocator = class("IslandActivityNpcAllocator", import(".IslandComparableAllocator"))

function IslandActivityNpcAllocator:Ctor(arg_1_1)
	self.npcList = arg_1_1:GetIsland():GetActivityNpcAgency():GetNpcObjects()

	IslandActivityNpcAllocator.super.Ctor(self, arg_1_1)

	return
end

function IslandActivityNpcAllocator:AddNpc(arg_2_1)
	if not table.contains(self.npcList, arg_2_1) then
		table.insert(self.npcList, arg_2_1)
	end

	return
end

function IslandActivityNpcAllocator:DelNpc(arg_3_1)
	if table.contains(self.npcList, arg_3_1) then
		table.removebyvalue(self.npcList, arg_3_1)
	end

	return
end

function IslandActivityNpcAllocator:OnInitFlags()
	for iter_4_0, iter_4_1 in ipairs(self.controller.sceneData.activityUnits) do
		self.flags[iter_4_1.id] = self:IsVisible(iter_4_1.id)
	end

	return
end

function IslandActivityNpcAllocator:IsVisible(arg_5_1)
	if not table.contains(self.npcList, arg_5_1) then
		return false
	end

	local var_5_0 = pg.island_world_objects[arg_5_1]

	if not pg.island_world_objects[arg_5_1] then
		return false
	end

	local var_5_1

	if var_5_0.param.activity then
		var_5_1 = var_5_0.param.activity[1] or 0

		if var_5_1 <= 0 then
			return false
		end
	end

	local var_5_2 = getProxy(ActivityProxy):RawGetActivityById(var_5_1)

	return var_5_2 and not var_5_2:isEnd()
end

function IslandActivityNpcAllocator:OnCompareSample(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		if iter_6_1 ~= nil and arg_6_2[iter_6_0] ~= nil and iter_6_1 ~= arg_6_2[iter_6_0] then
			if iter_6_1 == true and arg_6_2[iter_6_0] == false then
				self:RemoveUnit(IslandConst.UNIT_LIST_OBJ, iter_6_0)
			elseif iter_6_1 == false and arg_6_2[iter_6_0] == true then
				local var_6_1 = self:GetUnitData(iter_6_0)

				if var_6_1 then
					self:GenUnit(var_6_1)
				end
			end
		end
	end

	return
end

function IslandActivityNpcAllocator:GetUnitData(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(self.controller.sceneData.activityUnits) do
		if iter_7_1.id == arg_7_1 then
			return iter_7_1
		end
	end

	return nil
end

return IslandActivityNpcAllocator
