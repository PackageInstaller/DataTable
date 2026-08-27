local bs_81033 = class("bs_81033", LuaSkillBase)
local base = LuaSkillBase
bs_81033.config = {buffId1 = 107101, buffId2 = 2166}

function bs_81033:ctor()
end

function bs_81033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_81033_2", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffId1)
end

function bs_81033:OnAfterAddBuff(buff, target)
  if target == self.caster and self.caster:GetBuffTier(self.config.buffId2) < self.arglist[3] then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId2, 1, self.arglist[2])
  end
end

function bs_81033:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81033
