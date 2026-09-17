local this = class("moduleCellHeroHeadEffect", G_UIModuleBase)

function this.bind()
  return {}
end

function this.methods()
  return {}
end

function this:initHeroId(heroId)
  self.heroId = heroId
end

function this:toBind(uiBinding)
  this.super.toBind(self, uiBinding)
  self.entityDeadHandle = self.entityDeadHandle or handler(self, self.onEvent_EntityDead)
  C_EntityManager.AddOnEntityDeadHandler(self.entityDeadHandle)
  self.isDoLeave = false
  self:initChoice()
end

function this:open()
  L_BattleDataManager:addListener(L_BattleDataManager.event.battleHeroLeave, self.onEvent_heroLeave, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.battleHeroWaringLock, self.onEvent_battleHeroWarningLock, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.switchCD, self.onEvent_switchCD, self)
  L_FormationManager:addListener(L_FormationManager.event.formationNoEnergy, self.onEvent_noEnergy, self)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.onEvent_setMainControl, self)
end

function this:show(options)
  self:refreshSwitchCD()
end

function this:onEvent_switchCD(args)
  if not L_BattleDataManager:getIsInBattle() then
    return
  end
  self:refreshSwitchCD()
end

function this:refreshSwitchCD()
  if not L_BattleDataManager:getIsInBattle() then
    self:doChangeCdAnim(false)
    return
  end
  local main = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if main and main.data.UUID ~= self.heroId and not L_BattleDataManager:getIsInCD() and not self.isDoLeave then
    self:doChangeCdAnim(false)
  end
end

function this:onEvent_EntityDead(CsEntity)
  local hero = L_PlayerManager:getAllHeroCsEntity()[self.heroId]
  if hero == nil then
    return
  end
  self._isDead = true
  if CsEntity.data.entityId == hero.data.entityId then
    self.bindComponents.doChangeAnim:Play("Init", 0)
    self.bindComponents.doChangeAnim:Play("Init", 1)
    self.bindComponents.doChangeAnim:Play("Init_dead", 2)
  end
end

function this:close()
  L_BattleDataManager:removeListener(L_BattleDataManager.event.switchCD, self.onEvent_switchCD, self)
  C_EntityManager.RemoveOnEntityDeadHandler(self.entityDeadHandle)
  L_FormationManager:removeListener(L_FormationManager.event.formationNoEnergy, self.onEvent_noEnergy, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.battleHeroWaringLock, self.onEvent_battleHeroWarningLock, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.battleHeroLeave, self.onEvent_heroLeave, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.onEvent_setMainControl, self)
end

function this:unBind(...)
  this.super.unBind(self, ...)
end

function this:onEvent_setMainControl()
  self:playAni("Init", 1)
end

function this:setChoiceEffect(flag, init)
  if flag then
    self.bindComponents.doChangeAnim:Play("Init", 0)
    if L_BattleDataManager:getIsInBattle() then
      self:playAni("anim_battle_hero_instage", 0)
    else
      self:playAni("anim_battle_hero_instage_outbattle", 0)
    end
  elseif init then
    self:playAni("Init", 0)
  elseif L_BattleDataManager:getIsInBattle() then
    self:playAni("anim_battle_hero_outstage", 0)
  else
    self:playAni("anim_battle_hero_outstage_outbattle", 0)
  end
end

function this:initChoice()
  self.bindComponents.doChangeAnim:Play("Init", 0)
  self.bindComponents.doChangeAnim:Play("Init", 1)
  local initStr = self.parent:isDead() and "Init_dead" or "Init"
  self.bindComponents.doChangeAnim:Play(initStr, 2)
end

function this:onEvent_noEnergy(heroId)
  if heroId == self.heroId then
    self.bindComponents.noEnergyTipAnim:Stop()
    self.bindComponents.noEnergyTipAnim:Play("anim_battle_hero_cannotswitch")
  end
end

function this:onEvent_heroLeave(param)
  if not L_BattleDataManager:getIsInBattle() then
    return
  end
  if math.isEmpty(self.heroId) then
    return
  end
  local hero = L_PlayerManager:getAllHeroCsEntity()[self.heroId]
  if hero == nil then
    return
  end
  if param.entityId == hero.data.entityId then
    self:doHeroLeaveStageAnim(param.isLeaveStart)
  end
end

function this:doChangeCdAnim(flag)
  if flag then
    self:playAni("anim_battle_hero_CD_in", 2)
  else
    self:playAni("anim_battle_hero_CD_out", 2)
  end
end

function this:doHeroLeaveStageAnim(flag)
  self.isDoLeave = flag
  if flag then
    self:playAni("anim_battle_hero_CD_in", 2)
  else
    self:playAni("anim_battle_hero_CD_out", 2)
  end
end

function this:onEvent_battleHeroWarningLock(heroId)
  if not L_BattleDataManager:checkPlayerBattle() then
    return
  end
  if AzurWorld.playerMgr.myPlayerData:GetHeroEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex) == nil then
    return
  end
  if heroId ~= AzurWorld.playerMgr.myPlayerData:GetHeroEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex).data.UUID then
    return
  end
  if L_BattleDataManager:getHeroWarningLock(heroId) and L_PlayerManager:getCanChangeHero(self.heroId) and heroId ~= self.heroId then
    self:playAni("anim_battle_hero_canswitch", 1)
  else
    self:playAni("Init", 1)
  end
end

function this:refreshDead()
  if self._isDead ~= self.parent:isDead() then
    self._isDead = self.parent:isDead()
    self.bindComponents.doChangeAnim:Play(self._isDead and "Init_dead" or "Init", 2)
  end
end

function this:playAni(name, layer)
  if self.parent:isDead() then
    self:initChoice()
    return
  end
  self.bindComponents.doChangeAnim:Update(0)
  self.bindComponents.doChangeAnim:Play(name, layer)
end

return this
