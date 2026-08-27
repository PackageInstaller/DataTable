local bs_22202 = class("bs_22202", LuaSkillBase)
local base = LuaSkillBase
bs_22202.config = {buffId = 110066, buffId_live = 3009}

function bs_22202:ctor()
end

function bs_22202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_22202_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.HurtResultStart, "bs_22202_4", 1, self.OnHurtResultStart)
  self:AddSetDeadHurtTrigger("bs_22202_2", 99, self.OnSetDeadHurt, nil, nil, nil, nil, nil, 1)
  self.AVG = 0
end

function bs_22202:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  LuaSkillCtrl:StartAvgWithPauseGame("cpt_clukay_05_03a", nil, nil)
end

function bs_22202:OnHurtResultStart(skill, context)
  if context.target.roleDataId == 1058 and self.AVG == 0 and context.target.hp * 1000 // context.target.maxHp < 300 then
    LuaSkillCtrl:StartAvgWithPauseGame("cpt_clukay_05_03b", nil, nil)
    self.AVG = 1
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1, true)
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId, 1, nil, true)
  end
  if context.target == self.caster and self.AVG == 0 then
    context.active = false
  end
end

function bs_22202:OnSetDeadHurt(context)
  LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 1, true)
  LuaSkillCtrl:StartAvgWithPauseGame("cpt_clukay_05_03c", nil, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function bs_22202:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_22202
