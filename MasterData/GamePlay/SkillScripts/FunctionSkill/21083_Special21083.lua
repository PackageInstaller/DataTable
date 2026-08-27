local bs_21083 = class("bs_21083", LuaSkillBase)
local base = LuaSkillBase
bs_21083.config = {gridId = 1, buffId = 110035}

function bs_21083:ctor()
end

function bs_21083:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21083_1", 1, self.OnAfterBattleStart)
  self.Num = 0
  if LuaSkillCtrl:GetRoleEfcGrid(self.caster) == self.config.gridId then
    self.Num = 1
  end
end

function bs_21083:OnAfterBattleStart()
  if self.Num == 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1] // 50, nil)
  end
end

function bs_21083:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21083
