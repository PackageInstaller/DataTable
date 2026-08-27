local bs_80012 = class("bs_80012", LuaSkillBase)
local base = LuaSkillBase
bs_80012.config = {buffId = 288, buffTime = 30}

function bs_80012:ctor()
end

function bs_80012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_80012_2", 2, self.OnSelfAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
end

function bs_80012:OnSelfAfterMove()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[1])
end

function bs_80012:OnRoleSplash(role)
  if role == self.caster then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[1])
  end
end

function bs_80012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80012
