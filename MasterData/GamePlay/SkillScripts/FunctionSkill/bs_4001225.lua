local bs_4001225 = class("bs_4001225", LuaSkillBase)
local base = LuaSkillBase
bs_4001225.config = {
  buffId_fire = 1227,
  buffId_blood = 195,
  duration_blood = 75,
  duration_fire = 90
}

function bs_4001225:ctor()
end

function bs_4001225:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_4001225", 50, self.OnAfterAddBuff, nil, nil, nil, eBattleRoleBelong.enemy, nil, nil, nil)
end

function bs_4001225:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_fire then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_blood, 1, self.config.duration_blood, true)
  end
  if buff.dataId == self.config.buffId_blood then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_fire, 1, self.config.duration_fire, true)
  end
end

function bs_4001225:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001225
