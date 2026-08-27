local bs_20230 = class("bs_20230", LuaSkillBase)
local base = LuaSkillBase
bs_20230.config = {buffId = 1507}

function bs_20230:ctor()
end

function bs_20230:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_20230_1", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffId, nil, nil)
end

function bs_20230:OnAfterAddBuff(buff, target)
  if target == self.caster then
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    if buffTier == nil or buffTier < 1 then
      buffTier = 1
    end
    local scale = 1 + buffTier * 0.16
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(scale, scale, scale), 0.4)
  end
end

function bs_20230:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20230
