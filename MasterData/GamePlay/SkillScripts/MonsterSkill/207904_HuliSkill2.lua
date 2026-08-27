local bs_207904 = class("bs_207904", LuaSkillBase)
local base = LuaSkillBase
bs_207904.config = {
  hurt_config = 3,
  buffId_151 = 151,
  skill_time = 38,
  skill_speed = 1,
  start_time = 13,
  startAnimId = 1020,
  effectId_JXG = 207910,
  effectId_DG = 207911,
  effectId_AOE = 207912,
  effectId_JT = 207913,
  monsterId1 = 44,
  monsterId2 = 45,
  maxHpPer = 50,
  powPer = 1000
}

function bs_207904:ctor()
end

function bs_207904:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_207904_1", 1, self.OnRoleDie)
  self.A_num = 0
  self.B_num = 0
end

function bs_207904:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimId, self.config.skill_speed, self.config.start_time, attackTrigger)
  self:AbandonSkillCdAutoReset(true)
end

function bs_207904:OnAttackTrigger(data)
  self:EndSkillAndCallNext()
  local number = 1 - self.caster.attackRange
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, number)
  if targetList ~= nil then
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:CallEffect(targetList[i].targetRole, self.config.effectId_JT, self)
      local buff = LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId_151, 1, 10)
    end
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_JXG, self, nil, nil, nil, true)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if 0 >= targetList.Count then
    return
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallEffectWithArg(targetList[i].targetRole, self.config.effectId_AOE, self, false, false, self.SkillEventFunc)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i].targetRole)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    })
  end
  LuaSkillCtrl:StartTimer(nil, 4, BindCallback(self, self.SummonAll), nil)
end

function bs_207904:SummonAll()
  if self.A_num < 3 then
    local num = 3 - self.A_num
    for i = 1, num do
      LuaSkillCtrl:StartTimer(nil, i * 3, function()
        local grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
        if grid ~= nil then
          self:summoner(grid, "A")
          self.A_num = self.A_num + 1
        end
      end, self, 0, 3)
    end
  end
  if 3 > self.B_num then
    local num = 3 - self.B_num
    local ALLtargetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    local num_ex = 3 - self.B_num
    for i = 1, num do
      for j = 0, ALLtargetList.Count - 1 do
        if ALLtargetList[j].targetRole ~= nil then
          local role = ALLtargetList[j].targetRole
          if role ~= nil then
            local grid_role = LuaSkillCtrl:CallFindEmptyGridNearest(role)
            if grid_role ~= nil and LuaSkillCtrl:GetGridsDistance(role.x, role.y, grid_role.x, grid_role.y) == 1 then
              self:summoner(grid_role, "B")
              self.B_num = self.B_num + 1
              if num_ex <= self.B_num then
                break
              end
            end
          end
        end
      end
      if num_ex <= self.B_num then
        break
      end
    end
  end
end

function bs_207904:summoner(grid, team)
  local x = grid.x
  local y = grid.y
  local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local cskill = self.caster.recordTable.CasterSkill or self.cskill
  local summoner = LuaSkillCtrl:CreateSummonerWithCSkill(cskill, self.config.monsterId1, x, y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAttr(eHeroAttr.def, self.caster.def // 10)
  summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res // 10)
  summoner:SetAsRealEntity(1)
  local table = {team1 = team}
  summoner:SetRecordTable(table)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_DG, self)
end

function bs_207904:OnRoleDie(killer, role)
  if role.recordTable.team1 == "B" and role.roleDataId == self.config.monsterId1 then
    self.B_num = self.B_num - 1
  elseif role.recordTable.team1 == "A" and role.roleDataId == self.config.monsterId1 then
    self.A_num = self.A_num - 1
  end
end

function bs_207904:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId_JT and eventId == eBattleEffectEvent.Trigger then
    local targetRole = target.targetRole
  end
end

function bs_207904:EndSkillAndCallNext()
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self:CallNextBossSkill()
end

function bs_207904:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207904
