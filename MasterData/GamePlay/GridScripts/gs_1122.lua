local gs_1122 = class("gs_1122", LuaGridBase)
local base = LuaGridBase
gs_1122.config = {
  effectId = 10374,
  leafEffectId = 10733,
  eatEffectId = 10376,
  buffId = 1049,
  buffTier = 300,
  caoTime = 70,
  lineEffectId = 10728
}

function gs_1122:ctor()
end

function gs_1122:OnGridBattleStart(role)
end

function gs_1122:OnGridEnterRole(role)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnStateWake)
end

function gs_1122:OnGridExitRole(role)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnStateSleep)
end

function gs_1122:OnGridRoleDead(role)
end

return gs_1122
