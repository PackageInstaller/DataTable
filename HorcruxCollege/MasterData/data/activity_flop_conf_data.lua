local var_0_0 = {}
local var_0_1 = {
	"data.activity_230.activity_flop_230_data",
	"data.activity_264.activity_flop_264_data",
	"data.activity_291.activity_flop_291_data",
	"data.activity_304.activity_flop_304_data",
	"data.activity_312.activity_flop_312_data",
	"data.activity_330.activity_flop_330_data",
	"data.activity_333.activity_flop_333_data",
	"data.activity_334.activity_flop_334_data",
	"data.activity_405.activity_flop_405_data",
	"data.activity_418.activity_flop_418_data",
	"data.activity_428.activity_flop_428_data",
	"data.activity_430.activity_flop_430_data",
	"data.activity_433.activity_flop_433_data",
	"data.activity_436.activity_flop_436_data",
	"data.activity_441.activity_flop_441_data",
	"data.activity_450.activity_flop_450_data",
	"data.activity_457.activity_flop_457_data",
	"data.activity_458.activity_flop_458_data",
	"data.activity_462.activity_flop_462_data",
	"data.activity_465.activity_flop_465_data",
	"data.activity_481.activity_flop_481_data",
	"data.activity_485.activity_flop_485_data",
	"data.activity_490.activity_flop_490_data",
	"data.activity_491.activity_flop_491_data",
	"data.activity_500.activity_flop_500_data",
	"data.activity_507.activity_flop_507_data",
	"data.activity_512.activity_flop_512_data",
	"data.activity_526.activity_flop_526_data",
	"data.activity_528.activity_flop_528_data",
	"data.activity_529.activity_flop_529_data",
	"data.activity_538.activity_flop_538_data",
	"data.activity_542.activity_flop_542_data",
	"data.activity_543.activity_flop_543_data",
	"data.activity_545.activity_flop_545_data",
	"data.activity_547.activity_flop_547_data",
	"data.activity_550.activity_flop_550_data",
	"data.activity_557.activity_flop_557_data",
	"data.activity_561.activity_flop_561_data",
	"data.activity_562.activity_flop_562_data",
	"data.activity_563.activity_flop_563_data",
	"data.activity_565.activity_flop_565_data",
	"data.activity_569.activity_flop_569_data",
	"data.activity_570.activity_flop_570_data",
	"data.activity_572.activity_flop_572_data",
	"data.activity_576.activity_flop_576_data",
	"data.activity_589.activity_flop_589_data",
	"data.activity_591.activity_flop_591_data",
	"data.activity_593.activity_flop_593_data",
	"data.activity_700.activity_flop_700_data",
	"data.activity_703.activity_flop_703_data",
	"data.activity_707.activity_flop_707_data",
	"data.activity_717.activity_flop_717_data",
	"data.activity_719.activity_flop_719_data",
	"data.activity_720.activity_flop_720_data",
	"data.activity_722.activity_flop_722_data",
	"data.activity_723.activity_flop_723_data",
	"data.activity_726.activity_flop_726_data",
	"data.activity_727.activity_flop_727_data",
	"data.activity_730.activity_flop_730_data",
	"data.activity_733.activity_flop_733_data",
	"data.activity_737.activity_flop_737_data",
	"data.activity_755.activity_flop_755_data",
	"data.activity_758.activity_flop_758_data",
	"data.activity_767.activity_flop_767_data",
	"data.activity_773.activity_flop_773_data",
	"data.activity_775.activity_flop_775_data",
	"data.activity_776.activity_flop_776_data",
	"data.activity_786.activity_flop_786_data",
	"data.activity_805.activity_flop_805_data",
	"data.activity_806.activity_flop_806_data",
	"data.activity_811.activity_flop_811_data",
	"data.activity_813.activity_flop_813_data",
	"data.activity_818.activity_flop_818_data",
	"data.activity_833.activity_flop_833_data",
	"data.activity_837.activity_flop_837_data",
	"data.activity_838.activity_flop_838_data",
	"data.activity_839.activity_flop_839_data",
	"data.activity_846.activity_flop_846_data",
	"data.activity_855.activity_flop_855_data",
	"data.activity_865.activity_flop_865_data",
	"data.activity_866.activity_flop_866_data",
	"data.activity_869.activity_flop_869_data",
	"data.activity_876.activity_flop_876_data",
	"data.activity_881.activity_flop_881_data",
	"data.activity_888.activity_flop_888_data",
	"data.activity_891.activity_flop_891_data",
	"data.activity_892.activity_flop_892_data",
	"data.activity_896.activity_flop_896_data",
	"data.activity_flop.activitydata.activity_flop_142_data",
	"data.activity_flop.activitydata.activity_flop_148_data",
	"data.activity_flop.activitydata.activity_flop_154_data",
	"data.activity_flop.activitydata.activity_flop_185_data",
	"data.activity_flop.activitydata.activity_flop_186_data",
	"data.activity_flop.activitydata.activity_flop_196_data",
	"data.activity_flop.activitydata.activity_flop_197_data",
	"data.activity_flop.activitydata.activity_flop_208_data",
	"data.activity_flop.activitydata.activity_flop_210_data",
	"data.activity_flop.activitydata.activity_flop_217_data",
	"data.activity_flop.activitydata.activity_flop_227_data",
	"data.activity_flop.activitydata.activity_flop_248_data",
	"data.activity_flop.activitydata.activity_flop_314_data",
	"data.activity_flop.activitydata.activity_flop_conf_basic_data"
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
			print("activity_flop_conf_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
