local bs_10320222 = class("bs_10320222", LuaSkillBase)
local base = LuaSkillBase
bs_10320222.config = {
  actionId = 1002,
  skill_time = 50,
  start_time = 5,
  skill_speed = 1,
  selectId_skill = 9,
  aoe_config = {
    effect_shape = eSkillResultShapeType.Block,
    aoe_select_code = 5,
    aoe_range = 1
  },
  hurt_config1 = {
    hit_formula = 0,
    basehurt_formula = 10078,
    crit_formula = 0,
    crithur_ratio = 0
  },
  hurt_config2 = {
    hit_formula = 0,
    basehurt_formula = 10079,
    crit_formula = 0,
    crithur_ratio = 0
  },
  effectId_C4trail = 103204,
  effectId_C4_loop = 103205,
  audioId1 = 103205,
  audioId2 = 103206
}

function bs_10320222:ctor()
end

function bs_10320222:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.grid_list = {}
  self.boom = {}
  self.boom_Em = {}
  self.boom_time = {}
  self.skill_num = 0
end

function bs_10320222:PlaySkill(data)
  self.skill_num = self.skill_num + 1
  local skilltime = self.config.skill_time * 100 // (self.config.skill_speed * 100)
  local starttime = self.config.start_time * 100 // (self.config.skill_speed * 100)
  self:CallCasterWait(skilltime)
  local triggerCallBack = BindCallback(self, self.OnActionCallBack)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.skill_speed, starttime, triggerCallBack)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
end

function bs_10320222:OnActionCallBack()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_skill, 10)
  local grid_list = {}
  local time = self.arglist[1]
  local times = self.arglist[1]
  if targetList.Count > 0 then
    for i = 1, times do
      if not (0 < time) then
        break
      end
      for i = 0, targetList.Count - 1 do
        local role = targetList[i].targetRole
        if role.belongNum == eBattleRoleBelong.enemy and 0 < time then
          local grid_dict = LuaSkillCtrl:FindEmptyGridsWithinRange(role.x, role.y, 5)
          if grid_dict == nil or grid_dict.Count <= 0 then
            goto lbl_84
          end
          for i = 0, grid_dict.Count - 1 do
            if self.grid_list[grid_dict[i]] == nil then
              local target_role = LuaSkillCtrl:GetTargetWithGrid(grid_dict[i].x, grid_dict[i].y)
              local BJ = time + self.skill_num * 5
              LuaSkillCtrl:StartTimer(self, (times - time) * 5, function()
                LuaSkillCtrl:CallEffectWithArg(target_role, self.config.effectId_C4trail, self, nil, nil, self.OnEffectTrigger, BJ)
              end)
              time = time - 1
              self.grid_list[grid_dict[i]] = true
              break
            end
          end
        end
      end
      goto lbl_84
      do break end
      ::lbl_84::
    end
  end
  if 0 < time then
    for i = 1, time * 2 do
      local grid = LuaSkillCtrl:FindEmptyGrid(nil)
      if grid ~= nil and self.grid_list[grid] == nil then
        local target_role = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
        local BJ = time + self.skill_num * 5
        LuaSkillCtrl:StartTimer(self, (times - time) * 5, function()
          LuaSkillCtrl:CallEffectWithArg(target_role, self.config.effectId_C4trail, self, nil, nil, self.OnEffectTrigger, BJ)
        end)
        time = time - 1
      end
      if time <= 0 then
        break
      end
    end
  end
end

function bs_10320222:OnEffectTrigger(time, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if self.boom[time] == nil then
      self.boom[time] = LuaSkillCtrl:CallEffect(target, self.config.effectId_C4_loop, self)
    end
    local collisionEnter = BindCallback(self, self.OnCollisionEnter, time, target)
    LuaSkillCtrl:CallAddCircleColliderForEffect(self.boom[time], 30, eColliderInfluenceType.Enemy, nil, collisionEnter, nil)
    self.boom_time[time] = LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config1)
      skillResult:EndResult()
      if self.boom[time] ~= nil then
        self.boom[time]:Die()
        self.boom[time] = nil
      end
      if self.boom_time[time] ~= nil then
        self.boom_time[time] = nil
      end
      local grid = LuaSkillCtrl:GetGridWithPos(target.x, target.y)
      if self.grid_list[grid] ~= nil then
        self.grid_list[grid] = nil
      end
    end)
  end
end

function bs_10320222:OnCollisionEnter(time, target, collider, index, entity)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity, self.config.aoe_config)
  LuaSkillCtrl:PlayAuHit(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config2)
  skillResult:EndResult()
  if self.boom[time] ~= nil then
    self.boom[time]:Die()
    self.boom[time] = nil
  end
  if self.boom_time[time] ~= nil then
    self.boom_time[time]:Stop()
    self.boom_time[time] = nil
  end
  local grid = LuaSkillCtrl:GetGridWithPos(target.x, target.y)
  if self.grid_list[grid] ~= nil then
    self.grid_list[grid] = nil
  end
end

function bs_10320222:LuaDispose()
  base.LuaDispose(self)
  self.grid_list = nil
  self.boom = nil
  self.boom_Em = nil
  self.boom_time = nil
end

function bs_10320222:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10320222
