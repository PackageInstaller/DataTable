-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_monster_first_hint.lua

module("logic.config.t_monster_first_hint", package.seeall)

local title = {
	isBoss = 4,
	name = 2,
	label = 7,
	funcDesc = 8,
	hint = 9,
	image = 3,
	career = 6,
	colorType = 5,
	code = 1
}
local dataList = {
	{
		10001,
		"猎食者",
		"gwdctc_img_0002_boss",
		1,
		4,
		4,
		"以太;高,移动力;低",
		"猎食者近身后会眩晕目标，不要被祂追上了",
		"当猎食结束，什么痕迹都不会留下"
	},
	{
		11001,
		"狂欢路灯",
		"gwdctc_img_0002_gw",
		0,
		2,
		1,
		"范围;伤害,眩晕;敌人",
		"锋利的圆锯会让敌人眩晕，注意避其锋芒",
		"三小时的人生电影"
	}
}
local t_monster_first_hint = {}

t_monster_first_hint.dataList = dataList

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
	t_monster_first_hint[v[1]] = v

	setmetatable(v, mt)
end

return t_monster_first_hint
