local var_0_0 = {}
local var_0_1 = {
	"data.explore.explore_aim_10000_data",
	"data.explore.explore_aim_1009_data",
	"data.explore.explore_aim_1014_data",
	"data.explore.explore_aim_1023_data",
	"data.explore.explore_aim_1024_data",
	"data.explore.explore_aim_1027_data",
	"data.explore.explore_aim_1032_data",
	"data.explore.explore_aim_1034_data",
	"data.explore.explore_aim_1036_data",
	"data.explore.explore_aim_1037_data",
	"data.explore.explore_aim_146_data",
	"data.explore.explore_aim_2020christmas_data",
	"data.explore.explore_aim_2020spring_data",
	"data.explore.explore_aim_204520_data",
	"data.explore.explore_aim_204820_data",
	"data.explore.explore_aim_205220_data",
	"data.explore.explore_aim_205320_data",
	"data.explore.explore_aim_206220_data",
	"data.explore.explore_aim_206420_data",
	"data.explore.explore_aim_207820_data",
	"data.explore.explore_aim_208720_data",
	"data.explore.explore_aim_210_data",
	"data.explore.explore_aim_21330_data",
	"data.explore.explore_aim_230_data",
	"data.explore.explore_aim_264_data",
	"data.explore.explore_aim_418_data",
	"data.explore.explore_aim_430_data",
	"data.explore.explore_aim_550_data",
	"data.explore.explore_aim_576_data",
	"data.explore.explore_aim_593_data",
	"data.explore.explore_aim_714_data",
	"data.explore.explore_aim_755_data",
	"data.explore.explore_aim_767_data",
	"data.explore.explore_aim_775_data",
	"data.explore.explore_aim_792_data",
	"data.explore.explore_aim_805_data",
	"data.explore.explore_aim_806_data",
	"data.explore.explore_aim_813_data",
	"data.explore.explore_aim_830_data",
	"data.explore.explore_aim_838_data",
	"data.explore.explore_aim_855_data",
	"data.explore.explore_aim_861_data",
	"data.explore.explore_aim_865_data",
	"data.explore.explore_aim_872_data",
	"data.explore.explore_aim_881_data",
	"data.explore.explore_aim_888_data",
	"data.explore.explore_aim_891_data",
	"data.explore.explore_aim_892_data",
	"data.explore.explore_aim_TAP_data",
	"data.explore.explore_aim_anniversary_data",
	"data.explore.explore_aim_basic_data",
	"data.explore.explore_aim_halloween_data",
	"data.explore.explore_aim_hong_data",
	"data.explore.explore_aim_keke_data",
	"data.explore.explore_aim_moon_data",
	"data.explore.explore_aim_peier_data",
	"data.explore.explore_aim_qingrenjie2022_data",
	"data.explore.explore_aim_stable_data",
	"data.explore.explore_aim_summer2021_data",
	"data.explore.explore_aim_umaru_data",
	"data.explore.explore_aim_xuanshang1_data",
	"data.explore.explore_aim_xuanshang2_data",
	"data.explore.explore_aim_xuanshang3_data",
	"data.explore.explore_aim_xuanshangnew3_data",
	"data.explore.explore_aim_xuanshangnew4_data",
	"data.explore.explore_aim_xuanshangxin1_data",
	"data.explore.explore_aim_xuanshangxin2_data",
	"data.explore.explore_aim_yizhixuanshang1_data",
	"data.explore.explore_aim_yizhixuanshang2_data",
	"data.explore.explore_aim_yuandan2021_data"
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
			print("explore_aim_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
