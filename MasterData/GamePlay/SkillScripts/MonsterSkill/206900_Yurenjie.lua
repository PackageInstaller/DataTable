local bs_206900 = class("bs_206900", LuaSkillBase)
local base = LuaSkillBase
bs_206900.config = {
  timeDuration = 15,
  action1 = 1008,
  action2 = 1007,
  action3 = 1025,
  formula1 = 10153,
  formula2 = 10154,
  formula3 = 10155,
  noDeadBuff = 32,
  noDamageBuff = 88,
  HideBuff = 3004,
  unSelectableBuff = 50
}
local MonsterState = {normal = 0, overkill = 3}
FoolBattleGroupTimer = {
  [16] = 450,
  [20] = 675,
  [21] = 675
}

function bs_206900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local sceneId = LuaSkillCtrl.battleCtrl.BattleRoomData:GetSceneId()
  local time = FoolBattleGroupTimer[sceneId] or 675
  self.totalTime = time
  self.isAlone = false
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_206900_1", 1, self.OnAfterBattleStart)
  self:AddSetDeadHurtTrigger("bs_206900_2", 1, self.OnSetDeadHurt, nil, self.caster)
  self:AddSetHurtTrigger("bs_206900_3", 999, self.OnSetHurt, nil, self.caster)
  self:AddSetHealTrigger("bs_206900_4", 999, self.OnSetHeal, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.OnBattleEnd, "bs_206900_5", 1, self.OnBattleEnd)
end

function bs_206900:OnSetHeal(context)
  if self.state ~= MonsterState.overkill then
    return
  end
  context.heal = 0
end

function bs_206900:OnSetDeadHurt(context)
  if context.isMiss or self.state == MonsterState.overkill then
    return
  end
  if not self.isAlone then
    local teamMates = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    local teamMateCount = teamMates.Count
    if 1 < teamMateCount then
      for i = teamMateCount - 1, 0, -1 do
        local role = teamMates[i]
        if role ~= self.caster then
          local target = LuaSkillCtrl:GetTargetWithGrid(role.x, role.y)
          LuaSkillCtrl:CallEffect(target, 206900, self)
          if not LuaSkillCtrl.IsInVerify then
            role.lsObject.gameObject:SetActive(false)
          end
          role:SubHp(role.maxHp)
          role:OnDead(self.caster, self.cskill)
        end
      end
    end
    self.isAlone = true
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.action1)
  self:EnterOverKill()
end

function bs_206900:EnterOverKill()
  self.state = MonsterState.overkill
  local target = LuaSkillCtrl:GetTargetWithGrid(self.caster.x, self.caster.y)
  LuaSkillCtrl:CallEffect(target, 206902, self)
end

function bs_206900:OnSetHurt(context)
  if self.state ~= MonsterState.overkill then
    return
  end
  self.overkillDamage = self.overkillDamage + context.hurt
  MsgCenter:Broadcast(eMsgEventId.OnOverKillValueChange, self.overkillDamage, false)
  LuaSkillCtrl:CallEffect(self.caster, 206901, self)
  LuaSkillCtrl:SetGameScoreValue(3, self.overkillDamage)
end

function bs_206900:OnAfterBattleStart()
  self.isAlone = false
  self:CheckIsAlone()
  self.state = MonsterState.normal
  self.overkillDamage = 0
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.totalTime // 15)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
  local timeInvoker = BindCallback(self, self.TimeUpdate)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, timeInvoker, self, -1)
  LuaSkillCtrl:CallBuff(self, self.caster, 198, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.noDeadBuff, 1, nil, true)
end

function bs_206900:CheckIsAlone()
  local teamMates = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  self.isAlone = teamMates.Count <= 1
end

function bs_206900:TimeUp()
  self.timer = nil
  local score = (self.caster.maxHp - self.caster.hp + self.overkillDamage) * 1000 // self.caster.maxHp
  LuaSkillCtrl:SetFinalScoreValue(2, score)
  LuaSkillCtrl:SetFinalScoreValue(3, self.overkillDamage)
  MsgCenter:Broadcast(eMsgEventId.OnOverKillValueChange, self.overkillDamage, true)
  local result = self.state == MonsterState.overkill
  LuaSkillCtrl:ForceEndBattle(result)
end

function bs_206900:TimeUpdate()
  self.totalTime = self.totalTime - self.config.timeDuration
  local showTime = self.totalTime // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  if self.totalTime <= 0 then
    self:TimeUp()
  end
end

function bs_206900:OnBattleEnd()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  MsgCenter:Broadcast(eMsgEventId.OnOverKillValueChange, self.overkillDamage, true)
end

function bs_206900:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_206900:LuaDispose()
  base.LuaDispose(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  self.overkillDamage = nil
end

return bs_206900
