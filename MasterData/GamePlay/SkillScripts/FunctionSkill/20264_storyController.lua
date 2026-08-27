local bs_20264 = class("bs_20264", LuaSkillBase)
local base = LuaSkillBase
bs_20264.config = {
  battleRoomId = 382911,
  Controltime = 375,
  Waittime = 10,
  effectId = 212702,
  roleID = 1072,
  buffId = 1279
}

function bs_20264:ctor()
end

function bs_20264:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20264_1", 2, self.OnAfterBattleStart)
  self.effect = nil
end

function bs_20264:OnAfterBattleStart()
  local battleRoomId = LuaSkillCtrl:GetBattleRoomId()
  if battleRoomId == self.config.battleRoomId then
    local eventfunc = BindCallback(self, self.PlayAVG)
    self.timer1 = LuaSkillCtrl:StartTimer(self, self.config.Controltime, eventfunc)
  end
end

function bs_20264:PlayAVG()
  local endEvent = BindCallback(self, self.Showtime)
  LuaSkillCtrl:StartAvgWithPauseGame("23summer_s15_1", nil, endEvent)
end

function bs_20264:Showtime()
  LuaSkillCtrl:StartTimer(nil, 7, function()
    local SelfTarget
    local SelfTargetList = LuaSkillCtrl:CallTargetSelect(self, 6, 100)
    for i = 0, SelfTargetList.Count - 1 do
      if SelfTargetList[i].targetRole.roleDataId == self.config.roleID then
        SelfTarget = SelfTargetList[i]
      end
    end
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1.2, 1, 30)
    LuaSkillCtrl:ClearAllShield(SelfTarget.targetRole)
    LuaSkillCtrl:RemoveLife(SelfTarget.targetRole.hp - 1, self, SelfTarget, false, nil, true, true)
    LuaSkillCtrl:CallBuff(self, SelfTarget.targetRole, self.config.buffId, 1, 999, true)
    self.effect = LuaSkillCtrl:CallEffect(SelfTarget, self.config.effectId, self)
    LuaSkillCtrl:CallEffectDoScale(self.effect, 4, 2.5)
    LuaSkillCtrl:StartTimer(nil, 7, function()
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 100)
      if targetList == nil then
        return
      end
      if targetList.Count <= 0 then
        return
      end
      for i = 0, targetList.Count - 1 do
        LuaSkillCtrl:RemoveLife(targetList[i].targetRole.hp + 1, self, targetList[i], false, nil, true, true)
      end
    end)
  end)
  LuaSkillCtrl:StartTimer(nil, 28, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function bs_20264:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20264
