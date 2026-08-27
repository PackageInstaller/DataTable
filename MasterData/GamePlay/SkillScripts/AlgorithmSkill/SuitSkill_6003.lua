local bs_6003 = class("bs_6003", LuaSkillBase)
local base = LuaSkillBase
bs_6003.config = {}

function bs_6003:ctor()
end

function bs_6003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_6003_12", 1, self.OnAfterPlaySkill)
  self.attack_num = 0
end

function bs_6003:OnAfterPlaySkill(skill, role)
  if skill.isCommonAttack and self.caster == role then
    self.attack_num = self.attack_num + 1
    local num = self.attack_num
    if self.attack_num % self.arglist[1] == 0 then
      LuaSkillCtrl:CallResetCDNumForRole(role, self.arglist[2])
    end
  end
end

function bs_6003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_6003
