local bs_107301 = class("bs_107301", LuaSkillBase)
local base = LuaSkillBase
bs_107301.config = {
  hurtConfig = 5,
  grid_id = 1133,
  extra_skill = 107304,
  Role_id = 1073,
  effect_hit = 107307
}

function bs_107301:ctor()
end

function bs_107301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107301_1", 1, self.OnAfterBattleStart)
  self.BenchRole = LuaSkillCtrl:GetOriginRole(self.config.Role_id)
  LuaSkillCtrl:AddExtraAddSkill(self.config.extra_skill, self.level)
end

function bs_107301:OnAfterBattleStart()
  self.passive = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.Callback, self, -1)
end

function bs_107301:Callback()
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
    if self.BenchRole ~= nil and not self.BenchRole.roleOnBench then
      LuaSkillCtrl:CallEffect(self.target, self.config.effect_hit, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
        self.arglist[2]
      })
      skillResult:EndResult()
    end
    self.target = nil
  end
end

function bs_107301:OnCasterDie()
  base.OnCasterDie(self)
  self.target = nil
  self.passive:Stop()
end

function bs_107301:LuaDispose()
  base.LuaDispose(self)
  self.target = nil
end

return bs_107301
