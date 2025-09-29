-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_pastInfo.lua

module("logic.config.t_pastInfo", package.seeall)

local title = {
	id = 1,
	name = 2
}
local dataList = {
	{
		1,
		"姓名"
	},
	{
		2,
		"阵营"
	},
	{
		3,
		"身高"
	},
	{
		4,
		"体重"
	},
	{
		5,
		"出生时间"
	},
	{
		6,
		"能力"
	},
	{
		7,
		"地区"
	},
	{
		8,
		"基础情报"
	},
	{
		101,
		"特殊项1"
	},
	{
		102,
		"特殊项2"
	},
	{
		103,
		"特殊项3"
	},
	{
		201,
		"私人物品1"
	},
	{
		202,
		"私人物品2"
	},
	{
		203,
		"私人物品3"
	},
	{
		204,
		"私人物品4"
	}
}
local t_pastInfo = {}

t_pastInfo.dataList = dataList

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
	t_pastInfo[v[1]] = v

	setmetatable(v, mt)
end

return t_pastInfo
