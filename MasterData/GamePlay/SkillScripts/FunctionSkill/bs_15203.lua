local bs_15203 = class("bs_15203", LuaSkillBase)
local base = LuaSkillBase
bs_15203.config = {eatEffectId = 10735, effectId = 12076}

function bs_15203:ctor()
end

function bs_15203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_15203_1", 1, self.OnAfterPlaySkill)
end

function bs_15203:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack and self:IsReadyToTake() then
    self:OnSkillTake()
    local targetlist = LuaSkillCtrl:FindRolesAroundRole(self.caster)
    if targetlist == nil then
      return
    end
    if targetlist.Count > 0 then
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
      for i = 0, targetlist.Count - 1 do
        local targetRole = targetlist[i]
        if targetRole.belongNum == eBattleRoleBelong.player and not targetRole:IsUnSelect(self.caster) then
          local skills = targetRole:GetBattleSkillList()
          if skills ~= nil then
            local skillCount = skills.Count
            if 0 < skillCount then
              for j = 0, skillCount - 1 do
                local curTotalCd = skills[j].totalCDTime * self.arglist[1] // 1000
                if not skills[j].isCommonAttack then
                  LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
                  LuaSkillCtrl:CallEffect(targetRole, self.config.eatEffectId, self)
                end
              end
            end
          end
        end
      end
    end
  end
end

function bs_15203:OnAfterBattleStart()
end

function bs_15203:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15203
