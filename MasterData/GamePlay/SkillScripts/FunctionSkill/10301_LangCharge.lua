local bs_10301 = class("bs_10301", LuaSkillBase)
local base = LuaSkillBase
bs_10301.config = {eatEffectId = 10735, stunBuff = 110006}

function bs_10301:ctor()
end

function bs_10301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnWaveCollision, self.OnWaveCollision)
  self.caster.recordTable["10301_flag"] = true
end

function bs_10301:OnWaveCollision(entity)
  if entity == self.caster then
    local skills = entity:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * self.arglist[1] // 1000
          if not skills[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
            LuaSkillCtrl:CallEffect(entity, self.config.eatEffectId, self)
          end
        end
      end
    end
  end
end

function bs_10301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10301
