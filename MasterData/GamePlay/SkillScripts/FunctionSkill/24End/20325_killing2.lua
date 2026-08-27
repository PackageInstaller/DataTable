local bs_20324 = class("bs_20324", LuaSkillBase)
local base = LuaSkillBase
bs_20324.config = {}

function bs_20324:ctor()
end

function bs_20324:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_20324", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.enemy, nil, eBattleRoleType.character)
end

function bs_20324:OnRoleDie(killer, role)
  if role.camp == self.arglist[1] then
    LuaSkillCtrl:AddCacheGold(self.arglist[2])
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId_1, self)
  end
end

function bs_20324:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20324
