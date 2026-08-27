local bs_10195 = class("bs_10195", LuaSkillBase)
local base = LuaSkillBase
bs_10195.config = {eatEffectId = 10376}

function bs_10195:ctor()
end

function bs_10195:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDoodad, self.OnDoodad)
end

function bs_10195:OnDoodad(sender, targetRole)
  if targetRole.belongNum == 2 and self.caster.recordTable.lastAttackRole == targetRole then
    self:PlayChipEffect()
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime
          if not skills[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
            self.flag = false
            LuaSkillCtrl:CallEffect(self.caster, self.config.eatEffectId, self)
          end
        end
        LuaSkillCtrl:CallDoodad(nil, self.caster)
      end
    end
  end
end

function bs_10195:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10195
