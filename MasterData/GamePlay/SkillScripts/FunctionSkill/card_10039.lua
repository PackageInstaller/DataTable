local card_10039 = class("card_10039", LuaSkillBase)
local base = LuaSkillBase
card_10039.config = {debuffId = 2233}

function card_10039:ctor()
end

function card_10039:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("card_10039_2", 1, self.OnBeforeAddBuff, nil, nil, nil, eBattleRoleBelong.enemy)
end

function card_10039:OnBeforeAddBuff(target, context)
  if target ~= self.caster and context.buff.buffCfg.IsControl then
    LuaSkillCtrl:CallBuff(self, target, self.config.debuffId, 1, self.arglist[1], true, nil, true)
  end
end

function card_10039:OnCasterDie()
  base.OnCasterDie(self)
end

return card_10039
