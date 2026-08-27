local bs_20231 = class("bs_20231", LuaSkillBase)
local base = LuaSkillBase
bs_20231.config = {buffId = 1508}

function bs_20231:ctor()
end

function bs_20231:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_20231_1", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffId, nil, nil)
  self:AddBeforeBuffDispelTrigger("bs_20231_2", 1, self.BeforeBuffDispel, self.caster, nil, self.config.buffId, nil, nil)
  self:AddBuffDieTrigger("bs_20231_3", 1, self.OnBuffDie, self.caster, nil, self.config.buffId, nil, nil)
end

function bs_20231:OnAfterAddBuff(buff, target)
  self:eventFunc()
end

function bs_20231:BeforeBuffDispel(targetRole, context)
  self:eventFunc(true)
end

function bs_20231:OnBuffDie(buff, target, removeType)
  self:eventFunc()
end

function bs_20231:eventFunc(isBuffDispel)
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

function bs_20231:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20231
