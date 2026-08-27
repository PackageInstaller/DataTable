local bs_1035082 = class("bs_1035082", LuaSkillBase)
local base = LuaSkillBase
bs_1035082.config = {buffId_253 = 253}

function bs_1035082:ctor()
end

function bs_1035082:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_1035082_beforeBuff", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
end

function bs_1035082:OnBeforeAddBuff(target, context)
  if context.buff.buffType == 2 and target == self.caster and target:GetBuffTier(self.config.buffId_253) == 0 then
    context.active = false
    local parentBuffId = LuaSkillCtrl:GetSkillBindBuffId(self)
    if 0 < parentBuffId then
      LuaSkillCtrl:DispelBuff(self.caster, parentBuffId, 1)
    end
  end
end

function bs_1035082:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1035082
