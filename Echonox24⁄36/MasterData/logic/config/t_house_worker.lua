-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_worker.lua

module("logic.config.t_house_worker", package.seeall)

local title = {
	roomName = 6,
	jobName = 7,
	zoneId = 5,
	roomType = 4,
	workType = 3,
	indexInRoom = 9,
	houseIndex = 2,
	number = 8,
	icon = 10,
	jobCode = 1
}
local dataList = {
	{
		1,
		1,
		1,
		1,
		1211,
		"主管室",
		"副主管",
		3,
		1,
		"room_compile1"
	},
	{
		2,
		1,
		1,
		1,
		1211,
		"主管室",
		"领航员",
		3,
		2,
		"room_compile2"
	},
	{
		3,
		1,
		1,
		1,
		1211,
		"主管室",
		"战略分析员",
		3,
		3,
		"room_compile3"
	},
	{
		4,
		2,
		3,
		3,
		1207,
		"制造厂",
		"技术工程师",
		3,
		1,
		"room_compile7"
	},
	{
		5,
		2,
		3,
		3,
		1207,
		"制造厂",
		"生产线管理",
		3,
		2,
		"room_compile8"
	},
	{
		6,
		2,
		3,
		3,
		1207,
		"制造厂",
		"研发顾问",
		3,
		3,
		"room_compile9"
	},
	{
		7,
		3,
		2,
		2,
		1203,
		"贸易站",
		"贸易操作",
		3,
		1,
		"room_compile4"
	},
	{
		8,
		3,
		2,
		2,
		1203,
		"贸易站",
		"物资调配",
		3,
		2,
		"room_compile5"
	},
	{
		9,
		3,
		2,
		2,
		1203,
		"贸易站",
		"采购中心",
		3,
		3,
		"room_compile6"
	},
	{
		10,
		4,
		4,
		4,
		1101,
		"1号收容室",
		"收容人员",
		3,
		1,
		""
	},
	{
		11,
		5,
		4,
		4,
		1102,
		"2号收容室",
		"收容人员",
		3,
		1,
		""
	},
	{
		12,
		6,
		4,
		4,
		1103,
		"3号收容室",
		"收容人员",
		3,
		1,
		""
	},
	{
		13,
		7,
		4,
		4,
		1104,
		"4号收容室",
		"收容人员",
		3,
		1,
		""
	},
	{
		14,
		8,
		4,
		4,
		1105,
		"5号收容室",
		"收容人员",
		3,
		1,
		""
	},
	{
		15,
		9,
		4,
		4,
		1106,
		"6号收容室",
		"收容人员",
		3,
		1,
		""
	}
}
local t_house_worker = {}

t_house_worker.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_house_worker[v[1]] = v

	setmetatable(v, mt)
end

return t_house_worker
