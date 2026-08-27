local bs_10300 = class("bs_10300", LuaSkillBase)
local base = LuaSkillBase
bs_10300.config = {}

function bs_10300:ctor()
end

function bs_10300:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10300_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
end

function bs_10300:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self:IsReadyToTake() and sender == self.caster and isCrit and skill.isCommonAttack then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * self.arglist[1] // 1000
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          self:OnSkillTake()
        end
      end
    end
    self:PlayChipEffect()
  end
end

function bs_10300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10300
