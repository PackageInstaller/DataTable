local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_107 = class("sc_107", StorySkillBase)
local base = StorySkillBase
sc_107.config = {
  buff = 2305,
  avgId = 59001262,
  trans_list = {
    {20041, 50010},
    {20088, 50011},
    {20089, 50012},
    {20091, 50013},
    {20084, 50014},
    {1001042, 50015}
  }
}
sc_107.config = setmetatable(sc_107.config, {
  __index = base.config
})

function sc_107:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_107:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self.pasika = self:GetRole(1071)
  if self.pasika == nil or self.pasika.belongNum ~= eBattleRoleBelong.player then
    return
  end
  if not self:isBattleRoom(1303404) then
    self:flow1()
  else
    self:flow2()
  end
end

function sc_107:flow1()
  self:AddSetDeadHurtTrigger("sc_107_1", 900, self.OnSetDeadHurt, nil, self.pasika)
  LuaSkillCtrl:CallBuff(self, self.pasika, self.config.buff, 10)
  self.flag_tip = false
  local target = self:GetRole(1071)
  if target == nil then
    return
  end
  local damage = target.maxHp * 100 // 1000
  if damage >= target.hp then
    damage = target.hp - 1
  end
  LuaSkillCtrl:RemoveLife(target.maxHp * 100 // 1000, self, target, nil, nil, true, nil, eHurtType.RealDmg, true)
end

function sc_107:flow2()
  self:AddSetHurtTrigger("sc_107_2", 1, self.OnSetHurt, self.pasika)
  self.enemy_caster = LuaSkillCtrl:GetRoleWithPos(6, 2)
  self:SetUndead(self.enemy_caster)
  LuaSkillCtrl:DispelBuff(self.enemy_caster, 196, 0)
  LuaSkillCtrl:CallBuff(self, self.enemy_caster, 175, 1)
  LuaSkillCtrl:StartTimer(nil, 30, function()
    self:CastSummonerById(4, 1, 50010)
    self:CastSummonerById(4, 3, 50010)
  end)
  LuaSkillCtrl:StartTimer(nil, 60, function()
    self:CastSummonerById(4, 1, 50010)
    self:CastSummonerById(4, 2, 50010)
  end)
  local cb = BindCallback(self, self.flow2_1)
  LuaSkillCtrl:StartTimer(nil, 150, cb)
end

function sc_107:flow2_1()
  LuaSkillCtrl:StartTimer(nil, 15, function()
    self:CastSummonerById(4, 1, 50010)
    self:CastSummonerById(4, 3, 50010)
  end)
  LuaSkillCtrl:StartTimer(nil, 45, function()
    self:CastSummonerById(4, 1, 50010)
    self:CastSummonerById(4, 3, 50010)
    self:CastSummonerById(5, 2, 50010)
  end)
  LuaSkillCtrl:StartTimer(nil, 80, function()
    self:CastSummonerById(4, 1, 50010)
    self:CastSummonerById(4, 3, 50010)
    self:CastSummonerById(5, 2, 50010)
  end)
  LuaSkillCtrl:StartTimer(nil, 135, BindCallback(self, self.flow2_2))
end

function sc_107:flow2_2()
  self.call_timer = LuaSkillCtrl:StartTimer(nil, 30, function()
    self:CastSummonerById(4, 1, 50012)
    self:CastSummonerById(4, 3, 50012)
    self:CastSummonerById(5, 2, 50012)
  end, nil, -1)
  LuaSkillCtrl:StartTimer(nil, 100, function()
    if self.call_timer ~= nil then
      self.call_timer:Stop()
      self.call_timer = nil
    end
    LuaSkillCtrl:CallBuff(self, self.pasika, 66, 1)
    local targetGrids = LuaSkillCtrl:FindEmptyGridsWithinRange(self.pasika.x, self.pasika.y, 1)
    if targetGrids ~= nil and targetGrids.Count > 0 then
      for i = 0, targetGrids.Count - 1 do
        self:CastSummonerById(targetGrids[i].x, targetGrids[i].y, 50010)
      end
    end
    LuaSkillCtrl:StartTimer(nil, 15, function()
      local targetGrids = LuaSkillCtrl:FindEmptyGridsWithinRange(self.pasika.x, self.pasika.y, 2)
      if targetGrids ~= nil and targetGrids.Count > 0 then
        for i = 0, targetGrids.Count - 1 do
          self:CastSummonerById(targetGrids[i].x, targetGrids[i].y, 50010)
        end
      end
    end)
    self.timer_hurt = LuaSkillCtrl:StartTimer(nil, 15, function()
      self:HurtCameraEffect()
    end, nil, -1)
    LuaSkillCtrl:StartTimer(nil, 75, function()
      if self.timer_hurt ~= nil then
        self.timer_hurt:Stop()
        self.timer_hurt = nil
      end
      local cb = BindCallback(self, self.flow_3)
      LuaSkillCtrl:StartAvgWithPauseGame(nil, self.config.avgId, cb)
    end)
  end)
end

function sc_107:flow_3()
  LuaSkillCtrl:DispelBuff(self.pasika, 66, 0)
  self:EnterMovieMode()
  LuaSkillCtrl:CallEffect(self.pasika, 13102, self)
  LuaSkillCtrl:StartTimer(nil, 7, function()
    LuaSkillCtrl:ChangeRoleBody(self.pasika, "persicaria_species_entropy")
  end)
  LuaSkillCtrl:DispelBuff(self.enemy_caster, 175, 0)
  local targetGrid = LuaSkillCtrl:GetTargetWithGrid(self.pasika.x, self.pasika.y)
  local targetRoles = LuaSkillCtrl:FindAllRolesWithinRange(self.pasika, 1, false)
  for i = 0, targetRoles.Count - 1 do
    local role = targetRoles[i]
    if role ~= nil and role.belongNum == eBattleRoleBelong.enemy then
      self:CroodeRole(role, 50013)
    end
  end
  LuaSkillCtrl:StartTimer(nil, 30, function()
    local targetRoles = LuaSkillCtrl:FindAllRolesWithinRange(self.pasika, 2, false)
    for i = 0, targetRoles.Count - 1 do
      local role = targetRoles[i]
      if role ~= nil and role.belongNum == eBattleRoleBelong.enemy then
        self:CroodeRole(role, 50012)
      end
    end
  end)
  LuaSkillCtrl:StartTimer(nil, 60, function()
    self:ShakeCamera()
    local elist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    for i = 0, elist.Count - 1 do
      if elist[i] ~= self.enemy_caster then
        self:CroodeRole(elist[i], 50010)
      end
    end
  end)
  LuaSkillCtrl:StartTimer(nil, 140, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function sc_107:isContain(table, element)
  for k, v in ipairs(table) do
    if element == v then
      return k
    end
  end
  return -1
end

function sc_107:randomCastSummnoner(x, y)
  local rand = LuaSkillCtrl:CallRange(0, 5)
  local summnoner_id = 50010 + rand
  self:CastSummonerById(x, y, summnoner_id)
end

function sc_107:CastSummonerById(x, y, id)
  local role = self.pasika
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
  self:CastSummoner(x, y, id, eBattleRoleBelong.enemy, attr_table)
end

function sc_107:pasika_call(x, y, id)
  local role = self.pasika
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
  local entity = self:CastSummoner(x, y, id, eBattleRoleBelong.player, attr_table)
  LuaSkillCtrl:CallEffect(entity, 12118, self)
end

function sc_107:OnSetHurt(context)
  context.hurt = context.target.maxHp // 2
end

function sc_107:OnSetDeadHurt(context)
  if not self.flag_tip then
    self.flag_tip = true
    LuaSkillCtrl:CallPlayEpTipDialogInBattle(12341)
  end
  LuaSkillCtrl:CallHeal(self.pasika.maxHp // 2, self, self.pasika)
end

function sc_107:CroodeRole(role, override_id)
  if role == nil then
    return
  end
  local grid_target = LuaSkillCtrl:GetTargetWithGrid(role.x, role.y)
  LuaSkillCtrl:CallEffect(role, 12048, self)
  LuaSkillCtrl:CallBuff(self, role, 66, 1, nil)
  LuaSkillCtrl:CallBuff(self, role, 88, 1, nil)
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
  LuaSkillCtrl:StartTimer(nil, 15, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 5)
    LuaSkillCtrl:DispelBuff(role, 66, 0)
    LuaSkillCtrl:DispelBuff(role, 88, 0)
    LuaSkillCtrl:CallEffect(grid_target, 12118, self)
    self:DisableUndead(role)
    LuaSkillCtrl:RemoveLife(role.maxHp + 1, self, role, true)
  end)
  LuaSkillCtrl:StartTimer(nil, 30, function()
    local transId2 = self:GetSummnonerId(role.roleDataId)
    if override_id ~= nil then
      transId2 = override_id
    end
    local temp = self:CastSummoner(x, y, transId2, eBattleRoleBelong.player, attr_table)
    self:StopRole(temp)
  end)
end

function sc_107:GetSummnonerId(Id)
  for _, v in ipairs(self.config.trans_list) do
    if v[1] == Id then
      return v[2]
    end
  end
  return 50012
end

function sc_107:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:CloseCameraEffectFunction(3, true)
  LuaSkillCtrl:CloseCameraEffectFunction(7, nil)
end

function sc_107:LuaDispose()
  base.LuaDispose(self)
  LuaSkillCtrl:CloseCameraEffectFunction(3, true)
  LuaSkillCtrl:CloseCameraEffectFunction(7, nil)
end

return sc_107
