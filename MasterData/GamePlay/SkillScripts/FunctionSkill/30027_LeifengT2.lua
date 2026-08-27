local bs_30027 = class("bs_30027", LuaSkillBase)
local base = LuaSkillBase
bs_30027.config = {buffId = 1188, buffIdDouble = 1121}

function bs_30027:ctor()
end

function bs_30027:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffHitMaxTierTrigger("bs_30027_1", 1, self.OnBuffHitMaxTier, nil, nil, nil, nil, self.config.buffId)
end

function bs_30027:OnBuffHitMaxTier(buff, role, isOverlay, maxTier)
  if self:IsReadyToTake() then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
    if targetlist.Count < 1 then
      return
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i].targetRole
      if 0 < targetRole.hp then
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffIdDouble, 1, self.arglist[2], true)
      end
    end
    self:OnSkillTake()
  end
end

function bs_30027:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30027
