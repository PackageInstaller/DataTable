-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_main_perform_animix_r.lua

module("logic.config.t_main_perform_animix_r", package.seeall)

local title = {
	default = 2,
	id = 1,
	sp = 3
}
local dataList = {
	{
		2000012,
		0.4,
		"jiaoshiqi_loop,0.45"
	}
}
local t_main_perform_animix_r = {}

t_main_perform_animix_r.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name[%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_main_perform_animix_r[v[1]] = v

	setmetatable(v, mt)
end

return t_main_perform_animix_r
