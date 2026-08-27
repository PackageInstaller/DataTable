local bs_4038 = class("bs_4038", LuaSkillBase)
local base = LuaSkillBase
bs_4038.config = {}

function bs_4038:ctor()
end

function bs_4038:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4038_1", 1, self.OnAfterBattleStart)
end

function bs_4038:OnAfterBattleStart()
  self.looper = LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.OnLoopDamage), nil, -1, self.arglist[1])
end

function bs_4038:OnLoopDamage()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role ~= nil and 0 < role.hp and role ~= self.caster then
        local hpLose = role._curHp * self.arglist[2] // 1000
        if hpLose == 1 then
          hpLose = 0
        end
        LuaSkillCtrl:RemoveLife(hpLose, self, role, true, nil, false, false, eHurtType.RealDmg, true)
      end
    end
  end
  LuaSkillCtrl:CallAddPlayerHmp(self.arglist[3] * 50)
end

function bs_4038:LuaDispose()
  base.LuaDispose(self)
  if self.looper ~= nil then
    self.looper:Stop()
    self.looper = nil
  end
end

function bs_4038:OnCasterDie()
  base.OnCasterDie(self)
  if self.looper ~= nil then
    self.looper:Stop()
    self.looper = nil
  end
end

return bs_4038
