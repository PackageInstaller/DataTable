-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_room.lua

module("logic.config.t_house_room", package.seeall)

local title = {
	subRoomType = 2,
	roomType = 1,
	initPosOffset = 5,
	resLoadType = 4,
	resPath = 3
}
local dataList = {
	{
		1,
		0,
		"sx-s202_control-room/scene_run/sx-s202_control-room_run",
		1,
		""
	},
	{
		2,
		0,
		"sx-s203_trade_station/scene_run/sx-s203_trade-station_run",
		1,
		""
	},
	{
		3,
		0,
		"sx-s204_manufacturer/scene_run/sx-s204_manufacturer_run",
		1,
		""
	},
	{
		4,
		1,
		"sx-s205_snakeroom/scene_run/sx-s205_snakeroom_run#sx-s205_snakeroom",
		2,
		""
	},
	{
		4,
		2,
		"sx-s206_adversity/scene_run/sx-s206_adversity_run#sx-s206_adversity",
		2,
		"0#-0.8#0"
	},
	{
		5,
		1,
		"sx-s211_emptyroom/scene_run/sx-s211_emptyroom_run#sx-s211_emptyroom",
		3,
		""
	},
	{
		5,
		2,
		"sx-s211_emptyroom/scene_run/sx-s211_emptyroom_run#sx-s211_emptyroom",
		3,
		""
	},
	{
		5,
		3,
		"sx-s211_emptyroom/scene_run/sx-s211_emptyroom_run#sx-s211_emptyroom",
		3,
		""
	},
	{
		5,
		4,
		"sx-s211_emptyroom/scene_run/sx-s211_emptyroom_run#sx-s211_emptyroom",
		3,
		""
	},
	{
		5,
		7,
		"sx-s212_mysteriousroom/scene_run/sx-s212_mysteriousroom_run#sx-s212_emptyroom",
		3,
		""
	}
}
local t_house_room = {}

t_house_room.dataList = dataList

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
	local parent1 = t_house_room[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_house_room[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_house_room
