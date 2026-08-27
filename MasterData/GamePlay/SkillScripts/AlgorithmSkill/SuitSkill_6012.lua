local bs_6012 = class("bs_6012", LuaSkillBase)
local base = LuaSkillBase
bs_6012.config = {buffid = 601201}

function bs_6012:ctor()
end

function bs_6012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_6012_2", 1, self.OnAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnAfterMove)
end

function bs_6012:OnAfterMove()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid, 1, 75)
end

function bs_6012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6012
