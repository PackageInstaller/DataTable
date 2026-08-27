local bs_82053 = class("bs_82053", LuaSkillBase)
local base = LuaSkillBase
bs_82053.config = {}

function bs_82053:ctor()
end

function bs_82053:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.OnBtRoleBreakStateEnter, "bs_82053", 2, self._OnEnterBreak)
end

function bs_82053:_OnEnterBreak(role)
  if role.belongNum == eBattleRoleBelong.enemy and role.hp > 0 then
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[1])
  end
end

function bs_82053:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_82053
