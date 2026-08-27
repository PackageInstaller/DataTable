local bs_30024 = class("bs_30024", LuaSkillBase)
local base = LuaSkillBase
bs_30024.config = {freezeBuff = 1178, increase_skill_intensity_buff = 1181}

function bs_30024:InitSkill(isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_30024_1", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, self.config.freezeBuff)
end

function bs_30024:OnAfterAddBuff(buff, target)
  if buff.maker.hp <= 0 then
    return
  end
  if self:IsReadyToTake() then
    local curTier = self.caster:GetBuffTier(self.config.increase_skill_intensity_buff)
    if curTier < self.arglist[2] then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.increase_skill_intensity_buff, 1, nil, true)
    end
  end
end

function bs_30024:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30024
