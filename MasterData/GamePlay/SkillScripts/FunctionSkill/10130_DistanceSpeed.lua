local bs_10130 = class("bs_10130", LuaSkillBase)
local base = LuaSkillBase
bs_10130.config = {buffId = 1009}

function bs_10130:ctor()
end

function bs_10130:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10130_1", 1, self.OnBeforePlaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10130_2", 1, self.OnAfterBattleStart)
end

function bs_10130:OnAfterBattleStart()
  self.caster.recordTable["10130_Initx"] = self.caster.x
  self.caster.recordTable["10130_Inity"] = self.caster.y
  self.caster.recordTable["10130_Distance"] = 0
end

function bs_10130:OnBeforePlaySkill(role, context)
  if role ~= self.caster then
    return
  end
  local distance = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, self.caster.recordTable["10130_Initx"], self.caster.recordTable["10130_Inity"])
  if distance ~= self.caster.recordTable["10130_Distance"] then
    self:PlayChipEffect()
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1] * distance, nil, true)
    self.caster.recordTable["10130_Distance"] = distance
  end
end

function bs_10130:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10130
