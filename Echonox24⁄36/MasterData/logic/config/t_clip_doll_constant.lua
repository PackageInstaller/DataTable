-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_clip_doll_constant.lua

module("logic.config.t_clip_doll_constant", package.seeall)

local title = {
	tasknumber = 3,
	activityid = 1,
	coinid = 2
}
local dataList = {
	{
		801,
		1100017,
		4
	}
}
local t_clip_doll_constant = {}

t_clip_doll_constant.dataList = dataList

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
	t_clip_doll_constant[v[1]] = v

	setmetatable(v, mt)
end

return t_clip_doll_constant
