local this = class("pagePet", G_UIPageBase)
local petInfoTpl = L_GameTpl:getPetTpl()
local unitTpl = L_GameTpl:getUnitTpl()
local DEFAULT_IDLE_WAITING_TIME = {3, 5}
local DEFAULT_IDLE_RANDOM_EXPRESSION_IDS = {
  1,
  2,
  3
}
local DEFAULT_IDLE_SLEEP_EXPRESSION_ID = 4
local DEFAULT_IDLE_SLEEP_TRIGGER_COUNT = 3
local IDLE_PERFORM_EXPRESSION_ID_MAP = {
  [1] = 5,
  [2] = 9,
  [3] = 8,
  [4] = 11
}
local IDLE_PERFORM_EFFECT_MOUNT_NODE_NAME_LIST = {"Head", "head"}
local IDLE_PERFORM_EFFECT_SPECIAL_MOUNT_NODE_NAME_MAP = {
  [1] = "HitPoint",
  [2] = "HitPoint",
  [3] = "HitPoint"
}
local IDLE_PERFORM_EFFECT_NAME_LIST = {
  [1] = "Effect/Common/pre_pet_happy_01.prefab",
  [2] = "Effect/Home/Common/pre_home_music_01.prefab",
  [3] = "Effect/Common/pre_pet_happiness_01.prefab",
  [4] = "Effect/Home/Common/pre_home_sleep_01.prefab"
}
local IDLE_PERFORM_AUDIO_EVENT_LIST = {
  [1] = "Play_QVO_System_%s_Greeting",
  [2] = "Play_QVO_System_%s_Touch",
  [3] = "Play_QVO_System_%s_Idle",
  [4] = "Play_QVO_System_%s_Sleep"
}

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    sortParam = {
      type = L_Const.sortType.lv,
      order = L_Const.sortOrder.DESC
    },
    name = "",
    isModify = false
  }
  self.filterTypeOrder = {
    L_PetConst.filterPetBox.grade,
    L_PetConst.filterPetBox.level,
    L_PetConst.filterPetBox.labor
  }
  self.filterType = {
    [L_PetConst.filterPetBox.level] = "ui_pageHomeCenterPetStationedManage_01",
    [L_PetConst.filterPetBox.grade] = "ui_pageHomeCenterPetStationedManage_02",
    [L_PetConst.filterPetBox.labor] = "ui_pageHomeCenterPetStationedManage_04"
  }
end

function this.bind()
  return {
    currentPetDisplay = false,
    infoToggles = true,
    toggleInfo = true,
    upBg = false,
    showPetList = false,
    petList = {
      moduleName = "modulePages/cellIconUnit"
    },
    toggleModuleBar = {
      type = "toggleModule",
      modulePetProperty = {
        assetName = "UI/Pages/Pet/modulePetProperty",
        moduleName = "pages/pet/modulePetProperty"
      },
      moduleRankUpPet = {
        assetName = "UI/Pages/Pet/moduleRankUpPet",
        moduleName = "pages/Pet/moduleRankUpPet"
      },
      modulePetUseItem = {
        assetName = "UI/Pages/Pet/modulePetUseItem",
        moduleName = "pages/Pet/modulePetUseItem"
      },
      modulePetDevelop = {
        assetName = "UI/Pages/Pet/modulePetDevelop",
        moduleName = "pages/Pet/modulePetDevelop"
      }
    },
    toggleModuleName = "",
    module_sortWay = {
      moduleName = "ModulePages/moduleSortWay"
    },
    modulePetSceneMod = {
      type = "toggleModule",
      modulePetSceneMod = {
        assetName = "UI/Pages/Pet/modulePetSceneMod",
        moduleName = "pages/Pet/modulePetSceneMod"
      }
    },
    modulePetSceneModName = "",
    activePetDisplay = true,
    activePetListButton = false,
    isOnToggleGene = false,
    isOnToggleFeed = false,
    isOnToggleRankUp = false,
    filter = false,
    modulePetFilter = {
      moduleName = "modulePages/filtrate/modulePetFilter"
    },
    bgMask = false,
    warning_petList = false,
    warning_pagePet = false,
    masterIcon = false,
    masterLv = "",
    masterName = "",
    img_masterHero = "",
    txt_petFavorLv = "",
    go_petFavor = false,
    list_dropdown = {
      moduleName = "modulePages/sortFilter/cellSortFilterDropdown"
    },
    list_box_pet = {
      moduleName = "pages/pet/cellPixelPet"
    },
    dropDownContent = false,
    toggleArrow = false,
    txt_dropDown = "",
    contentBg = false
  }
end

function this.methods()
  return {
    petList = {
      onClick_Choose = function(self, id)
        if id ~= L_PetStore:getCurSelectPetId() then
          L_PetStore:setCurSelectPetId(id)
        end
      end
    },
    toggleInfoBtn = function(self)
      self:returnToDefaultModule()
    end,
    toggleRankUp = function(self)
      local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petRankUp)
      if not result then
        return
      end
      self.bind.toggleModuleName = "moduleRankUpPet"
      self.bind.showPetList = false
      self.bind.activePetListButton = false
    end,
    toggleDecoration = function(self)
      local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petDecoration)
      if not result then
        return
      end
      L_FlyMsgManager:showNormalMsgByKey("notice_pagePet_02")
    end,
    toggleUseItem = function(self)
      self.bind.toggleModuleName = "modulePetUseItem"
      self.bind.activePetDisplay = true
      self.modules.toggleModuleBar.modulePetUseItem:refreshPet(L_PetStore:getCurSelectPetId())
      self.bind.showPetList = false
      self.bind.activePetListButton = false
    end,
    toggleFeed = function(self)
      if self.bind.toggleModuleName == "modulePetDevelop" then
        return
      end
      self:returnToDefaultModule()
    end,
    onClick_openPetList = function(self)
      self.bind.showPetList = true
      self:sortPetList()
    end,
    onClick_closePetList = function(self)
      self.bind.showPetList = false
    end,
    onClick_openFilterModule = function(self)
      self.bind.filter = true
    end,
    onClick_geneRemakeTips = function(self)
      local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petGene)
      if not result then
        return
      end
      L_UI:open("pagePetGene")
    end,
    onClick_petFavor = function(self)
      L_UI:open("pagePetFavorDetail", {
        petGuid = self.petId
      })
    end,
    onClick_showDropDownContent = function(self)
      self:refreshFilterActive()
      self.bind.dropDownContent = not self.bind.dropDownContent
      self.bind.toggleArrow = not self.bind.toggleArrow
      self.bind.contentBg = not self.bind.contentBg
      if self.bind.dropDownContent then
        self.bindComponents.btnSortBoxList.parent = self.bindComponents.sortBoxContainer.parent
      else
        self.bindComponents.btnSortBoxList.parent = self.bindComponents.sortBoxContainer
      end
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.img_frame)
    end,
    list_dropdown = {
      onClick_select = function(self, bind)
        self.filter = bind.index
        self.bind.dropDownContent = false
        self.bind.txt_dropDown = bind.type
        self.bind.toggleArrow = false
        for i = 1, #self.modules.list_box_pet do
          local petCell = self.modules.list_box_pet[i]
          if petCell and petCell.refreshFilterType then
            petCell:refreshFilterType(self.filter)
          end
        end
      end
    },
    dropDownContentBgOnClick = function(self)
      self.bind.dropDownContent = false
      self.bind.toggleArrow = false
      self.bind.contentBg = false
      self.bindComponents.btnSortBoxList.parent = self.bindComponents.sortBoxContainer
    end
  }
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.pet)
  callback(result)
end

function this:created(...)
  this.super.created(self, ...)
  local options = self.options or {}
  if options.jumpParams then
    options.selectModuleType = options.jumpParams[1]
  end
  self.options = options
  if options.callBack then
    self.callBack = options.callBack
  end
  self.petId = options.petId
  if not self.petId then
    self.petId = L_PetStore:getFirstOrderPet()
  end
  if self.petId then
    L_PetStore:setCurSelectPetId(self.petId)
  end
  local pet = L_PetStore:getPetItem(self.petId)
  self.configId = pet.id
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.hasShown = false
  self.bind.bgMask = false
  if options.jumpParams then
    local jumpType = tonumber(options.jumpParams[1])
    if jumpType == 1 then
      self.bind.toggleModuleName = "modulePetDevelop"
    elseif jumpType == 2 then
      self.bind.toggleModuleName = "moduleRankUpPet"
      self.bind.isOnToggleRankUp = true
    end
  else
    self.bind.toggleModuleName = "modulePetDevelop"
  end
  CS.UnityEngine.Profiling.Profiler.BeginSample("pagepet:initdata")
  if self.petId then
    self:initData(self.petId)
    self:refreshHousePetList()
  end
  CS.UnityEngine.Profiling.Profiler.EndSample()
  self.selectPet = {}
  self.compareData = {}
  self.moduleFilterData = {
    closeCurModule = function()
      self.bind.filter = false
    end,
    filter = function(data)
    end
  }
  self.closeCurPageFunc = nil
  self.bind.modulePetSceneModName = "modulePetSceneMod"
  self:refreshPetMod()
  C_IntegrateMgr.TopBarModule:SetTopBarBackName(L_WordsTpl:getValue("notice_pagePet_01"))
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(function()
    if self.closeCurPageFunc then
      self.closeCurPageFunc()
      self.closeCurPageFunc = nil
      C_IntegrateMgr.TopBarModule:SetTopBarBackName(L_WordsTpl:getValue("notice_pagePet_01"))
      return
    end
    L_UI:close(self.pageName)
  end)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId, self)
  L_PetStore:listenCallFunc(L_PetStore.event.removePet, self.onEvent_removePet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshNewPet, self.onEvent_newPet, self)
  self:registerReddot(self.bindComponents.reddotNormal, L_ReddotManager.DotDef.PetNew)
  C_CameraManager.SetBrainBlendStyle(L_Const.blendStyle.cut)
  local brain = C_CameraManager.GetMainCameraBrain()
  brain.m_CustomBlends = nil
  self:initIdlePerformParams()
  local tpl = petInfoTpl:getTplById(self.configId)
  local customSceneId = petInfoTpl:getHouseType(tpl)
  L_PetManager:asyncLoadPetDetailScene(customSceneId, function()
    C_UIMgr.CloseCutin()
    self:refreshPetMod()
  end)
  self.filter = L_PetConst.filterPetBox.grade
  self:initDropDown()
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.PetDetails)
end

function this:open()
  L_PetStore:playPetVoiceSound(self.configId, L_PetConst.PetSystemVoiceType.Idle)
  self:registerReddot(self.bindComponents.evolutionReddot, string.format(L_ReddotManager.DotDef.PetRankUp, self.petId))
  L_PetStore:clearFlyMsg()
end

function this:restorePetScene()
  local tpl = petInfoTpl:getTplById(self.configId)
  local customSceneId = petInfoTpl:getHouseType(tpl)
  local pet = L_PetStore:getPetItem(self.petId)
  L_PetManager:asyncLoadPetDetailScene(customSceneId, function()
    if self.savedWeatherTime and self.savedWeatherTimeTick then
      C_RealWeather.SetTime(self.savedWeatherTime)
      C_RealWeather.SetTimeTick(self.savedWeatherTimeTick)
    end
    C_WorldScenePlantStreaming.SetUseSmooth(true)
    self:setSceneObjActive(false)
    C_UIMgr.CloseCutin()
    if self.bind.activePetDisplay == true and pet then
      self:refreshPetMod()
    end
  end)
end

function this:show()
  L_PetManager:SetPetRotDisable(true)
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.PetDetails)
  if self.hasShown then
    self:restorePetScene()
  end
  self.hasShown = true
end

function this:hide()
  L_PetManager:SetPetRotDisable(false)
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans[systemId]
  local locker = node.locker
  for _, v in ipairs(node) do
    locker:tryShowOrHide(v, isUnlock)
  end
end

function this:destroyAllLocker()
  if self.systemToTrans ~= nil then
    for _, v in pairs(self.systemToTrans) do
      if v ~= nil then
        local locker = v.locker
        if locker then
          C_IntegrateMgr.SystemUnlockModule:RemoveLocker(locker)
        end
      end
    end
  end
end

function this:initSortWayList()
  local list = {
    L_Const.sortType.lv,
    L_Const.sortType.guid
  }
  
  local function func(type, order)
    self.data.sortParam = {type = type, order = order}
    self:sortPetList()
  end
  
  self.modules.module_sortWay:initModule(list, func)
end

function this:setCommonTopData(func, name)
  self.closeCurPageFunc = func
  C_IntegrateMgr.TopBarModule:SetTopBarBackName(name)
end

function this:setSceneObjActive(active)
  AzurWorldInstance:SetAllNodeVisible(active)
  AzurWorld.visbleMgr:SetWeatherActive(active, CS.Lens.Gameplay.Modules.BigWorld.VisibleConst.EWeatherHideReason.UIHide)
  AzurWorld.visbleMgr:UISetArtSceneVisible(active)
end

function this:close(options)
  this.super.close(self, options)
  self:stopIdlePerform(true)
  if self.callBack then
    self.callBack()
  end
  self:disableAllModule()
  self:destroyAllLocker()
  L_PhotoManager:clearPhotoEntity(self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet)
  L_PetStore:unListenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId)
  L_PetStore:unListenCallFunc(L_PetStore.event.removePet, self.onEvent_removePet)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshNewPet, self.onEvent_newPet)
  L_PetManager:removePetScene()
  self:setSceneObjActive(true)
end

function this:onTopChange(options)
  if C_DeviceGradeHelper.IsLowMemoryDevice() or not C_AppConfigManager.IsPcPlatformForUI then
    if options.topLv == 0 and 0 < options.lastTopLv and self.topStateDirty then
      self:restorePetScene()
      self.topStateDirty = false
    elseif options.topLv == 1 and options.lastTopLv < 1 then
      L_PetManager:removePetScene()
      self.savedWeatherTime = C_RealWeather.GetTimeOfDay()
      self.savedWeatherTimeTick = C_RealWeather.GetTimeTick()
      self.topStateDirty = true
      self:setSceneObjActive(true)
      if self.csharpPage then
        self.csharpPage.needCutback = true
      end
    end
  end
end

function this:onEvent_refreshPet(pet)
  if pet.guid ~= self.petId then
    return
  end
  local isFlashChanged = self:isCurrentPetModelFlashChanged(pet)
  if pet.id then
    self.configId = pet.id
  end
  self:initData(pet.guid)
  self:refreshHousePetList()
  if isFlashChanged then
    self:refreshPetMod()
  end
end

function this:onEvent_setCurPetId(guid, isModify)
  if guid and isModify and guid ~= 0 then
    self:initData(guid)
    self:refreshScene()
    self:refreshPetMod()
  end
end

function this:onEvent_removePet()
end

function this:onEvent_newPet(entity)
end

function this:initData(guid)
  local isSwitchPet = self.petId ~= guid
  if isSwitchPet then
    self:stopIdlePerform(true)
    self:resetIdlePerformRuntime(true)
  end
  if guid == 0 or nil then
    self:hidePetDisplay()
  else
    self.petId = guid
    self.bind.currentPetDisplay = true
    self:registerReddot(self.bindComponents.evolutionReddot, string.format(L_ReddotManager.DotDef.PetRankUp, self.petId))
    if self.bind.toggleModuleName == "modulePetDevelop" then
      self.bind.isOnToggleFeed = true
      self.modules.toggleModuleBar.modulePetDevelop:setShowPetGuid(self.petId)
      self.modules.toggleModuleBar.modulePetDevelop:refreshUI()
    end
  end
end

function this:refreshPetDisplay()
  local petList = L_PetStore:getPetList()
  local countList = {}
  if not table.isEmpty(self.compareData) then
    countList = L_PetStore:getFilterPetData(petList, self.compareData)
  else
    for i, v in pairs(petList) do
      table.insert(countList, v)
    end
  end
  if #countList < 1 then
    self:hidePetDisplay()
  else
    L_PetStore:setCurSelectPetId(countList[1].guid)
    self.petId = countList[1].guid
    self.bind.infoToggles = true
    self.methods.toggleInfoBtn(self)
    self.bind.activePetListButton = false
    self.bind.currentPetDisplay = true
  end
  self:refreshPetMod()
end

function this:refreshPetMod(callback)
  if self.bind.activePetDisplay == true then
    local pet = L_PetStore:getPetItem(self.petId)
    if pet then
      self.currentPetModelIsFlash = pet:hasFlashGene()
      self.modules.modulePetSceneMod.modulePetSceneMod:refreshPetMod(pet.id, pet:isSpecialPet(), pet:hasFlashGene(), callback, pet:getSkinInfo(), pet.colorMatId)
    else
      self.currentPetModelIsFlash = nil
      self.modules.modulePetSceneMod.modulePetSceneMod:disableMod()
    end
  end
end

function this:isCurrentPetModelFlashChanged(pet)
  if not pet then
    return false
  end
  local isFlash = pet:hasFlashGene()
  return self.currentPetModelIsFlash ~= nil and self.currentPetModelIsFlash ~= isFlash
end

function this:refreshScene()
  local pet = L_PetStore:getPetItem(self.petId)
  local tpl = petInfoTpl:getTplById(pet.id)
  local customSceneId = petInfoTpl:getHouseType(tpl)
  L_PetManager:loadPetDetailScene(customSceneId)
end

function this:initPetList(compareData)
  local petList = L_PetStore:getPetList()
  local countList = {}
  if compareData ~= nil then
    self.compareData = compareData
    countList = L_PetStore:getFilterPetData(petList, compareData)
  else
    for i, v in pairs(petList) do
      table.insert(countList, v)
    end
  end
  local list = countList
  local sortType = self.data.sortParam.type
  local lst = {}
  local equippedLst = {}
  for i, v in pairs(list) do
    if v.hero_id ~= nil and v.hero_id ~= 0 then
      table.insert(equippedLst, v)
    else
      table.insert(lst, v)
    end
  end
  if sortType == L_Const.sortType.lv then
    table.sort(equippedLst, function(a, b)
      if a.lv == b.lv then
        return a.guid < b.guid
      else
        return a.lv < b.lv
      end
    end)
    table.sort(lst, function(a, b)
      if a.lv == b.lv then
        return a.guid < b.guid
      else
        return a.lv < b.lv
      end
    end)
  elseif sortType == L_Const.sortType.guid then
    table.sort(equippedLst, function(a, b)
      return a.guid < b.guid
    end)
    table.sort(lst, function(a, b)
      return a.guid < b.guid
    end)
  end
  if self.data.sortParam.order == L_Const.sortOrder.DESC then
    local tmpList = {}
    for i = #lst, 1, -1 do
      table.insert(tmpList, lst[i])
    end
    lst = tmpList
    local equipList = {}
    for i = #equippedLst, 1, -1 do
      table.insert(equipList, equippedLst[i])
    end
    equippedLst = equipList
  end
  countList = {}
  for i, v in ipairs(equippedLst) do
    table.insert(countList, v)
  end
  for i, v in ipairs(lst) do
    table.insert(countList, v)
  end
  if #countList < 1 then
    self:hidePetDisplay()
  else
    local function onClick_Choose(cell)
      local petId = cell.bind.guid
      
      if L_PetStore:getCurSelectPetId() ~= petId then
        L_PetStore:setCurSelectPetId(petId)
        self.petId = petId
      end
    end
    
    L_PetStore:setCurSelectPetId(countList[1].guid)
    self.petId = countList[1].guid
    self.bind.petList:clear()
    local lst = {}
    for i = 1, #countList do
      table.insert(lst, {
        activeSelect = L_PetStore:getCurSelectPetId() == countList[i].guid,
        guid = countList[i].guid,
        itemType = L_Const.resType.pet,
        reddotName = string.format(L_ReddotManager.DotDef.PetNew, countList[i].guid),
        callback = onClick_Choose,
        index = i,
        nameColor = L_Const.colorHtml.white001
      })
    end
    self.bind.petList:insert_array(lst)
    self.bind.infoToggles = true
    self.methods.toggleInfoBtn(self)
    self.bind.currentPetDisplay = true
  end
  if compareData ~= nil then
    self.bind.showPetList = true
  end
end

function this:refreshPetList(list)
  local petList
  if list then
    petList = list
  else
    petList = L_PetStore:getPetList()
  end
  local countList = {}
  if not table.isEmpty(self.compareData) then
    countList = L_PetStore:getFilterPetData(petList, self.compareData)
  else
    for i, v in ipairs(petList) do
      table.insert(countList, v)
    end
  end
  if #self.bind.petList >= 1 then
    self.bind.petList:clear()
    if L_PetStore:getCurSelectPetId() ~= nil then
      self.petId = L_PetStore:getCurSelectPetId()
    else
      self.petId = countList[1].guid
    end
    L_PetStore:setCurSelectPetId(self.petId)
    
    local function onClick_Choose(cell)
      local petId = cell.bind.guid
      if L_PetStore:getCurSelectPetId() ~= petId then
        L_PetStore:setCurSelectPetId(petId)
        self.petId = petId
      end
    end
    
    local lst = {}
    local focusIndex = 1
    for i = 1, #countList do
      focusIndex = L_PetStore:getCurSelectPetId() == countList[i].guid and i or focusIndex
      table.insert(lst, {
        activeSelect = L_PetStore:getCurSelectPetId() == countList[i].guid,
        guid = countList[i].guid,
        itemType = L_Const.resType.pet,
        reddotName = string.format(L_ReddotManager.DotDef.PetNew, countList[i].guid),
        callback = onClick_Choose,
        index = i,
        nameColor = L_Const.colorHtml.white001
      })
    end
    self.bind.petList:insert_array(lst)
    self.bindComponents.petList:FocusItemIndex(focusIndex - 1)
  else
  end
end

function this:sortPetList()
  local list = L_PetStore:getPetList()
  local sortType = self.data.sortParam.type
  local lst = {}
  local equippedLst = {}
  for i, v in pairs(list) do
    if v.hero_id ~= nil and v.hero_id ~= 0 then
      table.insert(equippedLst, v)
    else
      table.insert(lst, v)
    end
  end
  if sortType == L_Const.sortType.lv then
    table.sort(equippedLst, function(a, b)
      if a.lv == b.lv then
        return a.guid < b.guid
      else
        return a.lv < b.lv
      end
    end)
    table.sort(lst, function(a, b)
      if a.lv == b.lv then
        return a.guid < b.guid
      else
        return a.lv < b.lv
      end
    end)
  elseif sortType == L_Const.sortType.guid then
    table.sort(equippedLst, function(a, b)
      return a.guid < b.guid
    end)
    table.sort(lst, function(a, b)
      return a.guid < b.guid
    end)
  end
  if self.data.sortParam.order == L_Const.sortOrder.DESC then
    local tmpList = {}
    for i = #lst, 1, -1 do
      table.insert(tmpList, lst[i])
    end
    lst = tmpList
    local equipList = {}
    for i = #equippedLst, 1, -1 do
      table.insert(equipList, equippedLst[i])
    end
    equippedLst = equipList
  end
  local totalList = {}
  for i, v in ipairs(equippedLst) do
    table.insert(totalList, v)
  end
  for i, v in ipairs(lst) do
    table.insert(totalList, v)
  end
  self:refreshPetList(totalList)
end

function this:hidePetDisplay()
  self.bind.petList:clear()
  self.bind.upBg = false
  self.bind.toggleModuleName = ""
  self.petId = 0
end

function this:disableAllModule()
  self.bind.toggleModuleName = ""
  self.bind.currentPetDisplay = false
end

function this:returnToDefaultModule()
  local pet_guid = self.petId
  if not math.isEmpty(pet_guid) then
    self.bind.toggleModuleName = "modulePetDevelop"
    self.bind.activePetDisplay = true
    self:initData(pet_guid)
    self:refreshHousePetList()
  end
end

function this:closePetFreeModule()
end

function this:playPageAnimation(name)
  if name ~= nil and name ~= "" then
    self.bindComponents.pageAnimation:Play(name)
  end
end

function this:playEvolutionTimeline(guid, prePetData, oldSkillInfo)
  local pet = L_PetStore:getPetItem(guid)
  L_CatalogStore:_triggerCommonGetPet(pet)
  L_UI:open("pagePetEvo", {
    guid = guid,
    prePetData = prePetData,
    oldSkillInfo = oldSkillInfo
  })
end

function this:showWarning(bool)
  self.bind.warning_pagePet = bool
  if bool then
    local expandSize = self.bindComponents.masterName.preferredWidth
    self.bindComponents.warningTrans.sizeDelta = C_Vector2(187 + expandSize, 40)
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.warningTrans)
  end
end

function this:showMasterIcon(bool, lv, hero)
  self.bind.masterIcon = bool
  if bool then
    local item_hero = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(hero))
    self.bind.masterLv = tostring(lv)
    if hero.guid == L_HeroStore:getDefaultHeroGuid() then
      L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.ImageHeroIcon, L_PlayerStore:getPlayerModHeadImgName())
      self.bind.masterName = L_PlayerStore:getPlayerName()
    else
      L_PhotoManager:clearPhotoEntity(self)
      self.bind.img_masterHero = item_hero.icon
      self.bind.masterName = item_hero.name
    end
    local expandSize = self.bindComponents.masterName.preferredWidth
    self.bindComponents.masterIcon.sizeDelta = C_Vector2(131 + expandSize, 57)
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.masterIcon)
    local result = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.petFavor)
    self.bind.go_petFavor = result
    if result then
      local pet = L_PetStore:getPetItem(self.petId)
      self.bind.txt_petFavorLv = tostring(pet:petFavorLv())
    end
  end
end

function this:closePetAdvance()
  self:returnToDefaultModule()
end

function this:checkNoValidInput()
  if L_DeviceTpl:getIsPc() then
    if Unity.Input.anyKeyDown then
      return false
    end
    if Unity.Input.GetMouseButtonDown(0) or Unity.Input.GetMouseButtonDown(1) or Unity.Input.GetMouseButtonDown(2) then
      return false
    end
    return true
  end
  if 0 < Unity.Input.touchCount then
    return false
  end
  if Unity.Input.GetMouseButtonDown(0) or Unity.Input.GetMouseButton(0) or Unity.Input.GetMouseButtonUp(0) then
    return false
  end
  return true
end

function this:update()
  self:checkPlayIdlePerform()
  self:updateIdleLoopAudio()
end

function this:getRandomIdleWaitingTime()
  local minTime = tonumber(self.displayWaitingTimeMin) or DEFAULT_IDLE_WAITING_TIME[1]
  local maxTime = tonumber(self.displayWaitingTimeMax) or DEFAULT_IDLE_WAITING_TIME[2]
  if minTime > maxTime then
    maxTime = minTime
  end
  if minTime == maxTime then
    return minTime
  end
  return minTime + math.random() * (maxTime - minTime)
end

function this:getIdleNowTime()
  return C_Time.realtimeSinceStartup or C_Time.time or 0
end

function this:resetIdlePerformRuntime(resetRandomCount)
  self.idleNoInputTime = 0
  self.idleNoInputStartTime = self:getIdleNowTime()
  self.currentWaitingTime = self:getRandomIdleWaitingTime()
  if resetRandomCount then
    self.idleRandomCountA = 0
  end
end

function this:canCheckIdlePerform()
  if not self.isBind then
    return false
  end
  if math.isEmpty(self.petId) then
    return false
  end
  if self.bind.toggleModuleName ~= "modulePetDevelop" then
    return false
  end
  if not self.bind.activePetDisplay then
    return false
  end
  return true
end

function this:getNextIdleExpressionId(isForce)
  if isForce ~= true and self.idleRandomCountA >= self.idleSleepTriggerCount then
    self.idleRandomCountA = 0
    return self.idleSleepExpressionId
  end
  if table.isEmpty(self.idleRandomExpressionIds) then
    return self.idleSleepExpressionId
  end
  local randomIndex = math.random(1, #self.idleRandomExpressionIds)
  local expressionId = self.idleRandomExpressionIds[randomIndex]
  self.idleRandomCountA = self.idleRandomCountA + 1
  return expressionId
end

function this:getIdlePerformShowTime(expressionId)
  if expressionId == self.idleSleepExpressionId then
    return self.sleepExpressionShowTime
  end
  return self.happyExpressionShowTime
end

function this:getIdlePerformExpressionId(expressionIndex)
  return IDLE_PERFORM_EXPRESSION_ID_MAP[expressionIndex] or expressionIndex
end

function this:getIdlePerformPetObject()
  local inPlacePet = L_PetManager:getInPlacePet()
  if table.isEmpty(inPlacePet) then
    return nil
  end
  return inPlacePet.obj
end

function this:getIdlePerformEffectMountTransform(petObj, expressionId)
  local specialNodeName = IDLE_PERFORM_EFFECT_SPECIAL_MOUNT_NODE_NAME_MAP[expressionId]
  if not string.isEmpty(specialNodeName) then
    local specialMountTrans = L_GameUtil.findTranByName(petObj, specialNodeName)
    if L_CommonUtil.isValid(specialMountTrans) then
      return specialMountTrans
    end
  end
  for _, nodeName in ipairs(IDLE_PERFORM_EFFECT_MOUNT_NODE_NAME_LIST) do
    local mountTrans = L_GameUtil.findTranByName(petObj, nodeName)
    if L_CommonUtil.isValid(mountTrans) then
      return mountTrans
    end
  end
  return petObj.transform
end

function this:getIdlePerformEffectScale()
  local pet = L_PetStore:getPetItem(self.petId)
  local petConfigId = pet and pet.id or self.configId
  if math.isEmpty(petConfigId) then
    return 1
  end
  local petTpl = petInfoTpl:getTplById(petConfigId)
  if not petTpl then
    return 1
  end
  local unitId = petInfoTpl:getUnitID(petTpl)
  if math.isEmpty(unitId) then
    return 1
  end
  local unitCfg = unitTpl:getTplById(unitId)
  if not unitCfg then
    return 1
  end
  local effectScale = unitTpl:getEffectScale(unitCfg)
  if type(effectScale) == "table" then
    effectScale = effectScale[1]
  end
  effectScale = tonumber(effectScale) or 1000
  if effectScale <= 0 then
    effectScale = 1000
  end
  return effectScale / 1000
end

function this:playIdlePerformEffect(expressionId, isLoop)
  local effectName = self.idleEffectNameList and self.idleEffectNameList[expressionId]
  if string.isEmpty(effectName) then
    return
  end
  local petObj = self:getIdlePerformPetObject()
  if not L_CommonUtil.isValid(petObj) then
    return
  end
  local effectPath = effectName
  if string.isEmpty(effectPath) then
    return
  end
  self:stopIdlePerformEffect()
  local effectObj = L_ResPool:syncGameObject(effectPath)
  if not L_CommonUtil.isValid(effectObj) then
    return
  end
  local mountTrans = self:getIdlePerformEffectMountTransform(petObj, expressionId)
  effectObj.transform:SetParent(mountTrans)
  L_Vector3.setLocalPos(effectObj.transform, L_Vector3.new(0, 0, 0))
  L_Vector3.setLocalRot(effectObj.transform, L_Vector3.new(0, 0, 0))
  L_Vector3.setSize(effectObj.transform, self:getIdlePerformEffectScale())
  L_CommonUtil.setObjActive(effectObj, true)
  self.idleEffectObj = effectObj
end

function this:stopIdlePerformEffect()
  if L_CommonUtil.isValid(self.idleEffectObj) then
    C_GameObject.Destroy(self.idleEffectObj)
  end
  self.idleEffectObj = nil
end

function this:getIdlePerformAudioEvent(expressionId)
  local audioEventTpl = self.idleAudioEventList and self.idleAudioEventList[expressionId]
  if string.isEmpty(audioEventTpl) then
    return nil
  end
  if not string.find(audioEventTpl, "%%s") then
    return audioEventTpl
  end
  local pet = L_PetStore:getPetItem(self.petId)
  local petConfigId = pet and pet.id or self.configId
  if math.isEmpty(petConfigId) then
    return nil
  end
  return string.format(audioEventTpl, tostring(petConfigId))
end

function this:playIdlePerformAudio(expressionId, isLoop)
  local audioEvent = self:getIdlePerformAudioEvent(expressionId)
  if string.isEmpty(audioEvent) then
    return
  end
  if not isLoop then
    C_AudioManager.Play(audioEvent)
    return
  end
  self:stopIdlePerformAudio()
  self.idleLoopAudioEvent = audioEvent
  self:updateIdleLoopAudio()
end

function this:updateIdleLoopAudio()
  if string.isEmpty(self.idleLoopAudioEvent) then
    return
  end
  if L_CommonUtil.isValid(self.idleLoopAudioSource) and not self.idleLoopAudioSource.EventIsEnd then
    return
  end
  if L_CommonUtil.isValid(self.idleLoopAudioSource) then
    C_AudioManager.FreeSource(self.idleLoopAudioSource)
    self.idleLoopAudioSource = nil
  end
  self.idleLoopAudioSource = C_AudioManager.Play(self.idleLoopAudioEvent)
  if L_CommonUtil.isValid(self.idleLoopAudioSource) then
    self.idleLoopAudioSource:SetAutoRelease(false)
    self.idleLoopAudioSource:SetStopTransitionDuration(0)
  end
end

function this:stopIdlePerformAudio()
  if L_CommonUtil.isValid(self.idleLoopAudioSource) then
    C_AudioManager.FreeSource(self.idleLoopAudioSource)
  end
  self.idleLoopAudioSource = nil
  self.idleLoopAudioEvent = nil
end

function this:startIdlePerform(expressionId)
  local showTime = self:getIdlePerformShowTime(expressionId)
  if showTime <= 0 then
    return
  end
  self.idlePerforming = true
  self.idlePerformExpressionId = expressionId
  self.idlePerformRemainTime = showTime
  self.idleInputDuringPerform = false
  local realExpressionId = self:getIdlePerformExpressionId(expressionId)
  L_PetManager:playExpression(realExpressionId)
  local isSleep = expressionId == self.idleSleepExpressionId
  self:playIdlePerformEffect(expressionId, isSleep)
  self:playIdlePerformAudio(expressionId, isSleep)
end

function this:stopIdlePerform(forceToDefaultExpression)
  if forceToDefaultExpression then
    L_PetManager:playExpression()
  end
  self:stopIdlePerformEffect()
  self:stopIdlePerformAudio()
  self.idlePerforming = false
  self.idlePerformExpressionId = nil
  self.idlePerformRemainTime = 0
  self.idleInputDuringPerform = false
end

function this:initIdlePerformParams()
  local waitingTimeConf = L_GameConstTpl:getData("KIBO_BOX_DISPLAY_WAITING_TIME", L_Const.GameTplType.list_int, DEFAULT_IDLE_WAITING_TIME)
  if table.isEmpty(waitingTimeConf) then
    waitingTimeConf = DEFAULT_IDLE_WAITING_TIME
  end
  self.displayWaitingTimeMin = tonumber(waitingTimeConf[1]) or DEFAULT_IDLE_WAITING_TIME[1]
  self.displayWaitingTimeMax = tonumber(waitingTimeConf[2]) or self.displayWaitingTimeMin
  self.happyExpressionShowTime = L_GameConstTpl:getData("KIBO_BOX_HAPPY_PLAYTIME", L_Const.GameTplType.int, 3) or 3
  self.sleepExpressionShowTime = L_GameConstTpl:getData("KIBO_BOX_SLEEP_PLAYTIME", L_Const.GameTplType.int, 15) or 15
  self.idlePerformEnable = true
  self.idleSleepExpressionId = DEFAULT_IDLE_SLEEP_EXPRESSION_ID
  self.idleSleepTriggerCount = DEFAULT_IDLE_SLEEP_TRIGGER_COUNT
  self.idleRandomExpressionIds = DEFAULT_IDLE_RANDOM_EXPRESSION_IDS
  self.idleEffectNameList = {}
  for expressionId, effectName in pairs(IDLE_PERFORM_EFFECT_NAME_LIST) do
    self.idleEffectNameList[expressionId] = effectName
  end
  self.idleAudioEventList = {}
  for expressionId, audioEvent in pairs(IDLE_PERFORM_AUDIO_EVENT_LIST) do
    self.idleAudioEventList[expressionId] = audioEvent
  end
  self:stopIdlePerform(true)
  self:resetIdlePerformRuntime(true)
end

function this:checkPlayIdlePerform()
  if self.idlePerformEnable ~= true then
    return
  end
  local canCheck = self:canCheckIdlePerform()
  if not canCheck then
    if self.idlePerforming then
      self:stopIdlePerform(true)
    end
    self:resetIdlePerformRuntime(false)
    return
  end
  local nowTime = self:getIdleNowTime()
  if math.isEmpty(self.currentWaitingTime) then
    self.currentWaitingTime = self:getRandomIdleWaitingTime()
  end
  if math.isEmpty(self.idleNoInputStartTime) then
    self.idleNoInputStartTime = nowTime
  end
  local noValidInput = self:checkNoValidInput()
  if self.idlePerforming then
    local dt = C_Time.unscaledDeltaTime
    if dt <= 0 then
      return
    end
    if not noValidInput then
      self.idleInputDuringPerform = true
      if self.idlePerformExpressionId == self.idleSleepExpressionId then
        self:stopIdlePerform(true)
        self:resetIdlePerformRuntime(false)
        return
      end
    end
    self.idlePerformRemainTime = self.idlePerformRemainTime - dt
    if 0 >= self.idlePerformRemainTime then
      self:stopIdlePerform(true)
      self:resetIdlePerformRuntime(false)
    end
    return
  end
  if not noValidInput then
    self:resetIdlePerformRuntime(false)
    return
  end
  self.idleNoInputTime = math.max(0, nowTime - self.idleNoInputStartTime)
  if self.idleNoInputTime < self.currentWaitingTime then
    return
  end
  self.idleNoInputTime = 0
  self.idleNoInputStartTime = nowTime
  self.currentWaitingTime = self:getRandomIdleWaitingTime()
  local expressionId = self:getNextIdleExpressionId()
  self:startIdlePerform(expressionId)
end

function this:clickPetInteract()
  if self.idlePerformExpressionId and self.idlePerformExpressionId ~= self.idleSleepExpressionId then
    return
  end
  self:resetIdlePerformRuntime(false)
  self.idleNoInputTime = 0
  self.idleNoInputStartTime = self:getIdleNowTime()
  self.currentWaitingTime = self:getRandomIdleWaitingTime()
  local expressionId = self:getNextIdleExpressionId(true)
  self:startIdlePerform(expressionId)
end

function this:initHousePetList()
  local curPetId = self.petId
  if math.isEmpty(curPetId) then
    return {}
  end
  local allBoxList = L_PetStore:getPetBoxList()
  local targetBoxIndex, targetSlotIndex
  for boxIndex, boxList in ipairs(allBoxList) do
    for slotIndex, guid in ipairs(boxList) do
      if guid == curPetId then
        targetBoxIndex = boxIndex
        targetSlotIndex = slotIndex
        break
      end
    end
    if targetBoxIndex then
      break
    end
  end
  if not targetBoxIndex then
    return {}
  end
  local boxList = L_PetStore:getPetBoxList(targetBoxIndex)
  if not boxList then
    return {}
  end
  local result = {}
  local curPetIndex
  for slotIndex, guid in ipairs(boxList) do
    if not math.isEmpty(guid) and guid ~= 0 then
      if slotIndex == targetSlotIndex then
        curPetIndex = #result + 1
      end
      table.insert(result, guid)
    end
  end
  return result, curPetIndex
end

function this:refreshHousePetList()
  local guidList, curPetIndex = self:initHousePetList()
  if not guidList or #guidList == 0 then
    self.bind.list_box_pet:clear()
    return
  end
  local petStore = L_PetStore
  local curPetId = self.petId
  
  local function onClick_Choose(cell)
    local petId = cell.bind.guid
    if not math.isEmpty(petId) and petStore:getCurSelectPetId() ~= petId then
      local lastPetId = petStore:getCurSelectPetId()
      local sceneMod = self.modules.modulePetSceneMod.modulePetSceneMod
      local savedEuler = sceneMod.modEuler and L_Vector3.new(sceneMod.modEuler.x, sceneMod.modEuler.y, sceneMod.modEuler.z) or nil
      local isStarSoulTab = false
      local petDevelopModule = self.modules.toggleModuleBar.modulePetDevelop
      if petDevelopModule and petDevelopModule.tabIdx == 2 then
        isStarSoulTab = true
      end
      for i = 1, #self.modules.list_box_pet do
        local petCell = self.modules.list_box_pet[i]
        if petCell and petCell.bind and petCell.bind.guid == lastPetId then
          petCell:setGifPlay(false)
          break
        end
      end
      petStore:setCurSelectPetId(petId)
      for i = 1, #self.modules.list_box_pet do
        local petCell = self.modules.list_box_pet[i]
        if petCell and petCell.bind and petCell.bind.guid == petId then
          petCell:setGifPlay(true)
          break
        end
      end
      if savedEuler then
        sceneMod.modEuler = savedEuler
        L_PetManager:setScenePetRot(savedEuler)
      end
      if isStarSoulTab then
        L_PetManager:switchToStarSoul()
      end
    end
  end
  
  local lst = {}
  for i, guid in ipairs(guidList) do
    local cell = {}
    local pet = petStore:getPetItem(guid)
    if not table.isEmpty(pet) and not math.isEmpty(guid) then
      cell.guid = guid
      cell.itemType = L_Const.resType.pet
      cell.choice = guid == curPetId
      cell.callback = onClick_Choose
      cell.originBoxIndex = nil
      cell.originSlot = i
      cell.isFilterItem = false
      cell.slotIndex = i
      cell.pageType = L_PetConst.PageType.House
      cell.reddotName = string.format(L_ReddotManager.DotDef.PetNew, guid)
      cell.reddotGeneName = string.format(L_ReddotManager.DotDef.PetGeneMutation, guid)
    end
    table.insert(lst, cell)
  end
  if #self.bind.list_box_pet ~= #lst then
    self.bind.list_box_pet:clear()
    self.bind.list_box_pet:insert_array(lst)
  else
    for i = 1, #lst do
      if lst[i].guid then
        self.bind.list_box_pet:change(i, lst[i])
      else
        self.bind.list_box_pet[i].guid = nil
        self.modules.list_box_pet[i]:refresh()
      end
    end
  end
  if curPetIndex then
    self.bindComponents.list_box_pet:FocusItemIndex(curPetIndex - 1)
  end
end

function this:initDropDown()
  local tmp = {}
  for index, filterType in ipairs(self.filterTypeOrder) do
    local typeKey = self.filterType[filterType]
    local isActiveLine = index ~= #self.filterTypeOrder
    table.insert(tmp, {
      index = filterType,
      type = L_WordsTpl:getValue(typeKey),
      txt_name = L_WordsTpl:getValue(typeKey),
      go_icon = false,
      txt_name_h = L_WordsTpl:getValue(typeKey),
      go_line = isActiveLine
    })
  end
  local curTypeKey = self.filterType[self.filter]
  self.bind.txt_dropDown = curTypeKey and L_WordsTpl:getValue(curTypeKey) or ""
  self.bind.list_dropdown:clear()
  self.bind.list_dropdown:insert_array(tmp)
end

function this:refreshFilterActive()
  for i = 1, #self.bind.list_dropdown do
    local index = self.bind.list_dropdown:getValue(i, "index")
    local itemCls = self.bind.list_dropdown:getItemCls(i)
    if itemCls and itemCls.setActive then
      itemCls:setActive(index == self.filter)
    end
  end
end

return this
