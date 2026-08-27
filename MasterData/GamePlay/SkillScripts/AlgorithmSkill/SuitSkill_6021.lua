local bs_6021 = class("bs_6021", LuaSkillBase)
local base = LuaSkillBase
bs_6021.config = {
  buffId_1 = 602101,
  buffId_2 = 602102,
  buffId_3 = 602103
}

function bs_6021:ctor()
end

function bs_6021:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_6021_1", 1, self.OnAfterBattleStart)
  self:AddAfterPlaySkillTrigger("bs_6021_13", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.normalSkill)
end

function bs_6021:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, 1, nil, true)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
    self:AddBuff()
  end, self, -1)
end

function bs_6021:OnAfterPlaySkill(skill, role)
  local num = self.caster:GetBuffTier(self.config.buffId_2)
  if 0 < num then
    LuaSkillCtrl:StartTimer(nil, self.arglist[5], function()
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_2, 0, true)
      if self.timer ~= nil then
        self.timer:Stop()
        self.timer = nil
        self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
          self:AddBuff()
        end, self, -1)
      end
    end)
  end
end

function bs_6021:AddBuff()
  if self.caster:GetBuffTier(self.config.buffId_2) < self.arglist[4] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_2, 1, nil, true)
  end
end

function bs_6021:OnCasterDie()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  base.OnCasterDie(self)
end

return bs_6021
