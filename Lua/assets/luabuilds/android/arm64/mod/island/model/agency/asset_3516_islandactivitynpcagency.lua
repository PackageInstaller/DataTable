local IslandActivityNpcAgency = class("IslandActivityNpcAgency", import(".IslandBaseAgency"))

IslandActivityNpcAgency.ACTIVITY_NPC_ADD = "IslandActivityNpcAgency:ACTIVITY_NPC_ADD"
IslandActivityNpcAgency.ACTIVITY_NPC_UPDATE = "IslandActivityNpcAgency:ACTIVITY_NPC_UPDATE"
IslandActivityNpcAgency.ACTIVITY_NPC_DEL = "IslandActivityNpcAgency:ACTIVITY_NPC_DEL"

function IslandActivityNpcAgency:OnInit(arg_1_1)
	self.activityNpcs = {}

	return
end

function IslandActivityNpcAgency:ExistTradeNpc()
	for iter_2_0, iter_2_1 in pairs(self.activityNpcs) do
		if pg.island_world_objects[iter_2_1] and pg.island_world_objects[iter_2_1].type == 1 and pg.island_world_objects[iter_2_1].unitId == 101500 then
			return true, iter_2_1
		end
	end

	return false
end

function IslandActivityNpcAgency:InitNpcList(arg_3_1)
	self.activityNpcs = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		self.activityNpcs[iter_3_1.id] = iter_3_1.object_id
	end

	return
end

function IslandActivityNpcAgency:GetNpcList()
	return self.activityNpcs
end

function IslandActivityNpcAgency:GetNpcObjects()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self.activityNpcs) do
		table.insert(var_5_0, iter_5_1)
	end

	return var_5_0
end

function IslandActivityNpcAgency:AddNpc(arg_6_1)
	if not self:IncludeNpc(arg_6_1) then
		self.activityNpcs[arg_6_1.id] = arg_6_1.object_id

		self:DispatchEvent(IslandActivityNpcAgency.ACTIVITY_NPC_ADD, arg_6_1.object_id)
	end

	return
end

function IslandActivityNpcAgency:UpdateNpc(arg_7_1)
	if self:IncludeNpc(arg_7_1) then
		self.activityNpcs[arg_7_1.id] = arg_7_1.object_id

		self:DispatchEvent(IslandActivityNpcAgency.ACTIVITY_NPC_UPDATE, self.activityNpcs[arg_7_1.id], arg_7_1.object_id)
	end

	return
end

function IslandActivityNpcAgency:RemoveNpc(arg_8_1)
	if self:IncludeNpc(arg_8_1) then
		self.activityNpcs[arg_8_1.id] = nil

		self:DispatchEvent(IslandActivityNpcAgency.ACTIVITY_NPC_DEL, self.activityNpcs[arg_8_1.id])
	end

	return
end

function IslandActivityNpcAgency:IncludeNpc(arg_9_1)
	return self.activityNpcs[npcId] ~= nil
end

return IslandActivityNpcAgency
