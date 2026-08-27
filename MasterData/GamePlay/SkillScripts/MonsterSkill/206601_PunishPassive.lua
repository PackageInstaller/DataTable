local bs_206601 = class("bs_206601", LuaSkillBase)
local base = LuaSkillBase
bs_206601.config = {
  buffId_punish = 206601,
  buffId_punish2 = 206602,
  buffId_bati = 206800,
  buffId_sueyoiSpecialAttack = 1045002
}

function bs_206601:ctor()
end

function bs_206601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_206601_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_206601_2", 1, self.OnSetHurt, nil, nil, nil, self.caster.belongNum)
  self.caster.recordTable.punish = true
  self.caster:AddRoleProperty(eHeroAttr.cd_reduce, 1000, eHeroAttrType.Extra)
end

function bs_206601:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_bati, 1, nil, true)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_punish, 1, nil, true)
end

function bs_206601:OnSetHurt(context)
  if context.target ~= self.caster and context.target.recordTable.crime == true and not LuaSkillCtrl:RoleContainsBuffFeature(self.caster, 16) then
    local ReducedHurt = context.hurt * 500 // 1000
    if context.sender:GetBuffTier(self.config.buffId_sueyoiSpecialAttack) > 0 then
      ReducedHurt = self:SueyoiSpecialAttackHurt(context)
    end
    if 0 < ReducedHurt then
      context.hurt = context.hurt - ReducedHurt
      LuaSkillCtrl:RemoveLife(ReducedHurt, self, self.caster, true, nil, true, true, eHurtType.RealDmg)
    end
  end
end

function bs_206601:SueyoiSpecialAttackHurt(context)
  local skillRatio = context.sender.skill_intensity * context.sender.recordTable.DeriveHurt * (1000 + context.sender.damage_increase - context.target.injury_reduce) // 1000 // 1000
  local hurt = LuaSkillCtrl:CallFormulaNumber(9994, context.sender, context.sender, skillRatio)
  return hurt
end

return bs_206601
