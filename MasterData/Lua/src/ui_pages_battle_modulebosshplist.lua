local this = class("moduleBossHpList", G_UIModuleBase)
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _moduleNameList = {
  moduleOne = "moduleOne",
  moduleTwo = "moduleTwo",
  moduleThree = "moduleThree"
}
local _moduleName2Cfg = {
  [_moduleNameList.moduleOne] = {
    pfPath = "UI/Pages/BattlePage/moduleOne.prefab",
    scriptPath = "ui.pages.battle.moduleOne"
  },
  [_moduleNameList.moduleTwo] = {
    pfPath = "UI/Pages/BattlePage/moduleTwo.prefab",
    scriptPath = "ui.pages.battle.moduleTwo"
  },
  [_moduleNameList.moduleThree] = {
    pfPath = "UI/Pages/BattlePage/moduleThree.prefab",
    scriptPath = "ui.pages.battle.moduleThree"
  }
}

function this.bind()
  return {goContent = false}
end

function this.methods()
  return {}
end

function this:onEvent_battleStart()
  self:initBoss()
end

function this:onEvent_battleMonsterEntityInfoChange()
  self:initBoss()
end

function this:onEvent_showBossHpNodeStatusChange()
  self.bind.goContent = L_BattleDataManager:getShowBossHpNode()
end

function this:open()
  self.lastBossList = nil
  L_BattleManager:addListener(L_BattleManager.event.battleStart, self.onEvent_battleStart, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.battleMonsterEntityInfoChange, self.onEvent_battleMonsterEntityInfoChange, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.showBossHpNodeStatusChange, self.onEvent_showBossHpNodeStatusChange, self)
  if C_KiboDuelSystemMgr:IsInNestCoop() then
    self.onNestBossCreateHandler = handler(self, self.onNestBossCreate)
    AzurWorld.NestCoopMgr:RegisterEvent(CS.Azur.Gameplay.NestCoop.ENestCoopEvent.BossEntityCreated, self.onNestBossCreateHandler)
  end
  self:initBoss()
end

function this:close()
  if C_KiboDuelSystemMgr:IsInNestCoop() then
    AzurWorld.NestCoopMgr:UnregisterEvent(CS.Azur.Gameplay.NestCoop.ENestCoopEvent.BossEntityCreated, self.onNestBossCreateHandler)
  end
  self.lastBossList = nil
  C_MultiTeam.SetShowBossHp(false)
  local list = C_VarList:Get()
  list:AddBool(false)
  C_MultiEvent.instance:Dispatch(C_EMultiEvent.MultiBossHpShow, list)
  L_BattleManager:removeListener(L_BattleManager.event.battleStart, self.onEvent_battleStart, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.battleMonsterEntityInfoChange, self.onEvent_battleMonsterEntityInfoChange, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.showBossHpNodeStatusChange, self.onEvent_showBossHpNodeStatusChange, self)
end

function this:unBind()
  if self.cacheModule then
    for k, v in pairs(self.cacheModule) do
      v:_ensureUnbind()
      v:_dispose()
      v = nil
    end
    self.cacheModule = nil
  end
end

function this:initBoss()
  if not self.isBind then
    return
  end
  if not L_BattleDataManager:getShowBossHpNode() then
    self.bind.goContent = false
    return
  end
  C_MultiTeam.SetShowBossHp(true)
  local list = C_VarList:Get()
  list:AddBool(true)
  C_MultiEvent.instance:Dispatch(C_EMultiEvent.MultiBossHpShow, list)
  local bossList = {}
  if C_KiboDuelSystemMgr:IsInNestCoop() then
    local boss = C_EntityManager.GetKiBoBoss()
    if boss ~= nil then
      table.insert(bossList, boss.entity.data.entityId)
    else
    end
  else
    local enemyInfo = L_BattleDataManager:getMonsterCsEntityDic()
    for i, v in pairs(enemyInfo) do
      local entity = v
      if entity then
        local tpl = _enemyTpl:getTplById(entity.data.config.id)
        local enemyType = _enemyTpl:getEnemyType(tpl)
        if enemyType == L_Const.enemyType.boss then
          local aliveProperty = entity.data.aliveProperty
          if aliveProperty.hp:ToFloat() > 0 or 0 < aliveProperty.hpIndex then
            table.insert(bossList, i)
          end
        end
      end
    end
  end
  if not self.lastBossList then
    self.lastBossList = bossList
  else
    local bSame = true
    if #self.lastBossList ~= #bossList then
      bSame = false
    else
      for _, v in ipairs(self.lastBossList) do
        local bExist = false
        for _, v1 in ipairs(bossList) do
          if v1 == v then
            bExist = true
            break
          end
        end
        if not bExist then
          bSame = false
          break
        end
      end
    end
    if bSame then
      return
    else
      self.lastBossList = bossList
    end
  end
  table.sort(bossList, function(a, b)
    return a < b
  end)
  self.bind.goContent = not table.isEmpty(bossList)
  self:hideAllCacheModule()
  local cacheModule
  if #bossList == 1 then
    cacheModule = self:getCacheModule(_moduleNameList.moduleOne)
  elseif #bossList == 2 then
    cacheModule = self:getCacheModule(_moduleNameList.moduleTwo)
  elseif #bossList == 3 then
    cacheModule = self:getCacheModule(_moduleNameList.moduleThree)
  end
  if not cacheModule then
    C_MJLog.LogInfo("boss hp list don't find the cache module!:" .. tostring(#bossList))
    return
  end
  cacheModule:initBoss(bossList)
  cacheModule:setVisible(#bossList)
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

function this:getCacheModule(moduleName)
  if not self.cacheModule then
    self.cacheModule = {}
  end
  local tempParams = self.cacheModule[moduleName]
  if not tempParams then
    local moduleCfg = _moduleName2Cfg[moduleName]
    local moduleRoot = self:getRootByModuleName(moduleName)
    if not moduleCfg or not moduleRoot then
      return
    end
    local gameObject = C_UIMgr.uiLoader:Spawn(moduleCfg.pfPath, moduleRoot)
    tempParams = require(moduleCfg.scriptPath).new(G_UIModuleBase.ModuleType.Static)
    tempParams:created()
    L_Vector3.setAnchored(gameObject.transform, {x = 0, y = 0})
    tempParams:toBind(gameObject:GetComponent(typeof(C_UIBinding)))
    self.cacheModule[moduleName] = tempParams
  end
  return tempParams
end

function this:getRootByModuleName(moduleName)
  local moduleName2Root = {
    [_moduleNameList.moduleOne] = self.bindComponents.rectOne,
    [_moduleNameList.moduleTwo] = self.bindComponents.rectTwo,
    [_moduleNameList.moduleThree] = self.bindComponents.rectThree
  }
  return moduleName2Root[moduleName]
end

function this:hideAllCacheModule()
  if not self.cacheModule then
    return
  end
  for k, v in pairs(self.cacheModule) do
    v:setVisible(0)
  end
end

function this:onNestBossCreate(e, v)
  self:initBoss()
end

return this
