-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_character_unlock_content.lua

module("logic.config.t_character_unlock_content", package.seeall)

local title = {
	voiceId = 4,
	pastId = 3,
	id = 2,
	code = 1,
	condition = 5
}
local dataList = {}
local t_character_unlock_content = {}

t_character_unlock_content.dataList = dataList

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
	local parent1 = t_character_unlock_content[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_character_unlock_content[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_character_unlock_content
