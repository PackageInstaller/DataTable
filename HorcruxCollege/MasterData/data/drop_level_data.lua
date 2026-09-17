local var_0_0 = {}
local var_0_1 = {
	"data.drop_level.drop_level_14_data",
	"data.drop_level.drop_level_15_data",
	"data.drop_level.drop_level_16_data",
	"data.drop_level.drop_level_17_data",
	"data.drop_level.drop_level_19_data",
	"data.drop_level.drop_level_1_data",
	"data.drop_level.drop_level_22_data",
	"data.drop_level.drop_level_29_data",
	"data.drop_level.drop_level_2_data",
	"data.drop_level.drop_level_3_data",
	"data.drop_level.drop_level_47_data",
	"data.drop_level.drop_level_4_data",
	"data.drop_level.drop_level_62_data",
	"data.drop_level.drop_level_66_data",
	"data.drop_level.drop_level_68_data",
	"data.drop_level.drop_level_70_data",
	"data.drop_level.drop_level_71_data",
	"data.drop_level.drop_level_72_data",
	"data.drop_level.drop_level_73_data",
	"data.drop_level.drop_level_74_data",
	"data.drop_level.drop_level_81_data",
	"data.drop_level.drop_level_82_data",
	"data.drop_level.drop_level_83_data",
	"data.drop_level.drop_level_84_data",
	"data.drop_level.drop_level_85_data",
	"data.drop_level.drop_level_Valentino_data",
	"data.drop_level.drop_level_anniversary_data",
	"data.drop_level.drop_level_basic_data",
	"data.drop_level.drop_level_bianhua_data",
	"data.drop_level.drop_level_birthday_data",
	"data.drop_level.drop_level_double11_data",
	"data.drop_level.drop_level_fool_data",
	"data.drop_level.drop_level_helloween_data",
	"data.drop_level.drop_level_lamiya_data",
	"data.drop_level.drop_level_marry_data",
	"data.drop_level.drop_level_ob_1_data",
	"data.drop_level.drop_level_ob_84_data",
	"data.drop_level.drop_level_overclock1_data",
	"data.drop_level.drop_level_qixi2021_data",
	"data.drop_level.drop_level_select_data",
	"data.drop_level.drop_level_skin_data",
	"data.umaru.drop_level_umaru_data"
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
			print("drop_level_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
