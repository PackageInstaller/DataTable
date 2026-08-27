local bs_107803 = class("bs_107803", LuaSkillBase)
local base = LuaSkillBase
bs_107803.config = {
  effectId_screen = 8,
  effectId_start = 107806,
  effectId_loop = 107807,
  effectId_fs_loop = 107820,
  buffid_stop = 107803,
  buffid_attack = 107805,
  audioIdStart = 107809,
  audioIdMovie = 107810,
  audioIdEnd = 107811
}

function bs_107803:ctor()
end

function bs_107803:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_107803", 1, self.BeforeEndBattle)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRealSummonerCaster, self.OnRealSummonerCaster)
  self.ultiTime = false
  self.effect = {}
  self.halo = nil
  self.RoleId = {}
end

function bs_107803:PlaySkill(data)
  self.ultiTime = true
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid_attack, 1, self.arglist[1])
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  self.effect1 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self)
  local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local j = 1
  for i = 0, playerList.Count - 1 do
    if playerList[i].roleDataId == 79 then
      self.effect[j] = LuaSkillCtrl:CallEffect(playerList[i], self.config.effectId_fs_loop, self)
      LuaSkillCtrl:CallBuff(self, playerList[i], self.config.buffid_attack, 1, self.arglist[1])
      j = j + 1
    end
  end
  LuaSkillCtrl:ShowCameraEffectFunctionWithPriority(self.config.effectId_screen, 160)
  self:LockUltSkill()
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    self.ultiTime = false
    LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
    if self.effect1 ~= nil then
      self.effect1:Die()
      self.effect1 = nil
    end
    for k, v in pairs(self.effect) do
      if v ~= nil then
        v:Die()
        self.effect[k] = nil
      end
    end
    if self.halo ~= nil then
      self.halo:EndAndDisposeEmission()
      self.halo = nil
    end
    local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    for i = 0, playerList.Count - 1 do
      if playerList[i].roleDataId == 79 then
        LuaSkillCtrl:DispelBuff(playerList[i], self.config.buffid_attack, 0)
      end
    end
    self:UnlockUltSkill()
  end, self, nil)
  self:CallCasterWait(5)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:StartTimer(nil, 3, attackTrigger, self, nil)
end

function bs_107803:OnAttackTrigger(data)
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  self.halo = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 2000, 0, 6, collisionEnter, nil, collisionExit, nil, false, false, nil, self.caster)
end

function bs_107803:OnCollisionEnter(collider, index, entity)
  if entity == nil or entity == self.caster or entity.roleDataId == 79 then
    return
  end
  if entity.hp > 0 then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffid_stop, 1, self.arglist[1])
  end
end

function bs_107803:OnCollisionExit(collider, entity)
  if entity ~= nil and entity.hp > 0 then
    LuaSkillCtrl:DispelBuff(entity, self.config.buffid_stop, 0)
  end
end

function bs_107803:OnRealSummonerCaster(role)
  if self.ultiTime == false then
    return
  end
  if role.roleDataId == 79 then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffid_attack, 1, self.arglist[1])
  end
end

function bs_107803:LockUltSkill()
  local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, playerList.Count - 1 do
    if playerList[i].roleType == 1 then
      LuaSkillCtrl:SetRoleUltSkillUseable(playerList[i].roleDataId, true)
      table.insert(self.RoleId, playerList[i].roleDataId)
    end
  end
end

function bs_107803:UnlockUltSkill()
  for i = 1, #self.RoleId do
    LuaSkillCtrl:SetRoleUltSkillUseable(self.RoleId[i], false)
  end
  if self.RoleId ~= nil then
    self.RoleId = {}
  end
end

function bs_107803:BeforeEndBattle()
  LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
  local playerList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, playerList.Count - 1 do
    if playerList[i] ~= self.caster and playerList[i].roleDataId ~= 79 then
      LuaSkillCtrl:DispelBuff(playerList[i], self.config.buffid_stop, 0, true)
    end
  end
end

function bs_107803:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_107803:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_107803:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_107803:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_107803:OnCasterDie()
  if self.effect1 ~= nil then
    self.effect1:Die()
    self.effect1 = nil
  end
  for k, v in pairs(self.effect) do
    if v ~= nil then
      v:Die()
      v = nil
    end
  end
  base.OnCasterDie(self)
end

function bs_107803:LuaDispose()
  LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
  self.effect1 = nil
  self.effect = nil
  self.halo = nil
  base.LuaDispose(self)
end

return bs_107803
