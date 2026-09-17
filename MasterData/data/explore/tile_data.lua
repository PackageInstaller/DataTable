local var_0_0 = {}
local var_0_1 = {
	"data.explore.tile_10000_data",
	"data.explore.tile_10000_new_data",
	"data.explore.tile_1009_data",
	"data.explore.tile_1014_data",
	"data.explore.tile_1023_data",
	"data.explore.tile_1024_data",
	"data.explore.tile_1027_data",
	"data.explore.tile_1032_data",
	"data.explore.tile_1034_data",
	"data.explore.tile_1036_data",
	"data.explore.tile_1037_data",
	"data.explore.tile_146_data",
	"data.explore.tile_2020christmas_data",
	"data.explore.tile_2020spring_data",
	"data.explore.tile_204520_data",
	"data.explore.tile_204820_data",
	"data.explore.tile_205220_data",
	"data.explore.tile_205320_data",
	"data.explore.tile_206220_data",
	"data.explore.tile_206420_data",
	"data.explore.tile_207820_data",
	"data.explore.tile_208720_data",
	"data.explore.tile_210_data",
	"data.explore.tile_21330_data",
	"data.explore.tile_230_data",
	"data.explore.tile_264_data",
	"data.explore.tile_418_data",
	"data.explore.tile_430_data",
	"data.explore.tile_550_data",
	"data.explore.tile_576_data",
	"data.explore.tile_593_data",
	"data.explore.tile_714_data",
	"data.explore.tile_755_data",
	"data.explore.tile_767_data",
	"data.explore.tile_775_data",
	"data.explore.tile_792_data",
	"data.explore.tile_805_data",
	"data.explore.tile_806_data",
	"data.explore.tile_813_data",
	"data.explore.tile_830_data",
	"data.explore.tile_838_data",
	"data.explore.tile_855_data",
	"data.explore.tile_861_data",
	"data.explore.tile_865_data",
	"data.explore.tile_872_data",
	"data.explore.tile_881_data",
	"data.explore.tile_888_data",
	"data.explore.tile_891_data",
	"data.explore.tile_892_data",
	"data.explore.tile_TAP_data",
	"data.explore.tile_anniversary_data",
	"data.explore.tile_basic_data",
	"data.explore.tile_halloween_data",
	"data.explore.tile_hong_data",
	"data.explore.tile_keke_data",
	"data.explore.tile_moon_data",
	"data.explore.tile_peier_data",
	"data.explore.tile_qingrenjie2022_data",
	"data.explore.tile_stable_data",
	"data.explore.tile_summer2021_data",
	"data.explore.tile_umaru_data",
	"data.explore.tile_xuanshang1_data",
	"data.explore.tile_xuanshang2_data",
	"data.explore.tile_xuanshang3_data",
	"data.explore.tile_xuanshangnew3_data",
	"data.explore.tile_xuanshangnew4_data",
	"data.explore.tile_xuanshangxin1_data",
	"data.explore.tile_xuanshangxin2_data",
	"data.explore.tile_yizhixuanshang1_data",
	"data.explore.tile_yizhixuanshang2_data",
	"data.explore.tile_yuandan2021_data"
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
			print("tile_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
