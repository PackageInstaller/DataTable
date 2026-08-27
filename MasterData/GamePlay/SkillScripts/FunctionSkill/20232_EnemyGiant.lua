local bs_20232 = class("bs_20232", LuaSkillBase)
local base = LuaSkillBase
bs_20232.config = {buffId = 1509}

function bs_20232:ctor()
end

function bs_20232:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_20232_1", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffId, nil, nil)
  self:AddBeforeBuffDispelTrigger("bs_20232_2", 1, self.BeforeBuffDispel, self.caster, nil, self.config.buffId, nil, nil)
  self:AddBuffDieTrigger("bs_20232_3", 1, self.OnBuffDie, self.caster, nil, self.config.buffId, nil, nil)
end

function bs_20232:OnAfterAddBuff(buff, target)
  self:eventFunc()
end

function bs_20232:BeforeBuffDispel(targetRole, context)
  self:eventFunc(true)
end

function bs_20232:OnBuffDie(buff, target, removeType)
  self:eventFunc()
end

function bs_20232:eventFunc(isBuffDispel)
  local buffTier = self.caster:GetBuffTier(self.config.buffId)
  if isBuffDispel then
    buffTier = buffTier - 1
  end
  if buffTier == nil or buffTier < 1 then
    buffTier = 0
  end
  local scale = 1 + buffTier * 0.12
  LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(scale, scale, scale), 0.4)
end

function bs_20232:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20232
