local bs_103602 = require("GamePlay.SkillScripts.RoleSkill.103602_LamSkill")
local bs_103604 = class("bs_103604", bs_103602)
local base = bs_103602
bs_103604.config = {weaponLv = 1, buffId_up1 = 103601}
bs_103604.config = setmetatable(bs_103604.config, {
  __index = base.config
})

function bs_103604:ctor()
end

function bs_103604:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_103604_1", 1, self.OnAfterBattleStart)
  self:AddSetHurtTrigger("bs_103604_3", 3, self.OnSetHurt, self.caster, nil, nil, eBattleRoleBelong.enemy, nil, nil)
end

function bs_103604:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_up1, 1)
end

function bs_103604:OnSetHurt(context)
  if context.target.attackRange > 1 and context.skill.isNormalSkill then
    context.hurt = context.hurt * (self.arglist[6] + 1000) // 1000
  end
end

function bs_103604:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103604
