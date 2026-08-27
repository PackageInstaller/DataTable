local bs_20234 = class("bs_20234", LuaSkillBase)
local base = LuaSkillBase
bs_20234.config = {}

function bs_20234:ctor()
end

function bs_20234:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.buffId = LuaSkillCtrl:GetSkillBindBuffId(self)
  self:AddAfterAddBuffTrigger("bs_20234_1", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.buffId, nil, nil)
  self:AddBeforeBuffDispelTrigger("bs_20234_2", 1, self.OnBeforBuffDispel, nil, self.caster, self.buffId)
  self:AddBuffDieTrigger("bs_20234_3", 1, self.OnBuffDie, nil, self.caster, self.buffId)
  self.caster.recordTable.Scale = 1.0
end

function bs_20234:OnAfterAddBuff(buff, target)
  if target == self.caster then
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    if buffTier == nil or buffTier < 1 then
      buffTier = 1
    end
    self.caster.recordTable.Scale = buffTier * 0.1 + self.caster.recordTable.Scale
    local scale = self.caster.recordTable.Scale
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(scale, scale, scale), 0.4)
  end
end

function bs_20234:OnBeforBuffDispel(target, context)
  if target == self.caster then
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    if buffTier == nil or buffTier < 1 then
      buffTier = 1
    end
    self.caster.recordTable.Scale = buffTier * 0.1 + self.caster.recordTable.Scale
    local scale = self.caster.recordTable.Scale
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(scale, scale, scale), 0.4)
  end
end

function bs_20234:OnBuffDie(buff, target, removeType)
  if target == self.caster then
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    if buffTier == nil or buffTier < 1 then
      buffTier = 1
    end
    self.caster.recordTable.Scale = buffTier * 0.1 + self.caster.recordTable.Scale
    local scale = self.caster.recordTable.Scale
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(scale, scale, scale), 0.4)
  end
end

function bs_20234:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20234
