-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\BattleObject.lua

local strClassName = "BattleObject"
local BattleObject = Class(strClassName)

function BattleObject:ctor(id)
	self.id = id
end

return BattleObject
