local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_1 = class("sc_1", StorySkillBase)
local base = StorySkillBase
sc_1.config = {
  target_battle_id = 1185039,
  AvgList = {33061031, 33061031},
  BossDataId = 30005,
  MainActorDataId = 1088,
  ActorPos = {1, 2},
  BossPos = {4, 2},
  model_res_name = "wisdom",
  DieEffectId = 12210
}
sc_1.config = setmetatable(sc_1.config, {
  __index = base.config
})

function sc_1:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_1:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  if LuaSkillCtrl:GetBattleRoomId() ~= self.config.target_battle_id then
    return
  end
  self.boss = self:GetRole(self.config.BossDataId)
  self.zhi = self:GetRole(self.config.MainActorDataId)
  self:SetUndead(self.boss)
  self:SetUndead(self.zhi)
  self:AddSetDeadHurtTrigger("sc_1", 1, self.OnSetDeadHurt, nil, self.boss, nil, nil, nil, nil, nil, nil, nil)
end

function sc_1:OnSetDeadHurt(context)
  self:RemoveSkillTrigger(eSkillTriggerType.SetDeadHurt)
  local afer_avg_cb = BindCallback(self, self.AfterAVG)
  LuaSkillCtrl:StartAvgWithPauseGame(nil, self.config.AvgList[2], afer_avg_cb)
end

function sc_1:AfterAVG()
  base.EnterMovieMode(self)
  local p_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = p_list.Count - 1, 0, -1 do
    if p_list[i].roleDataId ~= self.config.MainActorDataId then
      LuaSkillCtrl:SetRoleVisible(p_list[i])
    else
      self:MoveRoleToGrid(p_list[i], self.config.ActorPos[1], self.config.ActorPos[2])
    end
  end
  local e_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = e_list.Count - 1, 0, -1 do
    if e_list[i].roleDataId ~= self.config.BossDataId then
      LuaSkillCtrl:RemoveLife(9999, self, e_list[i], true, nil, false, false, nil, true)
    else
      self:MoveRoleToGrid(e_list[i], self.config.BossPos[1], self.config.BossPos[2])
    end
  end
  LuaSkillCtrl:StartTimer(nil, 15, function()
    LuaSkillCtrl:CallEffect(self.boss, self.config.DieEffectId, self, self.SkillEventFunc)
  end)
end

function sc_1:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallEffect(self.boss, 12118, self)
    LuaSkillCtrl:ChangeRoleBody(self.boss, self.config.model_res_name, 0)
    self:PlayDieAction(self.boss, 1)
    LuaSkillCtrl:StartTimer(nil, 60, function()
      LuaSkillCtrl:ForceEndBattle(true)
    end)
  end
end

function sc_1:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_1
