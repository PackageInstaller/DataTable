-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleStatisticsMo.lua

module("logic.extensions.battle.model.BattleStatisticsMo", package.seeall)

local BattleStatisticsMo = class("BattleStatisticsMo")

function BattleStatisticsMo:ctor()
	self.teamId = 0
	self.charactorId = 0
	self.damage = 0
	self.treatment = 0
	self.defentDamage = 0
	self.defentTreatment = 0
	self.faceId = 0
	self.petLv = 0
end

return BattleStatisticsMo
