local bs_30067 = class("bs_30067", LuaSkillBase)
local base = LuaSkillBase
bs_30067.config = {buffId_Giant = 1507, buffId = 2155}

function bs_30067:ctor()
end

function bs_30067:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_30067", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_Giant)
end

function bs_30067:OnAfterAddBuff(buff, target)
  local tier = target:GetBuffTier(self.config.buffId_Giant)
  if tier ~= nil and 0 < tier then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0, true, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, tier, nil, true)
  end
end

function bs_30067:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30067
