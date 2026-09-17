local var_0_0 = {}
local var_0_1 = {
	"data.activity_230.activity_collect_230_conf",
	"data.activity_270.activity_collect_foolhq_conf",
	"data.activity_313.activity_collect_313_conf",
	"data.activity_418.activity_collect_418_conf",
	"data.activity_428.activity_collect_428_conf",
	"data.activity_464.activity_collect_464_conf",
	"data.activity_500.activity_collect_500_conf",
	"data.activity_550.activity_collect_550_conf",
	"data.activity_569.activity_collect_569_conf",
	"data.activity_576.activity_collect_576_conf",
	"data.activity_593.activity_collect_593_conf",
	"data.activity_707.activity_collect_707_conf",
	"data.activity_708.activity_collect_708_conf",
	"data.activity_722.activity_collect_722_conf",
	"data.activity_755.activity_collect_755_conf",
	"data.activity_767.activity_collect_767_conf",
	"data.activity_775.activity_collect_775_conf",
	"data.activity_806.activity_collect_806_conf",
	"data.activity_813.activity_collect_813_conf",
	"data.activity_838.activity_collect_838_conf",
	"data.activity_855.activity_collect_855_conf",
	"data.activity_865.activity_collect_865_conf",
	"data.activity_888.activity_collect_888_conf",
	"data.activity_collect.activityconf.activity_collect_142_conf",
	"data.activity_collect.activityconf.activity_collect_154_conf",
	"data.activity_collect.activityconf.activity_collect_202_conf",
	"data.activity_collect.activityconf.activity_collect_210_conf",
	"data.activity_collect.activityconf.activity_collect_foolhq_conf"
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
			print("activity_collect_conf id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
