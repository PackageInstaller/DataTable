local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_4 = class("sc_4", StorySkillBase)
local base = StorySkillBase
sc_4.config = {
  level_id = {
    1185131,
    1185132,
    1185133
  },
  hurt_down = 2255,
  atk_down = 2254,
  atk_up = 2256,
  rip_pos = {
    {0, 0},
    {0, 1},
    {0, 2},
    {0, 3},
    {0, 4}
  },
  effect_burning = 12212,
  effect_fire = 12213,
  effect_field = 12214,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 2
  },
  aoe_config1 = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 4
  }
}
sc_4.config = setmetatable(sc_4.config, {
  __index = base.config
})

function sc_4:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_4:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self.room_id = LuaSkillCtrl:GetBattleRoomId()
  if self.room_id == self.config.level_id[1] then
    self:Level1()
  elseif self.room_id == self.config.level_id[2] then
    self:Level2()
  elseif self.room_id == self.config.level_id[3] then
    self:Level3()
  else
    return
  end
end

function sc_4:Level1()
  self:MakeTagRoles()
  self:SwitchSpeedMode(1)
  self.RIPList = {}
  self.FLow1Count = 0
  self.FLow2Count = 0
  self.die_star = self.storyCampRoles[1][1]
  for role_tag, list in ipairs(self.storyCampRoles) do
    if role_tag ~= 3 then
      for _, role in ipairs(list) do
        self:SetUndead(role)
      end
    end
  end
  LuaSkillCtrl:CallBuff(self, self.die_star, self.config.hurt_down, 9, nil)
  LuaSkillCtrl:CallBuff(self, self.die_star, self.config.atk_up, 20, nil)
  for key, role in pairs(self.storyCampRoles[2]) do
    self:SetUnMove(role)
  end
  for key, role in pairs(self.storyCampRoles[1]) do
    self:SetUnMove(role)
  end
  for key, role in pairs(self.storyCampRoles[3]) do
    self:SetUnMove(role)
  end
  for key, role in pairs(self.storyCampRoles[4]) do
    self:SetUnMove(role)
  end
  for key, role in pairs(self.storyCampRoles[5]) do
    self:SetUnMove(role)
  end
  for key, role in pairs(self.storyCampRoles[9]) do
    self:SetUnselect(role)
  end
  self:AddOnRoleDieTrigger("level1", 2, self.Level1_DieTriger)
  self:AddAfterHurtTriggerForTable("level1", 1, self.OnDieStarHurt, {
    sender = self.die_star
  })
  self.boss_timer = LuaSkillCtrl:StartTimer(nil, 60, function()
    self:call_coorde(1, 1)
    self:call_coorde(1, 3)
  end, nil, -1)
  self.level1_flag1 = false
  self.level1_flag2 = false
end

function sc_4:Level1_DieTriger(killer, role)
  self.FLow1Count = self.FLow1Count + 1
  if self.FLow1Count >= 3 and not self.level1_flag1 then
    self.level1_flag1 = true
    self:Level1Flow1()
  end
  if self.level1_flag1 and not self.level1_flag2 then
    local pList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    if 1 >= pList.Count then
      self.level1_flag2 = true
      self:Level1Flow2()
    end
  end
end

function sc_4:Level1Flow1()
  if self.boss_timer ~= nil then
    self.boss_timer:Stop()
    self.boss_timer = nil
  end
  local to_croode_list = self.storyCampRoles[2]
  for k, v in ipairs(self.storyCampRoles[4]) do
    self:DisableUndead(v)
    self:DisableUnMove(v)
  end
  self:CroodeRole(to_croode_list[1], 20074)
  LuaSkillCtrl:StartTimer(nil, 30, function()
    self:CroodeRole(to_croode_list[2], 20074)
  end)
end

function sc_4:Level1Flow2()
  local plist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, plist.Count - 1 do
    self:DisableUnMove(plist[i])
  end
  LuaSkillCtrl:StartTimer(nil, 15, function()
    self:Level1Flow3()
  end)
end

function sc_4:Level1Flow3()
  self:MakeDieStarMove()
  LuaSkillCtrl:StartTimer(nil, 15, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function sc_4:OnDieStarHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  local percent = 0
  if self.room_id == self.config.level_id[1] then
    percent = 500
  elseif self.room_id == self.config.level_id[2] then
    percent = 800
  elseif self.room_id == self.config.level_id[3] then
    percent = 1000
  end
  LuaSkillCtrl:RemoveLife(target.maxHp * percent // 1000, self, target, true, nil, true, true)
end

function sc_4:Level2()
  self:MakeTagRoles()
  self:SwitchSpeedMode(1)
  self.RIPList = {}
  self.FLow1Count = 0
  self.FLow2Count = 0
  self.die_star = self.storyCampRoles[1][1]
  for role_tag, list in ipairs(self.storyCampRoles) do
    for _, role in ipairs(list) do
      self:SetUndead(role)
      self:SetUnMove(role)
    end
  end
  LuaSkillCtrl:CallBuff(self, self.die_star, self.config.hurt_down, 3, nil)
  LuaSkillCtrl:CallBuff(self, self.die_star, self.config.atk_up, 10, nil)
  self:AddOnRoleDieTrigger("level2", 2, self.Level2_DieTriger)
  self:AddAfterHurtTriggerForTable("level2", 1, self.OnDieStarHurt, {
    sender = self.die_star
  })
  self.boss_timer = LuaSkillCtrl:StartTimer(nil, 60, function()
    self:call_coorde(2, 1)
    self:call_coorde(2, 3)
  end, nil, -1)
  self.level2_flag1 = false
  self.level2_flag2 = false
  self.level2_flag3 = false
end

function sc_4:Level2_DieTriger(killer, role)
  self.FLow1Count = self.FLow1Count + 1
  if self.level2_flag1 then
    self.FLow2Count = self.FLow2Count + 1
  end
  if self.FLow1Count >= 2 and not self.level2_flag1 then
    self.level2_flag1 = true
    self:Level2Flow1()
  end
  if self.FLow2Count >= 2 and not self.level2_flag2 then
    self.level2_flag2 = true
    self:Level2Flow2()
  end
  if self.level2_flag2 then
    local elist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    if 1 >= elist.Count then
      self:Level2Flow3()
    end
  end
end

function sc_4:Level2Flow1()
  local role = self.storyCampRoles[5][1]
  self:CroodeRole(role, 50004)
end

function sc_4:Level2Flow2()
  if self.boss_timer ~= nil then
    self.boss_timer:Stop()
    self.boss_timer = nil
  end
  local role = self.storyCampRoles[3][1]
  self:DisableUndead(role)
  local grid_target = LuaSkillCtrl:GetTargetWithGrid(role.x, role.y)
  LuaSkillCtrl:CallEffect(role, 12209, self, self.DogDieEffect)
  self:PlayAudioById(105607)
end

function sc_4:DogDieEffect(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    if skillResult.roleList ~= nil and skillResult.roleList.Count > 1 then
      for i = 0, skillResult.roleList.Count - 1 do
        LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], 2250, 1, 7, false, nil, false)
      end
    end
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 14, {9999})
    skillResult:EndResult()
    local role = self.storyCampRoles[3][1]
    LuaSkillCtrl:RemoveLife(99999, self, role, true, nil, true)
  end
end

function sc_4:Level2Flow3()
  self:MakeDieStarMove()
  self:creat_wall(1)
  LuaSkillCtrl:StartTimer(nil, 15, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function sc_4:Level3()
  self:MakeTagRoles()
  self:SwitchSpeedMode(1)
  self.FLow1Count = 0
  self.FLow2Count = 0
  self.die_star = self.storyCampRoles[1][1]
  for role_tag, list in ipairs(self.storyCampRoles) do
    for _, role in ipairs(list) do
      self:SetUndead(role)
      self:SetUnMove(role)
    end
  end
  LuaSkillCtrl:CallBuff(self, self.die_star, self.config.hurt_down, 3, nil)
  LuaSkillCtrl:CallBuff(self, self.die_star, self.config.atk_up, 10, nil)
  for key, role in pairs(self.storyCampRoles[9]) do
    self:SetUnselect(role)
    LuaSkillCtrl:CallBuff(self, role, 88, 1, nil)
  end
  self:AddOnRoleDieTrigger("level2", 2, self.Level3_DieTriger)
  self:AddAfterHurtTriggerForTable("level2", 1, self.OnDieStarHurt, {
    sender = self.die_star
  })
  self.level3_flag1 = false
  self.level3_flag2 = false
  self.level3_flag3 = false
end

function sc_4:Level3_DieTriger(killer, role)
  self.FLow1Count = self.FLow1Count + 1
  if self.level2_flag1 then
    self.FLow2Count = self.FLow2Count + 1
  end
  if self.FLow1Count > 1 and not self.level3_flag1 then
    self.level3_flag1 = true
    self:Level3Flow1()
  end
end

function sc_4:Level3Flow1()
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 50)
  self:call_coorde(2, 3)
  self:call_coorde(2, 1)
  LuaSkillCtrl:StartTimer(nil, 15, function()
    self:call_coorde(2, 2)
    self:call_coorde(3, 1)
    self:call_coorde(4, 2)
    self:call_coorde(3, 3)
  end)
  self.flag = false
  self.shake_timer = LuaSkillCtrl:StartTimer(nil, 15, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 5)
    if self.flag then
      LuaSkillCtrl:ShowCameraEffectFunction(7, 0.4)
      self.flag = false
    else
      LuaSkillCtrl:ShowCameraEffectFunction(7, 0.1)
      self:PlayAudioById(104803)
      self.flag = true
    end
  end, nil, -1, -15)
  LuaSkillCtrl:StartTimer(nil, 30, function()
    self:call_coorde(4, 0, 20049)
    self:call_coorde(4, 1, 20049)
  end)
  LuaSkillCtrl:StartTimer(nil, 45, function()
    self:call_coorde(5, 2, 20049)
    self:call_coorde(4, 3, 20049)
    self:call_coorde(4, 4, 20049)
  end)
  LuaSkillCtrl:StartTimer(nil, 80, function()
    self:call_coorde(2, 0)
    self:call_coorde(2, 4)
  end)
  LuaSkillCtrl:StartTimer(nil, 100, function()
    self:call_coorde(2, 0)
    self:call_coorde(2, 4)
  end)
  LuaSkillCtrl:StartTimer(nil, 120, function()
    self:call_coorde(2, 0)
    self:call_coorde(2, 4)
    LuaSkillCtrl:CallBuff(self, self.die_star, 66, 1)
  end)
  LuaSkillCtrl:StartTimer(nil, 140, function()
    self:Level3Flow2()
  end)
end

function sc_4:Level3Flow2()
  if self.shake_timer ~= nil then
    self.shake_timer:Stop()
    self.shake_timer = nil
  end
  LuaSkillCtrl:CloseCameraEffectFunction(7, nil)
  local cb = BindCallback(self, self.Level3Flow3)
  LuaSkillCtrl:StartAvgWithPauseGame(nil, 33061111, cb)
end

function sc_4:Level3Flow3()
  self:PlayAudioById(104815)
  LuaSkillCtrl:DispelBuff(self.die_star, 66, 0, true, true)
  self:StopRole(self.die_star)
  local target_grid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  local target_grid_shield = LuaSkillCtrl:GetTargetWithGrid(5, 2)
  self:SetUnselect(self.storyCampRoles[9][1])
  self.camera_effect_strength = 0.1
  LuaSkillCtrl:CallBuff(self, self.die_star, 2257, 1, 300)
  LuaSkillCtrl:StartTimer(nil, 30, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(1, 1.5, 10, 50)
    local elist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    LuaSkillCtrl:CallStartLocalScale(self.die_star, Vector3(0, 0, 0), 0.1)
    for i = elist.Count - 1, 0, -1 do
      LuaSkillCtrl:CallBuff(self, elist[i], 66, 1, nil)
    end
    self:PlayAudioById(348)
    self.effect1 = LuaSkillCtrl:CallEffect(target_grid, 12212, self)
  end)
  LuaSkillCtrl:StartTimer(nil, 45, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 5)
    self.effect2 = LuaSkillCtrl:CallEffect(target_grid, 12213, self)
    self.effect3 = LuaSkillCtrl:CallEffect(target_grid_shield, 12214, self)
  end)
  LuaSkillCtrl:StartTimer(nil, 60, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 5)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.die_star, self.config.aoe_config1)
    if skillResult.roleList ~= nil and 1 < skillResult.roleList.Count then
      for i = 0, skillResult.roleList.Count - 1 do
        LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], 2250, 1, 7, false, nil, false)
      end
    end
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 14, {400})
    skillResult:EndResult()
  end)
  LuaSkillCtrl:StartTimer(nil, 80, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 5)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.die_star, self.config.aoe_config1)
    if skillResult.roleList ~= nil and 1 < skillResult.roleList.Count then
      for i = 0, skillResult.roleList.Count - 1 do
        LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], 2250, 1, 7, false, nil, false)
      end
    end
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 14, {1000})
    skillResult:EndResult()
  end)
  LuaSkillCtrl:StartTimer(nil, 100, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 1, 50)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.die_star, self.config.aoe_config1)
    if skillResult.roleList ~= nil and 1 < skillResult.roleList.Count then
      for i = 0, skillResult.roleList.Count - 1 do
        LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], 2250, 1, 7, false, nil, false)
      end
    end
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 14, {99999})
    skillResult:EndResult()
  end)
  LuaSkillCtrl:StartTimer(nil, 130, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function sc_4:MakeDieStarMove()
  self:DisableUnMove(self.die_star)
  local star_role = self.storyCampRoles[9][1]
  self:DisableUnselect(star_role)
end

function sc_4:MakeRIP(role)
end

function sc_4:CroodeRole(role, summnonerId)
  local grid_target = LuaSkillCtrl:GetTargetWithGrid(role.x, role.y)
  LuaSkillCtrl:CallEffect(role, 12048, self)
  LuaSkillCtrl:CallBuff(self, role, 66, 1, nil)
  local x, y = role.x, role.y
  local attr_table = {
    maxHp = role.maxHp * 100 // 1000,
    pow = role.pow * 100 // 1000,
    skill_intensity = role.skill_intensity * 100 // 1000,
    speed = role.speed,
    def = role.def * 100 // 1000,
    crit = role.crit,
    critDamage = role.critDamage,
    sunder = role.sunder,
    magic_res = role.magic_res,
    magic_pen = role.magic_pen
  }
  LuaSkillCtrl:StartTimer(nil, 30, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 5)
    LuaSkillCtrl:DispelBuff(role, 66, 0)
    LuaSkillCtrl:CallEffect(grid_target, 12118, self)
    self:DisableUndead(role)
    LuaSkillCtrl:RemoveLife(99999, self, role, true)
  end)
  LuaSkillCtrl:StartTimer(nil, 34, function()
    self:CastSummoner(x, y, summnonerId, eBattleRoleBelong.enemy, attr_table)
  end)
end

function sc_4:creat_wall(x)
  local attr_table = {
    maxHp = 10,
    pow = 1,
    skill_intensity = 1,
    speed = 0,
    def = 1,
    crit = 1,
    critDamage = 1,
    sunder = 1,
    magic_res = 1,
    magic_pen = 1
  }
  for y = 0, 4 do
    if LuaSkillCtrl:GetRoleWithPos(x, y) == nil then
      LuaSkillCtrl:StartTimer(nil, 3, function()
        self:CastSummoner(x, y, 73, eBattleRoleBelong.neutral, attr_table)
      end)
    end
  end
end

function sc_4:call_coorde(x, y, override_id)
  local summnonerId = 50001
  if override_id ~= nil then
    summnonerId = override_id
  end
  local role
  if self.storyCampRoles[4] == nil then
    role = self.storyCampRoles[9][1]
  else
    role = self.storyCampRoles[4][1]
  end
  local attr_table = {
    maxHp = role.maxHp * 100 // 1000,
    pow = role.pow * 100 // 1000,
    skill_intensity = role.skill_intensity * 100 // 1000,
    speed = role.speed,
    def = role.def * 100 // 1000,
    crit = role.crit,
    critDamage = role.critDamage,
    sunder = role.sunder,
    magic_res = role.magic_res,
    magic_pen = role.magic_pen
  }
  LuaSkillCtrl:StartTimer(nil, 3, function()
    self:CastSummoner(x, y, summnonerId, eBattleRoleBelong.enemy, attr_table)
  end)
end

function sc_4:call_coorde_random(x, y)
  local role = self.storyCampRoles[9][1]
  local attr_table = {
    maxHp = role.maxHp * 100 // 1000,
    pow = role.pow * 100 // 1000,
    skill_intensity = role.skill_intensity * 100 // 1000,
    speed = role.speed,
    def = role.def * 100 // 1000,
    crit = role.crit,
    critDamage = role.critDamage,
    sunder = role.sunder,
    magic_res = role.magic_res,
    magic_pen = role.magic_pen
  }
  local list = {
    50002,
    50003,
    50004,
    50001
  }
  LuaSkillCtrl:StartTimer(nil, 3, function()
    self:CastSummoner(x, y, 50001, eBattleRoleBelong.enemy, attr_table)
  end)
end

function sc_4:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 50)
  if self.effect1 ~= nil then
    self.effect1:Die()
    self.effect1 = nil
  end
  if self.effect2 ~= nil then
    self.effect2:Die()
    self.effect2 = nil
  end
  if self.effect3 ~= nil then
    self.effect3:Die()
    self.effect3 = nil
  end
end

function sc_4:LuaDispose()
  base.LuaDispose(self)
  LuaSkillCtrl:CloseCameraEffectFunction(7, nil)
  if self.effect1 ~= nil then
    self.effect1:Die()
    self.effect1 = nil
  end
  if self.effect2 ~= nil then
    self.effect2:Die()
    self.effect2 = nil
  end
  if self.effect3 ~= nil then
    self.effect3:Die()
    self.effect3 = nil
  end
end

return sc_4
