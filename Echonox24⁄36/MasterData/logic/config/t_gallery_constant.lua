-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_gallery_constant.lua

module("logic.config.t_gallery_constant", package.seeall)

local title = {
	strValue = 3,
	key = 1,
	numValue = 2,
	numValues = 4
}
local dataList = {
	{
		"CommentHotTagCount",
		5,
		""
	},
	{
		"CommentTagLimit",
		3,
		""
	},
	{
		"CommentRefreshMinute",
		60,
		""
	},
	{
		"CompareRightModelId",
		120001,
		""
	}
}
local t_gallery_constant = {}

t_gallery_constant.dataList = dataList

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
	t_gallery_constant[v[1]] = v

	setmetatable(v, mt)
end

return t_gallery_constant
