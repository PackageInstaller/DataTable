class = var_0_10000

local var_0_0 = var_0_10000("IslandInventoryIndexData")

var_0_0.MODE_SINGLE = 1
var_0_0.MODE_MULTI = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.layoutData = arg_1_0:GenLayoutData(arg_1_1)
	_ = var_2
	arg_1_0.data = var_2.map(arg_1_0.layoutData, function(arg_2_0)
		return arg_2_0.list[1]
	end)

	return
end

function var_0_0.GenLayoutData(arg_3_0, arg_3_1)
	pg = var_1_10002

	local var_3_0 = var_1_10002.island_storage_filter_template.get_id_list_by_belong_filter_id[arg_3_1]
	local var_3_1 = {}

	ipairs = var_1_10004

	for iter_3_0, iter_3_1 in var_1_10004(var_3_0) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.island_storage_filter_template[iter_3_1].name
		var_1_10010 = {}

		local var_3_2 = {}

		pg = var_1_10012
		var_1_10012 = var_1_10012.island_storage_filter_template.get_id_list_by_belong_filter_id[iter_3_1]
		ipairs = var_1_10013

		for iter_3_2, iter_3_3 in var_1_10013(var_1_10012) do
			bit = var_1_10018
			var_1_10018 = var_1_10018.lshift(1, iter_3_2)
			pg = var_19

			local var_3_3 = var_19.island_storage_filter_template[iter_3_3].name

			table = var_20

			var_20.insert(var_1_10010, var_1_10018)

			table = var_20

			var_20.insert(var_3_2, var_3_3)
		end

		table = var_1_10013
		var_1_10013 = var_1_10013.insert

		local var_3_4 = var_1_10010

		var_1_10015 = 1
		IndexConst = iter_3_2

		var_1_10013(var_3_4, var_1_10015, iter_3_2.BitAll(var_1_10010))

		table = var_1_10013
		var_1_10013 = var_1_10013.insert

		local var_3_5 = var_3_2

		var_1_10015 = 1
		i18n = iter_3_2

		var_1_10013(var_3_5, var_1_10015, iter_3_2("index_all"))

		table = var_1_10013

		var_1_10013.insert(var_3_1, {
			mode = var_0_0.MODE_MULTI,
			list = var_1_10010,
			names = var_3_2,
			title = var_1_10009
		})
	end

	pg = var_4

	local var_3_6 = var_4.island_storage_filter_template[arg_3_1].sort_id

	pg = var_5

	local var_3_7 = var_5.island_storage_filter_template[var_3_6]
	local var_3_8 = {}
	local var_3_9 = {}
	local var_3_10 = {}

	pg = var_1_10009

	local var_3_11 = var_1_10009.island_storage_filter_template.get_id_list_by_belong_filter_id[var_3_6]

	ipairs = var_1_10010

	for iter_3_4, iter_3_5 in var_1_10010(var_3_11) do
		pg = var_1_10015
		var_1_10015 = var_1_10015.island_storage_filter_template[iter_3_5]
		table = iter_3_2
		iter_3_2 = iter_3_2.insert

		local var_3_12 = var_3_8

		bit = var_1_10018

		iter_3_2(var_3_12, var_1_10018.lshift(1, iter_3_4))

		table = iter_3_2

		iter_3_2.insert(var_3_9, var_1_10015.name)

		table = iter_3_2

		iter_3_2.insert(var_3_10, var_1_10015.args)
	end

	local var_3_13 = {
		mode = var_0_0.MODE_SINGLE,
		list = var_3_8,
		names = var_3_9,
		sortFuncName = var_3_10
	}

	i18n = var_11
	var_3_13.title = var_11("island_word_sort")
	table = var_11

	var_11.insert(var_3_1, 1, var_3_13)

	return var_3_1
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
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getConfig(var_7_0, "filter")

	pg = var_7_0

	local var_7_2 = var_7_0.island_storage_filter_template.get_id_list_by_belong_filter_id[arg_7_0.id]
	local var_7_3 = 0

	ipairs = var_1_10005

	for iter_7_0, iter_7_1 in var_1_10005(var_7_2) do
		pg = var_1_10010
		var_1_10010 = var_1_10010.island_storage_filter_template.get_id_list_by_belong_filter_id[iter_7_1]

		local var_7_4 = {}

		ipairs = var_1_10012

		for iter_7_2, iter_7_3 in var_1_10012(var_7_1) do
			table = var_1_10017

			if var_1_10017.indexof(var_1_10010, iter_7_3) then
				table = var_18

				local var_7_5 = var_18.insert
				local var_7_6 = var_7_4

				bit = var_1_10020

				var_7_5(var_7_6, var_1_10020.lshift(1, var_1_10017))
			end
		end

		IndexConst = var_1_10012
		var_1_10012 = var_1_10012.BitAll(var_7_4)

		local var_7_7 = arg_7_0.data[iter_7_0 + 1]
		local var_7_8 = arg_7_0.layoutData[iter_7_0 + 1].list

		if not var_0_0.CheckSelectedAll(var_7_8, var_7_7) then
			bit = var_15

			if var_15.band(var_1_10012, var_7_7) > 0 then
				var_7_3 = var_7_3 + 1
			end
		end
	end

	return var_7_3 == #var_7_2
end

function var_0_0.GetSortData(arg_8_0)
	return arg_8_0.data[1]
end

function var_0_0.GetSortText(arg_9_0)
	local var_9_0 = arg_9_0:GetSortData()
	local var_9_1 = arg_9_0:GetLayoutData()[1]
	local var_9_2 = 0

	ipairs = var_1_10005

	for iter_9_0, iter_9_1 in var_1_10005(var_9_1.list) do
		bit = var_1_10010

		if var_1_10010.band(var_9_0, iter_9_1) > 0 then
			var_9_2 = iter_9_0

			break
		end
	end

	local var_9_3

	if not var_9_1.names[var_9_2] then
		var_9_3 = ""
	end

	return var_9_3
end

function var_0_0.Sort(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:GetSortData()
	local var_10_1 = 0
	local var_10_2 = 0
	local var_10_3 = arg_10_0:GetLayoutData()[1]
	local var_10_4 = 0

	ipairs = var_1_10010

	for iter_10_0, iter_10_1 in var_1_10010(var_10_3.list) do
		bit = var_1_10015

		if var_1_10015.band(var_10_0, iter_10_1) > 0 then
			var_10_4 = iter_10_0

			break
		end
	end

	if var_10_4 > 0 then
		local var_10_5 = var_10_3.sortFuncName[var_10_4]

		assert = var_11

		var_11(arg_10_1[var_10_5], "func should be exist")

		var_10_1, var_10_2 = arg_10_1[var_10_5](arg_10_1), arg_10_2[var_10_5](arg_10_2)
	end

	local function var_10_6(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0.id == arg_11_1.id then
			return arg_11_0:GetCount() > arg_11_1:GetCount()
		else
			local var_11_0

			if not arg_11_2 or not {
				arg_11_0.id < arg_11_1.id
			} then
				var_11_0 = {
					arg_11_0.id > arg_11_1.id
				}
			end

			return var_11_0[1]
		end

		return
	end

	if var_10_1 == var_10_2 then
		if arg_10_1:GetType() == arg_10_2:GetType() then
			return var_10_6(arg_10_1, arg_10_2, arg_10_3)
		else
			local var_10_7

			if not arg_10_3 or not {
				var_11 < var_12
			} then
				var_10_7 = {
					var_12 < var_11
				}
			end

			return var_10_7[1]
		end
	else
		local var_10_8

		if not arg_10_3 or not {
			var_10_1 < var_10_2
		} then
			var_10_8 = {
				var_10_2 < var_10_1
			}
		end

		return var_10_8[1]
	end

	return
end

function var_0_0.CheckSelectedAll(arg_12_0, arg_12_1)
	if #arg_12_0 <= 1 then
		return true
	end

	return arg_12_1 == arg_12_0[1]
end

return var_0_0
