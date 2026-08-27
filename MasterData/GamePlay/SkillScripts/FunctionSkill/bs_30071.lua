local bs_30071 = class("bs_30071", LuaSkillBase)
local base = LuaSkillBase
bs_30071.config = {buffId = 1515, buffId2 = 1516}

function bs_30071:ctor()
end

function bs_30071:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_30071_1", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId)
end

function bs_30071:OnAfterAddBuff(buff, target)
  local tier = target:GetBuffTier(self.config.buffId)
  if tier ~= nil and 0 < tier then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0, true, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId2, 1, 75, true)
  end
end

function bs_30071:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30071
