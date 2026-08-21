local var_0_0 = class("NetFleetUpdate", import("....BaseEntity"))

var_0_0.Fields = {
	id = "number",
	buffs = "table"
}

function var_0_0.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.buffs = WorldConst.ParsingBuffs(arg_1_1.buff_list)

	return
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_0.GetBuffsByTrap(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.buffs) do
		if iter_3_1:GetFloor() > 0 and iter_3_1:GetTrapType() == arg_3_1 then
			table.insert({}, iter_3_1)
		end
	end

	return {}
end

return var_0_0
