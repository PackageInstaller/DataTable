local bs_3001 = class("bs_3001", LuaSkillBase)
local base = LuaSkillBase
bs_3001.config = {effectId = 210201}

function bs_3001:ctor()
end

function bs_3001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforePlaySkillTrigger("bs_3001_1", 1, self.OnBeforePlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_3001", 1, self.OnAfterBattleStart)
end

function bs_3001:OnBeforePlaySkill(role, context)
  if role == self.caster and context.skill.isCommonAttack then
    local targetList = LuaSkillCtrl:GetGuardProfession()
    if targetList == nil then
      return
    end
    self.caster:SetRoleMoveFollowTarget(targetList, false, false)
  end
end

function bs_3001:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:GetGuardProfession()
  if targetList == nil then
    return
  end
  self.caster:SetRoleMoveFollowTarget(targetList, false, false)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
end

function bs_3001:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return bs_3001
