local bs_4014 = class("bs_4014", LuaSkillBase)
local base = LuaSkillBase
bs_4014.config = {
  buffId = 107101,
  buffId_1 = 204203,
  buffId_2 = 40141,
  buffId_66 = 66
}

function bs_4014:ctor()
end

function bs_4014:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_4014_1", 1, self.OnAfterAddBuff, nil, nil, nil, nil)
end

function bs_4014:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_1 then
    local restTier = target:GetBuffTier(self.config.buffId_1)
    if 6 <= restTier then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_66, 1, 30)
      LuaSkillCtrl:DispelBuff(target, self.config.buffId_1, 0, true)
    end
  end
  if buff.dataId == self.config.buffId then
    local random = LuaSkillCtrl:CallRange(1, 1000)
    if random <= self.arglist[1] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_1, 1)
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_2, 1, self.arglist[2])
    end
  end
end

function bs_4014:LuaDispose()
  base.LuaDispose(self)
end

function bs_4014:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4014
