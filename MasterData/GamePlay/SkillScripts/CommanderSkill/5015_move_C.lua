local bs_5015 = class("bs_5015", LuaSkillBase)
local base = LuaSkillBase
bs_5015.config = {
  effectId_up = 501101,
  effectId_down = 501102,
  effectId_heal = 501301,
  buffId_1000 = 1000,
  buffId_3004 = 3004,
  buffId_60505 = 60505
}
bs_5015.AbandonTakeFeature = {
  eBuffFeatureType.NotMove,
  eBuffFeatureType.Bewitch,
  eBuffFeatureType.Taunt,
  eBuffFeatureType.Stun,
  eBuffFeatureType.KnockOff,
  eBuffFeatureType.BeatBack,
  eBuffFeatureType.Exiled,
  eBuffFeatureType.AbandonMove
}

function bs_5015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_5015:PlaySkill(data, selectTargetCoord, selectRoles)
  self.targetGrid = LuaSkillCtrl:GetGridWithPos(selectTargetCoord.x, selectTargetCoord.y)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5015:CallSelectExecute(role)
  if role ~= nil and self.targetGrid ~= nil and role.belongNum == self.caster.belongNum then
    LuaSkillCtrl:CallEffect(role, self.config.effectId_up, self)
    LuaSkillCtrl:CallBreakAllSkill(role)
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_1000, 1, 5, true)
    self:TryResetMoveState(role)
    LuaSkillCtrl:SetRolePos(self.targetGrid, role)
    LuaSkillCtrl:CallEffect(role, self.config.effectId_down, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_3004, 1, 5, true)
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_60505, 1)
  end
end

function bs_5015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5015
