pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.ConfigTablePreloadMgr = var_0_10001("ConfigTablePreloadMgr")
pg = var_0

function var_0.ConfigTablePreloadMgr.Init(arg_1_0, arg_1_1)
	local var_1_0 = {
		"furniture_data_template",
		"ship_data_statistics",
		"task_data_template",
		"ship_skin_template_column_time"
	}
	local var_1_1 = {}

	ipairs = var_1_10004

	for iter_1_0, iter_1_1 in var_1_10004(var_1_0) do
		table = var_1_10009

		var_1_10009.insert(var_1_1, function(arg_2_0)
			pg = var_2_10001

			local var_2_0 = var_2_10001[iter_1_1]

			onNextTick = var_2

			var_2(arg_2_0)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_1_1, arg_1_1)

	return
end

return
