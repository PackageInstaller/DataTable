-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_gallery_hero.lua

module("logic.config.t_gallery_hero", package.seeall)

local title = {
	id = 1
}
local dataList = {
	{
		2000002
	},
	{
		2000003
	},
	{
		2000004
	},
	{
		2000005
	},
	{
		2000006
	},
	{
		2000007
	},
	{
		2000008
	},
	{
		2000009
	},
	{
		2000010
	},
	{
		2000011
	},
	{
		2000012
	},
	{
		2000013
	},
	{
		2000014
	},
	{
		2000015
	},
	{
		2000016
	},
	{
		2000017
	},
	{
		2000018
	},
	{
		2000019
	},
	{
		2000020
	},
	{
		2000021
	},
	{
		2000022
	},
	{
		2000023
	},
	{
		2000024
	},
	{
		2000025
	},
	{
		2000026
	},
	{
		2000027
	},
	{
		2000028
	},
	{
		2000029
	},
	{
		2000030
	},
	{
		2000031
	},
	{
		2000032
	},
	{
		2000033
	},
	{
		2000034
	},
	{
		2000035
	},
	{
		2000036
	},
	{
		2000037
	},
	{
		2000038
	},
	{
		2000039
	},
	{
		2000040
	},
	{
		2000041
	},
	{
		2000042
	},
	{
		2000043
	},
	{
		2000044
	},
	{
		2000045
	},
	{
		2000046
	},
	{
		2000047
	},
	{
		2000048
	},
	{
		2000049
	},
	{
		2000050
	},
	{
		2000051
	},
	{
		2000052
	},
	{
		2000053
	},
	{
		2000054
	},
	{
		2000055
	},
	{
		2000056
	},
	{
		2000057
	},
	{
		2000058
	},
	{
		2000059
	},
	{
		2000060
	}
}
local t_gallery_hero = {}

t_gallery_hero.dataList = dataList

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
	t_gallery_hero[v[1]] = v

	setmetatable(v, mt)
end

return t_gallery_hero
