local bs_108503 = class("bs_108503", LuaSkillBase)
local base = LuaSkillBase
bs_108503.config = {
  heal_config = {baseheal_formula = 10087},
  HurtConfigID = 13,
  buff_recover = 1088,
  buff_id2 = 108502,
  effect_01 = 108510,
  effect_02 = 108511,
  effectId_screen = 10,
  audioIdStart = 108506,
  audioIdMovie = 108507,
  audioIdEnd = 108508
}

function bs_108503:ctor()
end

function bs_108503:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_108503_1", 1, self.BeforeEndBattle)
end

function bs_108503:PlaySkill(data)
  self.num = 0
  LuaSkillCtrl:ShowCameraEffectFunctionWithPriority(self.config.effectId_screen, 150)
  local damageNum = self.arglist[6] / 15
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.CallBack, damageNum), nil, damageNum, 15)
end

function bs_108503:CallBack(damageNum)
  self.num = self.num + 1
  self:DoDamage()
  self:CallHeal()
  if self.num >= damageNum + 1 then
    LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
  end
end

function bs_108503:CallHeal()
  local healList = LuaSkillCtrl:CallTargetSelect(self, 6, 20)
  if healList ~= nil and healList.Count > 0 then
    for i = 0, healList.Count - 1 do
      local healTarget = healList[i].targetRole
      if healTarget.roleType == eBattleRoleType.character then
        LuaSkillCtrl:CallBuff(self, healTarget, self.config.buff_recover, self.arglist[2], 90)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, healTarget)
        LuaSkillCtrl:HealResult(skillResult, self.config.heal_config)
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(healTarget, self.config.effect_01, self)
      end
    end
  end
end

function bs_108503:DoDamage()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
  if targetList ~= nil and targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local target = targetList[i].targetRole
      if target.belongNum ~= eBattleRoleBelong.neutral then
        LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnBelladonnaAddBuff, target, self.arglist[4])
      end
      local damage = target:GetBuffTier(self.config.buff_id2) * self.arglist[5] + self.arglist[3]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {damage})
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(target, self.config.effect_02, self)
    end
  end
end

function bs_108503:BeforeEndBattle()
  LuaSkillCtrl:SetRoleVisible(self.caster, true)
  LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
end

function bs_108503:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_108503:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_108503:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_108503:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_108503:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_108503:LuaDispose()
  base.LuaDispose(self)
  LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
end

return bs_108503
