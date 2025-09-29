-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_gallery_comment_tag.lua

module("logic.config.t_gallery_comment_tag", package.seeall)

local title = {
	id = 1,
	typ = 3,
	content = 2
}
local dataList = {
	{
		1001,
		"YYDS",
		4
	},
	{
		1002,
		"来去无踪",
		4
	},
	{
		1003,
		"无敌金身",
		4
	},
	{
		1004,
		"一拳超人",
		3
	},
	{
		1005,
		"超高AI",
		3
	},
	{
		1006,
		"天天刮痧",
		3
	},
	{
		1007,
		"有点东西",
		2
	},
	{
		1008,
		"偶尔翻车",
		2
	},
	{
		1009,
		"纯粹看脸",
		2
	},
	{
		1010,
		"脆皮",
		1
	},
	{
		1011,
		"小菜鸟",
		1
	},
	{
		1012,
		"人工智障",
		1
	}
}
local t_gallery_comment_tag = {}

t_gallery_comment_tag.dataList = dataList

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
	t_gallery_comment_tag[v[1]] = v

	setmetatable(v, mt)
end

return t_gallery_comment_tag
