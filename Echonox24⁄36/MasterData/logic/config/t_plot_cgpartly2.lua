-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_plot_cgpartly2.lua

module("logic.config.t_plot_cgpartly2", package.seeall)

local title = {
	name = 2,
	code = 1,
	subCgPath = 3
}
local dataList = {}
local t_plot_cgpartly2 = {}

t_plot_cgpartly2.dataList = dataList

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
	t_plot_cgpartly2[v[1]] = v

	setmetatable(v, mt)
end

return t_plot_cgpartly2
