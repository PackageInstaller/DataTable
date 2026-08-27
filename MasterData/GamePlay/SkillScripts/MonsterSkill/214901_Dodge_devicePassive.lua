local bs_214901 = class("bs_214901", LuaSkillBase)
local base = LuaSkillBase
bs_214901.config = {
  buffId_1 = 214901,
  buffId_2 = 115,
  hurtConfig = 10,
  effectId = 212701,
  buffId1 = 179,
  buffId2 = 1033,
  buffId3 = 198,
  buffId4 = 88,
  effectId_screen = 11
}

function bs_214901:ctor()
end

function bs_214901:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_214901_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_214901_2", 1, self.OnAfterHurt, self.caster, nil, nil, nil)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_214901_3", 1, self.BeforeEndBattle)
end

function bs_214901:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId4, 1, nil, true)
  self.LoopDamage = LuaSkillCtrl:StartTimer(nil, self.arglist[5], BindCallback(self, self.OnLoopDamage), nil, -1, 0)
end

function bs_214901:OnLoopDamage()
  LuaSkillCtrl:ShowCameraEffectFunctionWithPriority(self.config.effectId_screen, 240)
  LuaSkillCtrl:StartTimer(nil, 6, function()
    local targetlist1 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if targetlist1.Count > 0 then
      for i = targetlist1.Count - 1, 0, -1 do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist1[i])
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
          self.arglist[1]
        })
        skillResult:EndResult()
      end
    end
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    if targetList.Count > 0 then
      for i = targetList.Count - 1, 0, -1 do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
          self.arglist[1]
        })
        skillResult:EndResult()
      end
    end
  end, nil, 0, 0)
end

function bs_214901:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss == true then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1, 1, self.arglist[3], nil)
  else
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_2, 1, self.arglist[4], nil)
  end
end

function bs_214901:BeforeEndBattle()
  LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
end

function bs_214901:OnCasterDie()
  base.OnCasterDie(self)
  if self.LoopDamage ~= nil then
    self.LoopDamage:Stop()
    self.LoopDamage = nil
  end
  LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
end

return bs_214901
