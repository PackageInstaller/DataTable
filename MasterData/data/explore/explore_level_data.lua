local var_0_0 = {}
local var_0_1 = {
	"data.explore.explore_level_10000_data",
	"data.explore.explore_level_1009_data",
	"data.explore.explore_level_1014_data",
	"data.explore.explore_level_1023_data",
	"data.explore.explore_level_1024_data",
	"data.explore.explore_level_1027_data",
	"data.explore.explore_level_1032_data",
	"data.explore.explore_level_1034_data",
	"data.explore.explore_level_1036_data",
	"data.explore.explore_level_1037_data",
	"data.explore.explore_level_146_data",
	"data.explore.explore_level_2020christmas_data",
	"data.explore.explore_level_2020spring_data",
	"data.explore.explore_level_204520_data",
	"data.explore.explore_level_204820_data",
	"data.explore.explore_level_205220_data",
	"data.explore.explore_level_205320_data",
	"data.explore.explore_level_206220_data",
	"data.explore.explore_level_206420_data",
	"data.explore.explore_level_207820_data",
	"data.explore.explore_level_208720_data",
	"data.explore.explore_level_210_data",
	"data.explore.explore_level_21330_data",
	"data.explore.explore_level_230_data",
	"data.explore.explore_level_264_data",
	"data.explore.explore_level_418_data",
	"data.explore.explore_level_430_data",
	"data.explore.explore_level_550_data",
	"data.explore.explore_level_576_data",
	"data.explore.explore_level_593_data",
	"data.explore.explore_level_714_data",
	"data.explore.explore_level_755_data",
	"data.explore.explore_level_767_data",
	"data.explore.explore_level_775_data",
	"data.explore.explore_level_792_data",
	"data.explore.explore_level_805_data",
	"data.explore.explore_level_806_data",
	"data.explore.explore_level_813_data",
	"data.explore.explore_level_830_data",
	"data.explore.explore_level_838_data",
	"data.explore.explore_level_855_data",
	"data.explore.explore_level_861_data",
	"data.explore.explore_level_865_data",
	"data.explore.explore_level_872_data",
	"data.explore.explore_level_881_data",
	"data.explore.explore_level_888_data",
	"data.explore.explore_level_891_data",
	"data.explore.explore_level_892_data",
	"data.explore.explore_level_TAP_data",
	"data.explore.explore_level_anniversary_data",
	"data.explore.explore_level_basic_data",
	"data.explore.explore_level_halloween_data",
	"data.explore.explore_level_hong_data",
	"data.explore.explore_level_keke_data",
	"data.explore.explore_level_moon_data",
	"data.explore.explore_level_peier_data",
	"data.explore.explore_level_qingrenjie2022_data",
	"data.explore.explore_level_stable_data",
	"data.explore.explore_level_summer2021_data",
	"data.explore.explore_level_umaru_data",
	"data.explore.explore_level_xuansahng1_data",
	"data.explore.explore_level_xuansahng2_data",
	"data.explore.explore_level_xuansahng3_data",
	"data.explore.explore_level_yuandan2021_data"
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
			print("explore_level_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
