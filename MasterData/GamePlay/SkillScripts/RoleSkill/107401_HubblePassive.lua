local bs_107401 = class("bs_107401", LuaSkillBase)
local base = LuaSkillBase
bs_107401.config = {
  effectId_trail = 107403,
  effect = 107405,
  effect_castend = 107418,
  buffId = 107401,
  buffId1 = 107404,
  configId = 17,
  monsterId = 74,
  monsterId_1 = 78,
  weaponLv = 0
}

function bs_107401:ctor()
end

function bs_107401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_107401_1", 1, self.OnRoleDie, nil, nil, nil, nil)
  self.maxCount = 5
  self.Count = 0
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107401_2", 1, self.OnAfterBattleStart)
end

function bs_107401:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[6], BindCallback(self, self.Summon), nil, -1, self.arglist[6])
end

function bs_107401:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum then
    local tar
    local targets = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
    for i = 0, targets.Count - 1 do
      local role = targets[i].targetRole
      if not LuaSkillCtrl:IsObstacle(role) then
        tar = role
        break
      end
    end
    if tar == nil then
      return
    end
    LuaSkillCtrl:CallEffectWithArgOverride(tar, self.config.effectId_trail, self, role, nil, nil, self.SkillEventFunc)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[3])
    if self.config.weaponLv >= 2 then
      local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
      if 0 < targetList.Count then
        for i = 0, targetList.Count - 1 do
          local role = targetList[i]
          if role ~= nil and 0 < role.hp and role.roleType ~= eBattleRoleType.realSummoner then
            LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId1, 1, self.arglist[8])
          end
        end
      end
    end
  end
  if role.roleType == eBattleRoleType.realSummoner and role.summoner.summonerMaker == self.caster then
    self.Count = self.Count - 1
  end
  if role.belongNum == eBattleRoleBelong.enemy and self.Count < self.maxCount then
    self:Summon(role)
  end
end

function bs_107401:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId_trail and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
      self.arglist[1]
    }, nil, nil)
    skillResult:EndResult()
  end
end

function bs_107401:Summon(role)
  local Grid
  if role == nil then
    Grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
    if Grid == nil then
      Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
    end
  else
    Grid = LuaSkillCtrl:GetGridWithRole(role)
  end
  local summonerEntity
  if Grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effect_castend, self)
    local monsterId = 0
    if self.config.weaponLv >= 2 then
      monsterId = self.config.monsterId_1
    else
      monsterId = self.config.monsterId
    end
    local summoner = LuaSkillCtrl:CreateSummoner(self, monsterId, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[4] // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.arglist[5] // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.arglist[5] // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.moveSpeed, self.caster.moveSpeed)
    summoner:SetAttr(eHeroAttr.def, self.caster.def)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res)
    summoner:SetAttr(eHeroAttr.lucky, self.lucky)
    summoner:SetAsRealEntity(1)
    summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    self.Count = self.Count + 1
  end
end

function bs_107401:LuaDispose()
  base.LuaDispose(self)
end

function bs_107401:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_107401
