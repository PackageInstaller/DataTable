local bs_20109 = class("bs_20109", LuaSkillBase)
local base = LuaSkillBase
bs_20109.config = {buffId = 1215}

function bs_20109:ctor()
end

function bs_20109:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20109_1", 1, self.OnAfterBattleStart)
end

function bs_20109:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.3, 1.3, 1.3), 0.2)
end

function bs_20109:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20109
