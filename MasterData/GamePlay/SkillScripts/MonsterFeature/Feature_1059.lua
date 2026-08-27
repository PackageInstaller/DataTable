local bs_1059 = class("bs_1059", LuaSkillBase)
local base = LuaSkillBase
bs_1059.config = {buffId = 107101}

function bs_1059:ctor()
end

function bs_1059:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_1059_2", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffId)
end

function bs_1059:OnAfterAddBuff(buff, target)
  if not self:IsReadyToTake() then
    return
  end
  if LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] and buff.maker ~= self.caster then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.arglist[2], 120)
    self:OnSkillTake()
  end
end

function bs_1059:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1059
