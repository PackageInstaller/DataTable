local bs_25213 = class("bs_25213", LuaSkillBase)
local base = LuaSkillBase
bs_25213.config = {buffId = 66}

function bs_25213:ctor()
end

function bs_25213:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.Callthrows, self.OnCallthrows)
end

function bs_25213:OnCallthrows(target, flag, argnum, flag1)
  if LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.arglist[2], true)
  end
end

function bs_25213:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25213
