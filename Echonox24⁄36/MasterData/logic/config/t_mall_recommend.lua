-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_mall_recommend.lua

module("logic.config.t_mall_recommend", package.seeall)

local title = {
	name = 2,
	isOnline = 6,
	sortIndex = 5,
	type = 3,
	code = 1,
	storeId = 9,
	endTime = 8,
	goodsId = 10,
	icon = 4,
	startTime = 7
}
local dataList = {
	{
		1,
		"PRIME会员购",
		1,
		"",
		1,
		true,
		nil,
		nil,
		130001,
		14101001
	},
	{
		2,
		"归鞘见礼",
		3,
		"",
		2,
		true,
		nil,
		nil,
		130001,
		0
	},
	{
		10005,
		"寻踪礼包",
		2,
		"sclb_banner_qiri_1",
		3,
		false,
		nil,
		nil,
		130002,
		14102002
	},
	{
		10006,
		"混响礼包",
		2,
		"sclb_banner_canxiang_1",
		7,
		false,
		nil,
		nil,
		130002,
		14102005
	},
	{
		10007,
		"限时补给",
		2,
		"slmyk_img_0004",
		6,
		false,
		nil,
		nil,
		130002,
		14102001
	},
	{
		10008,
		"测试便签",
		2,
		"slmyk_img_0004",
		8,
		false,
		nil,
		nil,
		160001,
		13501001
	}
}
local t_mall_recommend = {}

t_mall_recommend.dataList = dataList

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
	t_mall_recommend[v[1]] = v

	setmetatable(v, mt)
end

return t_mall_recommend
