local card_20039 = class("card_20039", LuaSkillBase)
local base = LuaSkillBase
card_20039.config = {buffId = 2234}

function card_20039:ctor()
end

function card_20039:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("card_20039_2", 1, self.OnBeforeAddBuff, nil, nil, nil, eBattleRoleBelong.enemy, nil, eBuffType.Debeneficial)
end

function card_20039:OnBeforeAddBuff(target, context)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.arglist[1], true, nil, true)
end

function card_20039:OnCasterDie()
  base.OnCasterDie(self)
end

return card_20039
