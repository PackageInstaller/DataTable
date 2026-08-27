local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_2 = class("sc_2", StorySkillBase)
local base = StorySkillBase
sc_2.config = {timeDuration = 15, role_data_id = 32}
sc_2.config = setmetatable(sc_2.config, {
  __index = base.config
})

function sc_2:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.timeValue = 450
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.timeValue, timeCallBack)
end

function sc_2:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self.sp_suer = self:GetRole(9011090)
  self.pasika = self:GetRole(1071)
  self:SetUndead(self.pasika)
  self:SetUndead(self.sp_suer)
  self.flag1 = true
  self.flag2 = false
  self.stop_flag = false
  self:AddAfterPlaySkillTrigger("sc_2", 1, self.OnAfterPlaySkill, self.sp_suer, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function sc_2:OnAfterPlaySkill(skill, role)
  if self.stop_flag then
    return
  end
  if self.flag1 and not self.flag2 then
    local random_grid = LuaSkillCtrl:FindEmptyGrid()
    if self.move_timer == nil then
      self.move_timer = LuaSkillCtrl:StartTimer(nil, 30, function()
        self:MoveRoleToGrid(self.pasika, random_grid.x, random_grid.y, function()
          self.flag = false
          if self.move_timer ~= nil then
            self.move_timer:Stop()
            self.move_timer = nil
          end
        end)
      end)
    end
  end
  if self.flag2 then
    LuaSkillCtrl:CallBuff(self, self.pasika, 66, 1, 30)
    LuaSkillCtrl:RemoveLife(role.maxHp // 5, self, role)
  end
end

function sc_2:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = math.max(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function sc_2:TimeUp()
  self:StoryFlow1()
  self.flag2 = true
end

function sc_2:StoryFlow1()
  self:SwitchSpeedMode(1.0)
  LuaSkillCtrl:RemoveLife(self.pasika.maxHp + 1, self, self.pasika)
  local grid_target = LuaSkillCtrl:GetTargetWithGrid(self.pasika.x, self.sp_suer.y)
  self.effect_ult = LuaSkillCtrl:CallEffect(grid_target, 12073, self)
  LuaSkillCtrl:DispelBuff(self.sp_suer, 66, 0)
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 4, 50)
  LuaSkillCtrl:CallBuff(self, self.pasika, 66, 1)
  self.stop_flag = true
  if self.move_timer ~= nil then
    self.move_timer:Stop()
    self.move_timer = nil
  end
  LuaSkillCtrl:StartTimer(nil, 15, function()
    LuaSkillCtrl:CallHeal(self.sp_suer.maxHp // 4, self, self.sp_suer)
  end, nil, 4)
  LuaSkillCtrl:StartTimer(self, 60, BindCallback(self, self.StoryFlow2))
end

function sc_2:StoryFlow2()
  LuaSkillCtrl:StartAvgWithPauseGame(nil, 59001101, BindCallback(self, self.StoryFlow3))
end

function sc_2:StoryFlow3()
  self.stop_flag = true
  self:StopRole(self.pasika)
  self:StopRole(self.suer)
  local attr_table = {
    maxHp = 10000,
    pow = 1000,
    skill_intensity = 1000,
    speed = 0,
    def = 0,
    crit = 0,
    critDamage = 0,
    sunder = 0,
    magic_res = 0,
    magic_pen = 0
  }
  self.suer = self:CastSummoner(3, 2, self.config.role_data_id, eBattleRoleBelong.player, attr_table)
  local grid_target = LuaSkillCtrl:GetTargetWithGrid(self.suer.x, self.suer.y)
  self.effect1 = LuaSkillCtrl:CallEffect(grid_target, 12212, self)
  LuaSkillCtrl:CallBuff(self, self.sp_suer, 2250, 1, 7, false, self.suer)
  LuaSkillCtrl:CallBuff(self, self.sp_suer, 66, 1, nil)
  self:EnterMovieMode()
  self:MoveRoleToGrid(self.pasika, self.suer.x - 2, self.suer.y)
  self:MoveRoleToGrid(self.sp_suer, self.suer.x + 2, self.suer.y)
  LuaSkillCtrl:StartTimer(nil, 15, function()
    local grid_table = {
      {2, 0},
      {1, 1},
      {2, 1},
      {2, 2},
      {1, 3},
      {2, 3},
      {2, 4}
    }
    for k, v in ipairs(grid_table) do
      self:CastSummoner(v[1], v[2], 73, eBattleRoleBelong.neutral, attr_table)
    end
  end)
  LuaSkillCtrl:StartTimer(nil, 45, function()
    if LuaSkillCtrl.IsInVerify == false then
      LuaSkillCtrl.cUltSkillCtrl.m_moviePlayer:PlayVideo("UltSkill/ultskill1003")
    end
  end)
  LuaSkillCtrl:StartTimer(nil, 30, function()
    if self.effect1 ~= nil then
      self.effect1:Die()
      self.effect1 = nil
    end
    self:MoveRoleToGrid(self.suer, self.suer.x + 1, self.suer.y)
    LuaSkillCtrl:CallStartLocalScale(self.suer, Vector3(0, 0, 0), 0.3)
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 4, 50)
  end)
  LuaSkillCtrl:StartTimer(nil, 90, function()
    LuaSkillCtrl:RemoveLife(99999, self, self.sp_suer)
    LuaSkillCtrl:CallStartLocalScale(self.suer, Vector3(1, 1, 1), 0.8)
    local grid_tagert = LuaSkillCtrl:GetTargetWithGrid(self.suer.x, self.suer.y)
    LuaSkillCtrl:CallEffect(grid_tagert, self.config.effectId_down, self)
  end)
  LuaSkillCtrl:StartTimer(nil, 90, function()
    local grid_target = LuaSkillCtrl:GetTargetWithGrid(self.sp_suer.x, self.sp_suer.y)
    self.effect_ult = LuaSkillCtrl:CallEffect(grid_target, 12073, self)
    self:DisableUndead(self.sp_suer)
  end)
  LuaSkillCtrl:StartTimer(nil, 105, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function sc_2:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_2
