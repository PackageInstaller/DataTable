-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_loading.lua

module("logic.config.t_loading", package.seeall)

local title = {
	title = 3,
	code = 1,
	bgName = 2,
	content = 4
}
local dataList = {
	{
		1,
		"loading_bg4",
		"现实时间",
		"我们从未理解时间，只是习惯祂"
	},
	{
		2,
		"loading_bg4",
		"守秘人准则第一条",
		"在神秘学的世界里，无知是幸运的\r\n越了解异常，异常越容易降临\r\n对普通人最好的保护，是不让他们接触超凡"
	}
}
local t_loading = {}

t_loading.dataList = dataList

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
	t_loading[v[1]] = v

	setmetatable(v, mt)
end

return t_loading
