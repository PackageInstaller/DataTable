local bs_207302 = class("bs_207302", LuaSkillBase)
local base = LuaSkillBase
bs_207302.config = {}

function bs_207302:ctor()
end

function bs_207302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_207302_1", 1, self.OnAfterHurt, nil, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_207302:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and sender == self.caster and not isMiss then
    local skills = target:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * -1 * self.arglist[1] // 1000
          if not skills[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
  end
end

function bs_207302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207302
