local bs_107304 = class("bs_107304", LuaSkillBase)
local base = LuaSkillBase
bs_107304.config = {
  hurtConfig = 5,
  grid_id = 1133,
  Role_id = 1073,
  effect_hit = 107307
}

function bs_107304:ctor()
end

function bs_107304:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107304_1", 1, self.OnAfterBattleStart)
  self.BenchRole = LuaSkillCtrl:GetOriginRole(self.config.Role_id)
end

function bs_107304:OnAfterBattleStart()
  if self.BenchRole ~= nil and self.BenchRole.roleOnBench then
    self.passive = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.Callback, self, -1)
  end
end

function bs_107304:Callback()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i] ~= nil then
        local role = targetList[i]
        if not role:IsUnSelect(self.caster) then
          if self.target == nil then
            self.target = role
          end
          local buffs = LuaSkillCtrl:GetRoleBuffs(role)
          if buffs ~= nil or buffs.Count >= 1 then
            for i = 0, buffs.Count - 1 do
              if buffs[i].buffType == eBuffType.Beneficial then
                self.target = role
                break
              end
            end
          end
        end
        break
      end
    end
  end
  if self.target ~= nil then
    local grid = LuaSkillCtrl:GetGridWithRole(self.target)
    if grid ~= nil then
      local EfcGrid = LuaSkillCtrl:CallCreateEfcGrid(grid.coord.x, grid.coord.y, 1133)
      EfcGrid:BindNeutralBattleSkill(self.cskill)
    end
    self.target = nil
  end
end

function bs_107304:OnCasterDie()
  base.OnCasterDie(self)
  self.target = nil
  if self.passive ~= nil then
    self.passive:Stop()
  end
end

function bs_107304:LuaDispose()
  base.LuaDispose(self)
  self.target = nil
end

return bs_107304
