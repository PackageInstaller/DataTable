local bs_20229 = class("bs_20229", LuaSkillBase)
local base = LuaSkillBase
bs_20229.config = {
  buffId = 2073,
  ScaleTable = {
    1.3,
    1.4,
    1.5,
    1.6,
    1.8
  }
}

function bs_20229:ctor()
end

function bs_20229:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.buffId = LuaSkillCtrl:GetSkillBindBuffId(self)
  self:AddAfterAddBuffTrigger("bs_20229_1", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.buffId, nil, nil)
  self:AddBuffDieTrigger("bs_108301_06", 6, self.OnBuffDie, self.caster, nil, self.buffId)
end

function bs_20229:OnBuffDie(buff, target, removeType)
  if target == self.caster then
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1, 1, 1), 0.4)
  end
end

function bs_20229:OnAfterAddBuff(buff, target)
  if target == self.caster then
    local buffTier = self.caster:GetBuffTier(self.buffId)
    if buffTier == nil or buffTier < 1 then
      buffTier = 1
    end
    local scale
    if buffTier < #self.config.ScaleTable then
      scale = self.config.ScaleTable[buffTier]
    else
      scale = 1.9
    end
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(scale, scale, scale), 0.4)
  end
end

function bs_20229:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20229
