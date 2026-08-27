local bs_307 = class("bs_307", LuaSkillBase)
local base = LuaSkillBase
bs_307.config = {
  buffId1 = 138,
  effectId1 = 10150,
  effectId2 = 10151,
  effectId3 = 10152,
  effectId4 = 10153,
  effectId5 = 10154,
  effectId6 = 10155,
  effectId7 = 10156
}

function bs_307:ctor()
end

function bs_307:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_307_1", 1, self.OnSetHurt, self.caster)
end

function bs_307:OnSetHurt(context)
  if self.caster:GetBuffTier(self.config.buffId1) ~= 0 and context.sender == self.caster and 0 < self.caster.recordTable["307_hurt"] then
    context.hurt = context.hurt * self.arglist[1] * 10 // 1000
    if self.effectBJ ~= nil then
      self.effectBJ:Die()
      self.effectBJ = nil
    end
    self.caster.recordTable["307_hurt"] = self.caster.recordTable["307_hurt"] - 1
    if context.hurt >= context.target.hp and self.caster:GetBuffTier(self.config.buffId1) > 0 and context.sender == self.caster then
      self.caster.recordTable["307_hurt"] = self.caster.recordTable["307_hurt"] + 2
      if 0 <= self.arglist[2] then
        LuaSkillCtrl:CallHeal(context.hurt * 500 // 1000, self, self.caster, true)
      end
    end
    print(self.caster.recordTable["307_hurt"])
    if 0 < self.caster.recordTable["307_hurt"] then
      print("biubiu")
      local effectconfig = self.config["effectId" .. tostring(self.caster.recordTable["307_hurt"])]
      self.effectBJ = LuaSkillCtrl:CallEffect(self.caster, effectconfig, self)
    end
    if self.caster.recordTable["307_hurt"] == 0 then
      print("end")
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId1, 1)
    end
  end
end

function bs_307:PlaySkill(data)
  self.caster.recordTable["307_hurt"] = 0
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

function bs_307:OnAttackTrigger(data)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1)
  self.caster.recordTable["307_hurt"] = 3
  local effectconfig = self.config["effectId" .. tostring(self.caster.recordTable["307_hurt"])]
  self.effectBJ = LuaSkillCtrl:CallEffect(self.caster, effectconfig, self)
end

function bs_307:LuaDispose()
  base.LuaDispose(self)
  self.effectBJ = nil
end

function bs_307:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_307
