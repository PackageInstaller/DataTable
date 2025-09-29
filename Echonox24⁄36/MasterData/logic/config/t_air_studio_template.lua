-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_template.lua

module("logic.config.t_air_studio_template", package.seeall)

local title = {
	description = 3,
	mapId = 4,
	name = 2,
	sceneId = 5,
	id = 1
}
local dataList = {
	{
		1001,
		"常规战斗",
		"地形为常规战斗布置",
		"10001",
		"3100101"
	},
	{
		1002,
		"逃出生天",
		"长线逃离关卡，当要防止位移超捷径",
		"10002",
		"3100101"
	},
	{
		2001,
		"前后围攻",
		"前后左右均可向进攻方进行围攻的地形",
		"20001",
		"3100102"
	},
	{
		2002,
		"长途撤离",
		"距离很远的撤离路线，可在位移点布置埋伏",
		"20002",
		"3100102"
	},
	{
		3001,
		"常规战斗",
		"地形为常规战斗布置，需要攻方步步为营前进",
		"30001",
		"3100103"
	},
	{
		3002,
		"危机四伏",
		"迂回地形较多，可进行各种伏兵布置",
		"30002",
		"3100103"
	}
}
local t_air_studio_template = {}

t_air_studio_template.dataList = dataList

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
	t_air_studio_template[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_template
