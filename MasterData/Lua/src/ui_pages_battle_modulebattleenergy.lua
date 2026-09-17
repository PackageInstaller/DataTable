local this = class("moduleBattleEnergy", G_UIModuleBase)

function this.bind()
  return {
    list_cellEnergy = {
      moduleName = "pages/battle/cellBattleEnergy"
    }
  }
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  self.playerData = C_EntityManager.MainPlayer.data
  self:initEnergyNode()
  self.updateTimer = Timer.repeated(0.1, self.update, self)
  L_FormationManager:addListener(L_FormationManager.event.formationNoEnergy, self.doNoPowerEffect, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.battleHeroWaringLock, self.onEvent_battleHeroWarningLock, self)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.onEvent_mainChange, self)
end

function this:initEnergyNode()
  self.maxSwitchEnergyPoint = self.playerData.maxSwitchEnergyPoint
  self.curEnergyPoint = 0
  self.energyList = {}
  local count = self.bindComponents.point.childCount - 1
  for i = 0, count do
    local child = self.bindComponents.point:GetChild(i)
    local energyNode = {}
    energyNode.go_cd = child:Find("cd").gameObject
    energyNode.fill_cd = child:Find("cd/fill"):GetComponent(typeof(C_LImage))
    energyNode.fill_cd.fillAmount = 0
    energyNode.node = child:Find("node").gameObject
    energyNode.anim = child:GetComponent(typeof(C_Animation))
    energyNode.gameObject = child.gameObject
    energyNode.go_high = child:Find("Fx_HighlightTips").gameObject
    if self.maxSwitchEnergyPoint < i + 1 then
      child.gameObject:ActiveTrans(false)
    else
      child.gameObject:ActiveTrans(true)
      table.insert(self.energyList, energyNode)
    end
  end
  for _, v in ipairs(self.energyList) do
    v.anim:Stop()
    v.node.transform.localScale = C_Vector3.one
    v.go_cd.transform.localScale = C_Vector3.one
  end
end

function this:close()
  L_FormationManager:removeListener(L_FormationManager.event.formationNoEnergy, self.doNoPowerEffect)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.onEvent_mainChange)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.battleHeroWaringLock, self.onEvent_battleHeroWarningLock)
  if self.updateTimer then
    Timer.remove(self.updateTimer)
    self.updateTimer = nil
  end
end

function this:update()
  if not L_BattleDataManager.data then
    return
  end
  if self.maxSwitchEnergyPoint ~= self.playerData.maxSwitchEnergyPoint then
    self:initEnergyNode()
  end
  local switchEnergyRecoverTime = self.playerData.switchEnergyRecoverTime
  local lastEnergyPointRecoverTime = self.playerData.lastEnergyPointRecoverTime
  if self.playerData.switchEnergyPoint < self.curEnergyPoint then
    for i = self.curEnergyPoint, self.playerData.switchEnergyPoint + 1, -1 do
      if 1 <= i then
        self:doUseEffectEnergyPoint(i)
      end
    end
    self.curEnergyPoint = self.playerData.switchEnergyPoint
  end
  if self.playerData.switchEnergyPoint > self.curEnergyPoint then
    self.curEnergyPoint = self.playerData.switchEnergyPoint
    self:doEffectEnergyPoint(self.playerData.switchEnergyPoint)
  end
  for i, v in ipairs(self.energyList) do
    if i <= self.curEnergyPoint then
      v.node:ActiveTrans(true)
      v.go_cd:ActiveTrans(false)
    else
      v.node:ActiveTrans(false)
      v.go_cd:ActiveTrans(true)
      v.fill_cd.fillAmount = 0
    end
  end
  if self.curEnergyPoint < self.maxSwitchEnergyPoint then
    self.energyList[self.curEnergyPoint + 1].fill_cd.fillAmount = math.lerp(0, 0.8, lastEnergyPointRecoverTime / switchEnergyRecoverTime)
  end
end

function this:show()
  if not self.energyList then
    return
  end
  for _, v in ipairs(self.energyList) do
    v.anim:Stop()
    v.node.transform.localScale = C_Vector3.one
    v.go_cd.transform.localScale = C_Vector3.one
  end
  self:update()
end

function this:doEffectEnergyPoint(index)
  self.energyList[index].anim:Stop()
  self.energyList[index].anim:Play("anim_point_in")
end

function this:doUseEffectEnergyPoint(index)
  self.energyList[index].anim:Stop()
  self.energyList[index].anim:Play("anim_point_out")
end

function this:doHighLightTipEffect()
  for i, v in ipairs(self.energyList) do
    if i <= self.curEnergyPoint then
      v.go_high:ActiveTrans(true)
    end
  end
end

function this:onEvent_mainChange()
  for i, v in ipairs(self.energyList) do
    v.go_high:ActiveTrans(false)
  end
end

function this:doNoPowerEffect()
  for i, v in ipairs(self.energyList) do
    v.anim:Play("anim_point_nopower")
  end
end

function this:onEvent_battleHeroWarningLock(heroId)
  if AzurWorld.playerMgr.myPlayerData:GetHeroEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex) == nil then
    return
  end
  if heroId ~= AzurWorld.playerMgr.myPlayerData:GetHeroEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex).data.UUID then
    return
  end
  local aliveHeroIdDic = {}
  local heroDic = L_PlayerManager:getAllHeroCsEntity()
  for i, v in pairs(heroDic) do
    if not C_EntityManager.IsEntityDead(v.data.UUID) and C_MyFloatUtility.GetFloat(v.data.aliveProperty.hp) > 0 then
      aliveHeroIdDic[i] = v
    end
  end
  local hero
  for i, v in pairs(aliveHeroIdDic) do
    if i ~= heroId then
      hero = i
      break
    end
  end
  if L_BattleDataManager:getHeroWarningLock(heroId) then
    if hero ~= nil and self.curEnergyPoint >= 1 then
      self:doHighLightTipEffect()
    end
  else
    for i, v in ipairs(self.energyList) do
      v.go_high:ActiveTrans(false)
    end
  end
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
