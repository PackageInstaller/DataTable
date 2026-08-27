local bs_4001035 = class("bs_4001035", LuaSkillBase)
local base = LuaSkillBase
bs_4001035.config = {buffId = 2018}

function bs_4001035:ctor()
end

function bs_4001035:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4001035_1", 1, self.OnAfterBattleStart)
  self.flag = true
end

function bs_4001035:OnAfterBattleStart()
  if self.flag == true then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[3])
    self.flag = false
  end
end

function bs_4001035:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001035
