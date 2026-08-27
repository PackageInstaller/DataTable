local bs_20265 = class("bs_20265", LuaSkillBase)
local base = LuaSkillBase
bs_20265.config = {
  beginTimerCD = 15,
  buffId1 = 2067,
  buffId2 = 1279,
  buffId3 = 1252,
  effectId = 212306,
  buffID_rage = 212302,
  MoveBuffId = 69,
  buffId_170 = 170,
  SummonnerId1 = 19,
  SummonnerId2 = 20,
  maxHpPer = 150,
  powPer = 700,
  skill_intensityPer = 700,
  critPer = 1000,
  critDamagePer = 1000,
  defPer = 1000,
  sunderPer = 1000,
  magic_resPer = 1000,
  magic_penPer = 1000,
  effectId_shencheng = 70001,
  effectId_chongji = 12065,
  effectId_baozhao = 10866,
  effectId_up = 501101,
  effectId_down = 501102,
  effect_end = 501101,
  buffId_1000 = 1000,
  buffId_3004 = 3004,
  effect_ziyu = 1008
}

function bs_20265:ctor()
end

function bs_20265:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if LuaSkillCtrl:GetBattleRoomId() == 1184411 then
    local bind = BindCallback(self, self.StoryEvent)
    self.timer = LuaSkillCtrl:StartTimer(nil, 150, bind)
  end
  if LuaSkillCtrl:GetBattleRoomId() == 1184412 then
    self:AddAfterHurtTrigger("bs_20265_1", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.player)
    self.flag = 1
    self.hurt_count = 0
    self:ActiveBloodLock()
  end
  if LuaSkillCtrl:GetBattleRoomId() == 1184413 then
    self:AddAfterHurtTrigger("bs_20265_2", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.player)
    self.flag = 2
    self.hurt_count = 0
    self:ActiveBloodLock()
  end
  self.roleNext = 0
end

function bs_20265:Leaving()
  local roleList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  LuaSkillCtrl:StartTimer(nil, 20, BindCallback(self, self.TPOut, roleList), nil, roleList.Count)
end

function bs_20265:TPOut(roleList)
  if self.roleNext == roleList.Count then
    LuaSkillCtrl:ForceEndBattle(true)
  end
  if self.roleNext < roleList.Count then
    LuaSkillCtrl:CallEffect(roleList[self.roleNext], self.config.effect_end, self)
    LuaSkillCtrl:CallStartLocalScale(roleList[self.roleNext], Vector3.New(0.0, 0.0, 0.0), 0.1)
  end
  self.roleNext = self.roleNext + 1
end

function bs_20265:ActiveBloodLock()
  local plist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local elist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, plist.Count - 1 do
    LuaSkillCtrl:CallBuff(self, plist[i], 3009, 1, nil)
  end
  for i = 0, elist.Count - 1 do
    LuaSkillCtrl:CallBuff(self, elist[i], 3009, 1, nil)
  end
end

function bs_20265:DisactiveBloodLock()
  local plist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local elist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, plist.Count - 1 do
    LuaSkillCtrl:DispelBuff(plist[i], 3009, 0, true, true)
  end
  for i = 0, elist.Count - 1 do
    LuaSkillCtrl:DispelBuff(elist[i], 3009, 0, true, true)
  end
end

function bs_20265:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.flag < 0 then
    return
  end
  self.hurt_count = self.hurt_count + 1
  if self.hurt_count >= 5 then
    if self.flag == 1 then
      LuaSkillCtrl:CallPlayEpTipDialogInBattle(70)
    end
    if self.flag == 2 then
      LuaSkillCtrl:CallPlayEpTipDialogInBattle(71)
    end
    self.flag = 0
    LuaSkillCtrl:StartTimer(nil, 45, function()
      self:DisactiveBloodLock()
    end)
  end
end

function bs_20265:StoryEvent()
  local grid1 = {4, 1}
  local grid2 = {4, 3}
  LuaSkillCtrl:StartTimer(nil, 15, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 50)
    self:CallSummonerOnPos(grid1[1], grid1[2])
    self:CallSummonerOnPos(grid2[1], grid2[2])
  end)
  LuaSkillCtrl:StartTimer(nil, 30, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 50)
    self:CallSummonerOnPos(grid1[1], grid1[2])
    self:CallSummonerOnPos(grid2[1], grid2[2])
  end)
  LuaSkillCtrl:StartTimer(nil, 50, function()
    local afterStory = BindCallback(self, self.AfterStory)
    LuaSkillCtrl:StartAvgWithPauseGame(nil, 56001032, afterStory)
  end)
  local elist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  self.master = elist[0]
end

function bs_20265:AfterStory()
  local elist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, elist.Count - 1 do
    LuaSkillCtrl:CallBuff(self, elist[i], 66, 1, nil)
  end
  local plist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, plist.Count - 1 do
    LuaSkillCtrl:CallBuff(self, plist[i], 2176, 1, nil)
  end
  local cb = BindCallback(self, self.Leaving)
  local enemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  LuaSkillCtrl:StartTimer(nil, 7, cb)
end

function bs_20265:HurtEvent()
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 50)
  local enemyList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if enemyList == nil or 1 > enemyList.Count then
    return
  end
  if 1 < enemyList.Count then
    LuaSkillCtrl:CallEffect(enemyList[1], self.config.effectId_baozhao, self)
    LuaSkillCtrl:RemoveLife(enemyList[1].maxHp + 100, self, enemyList[1])
  end
  LuaSkillCtrl:CallEffect(enemyList[0], self.config.effectId_baozhao, self)
  LuaSkillCtrl:RemoveLife(enemyList[0].maxHp + 100, self, enemyList[0])
end

function bs_20265:CallSummonerOnPos(x, y)
  local role = LuaSkillCtrl:GetRoleWithPos(x, y)
  if role ~= nil then
    local grid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
    x, y = grid.x, grid.y
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.SummonnerId1, x, y, eBattleRoleBelong.enemy)
  summoner:SetAttr(eHeroAttr.maxHp, self.master.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, self.master.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.master.skill_intensity * self.config.skill_intensityPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, self.master.speed)
  summoner:SetAttr(eHeroAttr.def, self.master.def * self.config.defPer // 1000)
  summoner:SetAttr(eHeroAttr.crit, self.master.crit * self.config.critPer // 1000)
  summoner:SetAttr(eHeroAttr.critDamage, self.master.critDamage * self.config.critDamagePer // 1000)
  summoner:SetAttr(eHeroAttr.sunder, self.master.sunder * self.config.sunderPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, self.master.magic_res * self.config.magic_resPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_pen, self.master.magic_pen * self.config.magic_penPer // 1000)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  local role = LuaSkillCtrl:GetRoleWithPos(x, y)
  LuaSkillCtrl:CallEffect(role, self.config.effectId_down, self)
  return summonerEntity
end

function bs_20265:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_20265
