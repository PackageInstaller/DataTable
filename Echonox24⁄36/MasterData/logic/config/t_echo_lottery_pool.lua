-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_echo_lottery_pool.lua

module("logic.config.t_echo_lottery_pool", package.seeall)

local title = {
	cost = 5,
	name = 2,
	code = 1,
	description = 6,
	campType = 3,
	systemOpen = 4
}
local dataList = {
	{
		2001,
		"常驻残响卡包",
		1,
		0,
		1013001,
		"1.每开启<color=#d4692d>2</color>个卡包，必定会有至少1个A级或以上残响。\r\n2.若连续20次开包未能获得S级残响，后续开包获得S级残响的概率会提升（其他评级的残响概率相应减少），至多<color=#d4692d>30</color>包内必定获得1个S级残响（综合为<color=#d4692d>15</color>包获得1个S级残响）；该概率提升在所有卡包共享，且在任一卡包获得S级残响后重置。\r\n3.每日开卡包上限是<color=#d4692d>999</color>次。\r\n4.常驻残响卡包在活动期间内可转换为当期活动卡包"
	},
	{
		2002,
		"限定：狂妄之智",
		2,
		0,
		1013002,
		"1.每开启<color=#d4692d>2</color>个卡包，必定会有至少1个A级或以上残响。\r\n2.若连续20次开包未能获得S级残响，后续开包获得S级残响的概率会提升（其他评级的残响概率相应减少），至多<color=#d4692d>30</color>包内必定获得1个S级残响（综合为<color=#d4692d>15</color>包获得1个S级残响）；该概率提升在所有卡包共享，且在任一卡包获得S级残响后重置。\r\n3.当开卡包获得S级残响时，有<color=#d4692d>50%</color>的概率为本期S级UP残响「<color=#d4692d>共生果实</color>」。如果本次开包获取的S级残响不是本期S级UP残响，下次开包获取的S级残响必定为本期S级UP残响。\r\n4.每日开卡包上限是<color=#d4692d>999</color>次。\r\n5.当前活动卡包不可转换为常驻残响卡包"
	},
	{
		2003,
		"限定：映铁雷光",
		2,
		0,
		1013003,
		"1.每开启<color=#d4692d>2</color>个卡包，必定会有至少1个A级或以上残响。\r\n2.若连续20次开包未能获得S级残响，后续开包获得S级残响的概率会提升（其他评级的残响概率相应减少），至多<color=#d4692d>30</color>包内必定获得1个S级残响（综合为<color=#d4692d>15</color>包获得1个S级残响）；该概率提升在所有卡包共享，且在任一卡包获得S级残响后重置。\r\n3.当开卡包获得S级残响时，有<color=#d4692d>50%</color>的概率为本期S级UP残响「<color=#d4692d>周四的读书会</color>」。如果本次开包获取的S级残响不是本期S级UP残响，下次开包获取的S级残响必定为本期S级UP残响\r\n4.每日开卡包上限是<color=#d4692d>999</color>次。\r\n5.当前活动卡包不可转换为常驻残响卡包"
	}
}
local t_echo_lottery_pool = {}

t_echo_lottery_pool.dataList = dataList

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
	t_echo_lottery_pool[v[1]] = v

	setmetatable(v, mt)
end

return t_echo_lottery_pool
