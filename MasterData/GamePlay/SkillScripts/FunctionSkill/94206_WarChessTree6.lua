local bs_94206 = class("bs_94206", LuaSkillBase)
local base = LuaSkillBase
bs_94206.config = {buffId = 110062}

function bs_94206:ctor()
end

function bs_94206:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("bs_94206_17", 1, self.OnHurtResultStart, self.caster, nil, nil, eBattleRoleBelong.enemy)
  self:AddSetHurtTrigger("bs_94206_2", 1, self.OnSetHurt, self.caster)
end

function bs_94206:OnHurtResultStart(skill, context)
  if skill.maker == self.caster and context.target.belongNum == eBattleRoleBelong.enemy then
    local value = context.target.hp * 1000 // context.target.maxHp
    if value < self.arglist[1] then
      LuaSkillCtrl:CallBuff(self, skill.maker, self.config.buffId, 1, nil)
    end
  end
end

function bs_94206:OnSetHurt(context)
  if context.sender == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_94206:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94206
