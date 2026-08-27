local bs_5016 = class("bs_5016", LuaSkillBase)
local base = LuaSkillBase
bs_5016.config = {
  effectId_up = 501101,
  effectId_down = 501102,
  efeffectId_around = 604,
  buffId_1000 = 1000,
  buffId_3004 = 3004,
  buffId_fengying = 603,
  buffId = 501201
}
bs_5016.AbandonTakeFeature = {
  eBuffFeatureType.NotMove,
  eBuffFeatureType.Bewitch,
  eBuffFeatureType.Taunt,
  eBuffFeatureType.Stun,
  eBuffFeatureType.KnockOff,
  eBuffFeatureType.BeatBack,
  eBuffFeatureType.Exiled,
  eBuffFeatureType.AbandonMove
}

function bs_5016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_5016:PlaySkill(data, selectTargetCoord, selectRoles)
  self.targetGrid = LuaSkillCtrl:GetGridWithPos(selectTargetCoord.x, selectTargetCoord.y)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5016:CallSelectExecute(role)
  if role ~= nil and self.targetGrid ~= nil and role.belongNum == self.caster.belongNum then
    LuaSkillCtrl:CallEffect(role, self.config.effectId_up, self)
    LuaSkillCtrl:CallBreakAllSkill(role)
    self:TryResetMoveState(role)
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_1000, 1, 5, true)
    LuaSkillCtrl:SetRolePos(self.targetGrid, role)
    LuaSkillCtrl:CallEffect(role, self.config.effectId_down, self)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_3004, 1, 5, true)
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1], true)
    LuaSkillCtrl:CallEffect(role, self.config.efeffectId_around, self)
    local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(role, 1, false)
    if targetlist_enemy.Count > 0 then
      for i = 0, targetlist_enemy.Count - 1 do
        if targetlist_enemy[i].belongNum == eBattleRoleBelong.enemy then
          LuaSkillCtrl:CallBuff(self, targetlist_enemy[i], self.config.buffId_fengying, 1, self.arglist[3], true)
        end
      end
    end
  end
end

function bs_5016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5016
