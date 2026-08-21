-- chunkname: @IQIGame\\Common\\Filter.lua

Filter = {
	funcList = {}
}

function Filter:New()
	return Clone(Filter)
end

function Filter:ApplyFilter(list)
	local result = {}

	for _, item in pairs(list) do
		if self:SatisfyAll(item) then
			table.insert(result, item)
		end
	end

	return result
end

function Filter:SatisfyAll(item)
	for i, filter in pairs(self.funcList) do
		if not filter(item) then
			return false
		end
	end

	return true
end

function Filter:SetFilter(index, f)
	self.funcList[index] = f
end

function Filter:Reset()
	self.funcList = {}
end
