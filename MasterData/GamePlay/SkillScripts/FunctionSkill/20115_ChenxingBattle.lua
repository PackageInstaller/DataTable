local bs_20115 = class("bs_20115", LuaSkillBase)
local base = LuaSkillBase
bs_20115.config = {
  maxHp = 1000000,
  pow = 10000,
  intensity = 10000,
  speed = 0,
  actionId = 1104,
  monsterId = 24,
  buffId = 278,
  buffId_wo = 1219,
  buufID_miansi = 3009,
  buffFeature_Invinciable = 2,
  totalTime = 300,
  buff_doubleAttack = 1121
}

function bs_20115:ctor()
end

function bs_20115:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20115_1", 1, self.OnAfterBattleStart)
end

function bs_20115:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.YazhiAll)
  LuaSkillCtrl:StartTimer(nil, self.config.totalTime, arriveCallBack)
end

function bs_20115:YazhiAll()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    if targetRole.belongNum ~= eBattleRoleBelong.neutral then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
      LuaSkillCtrl:DispelBuff(targetRole, self.config.buff_doubleAttack, 0, true, true)
    end
  end
  targetlist = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_wo, 1, 100, true)
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_wo, 1, 3009, true)
  end
  local arriveCallBack = BindCallback(self, self.Ruchang)
  LuaSkillCtrl:StartTimer(nil, 60, arriveCallBack)
end

function bs_20115:Ruchang()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if targetlist.Count < 1 then
    return
  end
  for i = targetlist.Count - 1, 0, -1 do
    local targetRole = targetlist[i]
    local IfRoleCotainsInvinciableBuff = LuaSkillCtrl:RoleContainsBuffFeature(targetRole, self.config.buffFeature_Invinciable)
    if IfRoleCotainsInvinciableBuff then
      local buff_invinciable = LuaSkillCtrl:GetRoleAllBuffsByFeature(targetRole, self.config.buffFeature_Invinciable)
      if buff_invinciable.Count > 0 then
        for j = 0, buff_invinciable.Count - 1 do
          LuaSkillCtrl:DispelBuff(targetRole, buff_invinciable[j].dataId, 0)
        end
      end
    end
    local damage = targetRole.maxHp * 10
    LuaSkillCtrl:RemoveLife(damage, self, targetRole, true, nil, true, true)
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, 2, 2)
  summoner:SetAttr(eHeroAttr.maxHp, self.config.maxHp)
  summoner:SetAttr(eHeroAttr.pow, self.config.pow)
  summoner:SetAttr(eHeroAttr.intensity, self.config.intensity)
  summoner:SetAttr(eHeroAttr.speed, self.config.speed)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:CallRoleAction(summonerEntity, 1104, 1)
  local arriveCallBack = BindCallback(self, self.Jiechu)
  LuaSkillCtrl:StartTimer(nil, 75, arriveCallBack)
  local arriveCallBack1 = BindCallback(self, self.Xindie)
  LuaSkillCtrl:StartTimer(nil, 45, arriveCallBack1)
end

function bs_20115:Xindie()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    if targetRole.roleDataId == 30005 then
      local damage = targetRole.maxHp * 10
      local grid = LuaSkillCtrl:GetGridWithPos(2, 2)
      LuaSkillCtrl:RemoveLife(damage, self, targetRole, true, nil, false, true)
      LuaSkillCtrl:CallEffect(targetRole, 10263, self)
      LuaSkillCtrl:SetRolePos(grid, targetRole)
    end
  end
end

function bs_20115:Jiechu()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId_wo, 0)
  end
end

function bs_20115:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20115
