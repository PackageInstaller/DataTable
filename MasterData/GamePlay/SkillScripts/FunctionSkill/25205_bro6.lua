local bs_25205 = class("bs_25205", LuaSkillBase)
local base = LuaSkillBase
bs_25205.config = {buffId = 2129, buffTier = 1}

function bs_25205:ctor()
end

function bs_25205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.CallHurtPool, self.CallHurtPool)
end

function bs_25205:CallHurtPool(luaSkill, typeId, posX, posY)
  local maxBuffTier = self.arglist[2] // self.arglist[1]
  local buffTier = self.caster:GetBuffTier(self.config.buffId)
  if maxBuffTier > buffTier then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_25205:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25205
