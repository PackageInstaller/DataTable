local bs_21250 = class("bs_21250", LuaSkillBase)
local base = LuaSkillBase
bs_21250.config = {
  buffId = 26,
  buffTier = 1,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10031,
    crit_formula = 0,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  },
  effctId = 20001
}

function bs_21250:ctor()
end

function bs_21250:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
end

function bs_21250:OnRoleSplash(role, grid)
  if role == self.caster and self:IsReadyToTake() then
    self:OnSkillTake()
    self:RealCastSkill()
  end
end

function bs_21250:OnRolePhaseMoveStart(role, luaskill)
  if role == self.caster and self:IsReadyToTake() then
    self:OnSkillTake()
    self:RealCastSkill()
  end
end

function bs_21250:RealCastSkill()
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.aoe_config)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
  for i = 0, skillResult.roleList.Count - 1 do
    local role = skillResult.roleList[i]
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier, self.arglist[2], true)
  end
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effctId, self)
  local skills = self.caster:GetBattleSkillList()
  if skills ~= nil then
    local skillCount = skills.Count
    if 0 < skillCount then
      for j = 0, skillCount - 1 do
        local curTotalCd = skills[j].totalCDTime * self.arglist[3] // 1000
        if not skills[j].isCommonAttack then
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
  end
end

function bs_21250:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21250
