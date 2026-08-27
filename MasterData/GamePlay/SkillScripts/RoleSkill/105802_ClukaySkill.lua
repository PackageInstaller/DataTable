local bs_105802 = class("bs_105802", LuaSkillBase)
local base = LuaSkillBase
bs_105802.config = {
  effectId_skill = 105811,
  effectId_skill_04 = 30581104,
  effectId_skill_05 = 30581105,
  effectId_skillQk = 105812,
  effectId_skillBz = 105810,
  actionId = 1002,
  audioId1 = 101003,
  skill_time = 55,
  start_time = 23,
  selectRange = 10,
  selectId2 = 34,
  hurtConfig = 13,
  HurtConfig = 3,
  buffIdys = 105801,
  buffIdcx = 105802,
  weaponLv = 0,
  monsterId = 89,
  effect_castend = 105833
}

function bs_105802:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.SkinId = LuaSkillCtrl:GetCasterSkinId(self.caster)
  if self.SkinId == 305804 then
    self.effectId_skill = self.config.effectId_skill_04
  elseif self.SkinId == 305805 then
    self.effectId_skill = self.config.effectId_skill_05
  else
    self.effectId_skill = self.config.effectId_skill
  end
end

function bs_105802:PlaySkill(data)
  local realgrid = LuaSkillCtrl:CallFindGridMostRolesArounded(2)
  if realgrid ~= nil then
    if self.config.weaponLv >= 1 then
      if realgrid.role == nil then
        self:Summon(realgrid)
      else
        local Grid = LuaSkillCtrl:CallFindEmptyGridNearest(realgrid.role)
        if Grid ~= nil then
          self:Summon(Grid)
        end
      end
    end
    local target = LuaSkillCtrl:GetTargetWithGrid(realgrid.x, realgrid.y)
    local attackTrigger = BindCallback(self, self.OnActionCallBack, target, realgrid)
    self.caster:LookAtTarget(target)
    if self.config.weaponLv >= 1 then
      self:CallCasterWait(self.config.skill_time * self.arglist[7] // 1000)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, 1.5, self.config.start_time * self.arglist[7] // 1000, attackTrigger)
    else
      self:CallCasterWait(self.config.skill_time)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, 1, self.config.start_time, attackTrigger)
    end
  end
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 305804 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skillQk, self)
  end
end

function bs_105802:Summon(Grid)
  local summonerEntity
  local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
  local monsterId = 0
  monsterId = self.config.monsterId
  local summoner = LuaSkillCtrl:CreateSummoner(self, monsterId, Grid.x, Grid.y, 2)
  summoner:SetAttr(eHeroAttr.maxHp, 1)
  summoner:SetAsRealEntity(1)
  local arg1 = self.arglist[6]
  local arg2 = self.arglist[8]
  local tab = {arg_1 = arg1, arg_2 = arg2}
  summoner:SetRecordTable(tab)
  summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
end

function bs_105802:OnActionCallBack(target, realgrid)
  if LuaSkillCtrl:GetCasterSkinId(self.caster) ~= 305804 then
  end
  LuaSkillCtrl:CallEffectWithArg(target, self.effectId_skill, self, false, false, self.OnEffectTrigger, realgrid)
  goto lbl_35
  LuaSkillCtrl:CallEffectWithArg(target, self.effectId_skill, self, false, false, self.OnEffectTrigger, realgrid)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skillQk, self)
  ::lbl_35::
end

function bs_105802:OnEffectTrigger(realgrid, effect, eventId, target)
  if effect.dataId == self.effectId_skill and eventId == eBattleEffectEvent.Trigger then
    local roles = LuaSkillCtrl:FindRolesAroundGrid(realgrid, 2)
    local roles_net = LuaSkillCtrl:FindRolesAroundGrid(realgrid, 0)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_skillBz, self)
    if roles ~= nil and 0 < roles.Count then
      for i = 0, roles.Count - 1 do
        if roles[i] ~= nil and 0 < roles[i].hp then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles[i])
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
            self.arglist[1]
          })
          skillResult:EndResult()
          LuaSkillCtrl:CallBuff(self, roles[i], self.config.buffIdys, 1, self.arglist[2])
          LuaSkillCtrl:CallBuffRepeated(self, roles[i], self.config.buffIdcx, 1, self.arglist[2] + 1, false, false, self.OnBuffExecute)
        end
      end
    end
    if roles_net ~= nil and 0 < roles_net.Count then
      for i = 0, roles_net.Count - 1 do
        if roles_net[i] ~= nil and 0 < roles_net[i].hp then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles_net[i])
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
            self.arglist[1]
          })
          skillResult:EndResult()
        end
      end
    end
    self:OnSkillDamageEnd()
  end
end

function bs_105802:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {
    self.arglist[5]
  }, true)
  skillResult:EndResult()
end

function bs_105802:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105802
