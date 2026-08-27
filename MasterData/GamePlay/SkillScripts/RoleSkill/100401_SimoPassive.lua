local bs_100401 = class("bs_100401", LuaSkillBase)
local base = LuaSkillBase
bs_100401.config = {
  buffId_Crit = 100403,
  buffId_Hiding = 3004,
  buffId_Acc = 100401,
  buffId_Acc_time = 30,
  hurt_config = {crit_formula = 10003}
}

function bs_100401:ctor()
end

function bs_100401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_100401_3", 1, self.OnAfterHurt, self.caster)
  self:AddHurtResultStartTrigger("bs_100401_7", 40, self.OnHurtResultStart, self.caster, nil, eBattleRoleBelong.player)
  self:AddHurtResultEndTrigger("bs_100401_5", 1, self.OnHurtResultEnd, self.caster, nil, eBattleRoleBelong.player)
  self.attackNum = 0
end

function bs_100401:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker == self.caster and skill.isCommonAttack then
    self.attackNum = self.attackNum + 1
    if self.attackNum >= self.arglist[2] then
      local grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
      if grid ~= nil then
        self:CallCasterWait(999)
        LuaSkillCtrl:CallBreakAllSkill(self.caster)
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Acc, 1, self.config.buffId_Acc_time, true)
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Hiding, 1, self.arglist[1], true)
        LuaSkillCtrl:MoveRoleToTarget(self, grid, self.caster, false, self.OnArrive)
      end
    end
  end
end

function bs_100401:OnHurtResultStart(skill, context)
  if skill.isCommonAttack == true and context.sender == self.caster and context.sender:GetBuffTier(self.config.buffId_Crit) > 0 then
    context.new_config = self.config.hurt_config
    setmetatable(context.new_config, {
      __index = context.config
    })
  end
end

function bs_100401:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and isCrit and skill.isCommonAttack and self.caster:GetBuffTier(self.config.buffId_Crit) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_Crit, 0, true)
  end
end

function bs_100401:OnArrive(grid, role, x, y)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CancleCasterWait()
  self.attackNum = 0
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Crit, 1)
end

function bs_100401:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100401
