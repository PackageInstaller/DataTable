local bs_4027 = class("bs_4027", LuaSkillBase)
local base = LuaSkillBase
bs_4027.config = {buffId = 40271}

function bs_4027:ctor()
end

function bs_4027:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4015_2", 1, self.OnAfterPlaySkill)
end

function bs_4027:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isNormalSkill then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[2])
  end
end

function bs_4027:LuaDispose()
  base.LuaDispose(self)
end

function bs_4027:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4027
