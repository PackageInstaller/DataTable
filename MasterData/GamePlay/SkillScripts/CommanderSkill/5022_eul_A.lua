local bs_5022 = class("bs_5022", LuaSkillBase)
local base = LuaSkillBase
bs_5022.config = {buffId = 502101, playerInvisibleBuff = 3004}
bs_5022.AbandonTakeFeature = {
  eBuffFeatureType.BeatBack,
  eBuffFeatureType.KnockOff,
  eBuffFeatureType.Stun,
  eBuffFeatureType.Exiled,
  eBuffFeatureType.CtrlImmunity
}

function bs_5022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterBuffRemoveTrigger("bs_5022_buff_die", 1, self.AfterBuffRemove, nil, nil, self.config.buffId)
end

function bs_5022:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5022:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1])
  end
end

function bs_5022:AfterBuffRemove(buffId, target, removeType)
  if target.hp <= 0 then
    return
  end
  if target.belongNum == eBattleRoleBelong.player then
    LuaSkillCtrl:CallBuff(self, target, self.config.playerInvisibleBuff, 1, self.arglist[2], true)
  end
  LuaSkillCtrl:CallRedisplayInSkillInputCtrl(target)
end

function bs_5022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5022
