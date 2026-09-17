local var_0_0 = {}
local var_0_1 = {
	"data.activity_767.activity_flop_champion_767_data",
	"data.activity_775.activity_flop_champion_775_data",
	"data.activity_776.activity_flop_champion_776_data",
	"data.activity_786.activity_flop_champion_786_data",
	"data.activity_805.activity_flop_champion_805_data",
	"data.activity_806.activity_flop_champion_806_data",
	"data.activity_811.activity_flop_champion_811_data",
	"data.activity_813.activity_flop_champion_813_data",
	"data.activity_837.activity_flop_champion_837_data",
	"data.activity_838.activity_flop_champion_838_data",
	"data.activity_839.activity_flop_champion_839_data",
	"data.activity_846.activity_flop_champion_846_data",
	"data.activity_855.activity_flop_champion_855_data",
	"data.activity_865.activity_flop_champion_865_data",
	"data.activity_866.activity_flop_champion_866_data",
	"data.activity_869.activity_flop_champion_869_data",
	"data.activity_876.activity_flop_champion_876_data",
	"data.activity_881.activity_flop_champion_881_data",
	"data.activity_888.activity_flop_champion_888_data",
	"data.activity_891.activity_flop_champion_891_data",
	"data.activity_892.activity_flop_champion_892_data",
	"data.activity_896.activity_flop_champion_896_data",
	"data.activity_commonflop_champion_data",
	"data.activity_flop_champion_755_data",
	"data.activity_flop_champion_758_data"
}

if DeviceManager.platform == "windows" then
	local var_0_2 = {}

	for iter_0_0, iter_0_1 in ipairs(var_0_1) do
		for iter_0_2, iter_0_3 in pairs((require(iter_0_1))) do
			if var_0_2[iter_0_2] then
				error(iter_0_2 .. " is conflict between " .. var_0_2[iter_0_2] .. " and " .. iter_0_1 .. ", 快叫凯达去改表")
			else
				var_0_2[iter_0_2] = iter_0_1
			end
		end
	end
end

for iter_0_4, iter_0_5 in pairs(var_0_1) do
	table.merge(var_0_0, (require(iter_0_5)))
end

setmetatable(var_0_0, {
	__index = function(arg_1_0, arg_1_1)
		if arg_1_1 then
			print("activity_flop_champion_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
