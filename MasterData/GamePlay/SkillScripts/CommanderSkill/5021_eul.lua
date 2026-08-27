local bs_5021 = class("bs_5021", LuaSkillBase)
local base = LuaSkillBase
bs_5021.config = {buffId = 502101}
bs_5021.AbandonTakeFeature = {
  eBuffFeatureType.BeatBack,
  eBuffFeatureType.KnockOff,
  eBuffFeatureType.Stun,
  eBuffFeatureType.Exiled,
  eBuffFeatureType.CtrlImmunity
}

function bs_5021:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterBuffRemoveTrigger("bs_5021_1", 1, self.AfterBuffRemove, nil, nil, self.config.buffId)
end

function bs_5021:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5021:CallSelectExecute(role)
  if role ~= nil and role.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1])
  end
end

function bs_5021:AfterBuffRemove(buffId, target, removeType)
  LuaSkillCtrl:CallRedisplayInSkillInputCtrl(target)
end

function bs_5021:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5021
