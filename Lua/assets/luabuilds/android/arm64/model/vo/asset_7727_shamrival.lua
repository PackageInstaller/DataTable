local ShamRival = class("ShamRival", import(".Rival"))

function ShamRival:Ctor(arg_1_1)
	ShamRival.super.super.Ctor(self, arg_1_1)

	self.id = arg_1_1.id
	self.level = arg_1_1.level
	self.name = arg_1_1.name
	self.vanguardShips = {}
	self.mainShips = {}

	_.each(arg_1_1.ship_list, function(arg_2_0)
		local var_2_0 = Ship.New(arg_2_0)
		local var_2_1 = var_2_0:getTeamType()

		if var_2_1 == TeamType.Vanguard then
			table.insert(self.vanguardShips, var_2_0)
		elseif var_2_1 == TeamType.Main then
			table.insert(self.mainShips, var_2_0)
		end

		return
	end)

	return
end

return ShamRival
