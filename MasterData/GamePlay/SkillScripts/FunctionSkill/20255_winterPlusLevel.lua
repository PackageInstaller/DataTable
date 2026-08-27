local bs_20255 = class("bs_20255", LuaSkillBase)
local base = LuaSkillBase
bs_20255.config = {buffId = 2013, buffId2 = 105}

function bs_20255:ctor()
end

function bs_20255:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_20255_2", 1, self.OnAfterHurt, self.caster, nil, eBattleRoleBelong.enemy, eBattleRoleBelong.player, nil, nil, nil, eSkillTag.commonAttack)
  self:AddBuffDieTrigger("bs_20255_3", 1, self.OnBuffDie, nil, eBattleRoleBelong.enemy, self.config.buffId)
end

function bs_20255:OnBuffDie(buff, target, removeType)
  LuaSkillCtrl:CallStartLocalScale(target, Vector3.New(1, 1, 1))
end

function bs_20255:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isTriggerSet and not isMiss then
    local buffTier = sender:GetBuffTier(self.config.buffId)
    if buffTier >= self.arglist[2] then
      LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, 1, self.arglist[3])
      return
    end
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, 1, self.arglist[3])
    local scale = buffTier * 0.1 + 1
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(scale, scale, scale))
  end
end

function bs_20255:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20255
