-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_ring_camera_param.lua

module("logic.config.t_house_ring_camera_param", package.seeall)

local title = {
	rangePosZ = 2,
	ringType = 1,
	rangeRadius = 3
}
local dataList = {
	{
		1,
		"-46#-39",
		"29#31"
	},
	{
		2,
		"-55#-39",
		"48.8#55.6"
	},
	{
		3,
		"-46#-39",
		"70.8#72.4"
	},
	{
		4,
		"-51#-39",
		"84#86"
	}
}
local t_house_ring_camera_param = {}

t_house_ring_camera_param.dataList = dataList

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
	t_house_ring_camera_param[v[1]] = v

	setmetatable(v, mt)
end

return t_house_ring_camera_param
