-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_item_air_scene.lua

module("logic.config.t_item_air_scene", package.seeall)

local title = {
	name = 2,
	quality = 5,
	useDesc = 9,
	type = 3,
	getWays = 8,
	desc = 11,
	repeatItem = 6,
	subType = 4,
	isShowBag = 10,
	id = 1,
	icon = 7
}
local dataList = {
	{
		3100101,
		"夜晚城市011",
		31,
		0,
		3,
		"{1100003:100}",
		"1004004",
		"",
		"",
		0,
		""
	},
	{
		3100102,
		"夜晚城市012",
		31,
		0,
		3,
		"{1100003:100}",
		"1004004",
		"",
		"",
		0,
		""
	},
	{
		3100103,
		"夜晚城市013",
		31,
		0,
		3,
		"{1100003:100}",
		"1004004",
		"",
		"",
		0,
		""
	},
	{
		3100201,
		"夜晚城市021",
		31,
		0,
		3,
		"{1100003:100}",
		"1004004",
		"",
		"",
		0,
		""
	},
	{
		3100202,
		"夜晚城市022",
		31,
		0,
		3,
		"{1100003:100}",
		"1004004",
		"",
		"",
		0,
		""
	},
	{
		3100203,
		"夜晚城市023",
		31,
		0,
		3,
		"{1100003:100}",
		"1004004",
		"",
		"",
		0,
		""
	},
	{
		3100301,
		"夜晚城市031",
		31,
		0,
		3,
		"{1100003:100}",
		"1004004",
		"",
		"",
		0,
		""
	},
	{
		3100302,
		"夜晚城市032",
		31,
		0,
		3,
		"{1100003:100}",
		"1004004",
		"",
		"",
		0,
		""
	},
	{
		3100303,
		"夜晚城市033",
		31,
		0,
		3,
		"{1100003:100}",
		"1004004",
		"",
		"",
		0,
		""
	}
}
local t_item_air_scene = {}

t_item_air_scene.dataList = dataList

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
	t_item_air_scene[v[1]] = v

	setmetatable(v, mt)
end

return t_item_air_scene
