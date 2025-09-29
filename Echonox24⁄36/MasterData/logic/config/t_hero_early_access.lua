-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_hero_early_access.lua

module("logic.config.t_hero_early_access", package.seeall)

local title = {
	imageGuideId = 6,
	name = 2,
	reward = 5,
	jumpId = 9,
	levelId = 4,
	condition = 8,
	heroId = 3,
	roleImg = 7,
	code = 1
}
local dataList = {
	{
		60002,
		"洄游空响",
		2000002,
		180002,
		2260001,
		5101,
		"syqtp_role_cfxl",
		"完成关卡可获得",
		22000000
	},
	{
		60057,
		"超凡序列",
		2000057,
		181057,
		2260001,
		7120,
		"syqtp_role_edps",
		"完成关卡可获得",
		40011002
	},
	{
		60051,
		"凛冽电光",
		2000051,
		181051,
		2260001,
		7121,
		"syqtp_role_kln",
		"完成关卡可获得",
		40011003
	}
}
local t_hero_early_access = {}

t_hero_early_access.dataList = dataList

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
	t_hero_early_access[v[1]] = v

	setmetatable(v, mt)
end

return t_hero_early_access
