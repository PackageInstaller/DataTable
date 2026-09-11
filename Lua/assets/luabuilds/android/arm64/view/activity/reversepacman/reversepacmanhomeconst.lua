local var_0_0 = {
	ROLE_TYPE = {
		CHASER = 1,
		PLANNER = 3,
		ALL = 0,
		AMBUSHER = 2
	},
	SPEED_LEVEL = {
		{
			color = "#59606d",
			value = "C",
			range = {
				0,
				99
			}
		},
		{
			color = "#5483c9",
			value = "B",
			range = {
				100,
				149
			}
		},
		{
			color = "#7d54c9",
			value = "A",
			range = {
				150,
				199
			}
		},
		{
			color = "#ff7022",
			value = "S",
			range = {
				200,
				400
			}
		}
	}
}

function var_0_0.GetSpeedLevel(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(var_0_0.SPEED_LEVEL) do
		if arg_1_0 >= iter_1_1.range[1] and arg_1_0 <= iter_1_1.range[2] then
			return iter_1_1
		end
	end

	return
end

return var_0_0
