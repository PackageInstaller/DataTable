local bs_25057 = class("bs_25057", LuaSkillBase)
local base = LuaSkillBase
bs_25057.config = {buffId = 110078}

function bs_25057:ctor()
end

function bs_25057:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.CallSummonerBuff)
  self:AddOnRoleDieTrigger("bs_25057_10", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
end

function bs_25057:CallSummonerBuff(role)
  if role.summoner.summonerMaker.belongNum == eBattleRoleBelong.player then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetList.Count < 1 then
      return
    end
    for i = 0, targetList.Count - 1 do
      if targetList[i].targetRole.roleType == eBattleRoleType.character then
        LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, 1, nil, true)
      end
    end
  end
end

function bs_25057:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.player and role.roleType == eBattleRoleType.realSummoner then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetList.Count < 1 then
      return
    end
    for i = 0, targetList.Count - 1 do
      if targetList[i].targetRole.roleType == eBattleRoleType.character then
        LuaSkillCtrl:DispelBuff(targetList[i].targetRole, self.config.buffId, 1, ture)
      end
    end
  end
end

function bs_25057:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25057
