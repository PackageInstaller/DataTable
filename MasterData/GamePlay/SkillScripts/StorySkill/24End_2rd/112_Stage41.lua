local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_2 = class("sc_2", StorySkillBase)
local base = StorySkillBase
sc_2.config = {
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  effectId_throw = 10936,
  effectId_baozhao = 10866
}
sc_2.config = setmetatable(sc_2.config, {
  __index = base.config
})

function sc_2:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_2:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  local plist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if plist == nil or plist.Count < 1 then
    return
  end
  for i = 0, plist.Count - 1 do
    self:SetUndead(plist[i])
  end
  if self:isBattleRoom(1304122) then
    self:flow_end()
  else
    self:flow_normal()
  end
end

function sc_2:flow_normal()
  self:AddAfterPlaySkillTrigger("sc_2", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function sc_2:OnAfterPlaySkill()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList == nil or targetList.Count < 1 then
    return
  end
  for i = targetList.Count - 1, 0, -1 do
    LuaSkillCtrl:RemoveLife(targetList[i].maxHp // 2, self, targetList[i])
  end
end

function sc_2:flow_end()
  self:EnterMovieMode()
  local enemy1 = LuaSkillCtrl:GetRoleWithPos(0, 2)
  local enemy2 = LuaSkillCtrl:GetRoleWithPos(6, 2)
  LuaSkillCtrl:CallBuff(self, enemy1, 88, 1)
  LuaSkillCtrl:CallBuff(self, enemy2, 88, 1)
  self.pf = LuaSkillCtrl:GetRoleWithPos(3, 2)
  self:SetUndead(self.pf)
  LuaSkillCtrl:StartTimer(nil, 15, function()
    self:CastSummonerById(1, 1, 20)
    self:CastSummonerById(4, 1, 20)
    self:CastSummonerById(1, 3, 20)
    self:CastSummonerById(4, 1, 20)
  end)
  LuaSkillCtrl:StartTimer(nil, 35, function()
    self:CastSummonerById(1, 2, 23)
    self:CastSummonerById(5, 2, 23)
  end)
  LuaSkillCtrl:StartTimer(nil, 60, function()
    self:CastSummonerById(2, 0, 53)
    self:CastSummonerById(4, 0, 53)
    self:CastSummonerById(2, 4, 53)
    self:CastSummonerById(4, 4, 53)
  end)
  self.hurt_timer = LuaSkillCtrl:StartTimer(nil, 20, function()
    self:HurtCameraEffect()
  end, nil, -1)
  LuaSkillCtrl:StartTimer(nil, 90, function()
    LuaSkillCtrl:StartAvgWithPauseGame(nil, 59001302, BindCallback(self, self.end_perform))
  end)
end

function sc_2:end_perform()
  self:CloseHurtCameraEffect()
  if self.hurt_timer ~= nil then
    self.hurt_timer:Stop()
    self.hurt_timer = nil
  end
  LuaSkillCtrl:StartTimer(nil, 15, function()
    self:BreakAll_perform()
  end)
  LuaSkillCtrl:StartTimer(nil, 30, function()
    self:BreakAll_perform()
  end, nil, 5)
  LuaSkillCtrl:StartTimer(nil, 40, function()
    local enemy1 = LuaSkillCtrl:GetRoleWithPos(0, 2)
    local enemy2 = LuaSkillCtrl:GetRoleWithPos(6, 2)
    LuaSkillCtrl:DispelBuff(enemy1, 88, 0)
    LuaSkillCtrl:DispelBuff(enemy2, 88, 0)
    self:SetUndead(enemy1)
  end, nil)
  LuaSkillCtrl:StartTimer(nil, 90, function()
    local enemy1 = LuaSkillCtrl:GetRoleWithPos(0, 2)
    LuaSkillCtrl:DispelBuff(enemy1, 88, 0)
    self:DisableUndead(enemy1)
  end, nil)
  LuaSkillCtrl:StartTimer(nil, 15, function()
    local grid = LuaSkillCtrl:GetTargetWithGrid(self.pf.x, self.pf.y)
    LuaSkillCtrl:CallEffect(grid, 12212, self)
  end)
  LuaSkillCtrl:StartTimer(nil, 47, function()
    LuaSkillCtrl:CallStartLocalScale(self.pf, Vector3.New(0, 0, 0), 0.1)
  end)
  LuaSkillCtrl:StartTimer(nil, 150, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function sc_2:CastSummonerById(x, y, id)
  local role = self.pf
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

function sc_2:BreakAll_perform()
  local break_grid = {
    {1, 1},
    {4, 1},
    {1, 3},
    {4, 3},
    {2, 4},
    {0, 0},
    {6, 0},
    {6, 4}
  }
  local point = LuaSkillCtrl:CallRange(1, #break_grid)
  local coord = break_grid[point]
  local target = LuaSkillCtrl:GetTargetWithGrid(coord[1], coord[2])
  local effect = LuaSkillCtrl:CallEffect(target, self.config.effectId_baozhao, self)
  LuaSkillCtrl:CallEffectDoScale(effect, 1.0 + LuaSkillCtrl:CallRange(0, 1), 0.2)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
  if 0 < skillResult.roleList.Count then
    self:ShakeCamera()
    for i = 0, skillResult.roleList.Count - 1 do
      AudioManager:PlayAudioById(213310)
      local damage = skillResult.roleList[i].maxHp
      LuaSkillCtrl:RemoveLife(damage, self, skillResult.roleList[i], true, nil, true, true)
    end
  end
end

function sc_2:OnCasterDie()
  self:CloseHurtCameraEffect()
  base.OnCasterDie(self)
end

return sc_2
