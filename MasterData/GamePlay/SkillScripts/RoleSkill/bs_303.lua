local bs_303 = class("bs_303", LuaSkillBase)
local base = LuaSkillBase
bs_303.config = {
  buffId1 = 135,
  buffId2 = 66,
  effectId3 = 10134,
  effectId2 = 10135,
  effectId1 = 10136,
  effectId0 = 10090
}

function bs_303:ctor()
end

function bs_303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_303_1", 1, self.OnSetHurt, nil, self.caster)
end

function bs_303:PlaySkill(data)
  self.caster.recordTable["303_HD"] = 3
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

function bs_303:OnAttackTrigger(date)
  self.Effect_303_3 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1)
end

function bs_303:OnSetHurt(context)
  if self.caster:GetBuffTier(self.config.buffId1) ~= 0 and context.target == self.caster and 0 < context.hurt and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[3] then
    LuaSkillCtrl:CallEffectWithArg(context.sender, self.config.effectId0, self, true, false, self.SkillEventFunc, context)
    context.hurt = 0
    LuaSkillCtrl:CallFloatText(self.caster, 7)
    self.caster.recordTable["303_HD"] = self.caster.recordTable["303_HD"] - 1
    if self.caster.recordTable["303_HD"] == 2 then
      if self.Effect_303_3 ~= nil then
        self.Effect_303_3:Die()
        self.Effect_303_2 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
      end
    elseif self.caster.recordTable["303_HD"] == 1 then
      if self.Effect_303_2 ~= nil then
        self.Effect_303_2:Die()
        self.Effect_303_1 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
      end
    elseif self.caster.recordTable["303_HD"] == 0 and self.Effect_303_1 ~= nil then
      self.Effect_303_1:Die()
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId1, 1)
    end
  end
end

function bs_303:SkillEventFunc(context, effect, eventId, target)
  if effect.dataId == self.config.effectId0 and eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, context.sender, self.config.buffId2, 1, self.arglist[1])
    if self.arglist[2] >= 0 then
      LuaSkillCtrl:RemoveLife(20, self, context.sender)
    end
  end
end

function bs_303:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_303:LuaDispose()
  base.LuaDispose(self)
  self.Effect_303_1 = nil
  self.Effect_303_2 = nil
  self.Effect_303_3 = nil
end

return bs_303
