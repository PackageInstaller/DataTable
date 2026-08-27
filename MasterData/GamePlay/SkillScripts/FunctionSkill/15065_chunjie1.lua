local bs_15065 = class("bs_15065", LuaSkillBase)
local base = LuaSkillBase
bs_15065.config = {buffId = 1258}

function bs_15065:ctor()
end

function bs_15065:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.times = 0
end

function bs_15065:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isCrit and self:IsReadyToTake() and not isTriggerSet then
    self.times = self.times + 1
    if self.times >= self.arglist[1] then
      local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
      if 1 > targetlist.Count then
        return
      end
      for i = 0, targetlist.Count - 1 do
        local targetRole = targetlist[i]
        local skills = targetRole:GetBattleSkillList()
        if skills ~= nil then
          local skillCount = skills.Count
          if 0 < skillCount then
            for j = 0, skillCount - 1 do
              local curTotalCd = skills[j].totalCDTime
              LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
            end
          end
        end
      end
      self.times = 0
    end
  end
end

function bs_15065:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15065
