local this = class("moduleMainPlayer", G_UIModuleBase)

function this.bind()
  return {
    scrollRectHero = {
      moduleName = "modulePages/cellHeroAvator"
    },
    goNodeNormal = true
  }
end

function this.methods()
  return {
    scrollRectHero = {
      onClick = function(self, bind)
        local index = L_FormationStore:getHeroPlaceInTeam(L_FormationManager:getCurFormationType(), nil, bind.heroId)
        if index - 1 == 0 then
          C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainSwitchHero1, true)
        elseif index - 1 == 1 then
          C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainSwitchHero2, true)
        elseif index - 1 == 2 then
          C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainSwitchHero3, true)
        elseif index - 1 == 3 then
          C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainSwitchHero4, true)
        end
      end
    }
  }
end

function this:open()
  L_UI:addListener(L_UI.pageEvent.preOpen, self.onEvent_showPage, self)
  L_UI:addListener(L_UI.pageEvent.closed, self.onEvent_hidePage, self)
  self._onCutWorldComplete = handler(self, self.onEvent_worldStart)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshModAvatar, self.onEvent_formationRefresh, self)
  self._ESyncFormationServerDataHandler = handler(self, self.onEvent_formationRefresh)
  AzurWorld.formationMgr:RegisterEvent(C_EFormationEvent.ESyncFormationServerData, self._ESyncFormationServerDataHandler)
  self._ESyncHeroServerDataHandler = handler(self, self.onEvent_formationHeroRefresh)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerDataList, self._ESyncHeroServerDataHandler)
  L_BattleDataManager:addListener(L_BattleDataManager.event.refreshHeroSettleData, self.onEvent_refreshHeroSettleData, self)
  self:refreshFormation()
end

function this:show(...)
  this.super.show(self, ...)
  for i, v in pairs(self.modules.scrollRectHero) do
    local item = v
    item:playSelectAnim()
    item:playHeroLevelUpFX()
    item:playPetLevelUpFX()
  end
end

function this:hide(...)
  this.super.hide(self, ...)
  L_BattleDataManager:clearLevelSettleData()
end

function this:close()
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshModAvatar, self.onEvent_formationRefresh, self)
  AzurWorld.formationMgr:UnregisterEvent(C_EFormationEvent.ESyncFormationServerData, self._ESyncFormationServerDataHandler)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.refreshHeroSettleData, self.onEvent_refreshHeroSettleData, self)
  L_UI:removeListener(L_UI.pageEvent.preOpen, self.onEvent_showPage)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onEvent_hidePage)
end

function this:onEvent_showPage(pageName)
  if pageName == "pageBattleSettle" then
    self.bind.goNodeNormal = false
  end
end

function this:onEvent_hidePage(pageName)
  if pageName == "pageBattleSettle" then
    self.bind.goNodeNormal = true
    self:show()
  end
end

function this:onEvent_worldStart()
  self:refreshFormation()
end

function this:onEvent_formationRefresh()
  self:refreshFormation()
end

function this:onEvent_formationHeroRefresh()
  self:refreshFormation()
end

function this:onEvent_battleEnd()
  self.bind.scrollRectHero:clear()
  self:refreshFormation()
end

function this:onEvent_refreshHeroSettleData(roleType, guid)
  if L_UI:currentPage(L_UI.groupKeys.stack) ~= L_UI:stackRootPage() then
    return
  end
  self:playLevelUpFX(roleType, guid)
end

function this:playLevelUpFX(roleType, guid)
  if not self.isBind then
    return
  end
  for i, v in pairs(self.modules.scrollRectHero) do
    local cell = v
    if roleType == L_Const.roleType.hero and guid == cell.bind.heroId then
      cell:playHeroLevelUpFX()
      break
    elseif roleType == L_Const.roleType.pet and guid == cell.bind.petGuid then
      cell:playPetLevelUpFX()
      break
    end
  end
end

function this:refreshFormation()
  if C_HomeUtil.IsInHome() then
    self:showLeaderOnly()
    return
  end
  self:showFormationList()
end

function this:showLeaderOnly()
  if not self.isBind then
    return
  end
  self.bind.scrollRectHero:clear()
  local temp_list = {}
  table.insert(temp_list, self:getFormationHeroInfo(L_FormationStore:getControl(L_FormationManager:getCurFormationType())))
  self.bind.scrollRectHero:insert_array(temp_list)
end

function this:showFormationList()
  if not self.isBind then
    return
  end
  local formationType = L_FormationManager:getCurFormationType()
  local posData = L_FormationStore:getFormationPosData(formationType)
  local temp = {}
  for i, guid in ipairs(posData) do
    if not math.isEmpty(guid) then
      table.insert(temp, {
        heroId = guid,
        petGuid = L_FormationStore:getFormationPosPetGuid(formationType, L_FormationStore:getUsingTeamIndex(formationType), i),
        index = i
      })
    end
  end
  if #temp == #self.bind.scrollRectHero then
    for i = 1, #self.bind.scrollRectHero do
      self.bind.scrollRectHero:change(i, temp[i])
    end
  else
    self.bind.scrollRectHero:clear()
    self.bind.scrollRectHero:insert_array(temp)
  end
end

function this:getFormationHeroInfo(heroId, tab)
  local hp_max = L_AttributeManager:getAttValueByHeroGuid(heroId, L_Const.battleAtt.MAXHP)
  local hero = L_BattleStore:getObjBattleInfo(heroId)
  tab = tab or {}
  tab.heroId = heroId
  tab.hp = hero and hero.hp / hp_max * 100 or 100
  tab.sp = hero and hero.sp or 0
  tab.index = 1
  return tab
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
