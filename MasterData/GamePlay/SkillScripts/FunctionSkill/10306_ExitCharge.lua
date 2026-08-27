local bs_10306 = class("bs_10306", LuaSkillBase)
local base = LuaSkillBase
bs_10306.config = {effectId = 10164}

function bs_10306:ctor()
end

function bs_10306:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10306_1", 1, self.OnAfterBattleStart)
end

function bs_10306:OnAfterBattleStart(isMidway)
  if not isMidway then
    return
  end
  if self.caster == nil then
    return
  end
  self:PlayChipEffect()
  LuaSkillCtrl:AddPlayerTowerMp(self.arglist[1])
  local skills = self.caster:GetBattleSkillList()
  if skills ~= nil then
    local skillCount = skills.Count
    if 0 < skillCount then
      for i = 0, skillCount - 1 do
        local curTotalCd = skills[i].totalCDTime
        LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], curTotalCd)
      end
    end
  end
end

function bs_10306:OnCasterDie()
  if self.caster == nil then
    return
  end
  self:PlayChipEffect()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 20)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    local skills = targetRole:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId, self)
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime * self.arglist[2] // 1000
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
  end
  base.OnCasterDie(self)
end

return bs_10306
