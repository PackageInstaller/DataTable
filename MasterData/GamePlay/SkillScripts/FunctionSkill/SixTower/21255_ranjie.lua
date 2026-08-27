local sixtower_ranjie = class("sixtower_ranjie", LuaSkillBase)
local base = LuaSkillBase
sixtower_ranjie.config = {}

function sixtower_ranjie:ctor()
end

function sixtower_ranjie:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("sixtower_ranjie", 999, self.OnSetHurt, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, nil, nil)
end

function sixtower_ranjie:OnSetHurt(context)
  if context.hurt_tag == eHurtTag.chiyan then
    context.hurt = context.hurt * (1000 + self.arglist[1]) // 1000
  else
    context.hurt = context.hurt * (1000 - self.arglist[2]) // 1000
  end
end

function sixtower_ranjie:OnCasterDie()
  base.OnCasterDie(self)
end

return sixtower_ranjie
