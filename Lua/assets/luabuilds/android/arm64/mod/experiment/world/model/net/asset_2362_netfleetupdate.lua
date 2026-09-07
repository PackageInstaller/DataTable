local NetFleetUpdate = class("NetFleetUpdate", import("....BaseEntity"))

NetFleetUpdate.Fields = {
	id = "number",
	buffs = "table"
}

function NetFleetUpdate:Setup(arg_1_1)
	self.id = arg_1_1.id
	self.buffs = WorldConst.ParsingBuffs(arg_1_1.buff_list)

	return
end

function NetFleetUpdate:Dispose()
	self:Clear()

	return
end

function NetFleetUpdate:GetBuffsByTrap(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(self.buffs) do
		if iter_3_1:GetFloor() > 0 and iter_3_1:GetTrapType() == arg_3_1 then
			table.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

return NetFleetUpdate
