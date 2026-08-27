local bs_102902 = require("GamePlay.SkillScripts.RoleSkill.102901_WillowPassive")
local bs_102905 = class("bs_102905", bs_102902)
local base = bs_102902
bs_102905.config = {
  weaponLv = 2,
  selectId = 6,
  buffDodge = 102903,
  buffAttack = 102904,
  buffcd_reduce = 102907,
  effectId_up = 102914
}
bs_102905.config = setmetatable(bs_102905.config, {
  __index = base.config
})

function bs_102905:ctor()
end

function bs_102905:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
end

function bs_102905:OnRoleSplash(role)
  if role.belongNum == self.caster.belongNum then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffAttack, 1, self.arglist[6])
    LuaSkillCtrl:CallBuff(self, role, self.config.buffcd_reduce, 1, self.arglist[6])
    LuaSkillCtrl:CallEffect(role, self.config.effectId_up, self, nil, nil, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffcd_reduce, 1, self.arglist[6])
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_up, self, nil, nil, nil, true)
  end
end

function bs_102905:OnRolePhaseMoveStart(role, luaskill)
  if role.belongNum == self.caster.belongNum then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffAttack, 1, self.arglist[6])
    LuaSkillCtrl:CallBuff(self, role, self.config.buffcd_reduce, 1, self.arglist[6])
    LuaSkillCtrl:CallEffect(role, self.config.effectId_up, self, nil, nil, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffcd_reduce, 1, self.arglist[6])
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_up, self, nil, nil, nil, true)
  end
end

function bs_102905:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102905
