local IslandInventoryIndexData = class("IslandInventoryIndexData")

IslandInventoryIndexData.MODE_SINGLE = 1
IslandInventoryIndexData.MODE_MULTI = 2

function IslandInventoryIndexData:Ctor(arg_1_1)
	self.id = arg_1_1
	self.layoutData = self:GenLayoutData(arg_1_1)
	self.data = _.map(self.layoutData, function(arg_2_0)
		return arg_2_0.list[1]
	end)

	return
end

function IslandInventoryIndexData:GenLayoutData(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(pg.island_storage_filter_template.get_id_list_by_belong_filter_id[arg_3_1]) do
		local var_3_1 = {}
		local var_3_2 = {}

		for iter_3_2, iter_3_3 in ipairs(pg.island_storage_filter_template.get_id_list_by_belong_filter_id[iter_3_1]) do
			table.insert(var_3_1, (bit.lshift(1, iter_3_2)))
			table.insert(var_3_2, pg.island_storage_filter_template[iter_3_3].name)
		end

		table.insert(var_3_1, 1, IndexConst.BitAll(var_3_1))
		table.insert(var_3_2, 1, i18n("index_all"))
		table.insert(var_3_0, {
			mode = IslandInventoryIndexData.MODE_MULTI,
			list = var_3_1,
			names = var_3_2,
			title = pg.island_storage_filter_template[iter_3_1].name
		})
	end

	local var_3_4 = {}
	local var_3_5 = {}
	local var_3_6 = {}

	for iter_3_4, iter_3_5 in ipairs(pg.island_storage_filter_template.get_id_list_by_belong_filter_id[pg.island_storage_filter_template[arg_3_1].sort_id]) do
		table.insert(var_3_4, bit.lshift(1, iter_3_4))
		table.insert(var_3_5, pg.island_storage_filter_template[iter_3_5].name)
		table.insert(var_3_6, pg.island_storage_filter_template[iter_3_5].args)
	end

	table.insert(var_3_0, 1, {
		mode = IslandInventoryIndexData.MODE_SINGLE,
		list = var_3_4,
		names = var_3_5,
		sortFuncName = var_3_6,
		title = i18n("island_word_sort")
	})

	return var_3_0
end

function IslandInventoryIndexData:GetLayoutData()
	return self.layoutData
end

function IslandInventoryIndexData:GetData(arg_5_1)
	return self.data
end

function IslandInventoryIndexData:SetData(arg_6_1)
	self.data = arg_6_1

	return
end

function IslandInventoryIndexData:Match(arg_7_1)
	local var_7_0 = arg_7_1:getConfig("filter")
	local var_7_1 = pg.island_storage_filter_template.get_id_list_by_belong_filter_id[self.id]
	local var_7_2 = 0

	for iter_7_0, iter_7_1 in ipairs(pg.island_storage_filter_template.get_id_list_by_belong_filter_id[self.id]) do
		local var_7_3 = {}

		for iter_7_2, iter_7_3 in ipairs(var_7_0) do
			local var_7_4 = table.indexof(pg.island_storage_filter_template.get_id_list_by_belong_filter_id[iter_7_1], iter_7_3)

			if var_7_4 then
				table.insert(var_7_3, bit.lshift(1, var_7_4))
			end
		end

		if IslandInventoryIndexData.CheckSelectedAll(self.layoutData[iter_7_0 + 1].list, self.data[iter_7_0 + 1]) or bit.band(IndexConst.BitAll(var_7_3), self.data[iter_7_0 + 1]) > 0 then
			var_7_2 = var_7_2 + 1
		end
	end

	return var_7_2 == #var_7_1
end

function IslandInventoryIndexData:GetSortData()
	return self.data[1]
end

function IslandInventoryIndexData:GetSortText()
	local var_9_0 = self:GetSortData()
	local var_9_1 = self:GetLayoutData()[1]
	local var_9_2 = 0

	for iter_9_0, iter_9_1 in ipairs(var_9_1.list) do
		if bit.band(var_9_0, iter_9_1) > 0 then
			var_9_2 = iter_9_0

			break
		end
	end

	return var_9_1.names[var_9_2] or ""
end

function IslandInventoryIndexData:Sort(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = self:GetSortData()
	local var_10_1 = 0
	local var_10_2 = 0
	local var_10_3 = self:GetLayoutData()[1]
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
		local var_10_5 = arg_10_1:GetType()
		local var_10_6 = arg_10_2:GetType()

		if var_10_5 == var_10_6 then
			return (function(arg_11_0, arg_11_1, arg_11_2)
				if arg_11_0.id == arg_11_1.id then
					return arg_11_0:GetCount() > arg_11_1:GetCount()
				else
					return (arg_11_2 and {
						arg_11_0.id < arg_11_1.id
					} or {
						arg_11_0.id > arg_11_1.id
					})[1]
				end

				return
			end)(arg_10_1, arg_10_2, arg_10_3)
		else
			return (arg_10_3 and {
				var_10_5 < var_10_6
			} or {
				var_10_6 < var_10_5
			})[1]
		end
	else
		return (arg_10_3 and {
			var_10_1 < var_10_2
		} or {
			var_10_2 < var_10_1
		})[1]
	end

	return
end

function IslandInventoryIndexData:CheckSelectedAll(arg_12_1)
	if #self <= 1 then
		return true
	end

	return arg_12_1 == self[1]
end

return IslandInventoryIndexData
