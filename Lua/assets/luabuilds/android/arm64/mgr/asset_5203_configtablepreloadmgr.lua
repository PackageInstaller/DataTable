pg = pg or {}
pg.ConfigTablePreloadMgr = singletonClass("ConfigTablePreloadMgr")

function pg.ConfigTablePreloadMgr.Init(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs({
		"furniture_data_template",
		"ship_data_statistics",
		"task_data_template",
		"ship_skin_template_column_time"
	}) do
		table.insert(var_1_0, function(arg_2_0)
			onNextTick(arg_2_0)

			return
		end)
	end

	seriesAsync(var_1_0, arg_1_1)

	return
end

return
