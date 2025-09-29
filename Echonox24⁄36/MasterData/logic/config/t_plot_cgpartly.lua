-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_plot_cgpartly.lua

module("logic.config.t_plot_cgpartly", package.seeall)

local title = {
	bgPath = 3,
	code = 1,
	name = 2
}
local dataList = {}
local t_plot_cgpartly = {}

t_plot_cgpartly.dataList = dataList

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
	t_plot_cgpartly[v[1]] = v

	setmetatable(v, mt)
end

return t_plot_cgpartly
