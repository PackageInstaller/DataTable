local bs_15096 = class("bs_15096", LuaSkillBase)
local base = LuaSkillBase
bs_15096.config = {fenEnBuff = 101901}

function bs_15096:ctor()
end

function bs_15096:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_15096_3", 2, self.OnBeforeAddBuff, self.caster, nil, nil, eBattleRoleBelong.enemy, 101901)
  self:AddAfterAddBuffTrigger("bs_15096_2", 1, self.OnAfterAddBuff, self.caster, nil, nil, eBattleRoleBelong.enemy, nil, nil, eBuffFeatureType.BeatBack)
end

function bs_15096:OnAfterAddBuff(buff, target)
  if target.belongNum == eBattleRoleBelong.enemy and self:IsReadyToTake() then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * self.arglist[1] // 1000
          if not skills[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
    self:OnSkillTake()
  end
end

function bs_15096:OnBeforeAddBuff(target, context)
  if target.belongNum == eBattleRoleBelong.enemy and self:IsReadyToTake() then
    local skills = self.caster:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * self.arglist[1] // 1000
          if not skills[j].isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
    self:OnSkillTake()
  end
end

function bs_15096:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15096
