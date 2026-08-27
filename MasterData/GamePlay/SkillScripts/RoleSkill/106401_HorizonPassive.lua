local bs_106401 = class("bs_106401", LuaSkillBase)
local base = LuaSkillBase
bs_106401.config = {effectId3 = 106410, hurtConfig = 2}

function bs_106401:ctor()
end

function bs_106401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["106401_Roll"] = self.arglist[2]
  self.caster.recordTable["106401_TIME"] = self.arglist[3]
  self:AddLuaTrigger(eSkillLuaTrigger.OnHorizonCauseBacklash, self.OnHorizonCauseBacklash)
end

function bs_106401:OnHorizonCauseBacklash(target)
  if target ~= nil and target.hp > 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effectId3, self)
  end
end

function bs_106401:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_106401:LuaDispose()
  base.LuaDispose(self)
end

return bs_106401
