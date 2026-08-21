local var_0_0 = class("IslandInventoryIndexData")

var_0_0.MODE_SINGLE = 1
var_0_0.MODE_MULTI = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.layoutData = arg_1_0:GenLayoutData(arg_1_1)
	arg_1_0.data = _.map(arg_1_0.layoutData, function(arg_2_0)
		return arg_2_0.list[1]
	end)

	return
end

function var_0_0.GenLayoutData(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(pg.island_storage_filter_template.get_id_list_by_belong_filter_id[arg_3_1]) do
		for iter_3_2, iter_3_3 in ipairs(pg.island_storage_filter_template.get_id_list_by_belong_filter_id[iter_3_1]) do
			table.insert({}, (bit.lshift(1, iter_3_2)))
			table.insert({}, pg.island_storage_filter_template[iter_3_3].name)
		end

		table.insert({}, 1, IndexConst.BitAll({}))
		table.insert({}, 1, i18n("index_all"))
		table.insert({}, {
			mode = var_0_0.MODE_MULTI,
			list = {},
			names = {},
			title = pg.island_storage_filter_template[iter_3_1].name
		})
	end

	for iter_3_4, iter_3_5 in ipairs(pg.island_storage_filter_template.get_id_list_by_belong_filter_id[pg.island_storage_filter_template[arg_3_1].sort_id]) do
		table.insert({}, bit.lshift(1, iter_3_4))
		table.insert({}, pg.island_storage_filter_template[iter_3_5].name)
		table.insert({}, pg.island_storage_filter_template[iter_3_5].args)
	end

	table.insert({}, 1, {
		mode = var_0_0.MODE_SINGLE,
		list = {},
		names = {},
		sortFuncName = {},
		title = i18n("island_word_sort")
	})

	return {}
end

function var_0_0.GetLayoutData(arg_4_0)
	return arg_4_0.layoutData
end

function var_0_0.GetData(arg_5_0, arg_5_1)
	return arg_5_0.data
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.data = arg_6_1

	return
end

function var_0_0.Match(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getConfig("filter")
	local var_7_1 = pg.island_storage_filter_template.get_id_list_by_belong_filter_id[arg_7_0.id]
	local var_7_2 = 0

	for iter_7_0, iter_7_1 in ipairs(pg.island_storage_filter_template.get_id_list_by_belong_filter_id[arg_7_0.id]) do
		for iter_7_2, iter_7_3 in ipairs(var_7_0) do
			local var_7_3 = table.indexof(pg.island_storage_filter_template.get_id_list_by_belong_filter_id[iter_7_1], iter_7_3)

			if var_7_3 then
				table.insert({}, bit.lshift(1, var_7_3))
			end
		end

		local var_7_4 = IndexConst.BitAll({})

		if var_0_0.CheckSelectedAll(arg_7_0.layoutData[iter_7_0 + 1].list, arg_7_0.data[iter_7_0 + 1]) or bit.band(var_7_4, arg_7_0.data[iter_7_0 + 1]) > 0 then
			var_7_2 = var_7_2 + 1
		end
	end

	return var_7_2 == #var_7_1
end

function var_0_0.GetSortData(arg_8_0)
	return arg_8_0.data[1]
end

function var_0_0.GetSortText(arg_9_0)
	local var_9_0 = arg_9_0:GetSortData()
	local var_9_1 = arg_9_0:GetLayoutData()[1]
	local var_9_2 = 0

	for iter_9_0, iter_9_1 in ipairs(var_9_1.list) do
		if bit.band(var_9_0, iter_9_1) > 0 then
			var_9_2 = iter_9_0

			break
		end
	end

	return var_9_1.names[var_9_2] or ""
end

function var_0_0.Sort(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:GetSortData()
	local var_10_1 = 0
	local var_10_2 = 0
	local var_10_3 = arg_10_0:GetLayoutData()[1]
	local var_10_4 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_3.list) do
		if bit.band(var_10_0, iter_10_1) > 0 then
			var_10_4 = iter_10_0

			break
		end
	end

	if var_10_4 > 0 then
		assert(arg_10_1[var_10_3.sortFuncName[var_10_4]], "func should be exist")

		var_10_2 = arg_10_2[var_10_3.sortFuncName[var_10_4]](arg_10_2)
		var_10_1 = arg_10_1[var_10_3.sortFuncName[var_10_4]](arg_10_1)
	end

	if var_10_1 == var_10_2 then
		local var_10_6 = arg_10_1:GetType()
		local var_10_7 = arg_10_2:GetType()

		if var_10_6 == var_10_7 then
			do return var_10_5(arg_10_1, arg_10_2, arg_10_3) end

			goto label_10_0
		end

		::label_10_0::

		if arg_10_3 then
			local var_10_8 = {
				var_10_6 < var_10_7
			}

			if not {
				var_10_6 < var_10_7
			} then
				var_10_8 = {
					var_10_7 < var_10_6
				}
			end

			do return var_10_8[1] end

			goto label_10_0

			if arg_10_3 then
				do
					local var_10_9 = {
						var_10_1 < var_10_2
					}

					if not {
						var_10_1 < var_10_2
					} then
						var_10_9 = {
							var_10_2 < var_10_1
						}
					end

					return var_10_9[1]
				end

				return
			end
		end
	end
end

function var_0_0.CheckSelectedAll(arg_12_0, arg_12_1)
	if #arg_12_0 <= 1 then
		return true
	end

	return arg_12_1 == arg_12_0[1]
end

return var_0_0
