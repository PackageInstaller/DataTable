local bs_106903 = class("bs_106903", LuaSkillBase)
local base = LuaSkillBase
bs_106903.config = {
  configId = 36,
  buffId_stun = 66,
  effect_self_start = 106905,
  effect_self_loop = 106906,
  effect_castend = 106907,
  effect_castend_hurt = 106908,
  monsterId = 69,
  action_start = 1005,
  action_loop = 1010,
  action_end = 1006,
  action_speed = 1,
  start_time_0 = 5,
  start_time_1 = 25,
  loop_time = 60,
  audioIdStart = 106903,
  audioIdMovie = 106904,
  audioIdEnd = 106305
}

function bs_106903:ctor()
end

local SyncAttrList = {
  eHeroAttr.moveSpeed,
  eHeroAttr.dodge,
  eHeroAttr.critDamage,
  eHeroAttr.sunder,
  eHeroAttr.damage_increase,
  eHeroAttr.injury_reduce,
  eHeroAttr.heal,
  eHeroAttr.treatment,
  eHeroAttr.magic_pen,
  eHeroAttr.cd_reduce,
  eHeroAttr.resistance
}

function bs_106903:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.effectHalo = nil
  self.halo = nil
  self.attack = nil
end

function bs_106903:PlayUltMovie(moveSelectTarget, selectTargetCoord, selectRoles)
  if not self:IsConsumeSkill() then
    return base.PlayUltMovie(self, moveSelectTarget, selectTargetCoord, selectRoles)
  end
  if selectTargetCoord == nil then
    return true
  end
  local targetGrid_role = LuaSkillCtrl:GetRoleWithPos(selectTargetCoord.x, selectTargetCoord.y)
  if targetGrid_role ~= nil then
    return true
  end
  return base.PlayUltMovie(self, moveSelectTarget, selectTargetCoord, selectRoles)
end

function bs_106903:PlaySkill(data, selectTargetCoord, selectRoles)
  self:CallCasterWait(120)
  local targetGrid = LuaSkillCtrl:GetGridWithPos(selectTargetCoord.x, selectTargetCoord.y)
  self:RealPlaySkill(targetGrid)
  LuaSkillCtrl:StartTimer(self, self.config.start_time_0, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.action_start, self.config.action_speed)
  end, nil)
  LuaSkillCtrl:StartTimer(self, self.config.start_time_1 + self.config.start_time_0, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.action_loop, self.config.action_speed)
    if self.effect_loop ~= nil then
      self.effect_loop:Die()
    end
    self.effect_loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effect_self_loop, self)
  end, nil)
  LuaSkillCtrl:StartTimer(self, self.config.start_time_1 + self.config.loop_time + self.config.start_time_0, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.action_end, self.config.action_speed)
    if self.effect_loop ~= nil then
      self.effect_loop:Die()
    end
  end, nil)
end

function bs_106903:RealPlaySkill(Grid)
  local summonerEntity
  local target = LuaSkillCtrl:GetTargetWithGrid(Grid.coord.x, Grid.coord.y)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, Grid.x, Grid.y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[3] // 1000)
  summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res // 2)
  summoner:SetAttr(eHeroAttr.def, self.caster.def // 2)
  summoner:SetAttr(eHeroAttr.moveSpeed, 0)
  local arg1 = self.arglist[1]
  local tab = {arg_1 = arg1}
  summoner:SetRecordTable(tab)
  summoner:SetAsRealEntity(1)
  summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:CallEffect(summonerEntity, self.config.effect_castend, self)
  local targetList = LuaSkillCtrl:FindAllRolesWithinRange(summonerEntity, 1, false)
  if 0 < targetList.Count then
    for i = targetList.Count - 1, 0, -1 do
      local role = targetList[i]
      if role.belongNum ~= self.caster.belongNum then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
          self.arglist[2]
        }, nil, nil)
        skillResult:EndResult()
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_stun, 1, self.arglist[4])
        LuaSkillCtrl:CallEffect(role, self.config.effect_castend_hurt, self)
      end
    end
  end
end

function bs_106903:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_106903:PlayUltEffect(data, selectTargetCoord, selectRoles)
  base.PlayUltEffect(self)
  local targetRole = LuaSkillCtrl:GetRoleWithPos(selectTargetCoord.x, selectTargetCoord.y)
  if targetRole ~= nil then
    return true
  end
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_106903:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_106903:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_106903:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_106903:LuaDispose()
  base.LuaDispose(self)
  self.effect_loop = nil
end

return bs_106903
