local var_0_0 = {}
local var_0_1 = {
	"data.activity_230.activity_flop_230_conf",
	"data.activity_264.activity_flop_264_conf",
	"data.activity_291.activity_flop_291_conf",
	"data.activity_304.activity_flop_304_conf",
	"data.activity_312.activity_flop_312_conf",
	"data.activity_330.activity_flop_330_conf",
	"data.activity_333.activity_flop_333_conf",
	"data.activity_334.activity_flop_334_conf",
	"data.activity_405.activity_flop_405_conf",
	"data.activity_418.activity_flop_418_conf",
	"data.activity_428.activity_flop_428_conf",
	"data.activity_430.activity_flop_430_conf",
	"data.activity_433.activity_flop_433_conf",
	"data.activity_436.activity_flop_436_conf",
	"data.activity_441.activity_flop_441_conf",
	"data.activity_450.activity_flop_450_conf",
	"data.activity_457.activity_flop_457_conf",
	"data.activity_458.activity_flop_458_conf",
	"data.activity_462.activity_flop_462_conf",
	"data.activity_465.activity_flop_465_conf",
	"data.activity_481.activity_flop_481_conf",
	"data.activity_485.activity_flop_485_conf",
	"data.activity_490.activity_flop_490_conf",
	"data.activity_491.activity_flop_491_conf",
	"data.activity_500.activity_flop_500_conf",
	"data.activity_507.activity_flop_507_conf",
	"data.activity_512.activity_flop_512_conf",
	"data.activity_526.activity_flop_526_conf",
	"data.activity_528.activity_flop_528_conf",
	"data.activity_529.activity_flop_529_conf",
	"data.activity_538.activity_flop_538_conf",
	"data.activity_542.activity_flop_542_conf",
	"data.activity_543.activity_flop_543_conf",
	"data.activity_545.activity_flop_545_conf",
	"data.activity_547.activity_flop_547_conf",
	"data.activity_550.activity_flop_550_conf",
	"data.activity_557.activity_flop_557_conf",
	"data.activity_561.activity_flop_561_conf",
	"data.activity_562.activity_flop_562_conf",
	"data.activity_563.activity_flop_563_conf",
	"data.activity_565.activity_flop_565_conf",
	"data.activity_569.activity_flop_569_conf",
	"data.activity_570.activity_flop_570_conf",
	"data.activity_572.activity_flop_572_conf",
	"data.activity_576.activity_flop_576_conf",
	"data.activity_589.activity_flop_589_conf",
	"data.activity_591.activity_flop_591_conf",
	"data.activity_593.activity_flop_593_conf",
	"data.activity_700.activity_flop_700_conf",
	"data.activity_703.activity_flop_703_conf",
	"data.activity_707.activity_flop_707_conf",
	"data.activity_717.activity_flop_717_conf",
	"data.activity_719.activity_flop_719_conf",
	"data.activity_720.activity_flop_720_conf",
	"data.activity_722.activity_flop_722_conf",
	"data.activity_723.activity_flop_723_conf",
	"data.activity_726.activity_flop_726_conf",
	"data.activity_727.activity_flop_727_conf",
	"data.activity_730.activity_flop_730_conf",
	"data.activity_733.activity_flop_733_conf",
	"data.activity_737.activity_flop_737_conf",
	"data.activity_755.activity_flop_755_conf",
	"data.activity_758.activity_flop_758_conf",
	"data.activity_767.activity_flop_767_conf",
	"data.activity_773.activity_flop_773_conf",
	"data.activity_775.activity_flop_775_conf",
	"data.activity_776.activity_flop_776_conf",
	"data.activity_786.activity_flop_786_conf",
	"data.activity_805.activity_flop_805_conf",
	"data.activity_806.activity_flop_806_conf",
	"data.activity_811.activity_flop_811_conf",
	"data.activity_813.activity_flop_813_conf",
	"data.activity_818.activity_flop_818_conf",
	"data.activity_833.activity_flop_833_conf",
	"data.activity_837.activity_flop_837_conf",
	"data.activity_838.activity_flop_838_conf",
	"data.activity_839.activity_flop_839_conf",
	"data.activity_846.activity_flop_846_conf",
	"data.activity_855.activity_flop_855_conf",
	"data.activity_865.activity_flop_865_conf",
	"data.activity_866.activity_flop_866_conf",
	"data.activity_869.activity_flop_869_conf",
	"data.activity_876.activity_flop_876_conf",
	"data.activity_881.activity_flop_881_conf",
	"data.activity_888.activity_flop_888_conf",
	"data.activity_891.activity_flop_891_conf",
	"data.activity_892.activity_flop_892_conf",
	"data.activity_896.activity_flop_896_conf",
	"data.activity_flop.activityconf.activity_flop_142_conf",
	"data.activity_flop.activityconf.activity_flop_148_conf",
	"data.activity_flop.activityconf.activity_flop_154_conf",
	"data.activity_flop.activityconf.activity_flop_185_conf",
	"data.activity_flop.activityconf.activity_flop_186_conf",
	"data.activity_flop.activityconf.activity_flop_196_conf",
	"data.activity_flop.activityconf.activity_flop_197_conf",
	"data.activity_flop.activityconf.activity_flop_208_conf",
	"data.activity_flop.activityconf.activity_flop_210_conf",
	"data.activity_flop.activityconf.activity_flop_217_conf",
	"data.activity_flop.activityconf.activity_flop_227_conf",
	"data.activity_flop.activityconf.activity_flop_248_conf",
	"data.activity_flop.activityconf.activity_flop_314_conf"
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
			print("activity_flop_condition_conf id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
