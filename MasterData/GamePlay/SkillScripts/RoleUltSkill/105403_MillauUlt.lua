local bs_105403 = class("bs_105403", LuaSkillBase)
local base = LuaSkillBase
bs_105403.config = {
  buffId_tasterMark = 105406,
  buffId_ultAttackUp = 105405,
  buffId_ultHemUp = 105407,
  buffId_shield = 105412,
  buffId_ultAttackUp2 = 105409,
  buffId_ultHemUp2 = 105410,
  effectId_Ult = 105408,
  buffId_100802 = 100802,
  buffId_Super = 3003,
  audioIdStart = 105412,
  audioIdMovie = 105413,
  audioIdEnd = 105414,
  movieEndRoleActionId = 1006,
  aoe_config = {
    effect_shape = 1,
    aoe_select_code = 3,
    aoe_range = 10
  },
  heal_config = {
    baseheal_formula = 100801,
    heal_number = 0,
    crit_formula = 0,
    crithur_ratio = 0,
    correct_formula = 9990
  },
  heal_configF = {
    baseheal_formula = 100802,
    heal_number = 0,
    crit_formula = 0,
    crithur_ratio = 0,
    correct_formula = 9990
  }
}

function bs_105403:ctor()
end

function bs_105403:InitSkill(isMidwaySkill)
  self.hurt_config = {}
  self.MapBorder = LuaSkillCtrl:GetMapBorder()
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_105403_1", 1, self.OnBreakShield)
end

function bs_105403:OnBreakShield(shieldType, sender, target)
  if shieldType == 0 and 0 < target:GetBuffTier(self.config.buffId_shield) then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_shield, 0)
  end
end

function bs_105403:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  local effectGrid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  effectGrid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  if self.MapBorder.x > 7 then
    effectGrid = LuaSkillCtrl:GetTargetWithGrid(5, 3)
  end
  LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_Ult, self, self.SkillEventFunc, nil, 0.5)
  LuaSkillCtrl:CallBattleCamShake()
end

function bs_105403:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    self.PlayerTargetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    for i = 0, self.PlayerTargetList.Count - 1 do
      local role = self.PlayerTargetList[i]
      local IfRoleCotainsUnselectedBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, eBuffFeatureType.NotBeSelected)
      if IfRoleCotainsUnselectedBuff == false and role.recordTable.WillowPic ~= true then
        local buff1 = LuaSkillCtrl:GetRoleBuffById(role, self.config.buffId_tasterMark)
        if buff1 ~= nil then
          local shieldValue1 = self.caster.def * self.arglist[1] // 1000 * 2
          if 0 < shieldValue1 then
            LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue1)
            local SelfShieldValue = LuaSkillCtrl:GetShield(role, 0)
            if SelfShieldValue ~= 0 then
              LuaSkillCtrl:CallBuff(self, role, self.config.buffId_shield, 1)
            end
          end
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_ultAttackUp2, 2, self.arglist[4])
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_ultHemUp2, 2, self.arglist[4])
        else
          local shieldValue2 = self.caster.def * self.arglist[1] // 1000
          if 0 < shieldValue2 then
            LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue2)
            local SelfShieldValue = LuaSkillCtrl:GetShield(role, 0)
            if SelfShieldValue ~= 0 then
              LuaSkillCtrl:CallBuff(self, role, self.config.buffId_shield, 1)
            end
          end
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_ultAttackUp, 1, self.arglist[4])
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_ultHemUp, 1, self.arglist[4])
        end
      end
    end
  end
end

function bs_105403:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Super, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_105403:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_105403:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_105403:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_105403:OnCasterDie()
  self:KillEquipmentSummoner()
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  self:RemoveAllLuaTrigger()
  self:RemoveAllHaleEmission()
end

return bs_105403
