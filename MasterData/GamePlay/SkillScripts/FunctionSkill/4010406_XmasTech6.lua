local bs_4010406 = class("bs_4010406", LuaSkillBase)
local base = LuaSkillBase
bs_4010406.config = {buffId = 110068}

function bs_4010406:ctor()
end

function bs_4010406:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("bs_4010406_17", 1, self.OnHurtResultStart, self.caster, nil, nil, eBattleRoleBelong.enemy)
  self:AddSetHurtTrigger("bs_4010406_2", 1, self.OnSetHurt, self.caster)
end

function bs_4010406:OnHurtResultStart(skill, context)
  if skill.maker == self.caster and context.target.belongNum == eBattleRoleBelong.enemy then
    local value = context.target.hp * 1000 // context.target.maxHp
    if value < self.arglist[1] then
      LuaSkillCtrl:CallBuff(self, skill.maker, self.config.buffId, 1, nil)
    end
  end
end

function bs_4010406:OnSetHurt(context)
  if context.sender == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_4010406:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010406
