-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_script.lua

module("logic.config.t_roguelike_script", package.seeall)

local title = {
	type = 4,
	name = 2,
	thumbnail = 5,
	selectRolePlot = 8,
	atmosphereMap = 6,
	enterPlot = 7,
	failPlot = 9,
	desc = 3,
	id = 1
}
local dataList = {
	{
		100,
		"迷雾森林",
		"西格纳斯西北部索纳雅村庄自五月起停止供应棉花，报案者自述无法联络上供应商，且庄园被厚重的雾霾所笼罩。",
		1,
		"rungroup_drama1",
		"rungroup_readjust6",
		0,
		0,
		0
	},
	{
		101,
		"罪与罚",
		"雨城小队前往白羽特别州第十九区调查连续失踪案件，却在抵达第八日失去音讯，队伍定位及信号被抹除。当清理队伍前往救援时，发现目的地发生大面积塌陷，整座城市空无一人。",
		2,
		"rungroup_drama1",
		"rungroup_readjust6",
		0,
		5010101,
		5010102
	}
}
local t_roguelike_script = {}

t_roguelike_script.dataList = dataList

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
	t_roguelike_script[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_script
