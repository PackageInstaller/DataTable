local var_0_0 = {}
local var_0_1 = {
	"data.infinite_score_up.infinite_score_up_2105_data",
	"data.infinite_score_up.infinite_score_up_2106_data",
	"data.infinite_score_up.infinite_score_up_3143_data",
	"data.infinite_score_up.infinite_score_up_3343_data",
	"data.infinite_score_up.infinite_score_up_4053_data",
	"data.infinite_score_up.infinite_score_up_4173_data",
	"data.infinite_score_up.infinite_score_up_4423_data",
	"data.infinite_score_up.infinite_score_up_4613_data",
	"data.infinite_score_up.infinite_score_up_4813_data",
	"data.infinite_score_up.infinite_score_up_5993_data",
	"data.infinite_score_up_148_data",
	"data.infinite_score_up_2101_data",
	"data.infinite_score_up_2103_data",
	"data.infinite_score_up_2104_data",
	"data.infinite_score_up_2151_data",
	"data.infinite_score_up_umaru_data"
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
			print("infinite_score_up_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
