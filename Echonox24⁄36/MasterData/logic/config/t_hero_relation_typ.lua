-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_hero_relation_typ.lua

module("logic.config.t_hero_relation_typ", package.seeall)

local title = {
	id = 1,
	name = 2,
	color = 3,
	priority = 4
}
local dataList = {
	{
		1,
		"友好",
		"#FFB11E",
		3
	},
	{
		2,
		"憧憬",
		"#1FFF55",
		2
	},
	{
		3,
		"绯闻",
		"#FF591E",
		1
	},
	{
		4,
		"仇恨",
		"#1E26FF",
		7
	},
	{
		5,
		"敌视",
		"#D71EFF",
		6
	},
	{
		6,
		"冷淡",
		"#1EDEFF",
		5
	},
	{
		7,
		"亲属",
		"#FFB11E",
		4
	}
}
local t_hero_relation_typ = {}

t_hero_relation_typ.dataList = dataList

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
	t_hero_relation_typ[v[1]] = v

	setmetatable(v, mt)
end

return t_hero_relation_typ
