local IslandPoolBase = class("IslandPoolBase")

function IslandPoolBase:Init(arg_1_1)
	arg_1_1()

	return
end

function IslandPoolBase:GetObject(arg_2_1, arg_2_2, arg_2_3)
	assert(false, "ovewrite this function in child class")

	return
end

function IslandPoolBase:ReturnObject(arg_3_1, arg_3_2)
	assert(false, "ovewrite this function in child class")

	return
end

function IslandPoolBase:Clear()
	return
end

function IslandPoolBase:Dispose()
	return
end

return IslandPoolBase
