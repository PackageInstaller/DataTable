local var_0_0 = {}
local var_0_1 = {
	"data.activity_conversation_1024_data",
	"data.activity_conversation_2020christmas_data",
	"data.activity_conversation_2020spring_data",
	"data.activity_conversation_2021MidAutumnFestival_data",
	"data.activity_conversation_2021valentinesday_data",
	"data.activity_conversation_2021yuanxiao_data",
	"data.activity_conversation_2022chunjie_data",
	"data.activity_conversation_2022newyearsday_data",
	"data.activity_conversation_21summer_data",
	"data.activity_conversation_21teachersday_data",
	"data.activity_conversation_21zhounian2_data",
	"data.activity_conversation_2323shengdan_data",
	"data.activity_conversation_anniversary_data",
	"data.activity_conversation_bianhua_data",
	"data.activity_conversation_data",
	"data.activity_conversation_halloween_data",
	"data.activity_conversation_towerdefence_data",
	"data.activity_conversation_umaru_data",
	"data.activity_conversation_wenguzhe_data",
	"data.activity_conversation_xuanshang1_data",
	"data.activity_conversation_xuanshang2_data",
	"data.activity_conversation_xuanshang3_data",
	"data.birthday_conversation_data",
	"data.branch_conversation_data",
	"data.conversation_marry_data",
	"data.conversation_monopoly_data",
	"data.expedition_conversation_data",
	"data.explore_conversation_10000_data",
	"data.explore_conversation_1009_data",
	"data.explore_conversation_1014_data",
	"data.explore_conversation_1023_data",
	"data.explore_conversation_1027_data",
	"data.explore_conversation_1032_data",
	"data.explore_conversation_1034_data",
	"data.explore_conversation_1036_data",
	"data.explore_conversation_1037_data",
	"data.explore_conversation_146_data",
	"data.explore_conversation_204520_data",
	"data.explore_conversation_204820_data",
	"data.explore_conversation_205220_data",
	"data.explore_conversation_205320_data",
	"data.explore_conversation_206220_data",
	"data.explore_conversation_206420_data",
	"data.explore_conversation_207820_data",
	"data.explore_conversation_208720_data",
	"data.explore_conversation_210_data",
	"data.explore_conversation_21330_data",
	"data.explore_conversation_230_data",
	"data.explore_conversation_264_data",
	"data.explore_conversation_418_data",
	"data.explore_conversation_430_data",
	"data.explore_conversation_550_data",
	"data.explore_conversation_576_data",
	"data.explore_conversation_593_data",
	"data.explore_conversation_714_data",
	"data.explore_conversation_755_data",
	"data.explore_conversation_767_data",
	"data.explore_conversation_775_data",
	"data.explore_conversation_792_data",
	"data.explore_conversation_805_data",
	"data.explore_conversation_806_data",
	"data.explore_conversation_813_data",
	"data.explore_conversation_830_data",
	"data.explore_conversation_838_data",
	"data.explore_conversation_855_data",
	"data.explore_conversation_861_data",
	"data.explore_conversation_865_data",
	"data.explore_conversation_872_data",
	"data.explore_conversation_881_data",
	"data.explore_conversation_888_data",
	"data.explore_conversation_891_data",
	"data.explore_conversation_892_data",
	"data.explore_conversation_TAP_data",
	"data.explore_conversation_data",
	"data.explore_conversation_hong_data",
	"data.explore_conversation_keke_data",
	"data.explore_conversation_moon_data",
	"data.explore_conversation_peier_data",
	"data.explore_conversation_qingrenjie2022_data",
	"data.explore_conversation_summer2021_data",
	"data.explore_conversation_yuandan2021_data",
	"data.explore_stable_conversation_data",
	"data.favor_conversation_data",
	"data.main_conversation18_data",
	"data.main_conversation2_data",
	"data.main_conversation_DLC_data",
	"data.main_conversation_data",
	"data.monopoly_conversation_data",
	"data.random_conversation_data",
	"data.talk_level_conversation_data",
	"data.travel_conversation_data"
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
			print("conversation_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
