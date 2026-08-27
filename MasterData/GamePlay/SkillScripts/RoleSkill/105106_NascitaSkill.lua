local bs_105102 = require("GamePlay.SkillScripts.RoleSkill.105102_NascitaSkill")
local bs_105106 = class("bs_105404", bs_105102)
local base = bs_105102
bs_105106.config = {
  buffId_claw = 1051012,
  buffId_Speed = 1051016,
  weaponLv = 3
}
bs_105106.config = setmetatable(bs_105106.config, {
  __index = base.config
})

function bs_105106:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTriggerForTable("bs_105106_1", 1, self.OnSetHurt, {
    sender = self.caster,
    extraArg1 = eSkillTag.normalSkill
  })
end

function bs_105106:OnSetHurt(context)
  if context.sender == self.caster and context.skill.skillTag == eSkillTag.normalSkill then
    if self.caster.recordTable.TargetSheildstate then
      local shieldValue_heal = context.hurt * self.arglist[3] // 1000
      LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue_heal)
    end
    local buffnum = context.target:GetBuffTier(self.config.buffId_claw)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Speed, buffnum, self.arglist[5])
  end
end

function bs_105106:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105106
