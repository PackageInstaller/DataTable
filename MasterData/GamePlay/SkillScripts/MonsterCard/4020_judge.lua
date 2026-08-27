local bs_4020 = class("bs_4020", LuaSkillBase)
local base = LuaSkillBase
bs_4020.config = {buffId = 40201}

function bs_4020:ctor()
end

function bs_4020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4020_1", 1, self.OnAfterBattleStart)
end

function bs_4020:OnAfterBattleStart()
  local hpLose = self.caster._curHp * self.arglist[1] // 1000
  if hpLose == 1 then
    hpLose = 0
  end
  LuaSkillCtrl:RemoveLife(hpLose, self, self.caster, true, nil, false, false, eHurtType.RealDmg, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1)
end

function bs_4020:LuaDispose()
  base.LuaDispose(self)
end

function bs_4020:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4020
