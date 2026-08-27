local bs_103604 = require("GamePlay.SkillScripts.RoleSkill.103604_LamSkill")
local bs_103605 = class("bs_103605", bs_103604)
local base = bs_103604
bs_103605.config = {
  weaponLv = 2,
  buffId_ranjie = 107101,
  HurtConfig1 = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0,
    hurt_tag = 1
  },
  HurtConfig2 = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 10003,
    hurt_tag = 1
  }
}
bs_103605.config = setmetatable(bs_103605.config, {
  __index = base.config
})

function bs_103605:ctor()
end

function bs_103605:OnCallback(num, target, data)
  local BuffNum = target:GetBuffTier(self.config.buffId_ranjie)
  if 0 < BuffNum then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_ranjie)
  end
  local hurtpro = 1000 + target.hp * 1000 // target.maxHp * self.arglist[3] // self.arglist[2]
  local Arg = (self.arglist[1] + BuffNum * self.arglist[7]) * hurtpro // 1000
  if num == 1 then
    LuaSkillCtrl:CallEffect(target, self.config.effectIdHit2, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig2, {Arg})
    skillResult:EndResult()
  else
    LuaSkillCtrl:CallEffect(target, self.config.effectIdHit1, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig1, {Arg})
    skillResult:EndResult()
  end
  self:OnSkillDamageEnd()
end

function bs_103605:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103605
