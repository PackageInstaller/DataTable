local bs_10309 = class("bs_10309", LuaSkillBase)
local base = LuaSkillBase
bs_10309.config = {}

function bs_10309:ctor()
end

function bs_10309:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10309_1", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.enemy, eBattleRoleBelong.player, eBattleRoleType.character, 5)
end

function bs_10309:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if not isMiss then
    LuaSkillCtrl:AddPlayerTowerMp(self.arglist[1])
  end
end

function bs_10309:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10309
