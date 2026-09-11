local function var_0_0()
	local var_1_0 = {}

	for iter_1_0 = 1, 5 do
		local var_1_1 = math.random(0, 35)

		if var_1_1 < 10 then
			table.insert(var_1_0, string.char(var_1_1 + 48))
		else
			table.insert(var_1_0, string.char(var_1_1 - 10 + 65))
		end
	end

	return table.concat(var_1_0, ".")
end

return {
	INIT = string.format("@@redux/INIT%s", var_0_0()),
	REPLACE = string.format("@@redux/REPLACE%s", var_0_0()),
	PROBE_UNKNOWN_ACTION = function()
		return string.format("@@redux/PROBE_UNKNOWN_ACTION%s", var_0_0())
	end
}
