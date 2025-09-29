-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_hero_preview_info.lua

module("logic.config.t_hero_preview_info", package.seeall)

local title = {
	id = 1,
	name = 4,
	camId = 2,
	posId = 3
}
local dataList = {
	{
		1,
		1,
		1,
		"默认"
	},
	{
		2000005,
		5,
		100005,
		"幻星"
	},
	{
		2000007,
		4,
		100007,
		"欧几里得"
	},
	{
		2000008,
		3,
		100008,
		"六分仪"
	},
	{
		2000010,
		1,
		100010,
		"林鸮"
	},
	{
		2000011,
		1,
		100011,
		"一云"
	},
	{
		2000012,
		1,
		100012,
		"芬里尔"
	},
	{
		2000013,
		3,
		100013,
		"安妮薇"
	},
	{
		2000016,
		5,
		100016,
		"烟火"
	},
	{
		2000019,
		5,
		100019,
		"多里安"
	},
	{
		2000020,
		1,
		100020,
		"安布蕾拉"
	},
	{
		2000021,
		1,
		100021,
		"暮雪"
	},
	{
		2000022,
		5,
		100022,
		"飞鸟"
	},
	{
		2000025,
		3,
		100025,
		"磷火"
	},
	{
		2000028,
		5,
		100028,
		"创"
	},
	{
		2000029,
		3,
		100029,
		"韩赛尔"
	},
	{
		2000030,
		1,
		100030,
		"波波沙"
	},
	{
		2000031,
		1,
		100031,
		"卡布奇诺"
	},
	{
		2000036,
		1,
		100036,
		"多萝西"
	},
	{
		2000039,
		1,
		100039,
		"伊丽莎白"
	},
	{
		2000041,
		1,
		100041,
		"辛德瑞拉"
	},
	{
		2000043,
		1,
		100043,
		"雅"
	},
	{
		2000046,
		5,
		100046,
		"伊万"
	},
	{
		2000047,
		3,
		100047,
		"奥杰塔"
	},
	{
		2000051,
		5,
		100051,
		"卡琳娜"
	},
	{
		2000053,
		1,
		100053,
		"阿尼亚"
	},
	{
		2000055,
		2,
		100055,
		"格里高列"
	},
	{
		2000056,
		5,
		100056,
		"提亚"
	},
	{
		2000057,
		2,
		100057,
		"厄迪普斯"
	}
}
local t_hero_preview_info = {}

t_hero_preview_info.dataList = dataList

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
	t_hero_preview_info[v[1]] = v

	setmetatable(v, mt)
end

return t_hero_preview_info
