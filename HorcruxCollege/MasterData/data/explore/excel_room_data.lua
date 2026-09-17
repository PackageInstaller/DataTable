local var_0_0 = {}
local var_0_1 = {
	"data.explore.excel_room_10000_data",
	"data.explore.excel_room_1009_data",
	"data.explore.excel_room_1014_data",
	"data.explore.excel_room_1023_data",
	"data.explore.excel_room_1024_data",
	"data.explore.excel_room_1027_data",
	"data.explore.excel_room_1032_data",
	"data.explore.excel_room_1034_data",
	"data.explore.excel_room_1036_data",
	"data.explore.excel_room_1037_data",
	"data.explore.excel_room_146_data",
	"data.explore.excel_room_2020christmas_data",
	"data.explore.excel_room_2020spring_data",
	"data.explore.excel_room_204520_data",
	"data.explore.excel_room_204820_data",
	"data.explore.excel_room_205220_data",
	"data.explore.excel_room_205320_data",
	"data.explore.excel_room_206220_data",
	"data.explore.excel_room_206420_data",
	"data.explore.excel_room_207820_data",
	"data.explore.excel_room_208720_data",
	"data.explore.excel_room_210_data",
	"data.explore.excel_room_21330_data",
	"data.explore.excel_room_230_data",
	"data.explore.excel_room_264_data",
	"data.explore.excel_room_413_data",
	"data.explore.excel_room_418_data",
	"data.explore.excel_room_550_data",
	"data.explore.excel_room_576_data",
	"data.explore.excel_room_593_data",
	"data.explore.excel_room_714_data",
	"data.explore.excel_room_755_data",
	"data.explore.excel_room_767_data",
	"data.explore.excel_room_775_data",
	"data.explore.excel_room_792_data",
	"data.explore.excel_room_805_data",
	"data.explore.excel_room_806_data",
	"data.explore.excel_room_813_data",
	"data.explore.excel_room_830_data",
	"data.explore.excel_room_838_data",
	"data.explore.excel_room_855_data",
	"data.explore.excel_room_861_data",
	"data.explore.excel_room_865_data",
	"data.explore.excel_room_872_data",
	"data.explore.excel_room_881_data",
	"data.explore.excel_room_888_data",
	"data.explore.excel_room_891_data",
	"data.explore.excel_room_892_data",
	"data.explore.excel_room_TAP_data",
	"data.explore.excel_room_anniversary_data",
	"data.explore.excel_room_basic_data",
	"data.explore.excel_room_halloween_data",
	"data.explore.excel_room_hong_data",
	"data.explore.excel_room_keke_data",
	"data.explore.excel_room_moon_data",
	"data.explore.excel_room_peier_data",
	"data.explore.excel_room_qingrenjie2022_data",
	"data.explore.excel_room_stable_data",
	"data.explore.excel_room_summer2021_data",
	"data.explore.excel_room_umaru_data",
	"data.explore.excel_room_xuanshang1_data",
	"data.explore.excel_room_xuanshang2_data",
	"data.explore.excel_room_xuanshang3_data",
	"data.explore.excel_room_xuanshangnew3_data",
	"data.explore.excel_room_xuanshangnew4_data",
	"data.explore.excel_room_xuanshangxin1_data",
	"data.explore.excel_room_xuanshangxin2_data",
	"data.explore.excel_room_yizhixuanshang1_data",
	"data.explore.excel_room_yizhixuanshang2_data",
	"data.explore.excel_room_yuandan2021_data"
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
			print("excel_room_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
