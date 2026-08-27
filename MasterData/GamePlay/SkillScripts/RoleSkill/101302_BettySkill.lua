local bs_101302 = class("bs_101302", LuaSkillBase)
local base = LuaSkillBase
bs_101302.config = {
  buffId_Wild = 101301,
  buffId_Wild_year = 101302,
  buffId_170 = 170
}

function bs_101302:ctor()
end

function bs_101302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101302:PlaySkill(data)
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 301303 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Wild_year, 1, self.arglist[1], true)
  else
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Wild, 1, self.arglist[1], true)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.arglist[1], true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  self.caster.recordTable.curStartShowDurationSkill = self
end

function bs_101302:OnBreakSkill(role)
  if role ~= self.caster then
    return
  end
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  if self.isSkillUncompleted then
    self.caster:RemoveSkillWaitBuff()
    self.cskill:ReturnCDTimeFromBreak()
    self.isSkillUncompleted = false
  end
  self:OnSkillDamageEnd()
end

function bs_101302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101302
