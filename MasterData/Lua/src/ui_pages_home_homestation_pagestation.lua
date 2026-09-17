local this = class("pageStation", G_UIPageBase)
local _HomeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _homeBuildingCollectionTpl = L_GameTpl:getHomeBuildingCollectionTpl()
local _HomeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _homeTalentTpl = L_GameTpl:getHomeTalentTpl()
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()
local _homeLaborCapacityTpl = L_GameTpl:getHomeLaborCapacityTpl()
local _petHomeSizeTpl = L_GameTpl:getPetHomeSizeTpl()
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()
local _homeBuffTpl = L_GameTpl:getHomeBuffTpl()
local columnNum = 5
local minLineNum = 5
local HideNodeList_pageSelectCoolie = CS.System.Collections.Generic.List(CS.System.String)()
HideNodeList_pageSelectCoolie:Add(L_Const.WorldNode.PLAYER)
HideNodeList_pageSelectCoolie:Add(L_Const.WorldNode.PLAYERPETNODE)

function this.bind()
  return {
    pos_board = C_Vector2(0, 0),
    grid_pet = {
      moduleName = "pages/home/homeStation/cellSelectStation"
    },
    img_capacity = nil,
    txt_capacity = nil,
    txt_sizeNeed = nil,
    isOn_capacityInfo = false,
    canvasGroup_petContent = 1,
    txt_buildName = "",
    active_toggle_coolieInfo = true,
    go_pet = true,
    pos_pet = C_Vector3(70.1, 54.5, 0),
    scale_pet = C_Vector3(1, 1, 1),
    module_petIcon = {
      moduleName = "pages/pet/modulePetFrameIcon"
    },
    saietyCurScore = "",
    saietyMaxScore = "",
    img_build = "",
    active_commonBuild = true,
    list_labor = {
      moduleName = "pages/Pet/cellPetTipHomeLabor"
    },
    grid_drops = {
      moduleName = "pages/home/homeStation/cellStationDropItem"
    },
    go_noDispatchPart = false,
    txt_btnName = nil,
    go_btn = true,
    txt_ungoBtnName = nil,
    ungo_btn = false,
    module_stationTabList = {
      moduleName = "pages/home/homeStation/moduleStationTabListVertical"
    },
    go_cropTab = false,
    active_buildBottom = true,
    active_buildBottom_crop = false,
    active_btn_checkIfUnloadHomeHub = false,
    active_checkIfUnloadHomeHub_on = false,
    offsetMin_capacityViewPort = C_Vector2(0, 0),
    list_recommendPet = {
      moduleName = "pages/home/homeStation/cellRecommendPetInfo"
    },
    txt_noTalent = "",
    module_cellPetLaborInfoTagTips = {
      moduleName = "pages/pet/new/cellPetLaborInfoTagTips"
    },
    active_tips = false,
    active_tipsMask = false,
    active_emptyPet = false,
    active_gridPet = false,
    text_empty_pet_labor = "",
    text_empty_pet_content = ""
  }
end

function this.methods()
  return {
    onClick_confirm = function(self)
      self:onClickConfirm()
    end,
    onClick_confirm2 = function(self)
      self:onClickConfirm()
    end,
    grid_pet = {
      onClick_select = function(self, bind)
        self._selectGuid = bind.guid
        C_MJLog.LogInfo("[奇波派驻] 选择奇波guid = " .. self._selectGuid, C_ELogModule.Home)
        self:setBoxListSelect(self._selectGuid)
        self:initStationInfo()
        self.bindComponents.anim_coolieInfo:Stop()
        self.bindComponents.anim_coolieInfo:Play("anim_station_change")
      end
    },
    list_labor = {
      onclick_help = function(self, bindCp)
        self.bindComponents.tipsRoot.anchoredPosition = bindCp.rectInfo.anchoredPosition
        self.bind.active_tips = true
        self.bind.active_tipsMask = true
        self:setNavigationStatus(false)
        self:refreshBottomGamepadCuts(true)
      end
    },
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_btn_checkIfUnloadHomeHub = function(self)
      self._ifUnloadHomeHub = not self._ifUnloadHomeHub
      self:refreshBtnCheckIfUnloadHomeHubView()
    end,
    onclick_tipsMask = function(self)
      self.bind.active_tips = false
      self.bind.active_tipsMask = false
      self:setNavigationStatus(true)
      self:refreshBottomGamepadCuts(false)
    end,
    onClick_petManageFilterBtn = function(self)
      L_UI:open("pageHomeLaborManage", {
        FilterLabor = type(self._needLaborType) == "table" and self._needLaborType[1] or self._needLaborType
      })
    end,
    onClick_petManageBtn = function(self)
      L_UI:open("pageHomeLaborManage", {
        FilterLabor = type(self._needLaborType) == "table" and self._needLaborType[1] or self._needLaborType
      })
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:InitData(options)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.initPage, self)
  
  function self.onHomeBuildSyncHandler()
    self:initPage()
  end
  
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeBuildSync, self.onHomeBuildSyncHandler)
  self.onHomeHubSyncHandler = handler(self, self.initPage)
  L_HomeStore:getCsHomeStore():RegisterEvent(C_EHomeStoreEvent.HomeHubSync, self.onHomeHubSyncHandler)
  self:initPage()
end

function this:open()
end

function this:refreshPagePanel(options)
  if not self.isBind then
    return
  end
  local inBuildGuid = options.buildGuid
  if self._buildGuid ~= nil and self._buildGuid ~= inBuildGuid then
    self:InitData(options)
    self:initPage()
  end
end

function this:InitData(options)
  self._needCapacityId = options.capacityId
  self._needLaborType = options.needLaborType or L_HomeConst.HomeLaborId.ZHAO_LIAO
  self._selectGuid = options.selectGuid
  self._curSetGuid = options.selectGuid
  self._blockId = options.blockId
  self._stationType = options.stationType
  self._buildGuid = options.buildGuid
  self._needSize = options.petSize
  self._callback = options.callback
  self._ifUnloadHomeHub = false
end

function this:show()
  C_HomeUtil.ShowOrHideEntityNodeWithCustomNodeList(false, HideNodeList_pageSelectCoolie, "pageSelectCoolie")
  self:setBoxListSelect(self._selectGuid)
  local navMng = self.gameObject:GetComponent(typeof(C_UINavigationBinding))
  local targetArea = self.bind.go_noDispatchPart and "notDispatch" or "dispatched"
  navMng:AddPendingArea(targetArea)
  C_InputManager.SetGamepadUIInputMap(self.pageName, true)
  self:refreshBottomGamepadCuts(false)
end

function this:hide()
  C_HomeUtil.ShowOrHideEntityNodeWithCustomNodeList(true, HideNodeList_pageSelectCoolie, "pageSelectCoolie")
  C_InputManager.SetGamepadUIInputMap(self.pageName, false)
end

function this:close(options)
  this.super.close(self, options)
  L_TimerManager:clearTimer(self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.initPage, self)
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeBuildSync, self.onHomeBuildSyncHandler)
  L_HomeStore:getCsHomeStore():UnregisterEvent(C_EHomeStoreEvent.HomeHubSync, self.onHomeHubSyncHandler)
end

function this:escHandle()
  if self.bind.active_tipsMask then
    self.methods.onclick_tipsMask(self)
  else
    L_UI:close(self.pageName)
  end
end

function this:setNavigationStatus(isEnabled)
  local navMng = self.gameObject:GetComponent(typeof(C_UINavigationBinding))
  if navMng ~= nil then
    navMng.navigationEnabled = isEnabled
  end
end

function this:refreshBottomGamepadCuts(isTipOn)
  local groupName = ""
  if isTipOn then
    groupName = "OnTips"
  elseif self.bind.go_noDispatchPart then
    groupName = "NoKibo"
  else
    groupName = "Default"
  end
  local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    moduleOrPageName = self.pageName,
    changeGroupName = groupName
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
end

function this:refreshView(capacityId, selectGuid, needLaborType)
  self._needCapacityId = capacityId
  self._selectGuid = selectGuid
  self._needLaborType = needLaborType
  self:initPage()
end

function this:initPage()
  local tpl_capacity = _homeLaborCapacityTpl:getTplById(self._needCapacityId)
  self.bind.img_capacity = _homeLaborCapacityTpl:getIconLight(tpl_capacity)
  self.bind.txt_capacity = _homeLaborTypeTpl:getLaborName(_homeLaborTypeTpl:getTplById(_homeLaborCapacityTpl:getLaborType(tpl_capacity)))
  local txt = self:getPetSizeDesc()
  self.bind.txt_sizeNeed = txt
  self:freshBoxList()
end

function this:isStationed(petGuid)
  if self._needCapacityId == L_HomeConst.homeLaborType.RANCH_PRODUCT then
    local _homeBlockTpl = L_GameTpl:getHomeBlockTpl()
    local defaultBlockId = _homeBlockTpl:getId(_homeBlockTpl:getBlockTypeList(L_HomeConst.blockType.RANCH)[1])
    local ranchData = C_HomeManager:GetHomeStore():GetRanchData(defaultBlockId)
    local slot = ranchData:GetSlotByGuid(petGuid)
    return not math.isEmpty(slot)
  else
    local csPetData = L_PetStore:getCsPetData(petGuid)
    return csPetData:GetIsInHomeHub()
  end
end

function this:freshBoxList()
  local allPets = L_PetStore:getPetList()
  local dataList = {}
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  for i, v in pairs(allPets) do
    if self:isStationed(v.guid) then
      if self._needCapacityId == L_HomeConst.homeLaborType.RANCH_PRODUCT then
        table.insert(dataList, {
          guid = v.guid,
          curSelect = self._selectGuid == v.guid,
          isCurStationed = self._curSetGuid == v.guid,
          isPasture = true,
          isCurStationedNum = self._curSetGuid == v.guid and 1 or 0,
          isWorkNum = v:isWorking() and 1 or 0,
          isRestNum = v:isRest() and 1 or 0,
          level = v.lv
        })
      else
        local tpl_pet_talent = _petHomeTalentTpl:getTplById(v.id)
        local C_PetData = C_PetStore:GetPet(v.guid)
        local C_LaborInfoList = C_PetData:GetLaborInfoList()
        if tpl_pet_talent and 0 < C_LaborInfoList.Count then
          local size = _petHomeTalentTpl:getSizeType(tpl_pet_talent)
          local node, index = table.ipairsFind(self._needSize, function(value)
            return value == size
          end)
          if index then
            if self._needLaborType then
              for i = 0, C_LaborInfoList.Count - 1 do
                local laborInfo = C_LaborInfoList[i]
                local laborId = laborInfo.laborId
                local isMatch = false
                if type(self._needLaborType) == "table" then
                  for _, needType in ipairs(self._needLaborType) do
                    if needType == laborId then
                      isMatch = true
                      break
                    end
                  end
                else
                  isMatch = self._needLaborType == laborId
                end
                if isMatch then
                  table.insert(dataList, {
                    guid = v.guid,
                    curSelect = self._selectGuid == v.guid,
                    isCurStationed = self._curSetGuid == v.guid,
                    isPasture = false,
                    needLaborType = self._needLaborType,
                    isCurStationedNum = self._curSetGuid == v.guid and 1 or 0,
                    isWorkNum = v:isWorking() and 1 or 0,
                    isRestNum = v:isRest() and 1 or 0,
                    level = v.lv
                  })
                end
              end
            else
              do
                local talent = v.talent_id or {}
                local node1, index1 = table.ipairsFind(talent, function(value)
                  local tpl_talent = _homeTalentTpl:getTplById(value)
                  local capacityId = _homeTalentTpl:getLaborCapacityId(tpl_talent)
                  return capacityId == self._needCapacityId
                end)
                if index1 then
                  table.insert(dataList, {
                    guid = v.guid,
                    curSelect = self._selectGuid == v.guid,
                    isCurStationed = self._curSetGuid == v.guid,
                    isPasture = false,
                    isCurStationedNum = self._curSetGuid == v.guid and 1 or 0,
                    isWorkNum = v:isWorking() and 1 or 0,
                    isRestNum = v:isRest() and 1 or 0,
                    level = v.lv
                  })
                end
              end
            end
          end
        end
      end
    end
  end
  local isEmpty = #dataList == 0
  self.bind.canvasGroup_petContent = isEmpty and 0.5 or 1
  self.bind.go_pet = not isEmpty
  self.bind.go_btn = not isEmpty
  self.bind.ungo_btn = false
  self.bind.go_noDispatchPart = isEmpty
  self.bind.active_toggle_coolieInfo = not isEmpty
  if isEmpty then
    self:refreshEmptyRecommendInfo()
  else
    self.bind.active_emptyPet = false
    self.bind.active_gridPet = true
    self:refreshTitleInfo()
  end
  L_CommonUtil.multipleSortByKey(dataList, {
    "-isCurStationedNum",
    "-isWorkNum",
    "-isRestNum",
    "level",
    "-guid"
  })
  local datalist_tmp = {}
  for i = 1, #dataList do
    table.insert(datalist_tmp, dataList[i])
  end
  local lineNum = math.ceil(#datalist_tmp / columnNum)
  lineNum = math.max(lineNum, minLineNum)
  for i = 1, lineNum * columnNum - #dataList do
    table.insert(datalist_tmp, {guid = 0})
  end
  local hasSelect = false
  for i = 1, #datalist_tmp do
    if datalist_tmp[i].guid == self._selectGuid then
      hasSelect = true
    end
  end
  if not hasSelect then
    self._selectGuid = nil
  end
  if math.isEmpty(self._selectGuid) and datalist_tmp[1].guid > 0 then
    datalist_tmp[1].curSelect = true
  end
  self._selectGuid = math.isEmpty(self._selectGuid) and datalist_tmp[1].guid or self._selectGuid
  self.bind.grid_pet:freshAll(datalist_tmp)
  self:initStationInfo()
  self:initCropTab()
end

function this:getPetSizeDesc()
  local txt = ""
  for i, v in ipairs(self._needSize) do
    local tpl_size = _petHomeSizeTpl:getTplById(v)
    txt = string.concat(txt, _petHomeSizeTpl:getSizeName(tpl_size))
    if i < #self._needSize then
      txt = string.concat(txt, "/")
    end
  end
  return txt .. L_WordsTpl:getValue("ui_modStore_13")
end

function this:refreshTitleInfo()
  local firstLaborType = type(self._needLaborType) == "table" and self._needLaborType[1] or self._needLaborType
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(firstLaborType)
  local laborName = _homeLaborTypeTpl:getLaborName(homeLaborTypeTpl)
  self.bind.text_empty_pet_labor = L_WordsTpl:getValue("ui_home_building_unpetset_02", {
    [0] = laborName
  })
end

function this:refreshEmptyRecommendInfo()
  local sizeDesc = self:getPetSizeDesc()
  local firstLaborType = type(self._needLaborType) == "table" and self._needLaborType[1] or self._needLaborType
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(firstLaborType)
  local laborName = _homeLaborTypeTpl:getLaborName(homeLaborTypeTpl)
  self.bind.active_emptyPet = true
  self.bind.active_gridPet = false
  self.bind.txt_noTalent = L_WordsTpl:getValue("home_pet_dispatch_note")
  self.bind.text_empty_pet_content = L_WordsTpl:getValue("ui_home_building_unpetset_01", {
    [0] = laborName,
    [1] = sizeDesc
  })
  self.bind.text_empty_pet_labor = L_WordsTpl:getValue("ui_home_building_unpetset_02", {
    [0] = laborName
  })
  local dataList = _petHomeTalentTpl:getRecommendList(self._needCapacityId, self._needSize, self._needLaborType)
  self.bind.list_recommendPet:clear()
  self.bind.list_recommendPet:insert_array(dataList)
  if #self.bind.list_recommendPet > 4 then
    self.bindComponents.ContentPivot.pivot = C_Vector2(0, 1)
    self.bindComponents.ContentPivot.anchoredPosition = C_Vector2(0, 0)
  else
    self.bindComponents.ContentPivot.pivot = C_Vector2(0.5, 1)
    self.bindComponents.ContentPivot.anchoredPosition = C_Vector2(0, 0)
  end
end

function this:setBoxListSelect(selectGuid)
  for i, v in pairs(self.modules.grid_pet) do
    if not math.isEmpty(v.bind.guid) then
      local cell = v
      cell:setSingleSelect(v.bind.guid == selectGuid)
    end
  end
end

function this:initStationInfo()
  if self._stationType == L_HomeConst.StationType.HomeBuilding or self._stationType == L_HomeConst.StationType.HomeCollection then
    local serverData = L_HomeStore:getHomeBuildingByGuid(self._buildGuid)
    local buildTpl = _HomeBuildingTpl:getTplById(serverData.build_id)
    self.bind.img_build = _HomeBuildingTpl:getBuildingPixelIcon(buildTpl)
    local groupId = _HomeBuildingTpl:getGroupId(buildTpl)
    local groupTpl = _HomeBuildingGroupTpl:getTplById(groupId)
    self.bind.txt_buildName = L_WordsTpl:getValue("notice_pageSelectCoolie_04", {
      [0] = _HomeBuildingGroupTpl:getName(groupTpl)
    })
    self.bind.active_commonBuild = true
    self._buildType = _HomeBuildingGroupTpl:getType(groupTpl)
  elseif self._stationType == L_HomeConst.StationType.Ranch then
    self.bind.txt_buildName = L_WordsTpl:getValue("notice_pageSelectCoolie_05")
    self.bind.active_commonBuild = true
    self.bind.img_build = "UI/Atlas/HomeBuilding/tex_icon_homebuilding_ranch_pixel.png"
    self._buildType = 53
  elseif self._stationType == L_HomeConst.StationType.Collection then
    local collectionMapData = C_HomeManager:GetHomeStore().WorldCollectModule:GetDataByBuildGuid(self._buildGuid)
    local tpl_collection = _homeBuildingCollectionTpl:getTplById(collectionMapData.BuildId)
    local homeCollectionWorldTpl = L_GameTpl:getHomeCollectionWorldTpl()
    self.bind.img_build = homeCollectionWorldTpl:getPixelIcon(homeCollectionWorldTpl:getTplById(self._buildGuid))
    self.bind.txt_buildName = L_WordsTpl:getValue("notice_pageSelectCoolie_04", {
      [0] = _homeBuildingCollectionTpl:getName(tpl_collection)
    })
    self.bind.active_commonBuild = true
    local buildTpl = _HomeBuildingTpl:getTplById(collectionMapData.build_id)
    local groupId = _HomeBuildingTpl:getGroupId(buildTpl)
    local groupTpl = _HomeBuildingGroupTpl:getTplById(groupId)
    self._buildType = _HomeBuildingGroupTpl:getType(groupTpl)
  elseif self._stationType == L_HomeConst.StationType.Crop then
    local serverData = L_HomeStore:getHomeBuildingByGuid(self._buildGuid)
    local buildTpl = _HomeBuildingTpl:getTplById(serverData.build_id)
    local groupId = _HomeBuildingTpl:getGroupId(buildTpl)
    local groupTpl = _HomeBuildingGroupTpl:getTplById(groupId)
    self.bind.txt_buildName = L_WordsTpl:getValue("notice_pageSelectCoolie_04", {
      [0] = _HomeBuildingGroupTpl:getName(groupTpl)
    })
    self.bind.active_commonBuild = false
    self._buildType = _HomeBuildingGroupTpl:getType(groupTpl)
  end
  self.bind.active_buildBottom = self._stationType ~= L_HomeConst.StationType.Crop
  self.bind.active_buildBottom_crop = self._stationType == L_HomeConst.StationType.Crop
  if self._stationType == L_HomeConst.StationType.Crop then
    self.bind.scale_pet = C_Vector3(1.4, 1.4, 1.4)
    self.bind.pos_pet = C_Vector3(100.9, 68.9, 0)
  else
    self.bind.scale_pet = C_Vector3(1, 1, 1)
    self.bind.pos_pet = C_Vector3(70.1, 54.5, 0)
  end
  if self._stationType == L_HomeConst.StationType.Crop then
    local imgPath = "UI/Texture/FrameTexture/tex_frame_sow2.png"
    local imgIndex = 9
    if self._needCapacityId == L_HomeConst.homeLaborType.WATER then
      imgPath = "UI/Texture/FrameTexture/tex_frame_water1.png"
      imgIndex = 1
    elseif self._needCapacityId == L_HomeConst.homeLaborType.HARVEST then
      imgPath = "UI/Texture/FrameTexture/tex_frame_harvest1.png"
      imgIndex = 9
    end
    self.bindComponents.img_buildBottom_crop.frameSelectCount = imgIndex
    self.bindComponents.img_buildBottom_crop.frameAnimFps = 10
    self.bindComponents.img_buildBottom_crop:LoadTexture(imgPath)
    self.bind.active_buildBottom_crop = false
    self.bind.active_buildBottom_crop = true
  end
  local currentSaity = L_SatietyStore:getPetSatiety(self._selectGuid)
  local maxSaity = L_SatietyStore:getPetMaxSatiety(self._selectGuid)
  self.bind.saietyCurScore = string.format("%s", currentSaity)
  self.bind.saietyMaxScore = string.format("/%s", maxSaity)
  if math.isEmpty(self._selectGuid) then
    return
  end
  local isPasture = self._needCapacityId == L_HomeConst.homeLaborType.RANCH_PRODUCT
  self.bind.isOn_capacityInfo = not isPasture
  local selectIsSet = self._curSetGuid == self._selectGuid
  local stationLock = false
  local btnName = ""
  if selectIsSet then
    local csPetData = L_PetStore:getCsPetData(self._selectGuid)
    stationLock = csPetData and csPetData:GetIsStationLock() and true or false
    if stationLock then
      btnName = L_WordsTpl:getValue("ui_homebuilding_set_button_1")
      self.bind.ungo_btn = true
      self.bind.go_btn = false
    else
      btnName = L_WordsTpl:getValue("ui_homebuilding_set_button_2")
    end
  else
    btnName = L_WordsTpl:getValue("ui_homebuilding_set_button_2")
    self.bind.ungo_btn = false
    self.bind.go_btn = true
  end
  if isPasture then
    self:initDropList()
    self.bind.txt_btnName = btnName
    self.bind.txt_ungoBtnName = btnName
  else
    self:initCapacityList()
    self.bind.txt_btnName = btnName
    self.bind.txt_ungoBtnName = btnName
  end
  local pet = L_PetStore:getPetItem(self._selectGuid)
  local isPetPlaceRanch
  if pet.work_build == 201 then
    isPetPlaceRanch = true
  else
    isPetPlaceRanch = false
  end
  self.modules.module_petIcon:setGuid(self._selectGuid, true)
  self:refreshBtnCheckIfUnloadHomeHubView()
end

function this:initCropTab()
  local isValidType = false
  if type(self._needLaborType) == "table" then
    for _, needType in ipairs(self._needLaborType) do
      if needType == 5 or needType == 6 then
        isValidType = true
        break
      end
    end
  else
    isValidType = self._needLaborType == 5 or self._needLaborType == 6
  end
  if not isValidType then
    return
  end
  if C_HomeUtil.CheckIsCollectBuildingGuid(self._buildGuid) == true then
    return
  end
  self.bind.go_cropTab = true
  if not L_DeviceTpl:getIsPc() then
    self.bind.pos_board = C_Vector2(-90, 0)
  end
  local buildingData = C_HomeUtil.GetBuildData(self._buildGuid)
  if not buildingData then
    errorf("找不到 buildData, 可能在用家园接口获取采集建筑, 或是配表错误, buildGuid: " .. tostring(self._buildGuid))
    return
  end
  local autoData = buildingData.auto
  local plantPetGuid, waterPetGuid, harvestPetGuid
  if autoData then
    plantPetGuid = autoData.plantPetGuid
    waterPetGuid = autoData.waterPetGuid
    harvestPetGuid = autoData.harvestPetGuid
  end
  local idList = {}
  for i = 1, 3 do
    table.insert(idList, 1000 + i)
  end
  local selectIndex = 1001
  for i, v in ipairs(idList) do
    if v == self._needCapacityId then
      selectIndex = i
      break
    end
    if i == 1 then
      self._needCapacityId = self._needCapacityId or v
    end
  end
  self.modules.module_stationTabList:setData(idList, autoData, function(laborId, petGuid, laborType)
    local id = laborId
    if id == self._needCapacityId then
      return
    end
    self._needCapacityId = id
    self.selectIndex = laborId
    self._curSetGuid = petGuid
    self:refreshView(laborId, petGuid, laborType)
  end, selectIndex)
  self.modules.module_stationTabList:setSelectTabId(selectIndex)
end

function this:initDropList()
  local confId = L_PetStore:getPetItem(self._selectGuid).id
  local petTalentTpl = _petHomeTalentTpl:getTplById(confId)
  local dropIds = _petHomeTalentTpl:getFarmProducts(petTalentTpl)
  local itemMaps = {}
  local data = {}
  for i, v in pairs(dropIds) do
    local tpl_drop = _homeDropTpl:getTplById(v)
    local itemType, itemId = _homeDropTpl:getItemType(tpl_drop), _homeDropTpl:getItemId(tpl_drop)
    if itemType ~= L_Const.resType.petEgg then
      itemMaps[itemType] = itemMaps[itemType] or {}
      if not itemMaps[itemType][itemId[1]] then
        local configData = L_ItemTplManager:getItemConfig(itemType, itemId[1])
        table.insert(data, {
          itemType = itemType,
          itemId = itemId[1],
          txt_name = configData.name,
          go_mainDrop = i == 1
        })
      end
      itemMaps[itemType][itemId[1]] = true
    end
  end
  self.bind.grid_drops:clear()
  self.bind.grid_drops:insert_array(data)
end

function this:initCapacityList()
  local talent = L_PetStore:getPetItem(self._selectGuid).talent_id
  local petId = L_PetStore:getPetItem(self._selectGuid).id
  local C_HomeManager = AzurWorld.HomeMgr
  local C_PetStore = C_HomeManager:GetPetStore()
  local C_PetData = C_PetStore:GetPet(self._selectGuid)
  local C_LaborInfoList = C_PetData:GetLaborInfoList()
  local showParamsList = {}
  for i = 0, C_LaborInfoList.Count - 1 do
    local C_LaborInfo = C_LaborInfoList[i]
    local laborId = C_LaborInfo.laborId
    local isMatch = false
    if type(self._needLaborType) == "table" then
      for _, needType in ipairs(self._needLaborType) do
        if needType == laborId then
          isMatch = true
          break
        end
      end
    else
      isMatch = laborId == self._needLaborType
    end
    if isMatch then
      local C_TalentIds = C_PetData.talentIds
      local talentId
      if 0 < C_TalentIds.Count then
        local tmpTalentId = C_TalentIds[0]
        local homeTalentTpl = _homeTalentTpl:getTplById(tmpTalentId)
        local laborOfTmpTalentId = _homeTalentTpl:getLaborTypeIdOfTalent(homeTalentTpl)
        if laborOfTmpTalentId == C_LaborInfo.laborId then
          talentId = tmpTalentId
        end
      end
      local showParams = {
        petId = C_PetData.configId,
        isStationEnter = true,
        laborId = C_LaborInfo.laborId,
        laborGrade = C_LaborInfo.laborGrade,
        talentId = talentId,
        isSelectCoolie = true,
        stationBuildingType = self._stationType,
        needLaborType = self._needLaborType,
        upperLaborGrade = C_LaborInfo.upperLaborGrade,
        buildType = self._buildType,
        listenKey = C_InputManager_KeyType.EPageStationShowTips
      }
      table.insert(showParamsList, showParams)
    end
  end
  self.bind.list_labor:clear()
  self.bind.list_labor:insert_array(showParamsList)
end

function this:refreshBtnCheckIfUnloadHomeHubView()
  local selectIsSet = self._curSetGuid == self._selectGuid
  local stationLock = false
  if selectIsSet then
    local csPetData = L_PetStore:getCsPetData(self._selectGuid)
    stationLock = csPetData and csPetData:GetIsStationLock() and true or false
  end
  self.bind.active_btn_checkIfUnloadHomeHub = selectIsSet and stationLock
  self.bind.offsetMin_capacityViewPort = selectIsSet and C_Vector2(0, 0) or C_Vector2(0, -44)
  self.bind.active_checkIfUnloadHomeHub_on = self._ifUnloadHomeHub
end

function this:onClickConfirm()
  local selectPet = L_PetStore:getPetItem(self._selectGuid)
  local isPetEquip = selectPet:getHeroId() ~= nil and selectPet:getHeroId() ~= 0
  local isSelectSet = self._curSetGuid == self._selectGuid
  local workStatus = selectPet.work_status
  local isCollect = L_HomeConst.isWildLabor[self._needCapacityId] == true
  local curPetStationedNum = L_HomeStore:getCurPetStationedNum()
  local unlockedPetStationedNum = L_HomeStore:getUnlockedPetStationedNum()
  if isSelectSet then
    if workStatus == L_Const.PetStationedWorkStatusType.PSWST_WILD_WORK then
    elseif workStatus == L_Const.PetStationedWorkStatusType.PSWST_HOME_WORK and L_ProductManager:getIsHomeWorkBuildingNeedPet(selectPet.work_build) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("home_pet_hire_note2"))
      return
    end
  else
    if self._needCapacityId ~= L_HomeConst.homeLaborType.RANCH_PRODUCT and curPetStationedNum >= unlockedPetStationedNum and not L_HomeStore:checkPetIsInHomeHub(self._selectGuid) then
      if self._curSetGuid ~= nil and 0 < self._curSetGuid then
        local data_tip = {
          txtContent = L_WordsTpl:getValue("home_manage_petdispatch_exchangethispet"),
          confirmCallback = function()
            self._callback(self._selectGuid, self._ifUnloadHomeHub, self._needCapacityId, self._curSetGuid)
            self._curSetGuid = self._selectGuid
          end
        }
        L_GameUtil.showCommonTip(data_tip)
      else
        local data_tip = {
          txtContent = L_WordsTpl:getValue("home_manage_petdispatch_jump_exchangeotherpet"),
          confirmCallback = function()
            L_UI:open("pageStationReplace", {
              replaceStationPetGuid = self._selectGuid,
              confirmCallback = function(replacePetGuidInHomeHub)
                self._callback(self._selectGuid, self._ifUnloadHomeHub, self._needCapacityId, replacePetGuidInHomeHub)
                self._curSetGuid = self._selectGuid
              end
            })
          end
        }
        L_GameUtil.showCommonTip(data_tip)
      end
      return
    end
    if workStatus == L_Const.PetStationedWorkStatusType.PSWST_HOME_WORK and L_ProductManager:getIsHomeWorkBuildingNeedPet(selectPet.work_build) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("home_pet_hire_note3"))
      return
    end
  end
  
  local function equipKiboTipEndDo()
    L_UI:close("pageCommonTip")
    L_TimerManager:newOrResetTimer(L_HomeManager, "equipKiboTipEndDo", function()
      L_TimerManager:stopTimer(L_HomeManager, "equipKiboTipEndDo")
      
      local function endDo()
        L_UI:close(self.pageName, nil, function()
          if self._callback ~= nil then
            self._callback(self._selectGuid, self._ifUnloadHomeHub, self._needCapacityId)
          end
        end)
      end
      
      local petGameplayStatus = selectPet:getGameplayStatus()
      if petGameplayStatus == L_Const.PetState.PET_ROULETTE then
        local data_tip = {
          txtContent = L_WordsTpl:getValue("notice_qibo_mutex_mount_farm"),
          confirmCallback = endDo
        }
        L_GameUtil.showCommonTip(data_tip)
        return
      end
      if petGameplayStatus == L_Const.PetState.PET_WORKING or workStatus == L_Const.PetStationedWorkStatusType.PSWST_RANCH_WORK then
        local data_tip = {
          txtContent = L_WordsTpl:getValue("notice_homebuilding_set_occupy"),
          confirmCallback = endDo
        }
        L_GameUtil.showCommonTip(data_tip)
        return
      end
      endDo()
    end, 0.1)
  end
  
  if isPetEquip then
    local data_tip = {
      txtContent = L_WordsTpl:getValue("notice_qibo_mutex_team_farm"),
      confirmCallback = equipKiboTipEndDo
    }
    L_GameUtil.showCommonTip(data_tip)
    return
  end
  equipKiboTipEndDo()
end

return this
