local IslandCollectItemData = class("IslandCollectItemData", import("model.vo.BaseVO"))

function IslandCollectItemData:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.hadFragmentList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.had_fragment or {}) do
		table.insert(self.hadFragmentList, iter_1_1)
	end

	return
end

function IslandCollectItemData:AddFragment(arg_2_1)
	table.insert(self.hadFragmentList, arg_2_1)

	return
end

function IslandCollectItemData:CheckFragment(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.hadFragmentList) do
		if iter_3_1 == arg_3_1 then
			return true
		end
	end

	return false
end

function IslandCollectItemData:ResetFragment()
	self.hadFragmentList = {}

	return
end

function IslandCollectItemData:UpdateData(arg_5_1)
	return
end

function IslandCollectItemData:bindConfigTable()
	return pg.island_collection
end

return IslandCollectItemData
