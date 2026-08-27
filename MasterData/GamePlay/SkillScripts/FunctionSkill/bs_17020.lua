local bs_17020 = class("bs_17020", LuaSkillBase)
local base = LuaSkillBase
bs_17020.config = {buffId = 2103, attBuffId = 2108}

function bs_17020:ctor()
end

function bs_17020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.CallHurtPool, self.CallHurtPool)
  self.times = 0
end

function bs_17020:CallHurtPool(luaSkill, typeId, posX, posY)
  local hurtPoolConfig = typeId
  if hurtPoolConfig == 3 then
    self.times = self.times + 1
  end
  if self.times == self.arglist[1] // 10 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.attBuffId, 1, 60, true)
    self.times = 0
  end
end

function bs_17020:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17020
