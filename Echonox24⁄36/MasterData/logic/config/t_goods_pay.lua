-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_goods_pay.lua

module("logic.config.t_goods_pay", package.seeall)

local title = {
	goodsType = 2,
	name = 3,
	sdkPayId = 5,
	goodsId = 1,
	price = 4
}
local dataList = {
	{
		10100001,
		10,
		"少量介质",
		600,
		""
	},
	{
		10100002,
		10,
		"一些介质",
		3000,
		""
	},
	{
		10100003,
		10,
		"许多介质",
		6800,
		""
	},
	{
		10100004,
		10,
		"很多介质",
		12800,
		""
	},
	{
		10100005,
		10,
		"大量介质",
		32800,
		""
	},
	{
		10100006,
		10,
		"超凡介质",
		64800,
		""
	},
	{
		11100001,
		11,
		"月卡",
		3000,
		""
	},
	{
		16100001,
		12,
		"赛季vip1",
		6800,
		""
	},
	{
		16100002,
		12,
		"赛季vip1-2",
		6800,
		""
	},
	{
		16100003,
		12,
		"赛季vip2",
		12800,
		""
	}
}
local t_goods_pay = {}

t_goods_pay.dataList = dataList

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
	t_goods_pay[v[1]] = v

	setmetatable(v, mt)
end

return t_goods_pay
