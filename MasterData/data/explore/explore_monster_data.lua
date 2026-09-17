local var_0_0 = {}
local var_0_1 = {
	"data.explore.explore_monster_10000_data",
	"data.explore.explore_monster_1009_data",
	"data.explore.explore_monster_1014_data",
	"data.explore.explore_monster_1023_data",
	"data.explore.explore_monster_1024_data",
	"data.explore.explore_monster_1027_data",
	"data.explore.explore_monster_1032_data",
	"data.explore.explore_monster_1034_data",
	"data.explore.explore_monster_1036_data",
	"data.explore.explore_monster_1037_data",
	"data.explore.explore_monster_146_data",
	"data.explore.explore_monster_2020christmas_data",
	"data.explore.explore_monster_2020spring_data",
	"data.explore.explore_monster_204520_data",
	"data.explore.explore_monster_204820_data",
	"data.explore.explore_monster_205220_data",
	"data.explore.explore_monster_205320_data",
	"data.explore.explore_monster_206220_data",
	"data.explore.explore_monster_206420_data",
	"data.explore.explore_monster_207820_data",
	"data.explore.explore_monster_208720_data",
	"data.explore.explore_monster_210_data",
	"data.explore.explore_monster_21330_data",
	"data.explore.explore_monster_230_data",
	"data.explore.explore_monster_264_data",
	"data.explore.explore_monster_418_data",
	"data.explore.explore_monster_430_data",
	"data.explore.explore_monster_550_data",
	"data.explore.explore_monster_576_data",
	"data.explore.explore_monster_593_data",
	"data.explore.explore_monster_714_data",
	"data.explore.explore_monster_755_data",
	"data.explore.explore_monster_767_data",
	"data.explore.explore_monster_775_data",
	"data.explore.explore_monster_792_data",
	"data.explore.explore_monster_805_data",
	"data.explore.explore_monster_806_data",
	"data.explore.explore_monster_813_data",
	"data.explore.explore_monster_830_data",
	"data.explore.explore_monster_838_data",
	"data.explore.explore_monster_855_data",
	"data.explore.explore_monster_861_data",
	"data.explore.explore_monster_865_data",
	"data.explore.explore_monster_872_data",
	"data.explore.explore_monster_881_data",
	"data.explore.explore_monster_888_data",
	"data.explore.explore_monster_891_data",
	"data.explore.explore_monster_892_data",
	"data.explore.explore_monster_TAP_data",
	"data.explore.explore_monster_anniversary_data",
	"data.explore.explore_monster_basic_data",
	"data.explore.explore_monster_halloween_data",
	"data.explore.explore_monster_hong_data",
	"data.explore.explore_monster_keke_data",
	"data.explore.explore_monster_moon_data",
	"data.explore.explore_monster_peier_data",
	"data.explore.explore_monster_qingrenjie2022_data",
	"data.explore.explore_monster_stable_data",
	"data.explore.explore_monster_summer2021_data",
	"data.explore.explore_monster_umaru_data",
	"data.explore.explore_monster_xuanshang1_data",
	"data.explore.explore_monster_xuanshang2_data",
	"data.explore.explore_monster_xuanshang3_data",
	"data.explore.explore_monster_yuandan2021_data"
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
			print("explore_monster_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
