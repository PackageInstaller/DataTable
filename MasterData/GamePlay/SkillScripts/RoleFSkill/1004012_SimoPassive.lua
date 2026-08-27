local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1004012 = class("bs_1004012", base)
bs_1004012.config = {
  buffId_Crit = 3005,
  buffId_Hiding = 3004,
  buffId_Acc = 100401,
  buffId_Acc_time = 30
}

function bs_1004012:ctor()
end

function bs_1004012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1004012_3", 1, self.OnAfterHurt, self.caster)
  self:AddSetHurtTrigger("bs_1004012_4", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.attackNum = 0
end

function bs_1004012:OnSetHurt(context)
  if context.sender == self.caster and context.skill.isCommonAttack then
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

function bs_1004012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and isCrit and self.caster:GetBuffTier(self.config.buffId_Crit) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_Crit, 0, true)
  end
end

function bs_1004012:OnArrive(grid, role, x, y)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CancleCasterWait()
  self.attackNum = 0
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Crit, 1)
end

function bs_1004012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1004012
