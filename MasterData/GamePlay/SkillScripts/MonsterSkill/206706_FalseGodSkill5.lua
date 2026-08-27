local bs_206706 = class("bs_206706", LuaSkillBase)
local base = LuaSkillBase
bs_206706.config = {
  sum1 = 1011,
  sum2 = 1012,
  sum3 = 1013,
  sum4 = 1014,
  sum5 = 1015,
  sum6 = 1016,
  skill_time = 25,
  start_time = 11,
  actionId = 1106,
  speed = 1,
  HurtConfigId = 3,
  selectId = 42,
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  effectId_down = 2067052
}

function bs_206706:ctor()
end

function bs_206706:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_206706:PlaySkill(data)
  self:AbandonSkillCdAutoReset(true)
  self.grid_1 = nil
  self.grid_2 = nil
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.skill_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:StartTimer(nil, self.config.skill_time, function()
    self:EndSkillAndCallNext()
  end)
end

function bs_206706:EndSkillAndCallNext()
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

function bs_206706:OnAttackTrigger(data)
  local grid_1, grid_2
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 10)
  if targetList.Count > 1 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i].targetRole
      local grid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
      if grid ~= nil then
        if grid_1 == nil then
          grid_1 = grid
        elseif grid_1 ~= grid then
          grid_2 = grid
          break
        end
      end
    end
  end
  if targetList.Count == 1 then
    local grid_list = LuaSkillCtrl:FindEmptyGridsWithinRange(targetList[0].targetRole.x, targetList[0].targetRole.y, 1, false)
    if grid_list ~= nil and grid_list.Count > 0 then
      for i = 0, grid_list.Count - 1 do
        if grid_1 == nil then
          grid_1 = grid_list[i]
        else
          grid_2 = grid_list[i]
          break
        end
      end
    end
  end
  if grid_1 == nil then
    grid_1 = LuaSkillCtrl:FindEmptyGrid(nil)
  end
  if grid_2 == nil then
    grid_2 = LuaSkillCtrl:FindEmptyGrid(nil)
  end
  if grid_1 ~= nil then
    self:OnCallSum(grid_1)
  end
  if grid_2 ~= nil and grid_2 ~= grid_1 then
    LuaSkillCtrl:PreSetRolePos(grid_2, self.caster)
    LuaSkillCtrl:StartTimer(nil, 3, function()
      LuaSkillCtrl:CanclePreSetPos(self.caster)
      self:OnCallSum(grid_2)
    end)
  end
end

function bs_206706:OnCallSum(Grid)
  local roll = LuaSkillCtrl:CallRange(1, 6)
  local SumRoll = self.config["sum" .. tostring(roll)]
  local summoner = LuaSkillCtrl:CreateSummoner(self, SumRoll, Grid.x, Grid.y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[2] // 1000)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.arglist[2] // 1000)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed * self.arglist[2] // 1000)
  summoner:SetAttr(eHeroAttr.moveSpeed, self.caster.moveSpeed)
  summoner:SetAttr(eHeroAttr.def, self.caster.def * self.arglist[2] // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.arglist[2] // 1000)
  summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.arglist[2] // 1000)
  summoner:SetAsRealEntity(1)
  local target = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_down, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.Aoe)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
    self.arglist[1]
  })
  skillResult:EndResult()
end

function bs_206706:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_206706
