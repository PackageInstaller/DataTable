local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_1 = class("sc_1", StorySkillBase)
local base = StorySkillBase
sc_1.config = {
  AvgList = {33061031},
  model_res_name = "wisdom",
  target_battle_id = 1200224,
  role_data_id = 109001,
  effect_Id = 109012,
  effect_impact_ID = 13001,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 2
  }
}
sc_1.config = setmetatable(sc_1.config, {
  __index = base.config
})

function sc_1:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_1:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  if LuaSkillCtrl:GetBattleRoomId() ~= self.config.target_battle_id and LuaSkillCtrl:GetBattleRoomId() ~= self.config.target_battle_id + 90000 then
    return
  end
  self:StoryFlow1()
end

function sc_1:StoryFlow1()
  self:EnterMovieMode()
  self:MakeAllWallDamagable()
  self:StartCameraShow()
  LuaSkillCtrl:StartTimer(nil, 30, function()
    self:StoryFlow2()
  end)
end

function sc_1:StartCameraShow()
  self.strength = 0.1
  self.timer = LuaSkillCtrl:StartTimer(nil, 15, function()
    LuaSkillCtrl:ShowCameraEffectFunction(3, self.strength)
    self.strength = self.strength + 0.3
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 1 + self.strength, 50)
  end, nil, -1, 15)
end

function sc_1:StoryFlow2()
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
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
  local target_role = LuaSkillCtrl:GetRoleWithPos(3, 2)
  if target_role ~= nil then
    LuaSkillCtrl:RemoveLife(999999, self, target_role)
  end
  self.suer = nil
  LuaSkillCtrl:StartTimer(nil, 7, function()
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 4, 50)
    local grid_target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
    self.effect1 = LuaSkillCtrl:CallEffect(grid_target, 12212, self)
    self.grid = LuaSkillCtrl:GetTargetWithGrid(3, 4)
    self.suer = self:CastSummoner(3, 2, self.config.role_data_id, eBattleRoleBelong.enemy, attr_table)
    self:StopRole(self.suer)
    self.suer:LookAtTarget(self.grid)
    LuaSkillCtrl:CallStartLocalScale(self.suer, Vector3(1.3, 1.3, 1.3), 0.3)
  end)
  LuaSkillCtrl:StartTimer(nil, 30, function()
    local enemy_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    if enemy_list ~= nil and enemy_list.Count > 1 then
      for i = enemy_list.Count - 1, 0, -1 do
        if enemy_list[i] ~= self.suer then
          LuaSkillCtrl:RemoveLife(enemy_list[i].maxHp + 1, self, enemy_list[i])
        end
      end
    end
    if self.effect1 ~= nil then
      self.effect1:Die()
      self.effect1 = nil
    end
  end)
  LuaSkillCtrl:StartTimer(nil, 75, self.End)
end

function sc_1:End()
  LuaSkillCtrl:ForceEndBattle(true)
end

function sc_1:LuaDispose()
  base.LuaDispose(self)
  LuaSkillCtrl:CloseCameraEffectFunction(3, true)
end

function sc_1:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:CloseCameraEffectFunction(3, true)
end

return sc_1
