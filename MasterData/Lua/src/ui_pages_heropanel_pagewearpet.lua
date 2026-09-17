local this = class("pageWearPet", G_UIPageBase)
local PosIndex = 2

function this.bind()
  return {
    module_commonTop = {
      moduleName = "modulePages/moduleCommonTop"
    },
    list_hud = {
      moduleName = "pages/formation/formationModule/cellTeamUnitHud"
    },
    module_selectPet = {
      moduleName = "modulePages/unit/moduleSelectPet"
    }
  }
end

function this.methods()
  return {
    module_selectPet = {
      onClick_selectPet = function(self, petGuid)
        local hero = L_HeroStore:getHero(self._heroGuid)
        self._moduleSelectPet = self.modules.module_selectPet
        if L_HeroStore:getHeroPetGuid(hero) == petGuid then
          local canPutOff = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.formationDownPet)
          if not canPutOff then
            L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("PROLOGUE_REMOVE_KIBO_FORBIDDEN"))
            return
          end
          L_HeroManager:reqWearPet(self._heroGuid, nil, function()
            L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_formation_remove"))
            self._moduleSelectPet:setListSelect()
          end)
        else
          L_HeroManager:reqWearPet(self._heroGuid, petGuid, function()
            local pet = L_PetStore:getPetItem(petGuid)
            self:PlayVoice(self._heroGuid)
            local selectDic = {}
            selectDic[petGuid] = {isSelect = true}
            self._moduleSelectPet:setListSelect(selectDic)
          end)
        end
      end
    }
  }
end

function this:PlayVoice(guid)
  if self.bInVoiceCD then
    return
  end
  self.bInVoiceCD = true
  local configId = L_HeroStore:getHeroConfigId(L_HeroStore:getHero(guid))
  L_AudioUtil.playSound("Play_VO_System_" .. configId .. "_Forming")
  self:newOrResetTimer("voiceCD", function()
    self.bInVoiceCD = false
  end, L_GameTpl:getGameConstTpl():getData("CHARACTER_CHANGEKIBO_VOICE_CD", L_Const.GameTplType.int))
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.heroWearPet)
  if not result then
    callback(false)
    return
  end
  if math.isEmpty(options.heroGuid) then
    callback(false)
    return
  end
  if not L_HeroStore:getHero(options.heroGuid) then
    callback(false)
    return
  end
  local hero = L_HeroStore:getHero(options.heroGuid)
  if not math.isEmpty(L_HeroStore:getTrailPet(hero)) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("hero_cant_change_test_kibo"))
    callback(false)
    return
  end
  callback(true)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  if AzurWorld.playerMgr and AzurWorld.playerMgr.myPlayerUnitAdapter then
    AzurWorld.playerMgr.myPlayerUnitAdapter.pause = true
  end
  options = options or {}
  self.preOpenInit = true
  local isLowMemoryDevice = C_DeviceGradeHelper.IsLowMemoryDevice() or C_AppConfigManager.IsMobilePlatformForUI
  self.cacheLv = isLowMemoryDevice and L_Const.topChangeHideLv.lowMemory or L_Const.topChangeHideLv.highMemory
  self._heroGuid = options.heroGuid
  local pageFormationMainStatus = L_UI:getPageStatus("pageFormationMain")
  self._hasOpenFormationMain = pageFormationMainStatus and pageFormationMainStatus == "hided"
  if self._hasOpenFormationMain then
    if L_FormationManager.runtimeData ~= nil then
      self._formationEditStatusCache = L_FormationManager:getEditStatus()
      self._formationTypeCache = L_FormationManager:getRuntimeFormationType()
      self._formationIndexCache = L_FormationManager:getRuntimeFormationIndex()
      self._formationFocusIndexCache = L_FormationManager:getFocusIndex()
    else
      self.isLoadedFormationScene = true
      L_FormationManager:loadFormationScene()
    end
  else
    self.isLoadedFormationScene = true
    L_FormationManager:loadFormationScene()
  end
  L_FormationManager:setRuntimeFormationType()
  L_FormationManager:setRuntimeFormationIndex()
  self._ESyncHeroServerDataHandler = handler(self, self.onEvent_refreshFormation)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerDataList, self._ESyncHeroServerDataHandler)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshFormation, self, nil, 0)
  self._lateUpdateHandle = L_CommonUtil.handle(self.onLateUpdate_displayFollow, self)
  C_UpdateSource.AddLateUpdateEventHandler(self._lateUpdateHandle, "FormationMainPage.lateUpdate")
  self:initPage()
  L_FormationManager:switchToEditPet(PosIndex)
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.WearPet)
end

function this:open()
end

function this:show()
  self.preOpenInit = false
  L_TimerManager:clearTimer(self)
  L_FormationManager:setSceneArtActive(true)
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.WearPet)
end

function this:hide()
  L_FormationManager:setSceneArtActive(false)
end

function this:close(options)
  this.super.close(self, options)
  L_TimerManager:clearTimer(self)
  L_AudioUtil.stopSound(self._petVoiceWrap)
  if self._lateUpdateHandle then
    C_UpdateSource.RemoveLateUpdateEventHandler(self._lateUpdateHandle)
  end
  self._lateUpdateHandle = nil
  AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ESyncHeroServerDataList, self._ESyncHeroServerDataHandler)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshFormation, self, nil, 0)
  if self._hasOpenFormationMain and not self.isLoadedFormationScene then
    L_FormationManager:setEditStatus(self._formationEditStatusCache)
    L_FormationManager:setRuntimeFormationType(self._formationTypeCache)
    L_FormationManager:setRuntimeFormationIndex(self._formationIndexCache)
    L_FormationManager:setFocusIndex(self._formationFocusIndexCache)
    L_FormationManager:setNeedRevertFormationScene(true)
  else
    L_FormationManager:removeFormationScene()
  end
  if AzurWorld.playerMgr and AzurWorld.playerMgr.myPlayerUnitAdapter then
    AzurWorld.playerMgr.myPlayerUnitAdapter.pause = false
    AzurWorld.playerMgr.myPlayerUnitAdapter:ResumePlayerUnit(nil, true, true)
  end
end

function this:onTopChange(options)
  if options.topLv == 0 and 0 < options.lastTopLv and self.topStateDirty then
    if not self.preOpenInit then
      L_FormationManager:loadFormationScene()
      self:initFormationModel()
      L_FormationManager:switchToEditPet(PosIndex)
    end
    self.topStateDirty = false
  elseif options.topLv == self.cacheLv and options.lastTopLv < self.cacheLv then
    if self._hasOpenFormationMain and not self.isLoadedFormationScene then
      L_FormationManager:setEditStatus(self._formationEditStatusCache)
      L_FormationManager:setRuntimeFormationType(self._formationTypeCache)
      L_FormationManager:setRuntimeFormationIndex(self._formationIndexCache)
      L_FormationManager:setFocusIndex(self._formationFocusIndexCache)
      L_FormationManager:setNeedRevertFormationScene(true)
    else
      L_FormationManager:removeFormationScene()
    end
    self.topStateDirty = true
  end
end

function this:escHandle()
  if not self._moduleSelectPet:escHandle() then
    L_UI:close(self.pageName)
  end
end

function this:initPage()
  self:initCommonTopModule()
  self:initFormationModel()
  self:initHudList()
  self:initSelectPetModule()
end

function this:initCommonTopModule()
  local data = {
    name = L_WordsTpl:getValue("ui_heroRole_28"),
    nameEn = "HE                            RO",
    closeCurPage = handler(self, self.escHandle)
  }
  self.modules.module_commonTop:initModule(data)
end

function this:initFormationModel(isSync)
  L_FormationManager:loadHeroModelAtPlaceAsync(self._heroGuid, PosIndex, isSync, function()
  end)
  local hero = L_HeroStore:getHero(self._heroGuid)
  L_FormationManager:loadPetModelAtPlace(L_HeroStore:getHeroPetGuid(hero), 2)
end

function this:initHudList()
  local hero = L_HeroStore:getHero(self._heroGuid)
  local petGuid = L_HeroStore:getHeroPetGuid(hero)
  local temp = {}
  table.insert(temp, {
    index = 2,
    roleType = L_Const.roleType.hero,
    roleId = self._heroGuid,
    bEdit = false
  })
  if not math.isEmpty(petGuid) then
    table.insert(temp, {
      index = 2,
      roleType = L_Const.roleType.pet,
      roleId = petGuid,
      bEdit = false
    })
  end
  self.bind.list_hud:clear()
  self.bind.list_hud:insert_array(temp)
end

function this:refreshHudList()
  local list = self.modules.list_hud
  for i, hud in pairs(list) do
    hud:setFollow()
    if i == 1 then
      hud:hideEditUI()
    else
      hud:setUIState(true, false)
    end
  end
end

function this:initSelectPetModule()
  self._moduleSelectPet = self.modules.module_selectPet
  local param = {}
  param.systemId = L_SystemConst.enum.formationQuickPet
  local hero = L_HeroStore:getHero(self._heroGuid)
  local petGuid = L_HeroStore:getHeroPetGuid(hero)
  if petGuid == 0 then
    local formationHeroList = AzurWorld.playerMgr.myPlayerData.formationHeroes
    for i = 0, formationHeroList.Count - 1 do
      local _, entity = formationHeroList:TryGetValue(i)
      if entity ~= nil then
        local petEntityId = entity.petEntityId
        if petEntityId ~= 0 then
          local petEntity = C_EntityManager.GetPetEntity(petEntityId)
          petGuid = petEntity.data.UUID
          break
        end
      end
    end
  end
  local selectDic = {}
  if not math.isEmpty(petGuid) then
    local petItem = L_PetStore:getPetItem(petGuid)
    param.defaultSelectBoxIndex = petItem.box_id // 100
    selectDic[petGuid] = {isSelect = true}
  end
  param.showRecommend = true
  param.heroConfigId = hero.configId
  self._moduleSelectPet:initModule(param)
  self._moduleSelectPet:setListSelect(selectDic)
  self._moduleSelectPet:enableDetailBtn()
end

function this:onEvent_refreshFormation()
  self:initFormationModel(true)
  self:initHudList()
end

function this:onLateUpdate_displayFollow()
  self:refreshHudList()
end

return this
