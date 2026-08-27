local bs_25051 = class("bs_25051", LuaSkillBase)
local base = LuaSkillBase
bs_25051.config = {}

function bs_25051:ctor()
end

function bs_25051:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_25051_2", 1, self.OnSetHurt, nil, nil, nil, eBattleRoleBelong.player, nil, eBattleRoleType.character)
  self.time = 0
end

function bs_25051:OnSetHurt(context)
  if context.target.belongNum == self.caster.belongNum and not context.isMiss and self.time < self.arglist[2] and context.target.isRemote then
    local basehurt = context.target.maxHp * self.arglist[1] // 1000
    if basehurt < context.hurt then
      context.hurt = basehurt
      self.time = self.time + 1
    end
  end
end

function bs_25051:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25051
