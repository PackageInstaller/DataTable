local bs_17101 = class("bs_17101", LuaSkillBase)
local base = LuaSkillBase
bs_17101.config = {
  summoner1 = 75,
  summoner2 = 76,
  effectId_down = 10111,
  maxHpPer = 500,
  powPer = 300,
  skill_intensityPer = 300,
  critPer = 0,
  critDamagePer = 0,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000
}

function bs_17101:ctor()
end

function bs_17101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17101_2", 1, self.OnAfterBattleStart)
  self.summoner = nil
  self.maxRole = self:findMaxRole()
end

function bs_17101:OnAfterBattleStart()
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, nil, -1, self.arglist[1])
  self:OnArriveAction()
end

function bs_17101:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetGrid = LuaSkillCtrl:FindEmptyGrid()
  if targetGrid == nil then
    return
  end
  local master = self:findMaxRole()
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summoner1, targetGrid.x, targetGrid.y, eBattleRoleBelong.player)
  summoner:SetAttr(eHeroAttr.maxHp, master.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, master.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, master.skill_intensity * self.config.skill_intensityPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, 0)
  summoner:SetAttr(eHeroAttr.def, master.def * self.config.defPer // 1000)
  summoner:SetAttr(eHeroAttr.sunder, master.sunder * self.config.sunderPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, master.magic_res * self.config.magic_resPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_pen, master.magic_pen * self.config.magic_penPer // 1000)
  summoner:SetAsRealEntity(1)
  local arg1 = self.arglist[2]
  local arg2 = self.arglist[3]
  local arg3 = self.arglist[4]
  local tab = {
    arg1 = arg1,
    arg2 = arg2,
    arg3 = arg3
  }
  summoner:SetRecordTable(tab)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  local target = LuaSkillCtrl:GetTargetWithGrid(targetGrid.x, targetGrid.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_down, self)
end

function bs_17101:findMaxRole()
  local targetList = LuaSkillCtrl:GetAllFriendRolesRelative(self.caster.belongNum)
  if targetList.Count <= 0 then
    return
  end
  local targetRole = targetList[0]
  for i = 0, targetList.Count - 1 do
    if targetRole.skill_intensity <= targetList[i].skill_intensity then
      targetRole = targetList[i]
    end
  end
  return targetRole
end

function bs_17101:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_17101:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy then
    return
  end
  if (role.roleDataId == self.config.summoner1 or role.roleDataId == self.config.summoner2) and role.roleType == eBattleRoleType.realSummoner then
    return
  end
  local isSacrifice = false
  if killer.roleType == eBattleRoleType.character and killer.belongNum == eBattleRoleBelong.player then
    isSacrifice = true
  end
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.CallSummoner, role.x, role.y, isSacrifice))
end

function bs_17101:CallSummoner(GridX, GridY, isSacrifice)
  local role = LuaSkillCtrl:GetRoleWithPos(GridX, GridY)
  local x, y
  if role ~= nil then
    local emptyGrid = LuaSkillCtrl:FindEmptyGridWithinRange(role, 3)
    x, y = emptyGrid.x, emptyGrid.y
  else
    x, y = GridX, GridY
  end
  if x == nil and y == nil then
    return
  end
  local summonerId = self.config.summoner1
  if isSacrifice then
    summonerId = self.config.summoner2
  end
  local master = self:findMaxRole()
  local summoner = LuaSkillCtrl:CreateSummoner(self, summonerId, x, y, eBattleRoleBelong.player)
  summoner:SetAttr(eHeroAttr.maxHp, master.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, master.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, master.skill_intensity * self.config.skill_intensityPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, master.speed)
  summoner:SetAttr(eHeroAttr.def, master.def * self.config.defPer // 1000)
  summoner:SetAttr(eHeroAttr.crit, master.crit * self.config.critPer // 1000)
  summoner:SetAttr(eHeroAttr.critDamage, master.critDamage * self.config.critDamagePer // 1000)
  summoner:SetAttr(eHeroAttr.sunder, master.sunder * self.config.sunderPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, master.magic_res * self.config.magic_resPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_pen, master.magic_pen * self.config.magic_penPer // 1000)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  local target = LuaSkillCtrl:GetTargetWithGrid(x, y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_down, self)
end

return bs_17101
