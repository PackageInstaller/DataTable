local bs_107203 = class("bs_107203", LuaSkillBase)
local base = LuaSkillBase
bs_107203.config = {
  buffId = 107101,
  buffId_bati = 196,
  buffId_Botbati = 107202,
  buff_lock = 107201,
  buff_invisibility = 107203,
  time_buff = 120,
  resName = "xinghuan_jijia",
  resID = 1972,
  resID_newyear = 1973,
  skin_newyear = 307203,
  resName_newyear = "xinghuan_newyear_jijia",
  resName_idol = "xinghuan_idol_jijia",
  resID_idol = 1974,
  skin_idol = 307204,
  effectId_cast1 = 107209,
  effectId_cast2 = 107210,
  effectId_casthit1 = 107206,
  effectId_casthit2 = 107208,
  effectId_jump_on = 107211,
  effectId_jump_off = 107213,
  move_audio = 212305,
  action_changeback = 1020,
  summonerId = 72,
  audioIdStart = 107207,
  audioIdMovie = 107208,
  audioIdEnd = 107209
}

function bs_107203:ctor()
end

function bs_107203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_107203_1", 1, self.BeforeEndBattle)
  self.caster.recordTable.changebody = false
  self:AddLuaTrigger(eSkillLuaTrigger.OnPlayArmorChange, self.OnPlayArmorChange, self)
end

function bs_107203:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnPlayArmorChange, self.arglist[4] + self.caster.recordTable.exChangeTimes)
  local enemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if enemyList.Count > 0 then
    for i = 0, enemyList.Count - 1 do
      local role = enemyList[i].targetRole
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.arglist[1], self.config.time_buff)
      LuaSkillCtrl:CallEffect(role, self.config.effectId_casthit2, self)
    end
  end
  local shieldValue = self.caster.skill_intensity * self.arglist[2] // 1000
  if 0 < shieldValue then
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
  end
end

function bs_107203:OnPlayArmorChange(times)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_lock, 1, times + 13)
  local changeback = BindCallback(self, self.changeback)
  self:CallCasterWait(13)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast1, self)
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == self.config.skin_newyear then
    LuaSkillCtrl:ChangeRoleBody(self.caster, self.config.resName_newyear, self.caster.moveSpeed, self.config.resID_newyear)
  elseif LuaSkillCtrl:GetCasterSkinId(self.caster) == self.config.skin_idol then
    LuaSkillCtrl:ChangeRoleBody(self.caster, self.config.resName_idol, self.caster.moveSpeed, self.config.resID_idol)
  else
    LuaSkillCtrl:ChangeRoleBody(self.caster, self.config.resName, self.caster.moveSpeed, self.config.resID)
  end
  self.caster.recordTable.changebody = true
  LuaSkillCtrl:SetGameObjectActive(self.caster.lsObject, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Botbati, 1, times)
  self.changebacktimer = LuaSkillCtrl:StartTimer(nil, times, changeback, nil, 0, 0)
end

function bs_107203:changeback()
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local grid_boom = LuaSkillCtrl:GetGridWithRole(self.caster)
  local Targetgrid = LuaSkillCtrl:GetTargetWithGrid(grid_boom.x, grid_boom.y)
  LuaSkillCtrl:SetGameObjectActive(self.caster.lsObject, false)
  LuaSkillCtrl:CallEffect(Targetgrid, self.config.effectId_cast2, self)
  local enemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if enemyList.Count > 0 then
    for i = 0, enemyList.Count - 1 do
      local role = enemyList[i].targetRole
      if role ~= self.caster then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.arglist[3], self.config.time_buff)
        LuaSkillCtrl:CallEffect(role, self.config.effectId_casthit2, self)
      end
    end
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_lock, 1, 15, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_invisibility, 1, 15, true)
  self:CallCasterWait(15)
  LuaSkillCtrl:StartTimer(nil, 15, function()
    LuaSkillCtrl:BreakCurrentAction(self.caster)
    LuaSkillCtrl:CallBreakAllSkill(self.caster, true)
    LuaSkillCtrl:RecoverRoleBody(self.caster)
    self.caster.recordTable.changebody = false
    if self.caster:GetBuffTier(self.config.buff_lock) > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_lock, 1)
    end
    if 0 < self.caster:GetBuffTier(self.config.buff_invisibility) then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_invisibility, 1)
    end
  end)
  LuaSkillCtrl:StartTimer(nil, 12, function()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_jump_off, self)
  end)
end

function bs_107203:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_107203:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_107203:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_107203:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_107203:OnCasterDie()
  if self.changebacktimer ~= nil then
    self.changebacktimer:Stop()
    self.changebacktimer = nil
  end
  base.OnCasterDie(self)
end

function bs_107203:LuaDispose()
  LuaSkillCtrl:RecoverRoleBody(self.caster)
  base.LuaDispose(self)
end

function bs_107203:BeforeEndBattle()
  if self.changebacktimer ~= nil then
    self.changebacktimer:Stop()
    self.changebacktimer = nil
  end
  LuaSkillCtrl:RecoverRoleBody(self.caster)
end

return bs_107203
