local bs_100502 = require("GamePlay.SkillScripts.RoleSkill.100502_CroqueSkill")
local bs_100505 = class("bs_100505", bs_100502)
local base = bs_100502
bs_100505.config = {
  weaponLv = 2,
  BuffId_huodun = 100502,
  buffId_chiyan = 107101,
  hurt_configid = 3
}
bs_100505.config = setmetatable(bs_100505.config, {
  __index = base.config
})

function bs_100505:ctor()
end

function bs_100505:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_100505_1", 1, self.OnAfterHurt, nil, self.caster, eBattleRoleBelong.enemy, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddAfterAddBuffTrigger("bs_100505_2", 2, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_chiyan)
  self.tag = false
end

function bs_100505:OnAfterAddBuff()
  self.caster.recordTable.chiyan_Num = self.caster.recordTable.chiyan_Num + 1
  if self.caster.recordTable.chiyan_Num >= 50 then
    self.caster.recordTable.chiyan_Num = 50
  end
end

function bs_100505:OnAttackTrigger(time, duration)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.BuffId_huodun, 1, nil)
  base.OnAttackTrigger(self, time, duration)
  self.tag = true
end

function bs_100505:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.belongNum == 2 and skill.skillType == eSkillTag.commonAttack and self.tag and target:GetBuffTier(self.config.BuffId_huodun) > 0 and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[6] then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId_chiyan, 1, self.arglist[7])
  end
end

function bs_100505:Onover()
  base.Onover(self)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.BuffId_huodun, 0, true)
  self.tag = false
end

return bs_100505
