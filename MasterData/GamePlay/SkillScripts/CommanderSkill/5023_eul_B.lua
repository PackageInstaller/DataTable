local bs_5023 = class("bs_5023", LuaSkillBase)
local base = LuaSkillBase
bs_5023.config = {buffId = 502101, enemyStunBuff = 289}
bs_5023.AbandonTakeFeature = {
  eBuffFeatureType.BeatBack,
  eBuffFeatureType.KnockOff,
  eBuffFeatureType.Stun,
  eBuffFeatureType.Exiled,
  eBuffFeatureType.CtrlImmunity
}

function bs_5023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterBuffRemoveTrigger("bs_5023_buff_die", 1, self.AfterBuffRemove, nil, nil, self.config.buffId)
end

function bs_5023:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5023:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1])
  end
end

function bs_5023:AfterBuffRemove(buffId, target, removeType)
  if target.hp <= 0 then
    return
  end
  if target.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, target, self.config.enemyStunBuff, 1, self.arglist[2])
  end
  LuaSkillCtrl:CallRedisplayInSkillInputCtrl(target)
end

function bs_5023:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5023
