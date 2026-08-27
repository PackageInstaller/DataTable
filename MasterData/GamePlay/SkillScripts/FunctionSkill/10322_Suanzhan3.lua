local bs_10322 = class("bs_10322", LuaSkillBase)
local base = LuaSkillBase
bs_10322.config = {}

function bs_10322:ctor()
end

function bs_10322:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10322_4", 1, self.OnAfterHurt, self.caster)
end

function bs_10322:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and hurtType == eHurtType.MagicDmg and self:IsReadyToTake() and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * self.arglist[2] // 1000
          if not skills[j].isCommonAttack then
            self:OnSkillTake()
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
  end
end

function bs_10322:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10322
