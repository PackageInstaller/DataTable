-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_equip_lv_effect.lua

module("logic.config.t_roguelike_equip_lv_effect", package.seeall)

local title = {
	lv = 2,
	upgradeItems = 9,
	cd = 6,
	cdType = 5,
	id = 1,
	activeEffectDescription = 3,
	activeEffects = 4,
	passiveEffectDescription = 7,
	passiveEffects = 8
}
local dataList = {}
local t_roguelike_equip_lv_effect = {}

t_roguelike_equip_lv_effect.dataList = dataList

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
	setmetatable(v, mt)
end

return t_roguelike_equip_lv_effect
