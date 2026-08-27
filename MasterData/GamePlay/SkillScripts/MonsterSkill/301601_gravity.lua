local bs_301601 = class("bs_301601", LuaSkillBase)
local base = LuaSkillBase
bs_301601.config = {buffId_gravity = 110140}

function bs_301601:ctor()
end

function bs_301601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_301601_2", 1, self.OnBeforeAddBuff, nil, nil, nil, nil, self.config.buffId)
end

function bs_301601:OnBeforeAddBuff(target, context)
  if LuaSkillCtrl:IsRoleAdjacent(self.caster, target) and context.buff.maker ~= self.caster then
    context.active = false
  end
end

function bs_301601:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_301601
