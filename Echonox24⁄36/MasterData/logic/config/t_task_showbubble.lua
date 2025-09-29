-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_task_showbubble.lua

module("logic.config.t_task_showbubble", package.seeall)

local title = {
	factor = 2,
	labelType = 3,
	actionName = 6,
	code = 1,
	content = 4,
	voice = 5
}
local dataList = {
	{
		1000001,
		1,
		1,
		"你完成任务了 好厉害哟",
		"gacha_bell",
		"idle"
	},
	{
		1000002,
		2,
		2,
		"你杵在这里啥也不干干嘛",
		"",
		"idle"
	},
	{
		1000003,
		3,
		1,
		"第三条泡泡内容提示",
		"gacha_bell",
		"idle"
	},
	{
		1000004,
		4,
		2,
		"第四条泡泡内容提示",
		"",
		"idle"
	},
	{
		1000005,
		4,
		1,
		"第五条泡泡内容提示",
		"gacha_bell",
		"idle"
	}
}
local t_task_showbubble = {}

t_task_showbubble.dataList = dataList

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
	t_task_showbubble[v[1]] = v

	setmetatable(v, mt)
end

return t_task_showbubble
