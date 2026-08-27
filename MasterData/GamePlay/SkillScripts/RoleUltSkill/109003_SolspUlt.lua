local bs_109003 = class("bs_109003", LuaSkillBase)
local base = LuaSkillBase
bs_109003.config = {
  HurtConfigID = 39,
  buffId = 107101,
  buffid = 109003,
  effectId_hit = 109012,
  effectId_screen = 12,
  audioIdStart = 109009,
  audioIdMovie = 109010,
  audioIdEnd = 109011
}

function bs_109003:ctor()
end

function bs_109003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_109003", 1, self.BeforeEndBattle)
end

function bs_109003:PlaySkill(data, selectTargetCoord, selectRoles)
  self:RemoveSkillTrigger(eSkillTriggerType.RoleDie)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_109003", 10, self.OnRoleDie)
  local time = self.arglist[4]
  LuaSkillCtrl:ShowCameraEffectFunctionWithPriority(self.config.effectId_screen, 150)
  self.shower = LuaSkillCtrl:StartTimer(nil, time, function()
    if self.AddBuffer ~= nil then
      self.AddBuffer:Stop()
      self.AddBuffer = nil
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffid, 1)
    LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
    self:RemoveSkillTrigger(eSkillTriggerType.RoleDie)
  end, nil, 0, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid, 1)
  if self.AddBuffer ~= nil then
    self.AddBuffer:Stop()
    self.AddBuffer = nil
  end
  self.AddBuffer = LuaSkillCtrl:StartTimer(nil, 15, function()
    local enemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if enemyList.Count > 0 then
      for i = 0, enemyList.Count - 1 do
        local role = enemyList[i].targetRole
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.arglist[2], 120)
      end
    end
  end, nil, -1, 15)
  local enemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if enemyList.Count > 0 then
    for i = 0, enemyList.Count - 1 do
      local role = enemyList[i].targetRole
      LuaSkillCtrl:CallEffect(role, self.config.effectId_hit, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
        self.arglist[3]
      })
      skillResult:EndResult()
    end
  end
end

function bs_109003:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy then
    self.shower.left = self.shower.left + self.arglist[5]
  end
end

function bs_109003:BeforeEndBattle()
  LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
end

function bs_109003:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_109003:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_109003:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_109003:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_109003:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
end

function bs_109003:LuaDispose()
  base.LuaDispose(self)
  LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
end

return bs_109003
