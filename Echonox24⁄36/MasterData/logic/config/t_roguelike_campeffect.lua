-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_campeffect.lua

module("logic.config.t_roguelike_campeffect", package.seeall)

local title = {
	effects = 2,
	camp = 1,
	desc = 3
}
local dataList = {
	{
		1,
		nil,
		"判定中所有附着于OAD角色骰子上的暴击面将转化为管制面\r\n洞察整顿替换成管制预备"
	},
	{
		2,
		nil,
		"判定中追加三面神化面\r\n幸运整顿替换成神化预备"
	},
	{
		3,
		nil,
		"所有兄弟会角色的力量上升一个级别\r\n力量整顿替换成主动防御"
	},
	{
		4,
		nil,
		"白银黎明角色处于正理智值时、负理智时将会有不同的增益效果\r\n沟通整顿将无法使用"
	},
	{
		5,
		nil,
		"诺亚角色在判定中所有的知识面转化成科技面\r\n所有的整顿取值方式变动"
	},
	{
		6,
		nil,
		"星空教会角色可享受任意触发的阵营效果、内容"
	},
	{
		7,
		nil,
		"所有水滴角色在判定中追加一颗固定内容的“真相骰”\r\n整顿中只有无序混乱可用"
	}
}
local t_roguelike_campeffect = {}

t_roguelike_campeffect.dataList = dataList

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
	t_roguelike_campeffect[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_campeffect
