local bs_20258 = class("bs_20258", LuaSkillBase)
local base = LuaSkillBase
bs_20258.config = {
  beginTimerCD = 15,
  buffId1 = 2067,
  buffId2 = 1279,
  actionId = 1057,
  skill_time = 35,
  action_speed = 1,
  start_time = 12,
  effectId = 212306,
  buffID_rage = 212302,
  MoveBuffId = 69,
  buffId_170 = 170,
  effect_xuanyun = 90,
  gridList = {
    {7, 1},
    {7, 6},
    {1, 3}
  },
  scaleTable = {
    1.3,
    1.4,
    1.5,
    1.6
  },
  buffId_busi = 32,
  buff_jitui = 1278,
  pos = {
    {6, 0},
    {6, 1},
    {6, 2},
    {6, 3},
    {6, 4},
    {6, 5},
    {6, 6},
    {7, 0},
    {7, 1},
    {7, 2},
    {7, 3},
    {7, 4},
    {7, 5},
    {7, 6}
  },
  pos1 = {
    {7, 2},
    {8, 2},
    {9, 2},
    {7, 3},
    {7, 4},
    {8, 4},
    {9, 4}
  },
  SummonnerId = 68,
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
  effectId_up = 501101,
  effectId_down = 501102,
  buffId_1000 = 1000,
  buffId_3004 = 3004,
  effect_ziyu = 1008
}

function bs_20258:ctor()
end

function bs_20258:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20258", 1, self.AfterBattleStart)
  self.count = 0
end

function bs_20258:AfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
  local eventFunc = BindCallback(self, self.OnBattleStart)
  self.timer1 = LuaSkillCtrl:StartTimer(self, 165, eventFunc)
end

function bs_20258:OnBattleStart()
  local eventFunc = BindCallback(self, self.storyFlow1, targetList)
  LuaSkillCtrl:StartAvgWithPauseGame("23carnival_s07_2", nil, eventFunc)
end

function bs_20258:storyFlow1(targetList)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_rage, 1, 900, false)
  local scale = self.config.scaleTable[1]
  LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3(scale, scale, scale), 0.9)
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 0.9, 50)
  local scale = self.config.scaleTable[2]
  LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3(scale, scale, scale), 0.9)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId1, 1, nil, true)
  end
  local attackTrigger1 = BindCallback(self, self.OnAttackTrigger1)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, nil, true)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger1)
end

function bs_20258:OnAttackTrigger1()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, nil, true)
  local grid_x = self.config.gridList[3][1]
  local grid_y = self.config.gridList[3][2]
  local grid = LuaSkillCtrl:GetGridWithPos(grid_x, grid_y)
  local MoveTime = LuaSkillCtrl:GetGridsDistance(grid.x, grid.y, self.caster.x, self.caster.y)
  LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, self.caster, grid.x, grid.y, MoveTime, self.config.MoveBuffId)
  local eventfunc = BindCallback(self, self.storyFlow2)
  self.timer2 = LuaSkillCtrl:StartTimer(self, MoveTime, eventfunc)
end

function bs_20258:storyFlow2()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, targetList.Count - 1 do
    local hp = targetList[i].hp
    if targetList[i].roleDataId == 116 then
      LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_busi, 1, nil, true)
      LuaSkillCtrl:RemoveLife(hp * 2, self, targetList[i], true, nil, true, true, eHurtType.RealDmg, true)
    else
      LuaSkillCtrl:CallEffect(targetList[i], self.config.effect_xuanyun, self)
    end
  end
  local eventFunc2 = BindCallback(self, self.storyFlow3)
  self.tiemr3 = LuaSkillCtrl:StartTimer(self, 25, eventFunc2)
end

function bs_20258:storyFlow3()
  local pf = LuaSkillCtrl:GetGuardProfession()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true, pf)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, targetList.Count - 1 do
    local target = targetList[i]
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:CallEffect(target, self.config.effect_ziyu, self)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {99999}, true, true)
    skillResult:EndResult()
  end
  local bindcall = BindCallback(self, self.CallSummonerOnPos)
  self.timer5 = LuaSkillCtrl:StartTimer(self, 15, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 1, 50)
    LuaSkillCtrl:CallEffect(pf, self.config.effectId_chongji, self)
    LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, self.caster, 8, 3, 7)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true, pf)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect_xuanyun, self)
    self.timer6 = LuaSkillCtrl:StartTimer(self, 5, bindcall, nil, 15)
  end)
end

function bs_20258:CallSummonerOnPos()
  if self.count == 0 then
    for i = 1, 7 do
      self:CallSummonerOnPos2(self.config.pos1[i][1], self.config.pos1[i][2])
    end
    self.count = self.count + 1
  elseif self.count > 14 then
    local endEvent = BindCallback(self, self.endGame)
    LuaSkillCtrl:StartAvgWithPauseGame("23carnival_s07_3", nil, endEvent)
  else
    local x = self.config.pos[self.count][1]
    local y = self.config.pos[self.count][2]
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.SummonnerId, x, y, eBattleRoleBelong.player)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.skill_intensityPer // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.def, self.caster.def * self.config.defPer // 1000)
    summoner:SetAttr(eHeroAttr.crit, self.caster.crit * self.config.critPer // 1000)
    summoner:SetAttr(eHeroAttr.critDamage, self.caster.critDamage * self.config.critDamagePer // 1000)
    summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder * self.config.sunderPer // 1000)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.config.magic_resPer // 1000)
    summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen * self.config.magic_penPer // 1000)
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    self.count = self.count + 1
    local role = LuaSkillCtrl:GetRoleWithPos(x, y)
    LuaSkillCtrl:CallEffect(role, self.config.effectId_down, self)
    LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId2, 1, nil, nil)
    return summonerEntity
  end
end

function bs_20258:CallSummonerOnPos2(x, y)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.SummonnerId, x, y, eBattleRoleBelong.player)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.skill_intensityPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAttr(eHeroAttr.def, self.caster.def * self.config.defPer // 1000)
  summoner:SetAttr(eHeroAttr.crit, self.caster.crit * self.config.critPer // 1000)
  summoner:SetAttr(eHeroAttr.critDamage, self.caster.critDamage * self.config.critDamagePer // 1000)
  summoner:SetAttr(eHeroAttr.sunder, self.caster.sunder * self.config.sunderPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.config.magic_resPer // 1000)
  summoner:SetAttr(eHeroAttr.magic_pen, self.caster.magic_pen * self.config.magic_penPer // 1000)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  local role = LuaSkillCtrl:GetRoleWithPos(x, y)
  LuaSkillCtrl:CallEffect(role, self.config.effectId_down, self)
  LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId2, 1, nil, nil)
  return summonerEntity
end

function bs_20258:endGame()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_20258:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20258
