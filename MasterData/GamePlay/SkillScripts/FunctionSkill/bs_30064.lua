local bs_30064 = class("bs_30064", LuaSkillBase)
local base = LuaSkillBase
bs_30064.config = {
  buffId_hotFire = 107101,
  buffId_miniFire = 110150,
  buffId_miniFire2 = 110152
}

function bs_30064:ctor()
end

function bs_30064:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_30064_1", 1, self.OnAfterAddBuff, self.caster, nil, nil, eBattleRoleBelong.enemy)
  self.time = 0
end

function bs_30064:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_miniFire or buff.dataId == self.config.buffId_miniFire2 then
    self.time = self.time + buff.tier
    if self.time >= self.arglist[1] then
      while self.time >= 3 do
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId_hotFire, 1, 120)
        self.time = self.time - 3
      end
    end
  end
end

function bs_30064:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30064
