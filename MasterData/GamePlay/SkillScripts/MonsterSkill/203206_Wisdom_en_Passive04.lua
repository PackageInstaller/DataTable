local bs_203206 = class("bs_203206", LuaSkillBase)
local base = LuaSkillBase
bs_203206.config = {buff_doubleAttack = 1121, buffId_198 = 198}

function bs_203206:ctor()
end

function bs_203206:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_203206_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_203206_2", 1, self.AfterPlaySkill)
end

function bs_203206:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_198, 1, nil, true)
  end
  self.timer203206 = LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetlist.Count < 1 then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local target = targetlist[i].targetRole
      if target.belongNum == self.caster.belongNum and target.camp == self.caster.camp then
        LuaSkillCtrl:CallBuff(self, target, self.config.buff_doubleAttack, 1)
      end
    end
  end, self, -1)
end

function bs_203206:AfterPlaySkill(skill, role)
  if skill.isCommonAttack and role.belongNum == self.caster.belongNum and role.camp == self.caster.camp then
    local restTier = role:GetBuffTier(self.config.buff_doubleAttack)
    if 0 < restTier then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_doubleAttack, 0, true)
    end
  end
end

function bs_203206:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer203206 ~= nil then
    self.timer203206:Stop()
    self.timer203206 = nil
  end
end

return bs_203206
