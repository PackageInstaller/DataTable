local var_0_0 = {}
local var_0_1 = {
	"data.activity_208.activity_art_conf_208_data",
	"data.activity_209.activity_art_conf_209_data",
	"data.activity_210.activity_art_conf_210_data",
	"data.activity_230.activity_art_conf230_data",
	"data.activity_428.activity_art_conf428_data",
	"data.activity_500.activity_art_conf500_data",
	"data.activity_550.activity_art_conf550_data",
	"data.activity_576.activity_art_conf576_data",
	"data.activity_593.activity_art_conf593_data",
	"data.activity_722.activity_art_conf722_data",
	"data.activity_755.activity_art_conf755_data",
	"data.activity_767.activity_art_conf767_data",
	"data.activity_775.activity_art_conf775_data",
	"data.activity_806.activity_art_conf806_data",
	"data.activity_813.activity_art_conf813_data",
	"data.activity_838.activity_art_conf838_data",
	"data.activity_855.activity_art_conf855_data",
	"data.activity_865.activity_art_conf865_data",
	"data.activity_888.activity_art_conf888_data"
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
			print("activity_art_conf_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
