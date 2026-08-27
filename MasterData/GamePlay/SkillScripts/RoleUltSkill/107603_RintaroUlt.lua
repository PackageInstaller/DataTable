local bs_107603 = class("bs_107603", LuaSkillBase)
local base = LuaSkillBase
bs_107603.config = {
  audioIdStart = 100309,
  audioIdMovie = 100310,
  audioIdEnd = 100311,
  actionId_start = 1005,
  ulteffect = 107608,
  heal_config = {baseheal_formula = 3021},
  effectQs = 107610
}

function bs_107603:ctor()
end

function bs_107603:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107603_1", 1, self.OnAfterBattleStart)
  self.originalStateInfo = {}
end

function bs_107603:OnAfterBattleStart()
  local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, list.Count - 1 do
    local role = list[i]
    local roleDataId = role.roleDataId
    if roleDataId == 1077 or roleDataId == 1078 or role == self.caster then
      self.originalStateInfo[role] = {}
      self.originalStateInfo[role].gridX = role.x
      self.originalStateInfo[role].gridY = role.y
      self.originalStateInfo[role].Labmem = 1
      self.originalStateInfo[role].hpvalue = role.hp
    end
  end
end

function bs_107603:PlaySkill(data)
  self:CallCasterWait(10)
  LuaSkillCtrl:CallEffect(self.caster, self.config.ulteffect, self)
  local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, list.Count - 1 do
    local role = list[i]
    local originalStateInfo = self.originalStateInfo[role]
    if originalStateInfo ~= nil then
      local num1 = originalStateInfo.hpvalue
      local num2 = role.hp
      if num1 > num2 then
        local num = num1 - num2
        LuaSkillCtrl:CallHeal(num, self, role, true)
      elseif num1 < num2 then
        local num = num2 - num1
        LuaSkillCtrl:RemoveLife(num, self, role, nil, nil, false, true, eHurtType.RealDmg, true)
      end
      local grid = LuaSkillCtrl:GetGridWithPos(originalStateInfo.gridX, originalStateInfo.gridY)
      if grid == nil and role.x ~= originalStateInfo.gridX and role.y ~= originalStateInfo.gridY then
        grid = LuaSkillCtrl:CallFindEmptyGridNearest(role)
      end
      if grid ~= nil then
        self:TryResetMoveState(role)
        LuaSkillCtrl:SetRolePos(grid, role, true)
      end
      LuaSkillCtrl:CallEffect(role, self.config.effectQs, self)
      local buffs = LuaSkillCtrl:GetRoleBuffs(role)
      if buffs ~= nil and 0 < buffs.Count then
        for i = 0, buffs.Count - 1 do
          if buffs[i].buffType == 2 then
            LuaSkillCtrl:ForceDispelBuff(role, buffs[i].dataId, 0)
          end
        end
      end
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
end

function bs_107603:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Super, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_107603:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start)
end

function bs_107603:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_107603:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_107603:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_107603:LuaDispose()
  base.LuaDispose(self)
  self.originalStateInfo = nil
end

return bs_107603
