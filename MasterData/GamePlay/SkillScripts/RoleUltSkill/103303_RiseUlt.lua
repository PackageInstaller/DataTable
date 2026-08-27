local bs_103303 = class("bs_103303", LuaSkillBase)
local base = LuaSkillBase
bs_103303.config = {
  buffID_jihuo = 103303,
  buffID_Atk = 103306,
  buffID_Int = 103308,
  buffID_beijihuo = 103307,
  effectID_Map = 103310,
  effectID_Map_s = 103313,
  effect_speed = 1,
  effectID_SelectGrid = 103312,
  effectID_SelectRole = 103311,
  selectTargetId = 6,
  buffId = 3014,
  audioIdStart = 103305,
  audioIdMovie = 103306,
  audioIdEnd = 103307
}

function bs_103303:ctor()
end

function bs_103303:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_103303_1", 10, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_103303_2", 10, self.OnBuffDie)
  self.MapBorder = LuaSkillCtrl:GetMapBorder()
  self.GridEffect = nil
  if LuaSkillCtrl.IsInTDBattle and LuaSkillCtrl.cluaSkillCtrl ~= nil then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1, true, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_103303:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  local targetGrid = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  if self.MapBorder.x == 7 then
    LuaSkillCtrl:CallEffect(effectTarget, self.config.effectID_Map, self, nil, nil, self.config.effect_speed)
  else
    LuaSkillCtrl:CallEffect(effectTarget, self.config.effectID_Map_s, self, nil, nil, self.config.effect_speed)
  end
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputTarget)
    LuaSkillCtrl:StartTimer(nil, 7, function()
      self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
    end)
  end
end

function bs_103303:CallSelectExecute(role)
  self.target_skill = role
  LuaSkillCtrl:CallBuff(self, role, self.config.buffID_beijihuo, 1, self.arglist[1], true)
  local targets = LuaSkillCtrl:CallTargetSelect(self, self.config.selectTargetId, 10)
  if targets ~= nil and targets.Count > 0 then
    for i = 0, targets.Count - 1 do
      local playerRole = targets[i].targetRole
      LuaSkillCtrl:CallEffect(role, self.config.effectID_SelectRole, self)
      LuaSkillCtrl:CallBuff(self, playerRole, self.config.buffID_jihuo, 1, self.arglist[1], false, role)
      self.jihuo_time = true
    end
  end
end

function bs_103303:OnRoleDie(killer, role)
  if role == self.target_skill and role.hp == 0 and role ~= nil and self.jihuo_time == true then
    local targets = LuaSkillCtrl:CallTargetSelect(self, self.config.selectTargetId, 10)
    if targets ~= nil and 0 < targets.Count then
      for i = 0, targets.Count - 1 do
        local playerRole = targets[i].targetRole
        local AtkNum = role.pow * self.arglist[2] // 1000
        local IntNum = role.skill_intensity * self.arglist[2] // 1000
        LuaSkillCtrl:CallBuff(self, playerRole, self.config.buffID_Atk, AtkNum, nil, true)
        LuaSkillCtrl:CallBuff(self, playerRole, self.config.buffID_Int, IntNum, nil, true)
      end
    end
  end
end

function bs_103303:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffID_jihuo then
    self.jihuo_time = false
  end
end

function bs_103303:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_103303:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_103303:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_103303:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_103303:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103303
