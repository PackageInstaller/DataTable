local bs_210903 = class("bs_210903", LuaSkillBase)
local base = LuaSkillBase
bs_210903.config = {
  buffId_124 = 124,
  buffId_63 = 63,
  buffId_fly = 5002101,
  buffId_69 = 69,
  buffId_198 = 198,
  effect_hit = 210909,
  buffId_259 = 259,
  HurtConfigID = 3
}

function bs_210903:ctor()
end

function bs_210903:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_210903", 1, self.OnAfterHurt, nil, self.caster)
  self.firstTime = true
  self.secondTime = true
end

function bs_210903:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  local hprate = self.caster._curHp * 1000 // self.caster.maxHp
  if hprate <= self.arglist[1] and self.firstTime == true then
    self:doskill()
    self.firstTime = false
  elseif hprate <= self.arglist[2] and self.secondTime == true then
    self:doskill()
    self.secondTime = false
  end
end

function bs_210903:doskill()
  local center = LuaSkillCtrl:GetMapCenterPos()
  local role = LuaSkillCtrl:GetRoleWithPos(center.x, center.y)
  if role ~= nil then
    local grid_go, grid_up
    if not LuaSkillCtrl:RoleContainsBuffFeature(role, eBuffFeatureType.CtrlImmunity) then
      local gridList = LuaSkillCtrl:FindEmptyGridsWithinRange(role.x, role.y, 5)
      if gridList == nil then
        return
      end
      if gridList.Count > 0 then
        grid_go = LuaSkillCtrl:GetGridWithRole(role)
        grid_up = gridList[0]
      end
    else
      local gridList = LuaSkillCtrl:FindEmptyGridsWithinRange(role.x, role.y, 1)
      if gridList == nil then
        return
      end
      if gridList.Count > 0 then
        grid_go = gridList[0]
      end
    end
    if grid_go == nil then
      return
    end
    if grid_up ~= nil then
      LuaSkillCtrl:PreSetRolePos(grid_up, self.caster)
    else
      LuaSkillCtrl:PreSetRolePos(grid_go, self.caster)
    end
    local MoveTime = 1
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_124, 1, 1 + MoveTime)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_198, 1, 1 + MoveTime)
    LuaSkillCtrl:StartTimer(nil, 1, function()
      if grid_up == nil then
        LuaSkillCtrl:CanclePreSetPos(self.caster)
      end
      if not LuaSkillCtrl:InInPhaseMove(self.caster) then
        self.caster:LookAtTarget(LuaSkillCtrl:GetTargetWithGrid(grid_go.x, grid_go.y))
        LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, self.caster, grid_go.x, grid_go.y, MoveTime, self.config.buffId_69)
        LuaSkillCtrl:StartTimer(nil, MoveTime, function()
          if role == nil or role.hp <= 0 then
            return
          end
          local tar_grid = LuaSkillCtrl:GetGridWithRole(role)
          local targrid = LuaSkillCtrl:GetTargetWithGrid(tar_grid.x, tar_grid.y)
          LuaSkillCtrl:CallEffect(targrid, self.config.effect_hit, self)
          if grid_up ~= nil then
            LuaSkillCtrl:CanclePreSetPos(self.caster)
            if not LuaSkillCtrl:InInPhaseMove(self.caster) and role.x == grid_go.x and role.y == grid_go.y then
              LuaSkillCtrl:CallPhaseMove(self, role, grid_up.x, grid_up.y, 3, self.config.buffId_63)
              LuaSkillCtrl:CallBuff(self, role, self.config.buffId_fly, 1, 3, true)
              if grid_go ~= nil then
                LuaSkillCtrl:CallCreateEfcGrid(grid_go.coord.x, grid_go.coord.y, 1126)
              end
              local targetList = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
              if targetList ~= nil and 0 < targetList.Count then
                for i = targetList.Count - 1, 0, -1 do
                  local role = targetList[i]
                  if role ~= nil and role.hp > 0 and role.belongNum ~= self.caster.belongNum then
                    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_259, 1, 5)
                    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
                    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
                      self.arglist[3]
                    })
                    skillResult:EndResult()
                  end
                end
              end
            end
          end
        end)
      end
    end)
  else
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_198, 1, 2)
    LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, self.caster, center.x, center.y, 2, self.config.buffId_69)
    LuaSkillCtrl:StartTimer(nil, 2, function()
      if center ~= nil then
        LuaSkillCtrl:CallCreateEfcGrid(center.coord.x, center.coord.y, 1126)
      end
      local targetList = LuaSkillCtrl:FindRolesAroundRole(self.caster)
      if targetList ~= nil and targetList.Count > 0 then
        for i = targetList.Count - 1, 0, -1 do
          local role = targetList[i]
          if role ~= nil and 0 < role.hp and role.belongNum ~= self.caster.belongNum then
            LuaSkillCtrl:CallBuff(self, role, self.config.buffId_259, 1, 5)
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
            LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
              self.arglist[3]
            })
            skillResult:EndResult()
          end
        end
      end
    end)
  end
end

function bs_210903:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_210903
