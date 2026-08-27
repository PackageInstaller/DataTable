local bs_4023 = class("bs_4023", LuaSkillBase)
local base = LuaSkillBase
bs_4023.config = {}

function bs_4023:ctor()
end

function bs_4023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_4023_11", 1, self.OnRoleDie)
  self.isready = true
end

function bs_4023:OnRoleDie(killer, role, killSkill)
  if role.belongNum == eBattleRoleBelong.player and self.isready then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i].targetRole
        if role ~= nil and 0 < role.hp then
          LuaSkillCtrl:CallResetCDNumForRole(role, self.arglist[1])
          if self.isready == true then
            self.isready = false
            self.CDtimer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
              self.isready = true
            end)
          end
        end
      end
    end
  end
end

function bs_4023:OnCasterDie()
  base.OnCasterDie(self)
  if self.CDtimer ~= nil then
    self.CDtimer:Stop()
    self.CDtimer = nil
  end
end

function bs_4023:LuaDispose()
  base.LuaDispose(self)
  if self.CDtimer ~= nil then
    self.CDtimer:Stop()
    self.CDtimer = nil
  end
end

return bs_4023
