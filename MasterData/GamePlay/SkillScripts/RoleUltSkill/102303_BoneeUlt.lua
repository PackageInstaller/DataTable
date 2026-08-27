local bs_102303 = class("bs_102303", LuaSkillBase)
local base = LuaSkillBase
bs_102303.config = {
  effect_start = 102309,
  effect_loop = 102310,
  shieldFormula = 3021,
  aoe_config = {
    effect_shape = 1,
    aoe_select_code = 2,
    aoe_range = 10
  },
  movieEndRoleActionId = 1006
}

function bs_102303:ctor()
end

function bs_102303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_102303_1", 99, self.OnBreakShield)
  self.hudunEffect = {}
end

function bs_102303:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_start, self, self.SkillEventFunc, nil)
end

function bs_102303:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local SelfShieldValue = LuaSkillCtrl:GetShield(self.caster, 0) * self.arglist[1] // 1000
    LuaSkillCtrl:ClearShield(self.caster, 0)
    self.PlayerTargetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    local shieldValue = SelfShieldValue + self.caster.maxHp * self.arglist[2] // 1000
    for i = 0, self.PlayerTargetList.Count - 1 do
      local role = self.PlayerTargetList[i]
      local IfRoleCotainsUnselectedBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, 5)
      if role ~= self.caster and IfRoleCotainsUnselectedBuff == false and role.recordTable.WillowPic ~= true then
        LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue)
        if self.hudunEffect[role] == nil then
          self.hudunEffect[role] = LuaSkillCtrl:CallEffect(role, self.config.effect_loop, self)
        end
      end
    end
  end
end

function bs_102303:OnBreakShield(shieldType, sender, target)
  if shieldType == 0 then
    self:Onover(target)
  end
end

function bs_102303:Onover(target)
  if self.hudunEffect[target] ~= nil then
    local effect = self.hudunEffect[target]
    effect:Die()
    self.hudunEffect[target] = nil
  end
end

function bs_102303:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_102303:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

function bs_102303:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_102303:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_102303:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_102303:LuaDispose()
  base.LuaDispose(self)
  self.hudunEffect = nil
end

return bs_102303
