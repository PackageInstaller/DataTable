local StorySkillBase = class("StorySkillBase", LuaSkillBase)
local base = LuaSkillBase
StorySkillBase.config = {
  effectId_up = 501101,
  effectId_down = 501102,
  buff_unCommonATK = 2172,
  buff_unAutoSkill = 2173,
  buff_unULTSKill = 2174,
  buff_unMove = 2175,
  buff_xuan_yun = 2176,
  buff_undead = 3009,
  buff_unselect = 69,
  attr_table = {
    maxHp = 1000,
    pow = 600,
    skill_intensity = 600,
    speed = 0,
    def = 1,
    crit = 100,
    critDamage = 2000,
    sunder = 100,
    magic_res = 300,
    magic_pen = 400
  },
  enable_roomList = {}
}

function StorySkillBase:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "StorySkillBase", 1, self.OnAfterBattleStart)
  self.storyCampRoles = {}
  self.HurtEffectFlag = false
  self.HurtEffect = false
end

function StorySkillBase:OnAfterBattleStart()
  if not self:isEnableBattleRoomQuick() then
    return
  end
end

function StorySkillBase:isEnableBattleRoom()
  local roomId = LuaSkillCtrl:GetBattleRoomId()
  if #self.config.enable_roomList < 1 then
    return true
  end
  for _, id in ipairs(self.config.enable_roomList) do
    if roomId == id then
      return true
    end
  end
  return false
end

function StorySkillBase:isEnableBattleRoomWithRule(ruleFunc)
  local roomId = LuaSkillCtrl:GetBattleRoomId()
  local targetList = {}
  for _, id in ipairs(self.config.enable_roomList) do
    local new_id = ruleFunc(id)
    table.insert(targetList, id)
    table.insert(targetList, new_id)
  end
  if #self.config.enable_roomList < 1 then
    return true
  end
  for _, id in ipairs(targetList) do
    if roomId == id then
      return true
    end
  end
  return false
end

function StorySkillBase:isEnableBattleRoomQuick()
  local function cb(id)
    return id + 90000
  end
  
  return self:isEnableBattleRoomWithRule(cb)
end

function StorySkillBase:isBattleRoom(id)
  local temp = LuaSkillCtrl:GetBattleRoomId()
  if temp == id or temp == id + 90000 then
    return true
  else
    return false
  end
end

function StorySkillBase:MakeAllWallDamagable()
  local role_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if role_list == nil or role_list.Count < 1 then
    return
  end
  for i = 0, role_list.Count - 1 do
    LuaSkillCtrl:DispelBuff(role_list[i], 188, 0, true)
    LuaSkillCtrl:DispelBuff(role_list[i], 88, 0, true)
    LuaSkillCtrl:DispelBuff(role_list[i], 175, 0, true)
  end
end

function StorySkillBase:EnterMovieMode()
  self:SwitchSpeedMode(1.0)
  if not LuaSkillCtrl.IsInVerify then
    self.win = UIManager:ShowWindow(UIWindowTypeID.Battle)
    if self.win ~= nil then
      self.win:SetUltAuto(false)
    end
  end
  local costurlnum = 0 - LuaSkillCtrl:GetUltHMp()
  LuaSkillCtrl:CallAddPlayerHmp(costurlnum)
  if self.timer_HMP ~= nil then
    self.timer_HMP:Stop()
    self.timer_HMP = nil
  end
  local pList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, pList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, pList[i], self.config.buff_xuan_yun, 1, nil, false, nil, false)
  end
  local pList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, pList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, pList[i], self.config.buff_xuan_yun, 1, nil, false, nil, false)
  end
end

function StorySkillBase:ExitMovieMode()
end

function StorySkillBase:SetUnselect(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buff_unselect, 1, nil, false, nil, false)
end

function StorySkillBase:DisableUnselect(role)
  LuaSkillCtrl:DispelBuff(role, self.config.buff_unselect, 0, true, true)
end

function StorySkillBase:SetUndead(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buff_undead, 1, nil, false, nil, false)
end

function StorySkillBase:DisableUndead(role)
  LuaSkillCtrl:DispelBuff(role, self.config.buff_undead, 0, true, true)
end

function StorySkillBase:StopRole(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buff_xuan_yun, 1, nil, false, nil, false)
end

function StorySkillBase:DisableStopRole(role)
  LuaSkillCtrl:DispelBuff(role, self.config.buff_xuan_yun, 0, true, true)
end

function StorySkillBase:SetUnMove(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buff_unMove, 1, nil, false, nil, false)
end

function StorySkillBase:DisableUnMove(role)
  LuaSkillCtrl:DispelBuff(role, self.config.buff_unMove, 0, true, true)
end

function StorySkillBase:SwitchSpeedMode(speed)
  if LuaSkillCtrl.IsInVerify then
    return
  end
  self.uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
  if self.uiBattle ~= nil then
    self.uiBattle:OnSpeedUpChange(speed)
  end
end

function StorySkillBase:Wait(time)
end

function StorySkillBase:ChangeModelScale(role, scale, duration)
  LuaSkillCtrl:CallStartLocalScale(role, Vector3.New(scale, scale, scale), duration)
end

function StorySkillBase:MoveRoleToGrid(role, x, y, cb)
  local grid_role = LuaSkillCtrl:GetRoleWithPos(x, y)
  if grid_role ~= nil and grid_role ~= role then
    local temp_grid = LuaSkillCtrl:FindEmptyGrid(function(x1, y1)
      return x1 ~= x or y1 ~= y
    end)
    if temp_grid == nil then
      return
    end
    LuaSkillCtrl:SetRolePos(temp_grid, role, true)
  end
  local grid_target = LuaSkillCtrl:GetTargetWithGrid(x, y)
  local target_grid = LuaSkillCtrl:GetGridWithPos(x, y)
  LuaSkillCtrl:CallEffect(role, self.config.effectId_up, self)
  LuaSkillCtrl:StartTimer(nil, 7, function()
    if role == nil then
      return
    end
    role.lsObject:ResetBeatBack()
    local lastCoordX = role.x
    local lastCoordY = role.y
    LuaSkillCtrl.cluaSkillCtrl:SetPosForce(target_grid, role)
    LuaSkillCtrl:CallEffect(grid_target, self.config.effectId_down, self)
    if cb ~= nil then
      cb()
    end
  end)
end

function StorySkillBase:PlayAudioById(Id)
  if LuaSkillCtrl.IsInVerify then
    return
  end
  self.audio = AudioManager:PlayAudioById(Id)
end

function StorySkillBase:PlayDieAction(role, speed)
  LuaSkillCtrl:CallRoleAction(role, 1058, speed)
  self:StopRole(role)
  self:SetUnselect(role)
end

function StorySkillBase:GetRole(roleDataId)
  local role
  local p_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = p_list.Count - 1, 0, -1 do
    if p_list[i].roleDataId == roleDataId then
      return p_list[i]
    end
  end
  local e_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = e_list.Count - 1, 0, -1 do
    if e_list[i].roleDataId == roleDataId then
      return e_list[i]
    end
  end
  return nil
end

function StorySkillBase:CastSummoner(x, y, summonerId, belongNum, attr_table)
  local attr
  if attr_table == nil then
    attr = self.config.attr_table
  else
    attr = attr_table
  end
  local isEmpty = LuaSkillCtrl:GetRoleWithPos(x, y)
  local grid_x = x
  local grid_y = y
  if isEmpty ~= nil then
    local grid = LuaSkillCtrl:FindEmptyGrid()
    grid_x, grid_y = grid.x, grid.y
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, summonerId, grid_x, grid_y, belongNum)
  for key, value in pairs(attr) do
    summoner:SetAttr(eHeroAttr[key], value)
  end
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_down, self)
  return summonerEntity
end

function StorySkillBase:CastSummonerDirect(x, y, summonerId, belongNum, attr_table)
  local attr
  if attr_table == nil then
    attr = self.config.attr_table
  else
    attr = attr_table
  end
  local isEmpty = LuaSkillCtrl:GetRoleWithPos(x, y)
  local grid_x = x
  local grid_y = y
  if isEmpty ~= nil then
    return
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, summonerId, grid_x, grid_y, belongNum)
  for key, value in pairs(attr) do
    summoner:SetAttr(eHeroAttr[key], value)
  end
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:CallEffect(summonerEntity, self.config.effectId_down, self)
  return summonerEntity
end

function StorySkillBase:MakeTagRoles()
  local temp = {}
  local p_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local e_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, p_list.Count - 1 do
    local role_tag = LuaSkillCtrl:GetRoleTag(p_list[i])
    if temp[role_tag] == nil then
      temp[role_tag] = {}
    end
    table.insert(temp[role_tag], 1, p_list[i])
  end
  for i = 0, e_list.Count - 1 do
    local role_tag = LuaSkillCtrl:GetRoleTag(e_list[i])
    if temp[role_tag] == nil then
      temp[role_tag] = {}
    end
    table.insert(temp[role_tag], 1, e_list[i])
  end
  self.storyCampRoles = temp
  return self.storyCampRoles
end

function StorySkillBase:ControlMove(role, x, y, onfinish)
  self:DisableUnMove(role)
  
  local function onfinish()
    LuaSkillCtrl:StartTimer(nil, 1, function()
      self:SetUnMove(role)
    end)
  end
  
  LuaSkillCtrl:MoveRoleToTarget()
end

function StorySkillBase:ShakeCamera(arg)
  if arg == nil then
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 3, 50)
  end
end

function StorySkillBase:HurtCameraEffect()
  self.HurtEffect = true
  if self.HurtEffectFlag then
    LuaSkillCtrl:ShowCameraEffectFunction(7, 0.01)
    self.HurtEffectFlag = not self.HurtEffectFlag
  else
    self:ShakeCamera()
    LuaSkillCtrl:ShowCameraEffectFunction(7, 0.4)
    self.HurtEffectFlag = not self.HurtEffectFlag
  end
end

function StorySkillBase:CloseHurtCameraEffect()
  LuaSkillCtrl:CloseCameraEffectFunction(7, nil)
end

function StorySkillBase:OnCasterDie()
  base.OnCasterDie(self)
  if self.HurtEffect then
    self:CloseHurtCameraEffect()
  end
end

return StorySkillBase
