-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/items/BattleItemEffect.lua

module("logic.extensions.battle.model.items.BattleItemEffect", package.seeall)

local BattleItemEffect = class("BattleItemEffect")

function BattleItemEffect:ctor(effPath, hagPoint)
	self.effPath = effPath
	self.hagPoint = hagPoint
end

return BattleItemEffect
