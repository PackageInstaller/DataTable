local bs_106504 = require("GamePlay.SkillScripts.RoleSkill.106504_LindPassive")
local bs_106506 = class("bs_106506", bs_106504)
local base = bs_106504
bs_106506.config = {
  weaponLv = 3,
  buff_1 = 106511,
  buff_2 = 106512
}
bs_106506.config = setmetatable(bs_106506.config, {
  __index = base.config
})

function bs_106506:ctor()
end

function bs_106506:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.OnBtRoleBreakStateEnter, "base_breakSkill", 2, self._OnEnterBreak)
end

function bs_106506:_OnEnterBreak(role)
  if role.belongNum == eBattleRoleBelong.enemy and role.hp > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_1, 1, self.arglist[20])
    LuaSkillCtrl:CallBuff(self, role, self.config.buff_2, 1, self.arglist[20])
  end
end

function bs_106506:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106506
