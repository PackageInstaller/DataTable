-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_second_money_goods.lua

module("logic.config.t_second_money_goods", package.seeall)

local title = {
	name = 3,
	quality = 5,
	sortIndex = 13,
	secondMoneyId = 8,
	costFirstMoneyNum = 7,
	buyLimit = 12,
	exchangeNum = 9,
	desc = 6,
	goodsType = 2,
	normalExtraExchangeNum = 11,
	onlineEndTime = 14,
	bindActivityLogic = 15,
	goodsId = 1,
	icon = 4,
	bindActivityConfig = 16,
	firstExtraExchangeNum = 10
}
local dataList = {
	{
		12100001,
		12,
		"以太结晶*10",
		"shop_yt_1",
		1,
		"珍贵矿石，极高的价值使其具有广泛的用途。",
		1,
		1100002,
		10,
		0,
		0,
		0,
		1,
		nil,
		0,
		0
	},
	{
		12100002,
		12,
		"以太结晶*60",
		"shop_yt_2",
		1,
		"珍贵矿石，极高的价值使其具有广泛的用途。",
		6,
		1100002,
		60,
		60,
		0,
		0,
		3,
		nil,
		0,
		0
	},
	{
		12100003,
		12,
		"以太结晶*300",
		"shop_yt_3",
		1,
		"珍贵矿石，极高的价值使其具有广泛的用途。",
		30,
		1100002,
		300,
		300,
		0,
		0,
		5,
		nil,
		0,
		0
	},
	{
		12100004,
		12,
		"以太结晶*680",
		"shop_yt_4",
		1,
		"珍贵矿石，极高的价值使其具有广泛的用途。",
		68,
		1100002,
		680,
		680,
		0,
		0,
		2,
		nil,
		0,
		0
	},
	{
		12100005,
		12,
		"以太结晶*1280",
		"shop_yt_5",
		1,
		"珍贵矿石，极高的价值使其具有广泛的用途。",
		128,
		1100002,
		1280,
		1280,
		0,
		0,
		4,
		nil,
		0,
		0
	},
	{
		12100006,
		12,
		"以太结晶*3280",
		"shop_yt_6",
		1,
		"珍贵矿石，极高的价值使其具有广泛的用途。",
		328,
		1100002,
		3280,
		3280,
		0,
		0,
		6,
		nil,
		0,
		0
	},
	{
		12100007,
		12,
		"以太结晶*6480",
		"shop_yt_7",
		4,
		"珍贵矿石，极高的价值使其具有广泛的用途。",
		648,
		1100002,
		6480,
		6480,
		0,
		0,
		7,
		nil,
		0,
		0
	}
}
local t_second_money_goods = {}

t_second_money_goods.dataList = dataList

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
	t_second_money_goods[v[1]] = v

	setmetatable(v, mt)
end

return t_second_money_goods
