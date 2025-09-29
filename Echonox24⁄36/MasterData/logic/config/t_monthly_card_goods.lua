-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_monthly_card_goods.lua

module("logic.config.t_monthly_card_goods", package.seeall)

local title = {
	dailyReward = 7,
	name = 3,
	totalDayLimit = 9,
	reward = 6,
	onlineEndTime = 10,
	bindActivityLogic = 11,
	bindActivityConfig = 12,
	desc = 4,
	goodsType = 2,
	explainId = 13,
	goodsId = 1,
	icon = 5,
	effectiveDays = 8
}
local dataList = {
	{
		11100001,
		11,
		"PRIME会员购",
		"会员有效期持续<color=#f1aa3b>30</color>天|累计可获得<color=#f1aa3b>3300</color>以太结晶|有效期内战斗悔棋次数<color=#f1aa3b>+9</color>",
		"shop_gift_0000",
		"{1100002:300}",
		"{1100002:100}",
		30,
		180,
		nil,
		0,
		0,
		1003
	}
}
local t_monthly_card_goods = {}

t_monthly_card_goods.dataList = dataList

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
	t_monthly_card_goods[v[1]] = v

	setmetatable(v, mt)
end

return t_monthly_card_goods
