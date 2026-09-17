local var_0_0 = {}
local var_0_1 = {
	"data.explore.explore_monster_team_10000_data",
	"data.explore.explore_monster_team_1009_data",
	"data.explore.explore_monster_team_1014_data",
	"data.explore.explore_monster_team_1023_data",
	"data.explore.explore_monster_team_1024_data",
	"data.explore.explore_monster_team_1027_data",
	"data.explore.explore_monster_team_1032_data",
	"data.explore.explore_monster_team_1034_data",
	"data.explore.explore_monster_team_1036_data",
	"data.explore.explore_monster_team_1037_data",
	"data.explore.explore_monster_team_146_data",
	"data.explore.explore_monster_team_2020christmas_data",
	"data.explore.explore_monster_team_2020spring_data",
	"data.explore.explore_monster_team_204520_data",
	"data.explore.explore_monster_team_204820_data",
	"data.explore.explore_monster_team_205220_data",
	"data.explore.explore_monster_team_205320_data",
	"data.explore.explore_monster_team_206220_data",
	"data.explore.explore_monster_team_206420_data",
	"data.explore.explore_monster_team_207820_data",
	"data.explore.explore_monster_team_208720_data",
	"data.explore.explore_monster_team_210_data",
	"data.explore.explore_monster_team_21330_data",
	"data.explore.explore_monster_team_230_data",
	"data.explore.explore_monster_team_264_data",
	"data.explore.explore_monster_team_418_data",
	"data.explore.explore_monster_team_430_data",
	"data.explore.explore_monster_team_576_data",
	"data.explore.explore_monster_team_593_data",
	"data.explore.explore_monster_team_714_data",
	"data.explore.explore_monster_team_755_data",
	"data.explore.explore_monster_team_767_data",
	"data.explore.explore_monster_team_775_data",
	"data.explore.explore_monster_team_792_data",
	"data.explore.explore_monster_team_805_data",
	"data.explore.explore_monster_team_806_data",
	"data.explore.explore_monster_team_813_data",
	"data.explore.explore_monster_team_830_data",
	"data.explore.explore_monster_team_838_data",
	"data.explore.explore_monster_team_855_data",
	"data.explore.explore_monster_team_861_data",
	"data.explore.explore_monster_team_865_data",
	"data.explore.explore_monster_team_872_data",
	"data.explore.explore_monster_team_881_data",
	"data.explore.explore_monster_team_888_data",
	"data.explore.explore_monster_team_891_data",
	"data.explore.explore_monster_team_892_data",
	"data.explore.explore_monster_team_TAP_data",
	"data.explore.explore_monster_team_anniversary_data",
	"data.explore.explore_monster_team_basic_data",
	"data.explore.explore_monster_team_halloween_data",
	"data.explore.explore_monster_team_hong_data",
	"data.explore.explore_monster_team_keke_data",
	"data.explore.explore_monster_team_moon_data",
	"data.explore.explore_monster_team_peier_data",
	"data.explore.explore_monster_team_qingrenjie2022_data",
	"data.explore.explore_monster_team_stable_data",
	"data.explore.explore_monster_team_summer2021_data",
	"data.explore.explore_monster_team_umaru_data",
	"data.explore.explore_monster_team_xuanshang1_data",
	"data.explore.explore_monster_team_xuanshang2_data",
	"data.explore.explore_monster_team_xuanshang3_data",
	"data.explore.explore_monster_team_yuandan2021_data"
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
			print("explore_monster_team_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
