local bs_10231 = class("bs_10231", LuaSkillBase)
local base = LuaSkillBase
bs_10231.config = {buffId = 1086, effectId = 10643}

function bs_10231:ctor()
end

function bs_10231:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_10231_1", 1, self.OnAfterBattleStart)
end

function bs_10231:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, self.arglist[3], self.RealPlaySkill, self, -1)
end

function bs_10231:RealPlaySkill()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
  if targetlist.Count < 1 then
    return
  end
  local targetRole = targetlist[0].targetRole
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, self.arglist[1])
end

function bs_10231:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10231
