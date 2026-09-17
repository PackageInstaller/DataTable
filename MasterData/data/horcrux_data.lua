local var_0_0 = {}
local var_0_1 = {
	"data.HelpGirl_2020christmas_data",
	"data.HelpGirl_2020spring_data",
	"data.HelpGirl_2021anniversary_data",
	"data.HelpGirl_2021fool_data",
	"data.HelpGirl_2022christmas_data",
	"data.HelpGirl_2022spring_data",
	"data.HelpGirl_202303_data",
	"data.HelpGirl_2025spring_data",
	"data.HelpGirl_2026spring_data",
	"data.HelpGirl_anniversary_data",
	"data.HelpGirl_bachelor_data",
	"data.HelpGirl_data",
	"data.HelpGirl_elementhorcrux_data",
	"data.HelpGirl_halloween_data",
	"data.HelpGirl_new_data",
	"data.HelpGirl_person_data",
	"data.HelpGirl_project10_data",
	"data.HelpGirl_stable_data",
	"data.HelpGirl_stackable_data",
	"data.HelpGirl_tap_data",
	"data.HelpGirl_umaru_data"
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
			print("horcrux_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
