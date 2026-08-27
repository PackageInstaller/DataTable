local bs_4010404 = class("bs_4010404", LuaSkillBase)
local base = LuaSkillBase
bs_4010404.config = {}

function bs_4010404:ctor()
end

function bs_4010404:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_4010404_1", 1, self.OnAfterBattleStart)
  self.time = nil
end

function bs_4010404:OnAfterBattleStart()
  if self.time ~= nil then
    self.timer:Stop()
    self.time = nil
  end
  self.time = LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self.OnAction), self, -1, self.arglist[1])
end

function bs_4010404:OnAction()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i]
      local skilllist = targetRole:GetBattleSkillList()
      if skilllist ~= nil then
        local skillCount = skilllist.Count
        if 0 < skillCount then
          for j = 0, skillCount - 1 do
            local curTotalCd = -skilllist[j].totalCDTime * self.arglist[2] // 1000
            LuaSkillCtrl:CallResetCDForSingleSkill(skilllist[j], curTotalCd)
          end
        end
      end
    end
  end
end

function bs_4010404:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010404
