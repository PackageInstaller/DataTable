local var_0_0 = {}
local var_0_1 = {
	"data.activity_230.activity_rob_coupons_230_data",
	"data.activity_330.activity_rob_coupons_330_data",
	"data.activity_428.activity_rob_coupons_428_data",
	"data.activity_430.activity_rob_coupons_430_data",
	"data.activity_500.activity_rob_coupons_500_data",
	"data.activity_550.activity_rob_coupons_550_data",
	"data.activity_576.activity_rob_coupons_576_data",
	"data.activity_593.activity_rob_coupons_593_data",
	"data.activity_722.activity_rob_coupons_722_data",
	"data.activity_755.activity_rob_coupons_755_data",
	"data.activity_767.activity_rob_coupons_767_data",
	"data.activity_775.activity_rob_coupons_775_data",
	"data.activity_806.activity_rob_coupons_806_data",
	"data.activity_813.activity_rob_coupons_813_data",
	"data.activity_838.activity_rob_coupons_838_data",
	"data.activity_855.activity_rob_coupons_855_data",
	"data.activity_865.activity_rob_coupons_865_data",
	"data.activity_888.activity_rob_coupons_888_data",
	"data.activity_rob_coupons/activity_rob_coupons_143_data",
	"data.activity_rob_coupons/activity_rob_coupons_154_data",
	"data.activity_rob_coupons/activity_rob_coupons_210_data"
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
			print("activity_rob_coupons_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
