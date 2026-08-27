local bs_17018 = class("bs_17018", LuaSkillBase)
local base = LuaSkillBase
bs_17018.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10182,
    crit_formula = 0
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  effectId = 10936,
  ysBuff = 2098
}

function bs_17018:ctor()
end

function bs_17018:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_17018_3", 3, self.OnAfterPlaySkill)
  self:AddAfterHurtTrigger("bs_17018_2", 1, self.OnAfterHurt, self.caster)
  self.isYunShi = false
end

function bs_17018:OnAfterPlaySkill(skill, role)
  if not skill.isCommonAttack and not self.isYunShi then
    self.isYunShi = true
  end
end

function bs_17018:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not skill.isCommonAttack and target == self.caster.recordTable.lastAttackRole and self.isYunShi and not isTriggerSet then
    self.isYunShi = false
    self:PlayChipEffect()
    self:OnSkillTake()
    local arriveCallBack = BindCallback(self, self.OnArriveAction, target)
    LuaSkillCtrl:StartTimer(nil, 15, arriveCallBack)
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_17018:OnArriveAction(role)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role, self.config.aoe_config)
  if skillResult.roleList.Count > 0 then
    for i = 0, skillResult.roleList.Count - 1 do
      local targetRole = skillResult.roleList[i]
      local buffTier = targetRole:GetBuffTier(self.config.ysBuff)
      local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult1, self.config.hurt_config, {buffTier}, true)
    end
  end
  skillResult:EndResult()
end

function bs_17018:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17018
