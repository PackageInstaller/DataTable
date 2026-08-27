local bs_82041 = class("bs_82041", LuaSkillBase)
local base = LuaSkillBase
bs_82041.config = {buffID = 710}

function bs_82041:ctor()
end

function bs_82041:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
end

function bs_82041:OnRealSummonerCaster(role)
  if role.roleType ~= eBattleRoleType.realSummoner then
    return
  end
  if role ~= nil or role.hp >= 0 then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffID, 1, nil, true)
    local heal = role.maxHp * self.arglist[2] // 1000
    LuaSkillCtrl:CallHeal(heal, self, role, true)
  end
end

function bs_82041:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_82041
