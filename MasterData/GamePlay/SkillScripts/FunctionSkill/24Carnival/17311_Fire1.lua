local FireBase = require("GamePlay.SkillScripts.FunctionSkill.24Carnival.FireBase")
local bs_17311 = class("bs_17311", FireBase)
local base = FireBase
bs_17311.config = {}
bs_17311.config = setmetatable(bs_17311.config, {
  __index = base.config
})

function bs_17311:ctor()
end

function bs_17311:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("bs_17311_1", 1, self.OnAfterHurt, {
    sender = self.caster,
    extraArg3 = false
  })
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17311_0", 1, self.OnAfterBattleStart)
end

function bs_17311:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and self.caster ~= target and not isMiss and (skill.skillTag == eSkillTag.normalSkill or skill.skillTag == eSkillTag.ultSkill) and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    self:CallFireBuff(target, 1)
  end
end

function bs_17311:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17311
