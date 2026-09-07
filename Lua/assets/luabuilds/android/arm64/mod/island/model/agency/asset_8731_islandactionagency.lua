local IslandActionAgency = class("IslandActionAgency", import(".IslandBaseAgency"))

function IslandActionAgency:OnInit(arg_1_1)
	self.actionList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.action_list) do
		table.insert(self.actionList, iter_1_1)
	end

	if pg.island_set.default_action then
		for iter_1_2, iter_1_3 in ipairs(pg.island_set.default_action.key_value_varchar) do
			if not self:ExistAction(iter_1_3) then
				table.insert(self.actionList, iter_1_3)
			end
		end
	end

	return
end

function IslandActionAgency:GetActionList()
	return self.actionList
end

function IslandActionAgency:ExistAction(arg_3_1)
	return table.contains(self.actionList, arg_3_1)
end

function IslandActionAgency:AddAction(arg_4_1)
	table.insert(self.actionList, arg_4_1)

	return
end

return IslandActionAgency
