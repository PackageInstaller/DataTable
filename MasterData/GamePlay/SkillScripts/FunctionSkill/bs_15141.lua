local bs_15141 = class("bs_15141", LuaSkillBase)
local base = LuaSkillBase
bs_15141.config = {effect = 12064}

function bs_15141:ctor()
end

function bs_15141:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15141_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_15141_3", 1, self.OnSetHurt, nil, self.caster)
  self.time = 0
  self.effect = nil
end

function bs_15141:OnAfterBattleStart()
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1, self.arglist[1])
end

function bs_15141:CallBack()
  if self.time == 1 then
    self.time = 0
  end
  if self.effect ~= nil then
    return
  else
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effect, self)
  end
end

function bs_15141:OnSetHurt(context)
  if context.target.roleDataId == 116 and self.time == 0 and not context.isMiss then
    self:PlayChipEffect()
    context.hurt = 0
    self.time = 1
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
  end
end

function bs_15141:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

function bs_15141:LuaDispose()
  base.LuaDispose(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return bs_15141
