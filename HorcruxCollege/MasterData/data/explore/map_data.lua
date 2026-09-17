local var_0_0 = {}
local var_0_1 = {
	"data.explore.map_10000_data",
	"data.explore.map_1009_data",
	"data.explore.map_1014_data",
	"data.explore.map_1023_data",
	"data.explore.map_1024_data",
	"data.explore.map_1027_data",
	"data.explore.map_1032_data",
	"data.explore.map_1034_data",
	"data.explore.map_1036_data",
	"data.explore.map_1037_data",
	"data.explore.map_146_data",
	"data.explore.map_2020christmas_data",
	"data.explore.map_2020spring_data",
	"data.explore.map_204520_data",
	"data.explore.map_204820_data",
	"data.explore.map_205220_data",
	"data.explore.map_205320_data",
	"data.explore.map_206220_data",
	"data.explore.map_206420_data",
	"data.explore.map_207820_data",
	"data.explore.map_208720_data",
	"data.explore.map_210_data",
	"data.explore.map_21330_data",
	"data.explore.map_230_data",
	"data.explore.map_264_data",
	"data.explore.map_418_data",
	"data.explore.map_430_data",
	"data.explore.map_576_data",
	"data.explore.map_593_data",
	"data.explore.map_714_data",
	"data.explore.map_755_data",
	"data.explore.map_767_data",
	"data.explore.map_775_data",
	"data.explore.map_792_data",
	"data.explore.map_805_data",
	"data.explore.map_806_data",
	"data.explore.map_813_data",
	"data.explore.map_830_data",
	"data.explore.map_838_data",
	"data.explore.map_855_data",
	"data.explore.map_861_data",
	"data.explore.map_865_data",
	"data.explore.map_872_data",
	"data.explore.map_881_data",
	"data.explore.map_888_data",
	"data.explore.map_891_data",
	"data.explore.map_892_data",
	"data.explore.map_TAP_data",
	"data.explore.map_anniversary_data",
	"data.explore.map_basic_data",
	"data.explore.map_halloween_data",
	"data.explore.map_hong_data",
	"data.explore.map_keke_data",
	"data.explore.map_moon_data",
	"data.explore.map_peier_data",
	"data.explore.map_qingrenjie2022_data",
	"data.explore.map_stable_data",
	"data.explore.map_summer2021_data",
	"data.explore.map_umaru_data",
	"data.explore.map_xuanshang1_data",
	"data.explore.map_xuanshang2_data",
	"data.explore.map_xuanshang3_data",
	"data.explore.map_xuanshangnew3_data",
	"data.explore.map_xuanshangnew4_data",
	"data.explore.map_xuanshangxin1_data",
	"data.explore.map_xuanshangxin2_data",
	"data.explore.map_yizhixuanshang1_data",
	"data.explore.map_yizhixuanshang2_data",
	"data.explore.map_yuandan2021_data"
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
			print("map_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
