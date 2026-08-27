local bs_17102 = class("bs_17102", LuaSkillBase)
local base = LuaSkillBase
bs_17102.config = {
  effect_jifei = 12101,
  buffId_jifei = 2148,
  effect_jitui = 12065,
  buffId_xuanyun = 2149
}

function bs_17102:ctor()
end

function bs_17102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnSacrifice, self.OnSacrifice)
  self:AddOnRoleDieTrigger("bs_17102_1", 3, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
  local cb = BindCallback(self, self.checkCd)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], cb, nil, nil, self.arglist[1])
  self.isReady = false
  self.flag = false
  self.isSacrifice = false
end

function bs_17102:checkCd()
  self.isReady = true
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_17102:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy or not self.isReady then
    return
  end
  self.flag = true
  self.isReady = false
  local cb = BindCallback(self, self.checkCd)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], cb)
  LuaSkillCtrl:StartTimer(nil, 2, BindCallback(self, self.eventFunc, killer, role))
end

function bs_17102:OnSacrifice(killer, role)
  if not self.flag then
    return
  end
  self.isSacrifice = true
end

function bs_17102:eventFunc(killer, role)
  local targetList = LuaSkillCtrl:FindAllRolesWithinRange(role, 1, false)
  for i = 0, targetList.Count - 1 do
    if targetList[i].belongNum == eBattleRoleBelong.enemy then
      LuaSkillCtrl:CallEffect(role, self.config.effect_jifei, self)
      LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_jifei, 1, 15, true)
    end
  end
  if self.isSacrifice then
    local enemylist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    if enemylist ~= nil and 0 < enemylist.Count then
      for i = 0, enemylist.Count - 1 do
        LuaSkillCtrl:CallEffect(role, self.config.effect_jitui, self)
        LuaSkillCtrl:CallBuff(self, enemylist[i], self.config.buffId_xuanyun, 1, self.arglist[2], true)
      end
    end
    self.isSacrifice = false
  end
  self.flag = true
end

function bs_17102:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17102
