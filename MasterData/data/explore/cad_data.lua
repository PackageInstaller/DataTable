local var_0_0 = {}
local var_0_1 = {
	"data.explore.cad_10000_data",
	"data.explore.cad_1009_data",
	"data.explore.cad_1014_data",
	"data.explore.cad_1023_data",
	"data.explore.cad_1024_data",
	"data.explore.cad_1027_data",
	"data.explore.cad_1032_data",
	"data.explore.cad_1034_data",
	"data.explore.cad_1036_data",
	"data.explore.cad_1037_data",
	"data.explore.cad_146_data",
	"data.explore.cad_2020christmas_data",
	"data.explore.cad_2020spring_data",
	"data.explore.cad_204520_data",
	"data.explore.cad_204820_data",
	"data.explore.cad_205220_data",
	"data.explore.cad_205320_data",
	"data.explore.cad_206220_data",
	"data.explore.cad_206420_data",
	"data.explore.cad_207820_data",
	"data.explore.cad_208720_data",
	"data.explore.cad_210_data",
	"data.explore.cad_21330_data",
	"data.explore.cad_230_data",
	"data.explore.cad_264_data",
	"data.explore.cad_418_data",
	"data.explore.cad_430_data",
	"data.explore.cad_550_data",
	"data.explore.cad_576_data",
	"data.explore.cad_593_data",
	"data.explore.cad_714_data",
	"data.explore.cad_755_data",
	"data.explore.cad_767_data",
	"data.explore.cad_775_data",
	"data.explore.cad_792_data",
	"data.explore.cad_805_data",
	"data.explore.cad_806_data",
	"data.explore.cad_813_data",
	"data.explore.cad_830_data",
	"data.explore.cad_838_data",
	"data.explore.cad_855_data",
	"data.explore.cad_861_data",
	"data.explore.cad_865_data",
	"data.explore.cad_872_data",
	"data.explore.cad_881_data",
	"data.explore.cad_888_data",
	"data.explore.cad_891_data",
	"data.explore.cad_892_data",
	"data.explore.cad_TAP_data",
	"data.explore.cad_anniversary_data",
	"data.explore.cad_basic_data",
	"data.explore.cad_halloween_data",
	"data.explore.cad_hong_data",
	"data.explore.cad_keke_data",
	"data.explore.cad_moon_data",
	"data.explore.cad_peier_data",
	"data.explore.cad_qingrenjie2022_data",
	"data.explore.cad_stable_data",
	"data.explore.cad_summer2021_data",
	"data.explore.cad_umaru_data",
	"data.explore.cad_xuanshang1_data",
	"data.explore.cad_xuanshang2_data",
	"data.explore.cad_xuanshang3_data",
	"data.explore.cad_xuanshangnew3_data",
	"data.explore.cad_xuanshangnew4_data",
	"data.explore.cad_xuanshangxin1_data",
	"data.explore.cad_xuanshangxin2_data",
	"data.explore.cad_yizhixuanshang1_data",
	"data.explore.cad_yizhixuanshang2_data",
	"data.explore.cad_yuandan2021_data"
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
			print("cad_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
