local bs_4011 = class("bs_4011", LuaSkillBase)
local base = LuaSkillBase
bs_4011.config = {buffID = 710}

function bs_4011:ctor()
end

function bs_4011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
end

function bs_4011:OnRealSummonerCaster(role)
  if role.roleType ~= eBattleRoleType.realSummoner or role.belongNum ~= eBattleRoleBelong.player then
    return
  end
  if role ~= nil or role.hp >= 0 then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffID, 1, nil, true)
    local heal = role.maxHp * self.arglist[2] // 1000
    LuaSkillCtrl:CallHeal(heal, self, role, true)
  end
end

function bs_4011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4011
