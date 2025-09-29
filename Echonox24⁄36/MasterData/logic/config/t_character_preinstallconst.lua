-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_character_preinstallconst.lua

module("logic.config.t_character_preinstallconst", package.seeall)

local title = {
	numValue = 2,
	keyName = 1
}
local dataList = {
	{
		"CharPreNumLimit",
		20
	},
	{
		"TeamNumLimit",
		20
	}
}
local t_character_preinstallconst = {}

t_character_preinstallconst.dataList = dataList

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
	t_character_preinstallconst[v[1]] = v

	setmetatable(v, mt)
end

return t_character_preinstallconst
