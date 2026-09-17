local var_0_0 = {}
local var_0_1 = {
	"data.photofile_HelpGirl_2020christmas_data",
	"data.photofile_HelpGirl_2020spring_data",
	"data.photofile_HelpGirl_2021anniversary_data",
	"data.photofile_HelpGirl_2021fool_data",
	"data.photofile_HelpGirl_2022christmas_data",
	"data.photofile_HelpGirl_2022spring_data",
	"data.photofile_HelpGirl_202303_data",
	"data.photofile_HelpGirl_2025spring_data",
	"data.photofile_HelpGirl_2026spring_data",
	"data.photofile_HelpGirl_anniversary_data",
	"data.photofile_HelpGirl_bachelor_data",
	"data.photofile_HelpGirl_basic_data",
	"data.photofile_HelpGirl_elementhorcrux_data",
	"data.photofile_HelpGirl_halloween_data",
	"data.photofile_HelpGirl_new_data",
	"data.photofile_HelpGirl_person_data",
	"data.photofile_HelpGirl_project10_data",
	"data.photofile_HelpGirl_stable_data",
	"data.photofile_HelpGirl_tap_data",
	"data.photofile_HelpGirl_umaru_data"
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
			print("photofile_HelpGirl_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
