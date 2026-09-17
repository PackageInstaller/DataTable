local cls = class("pagePetHatch", G_UIPageBase)
local rightShowEnums = {HatchEggInfo = 0, HatchQueue = 1}
local columnNum = L_DeviceTpl:getIsPc() and 8 or 7
local minLineNum = L_DeviceTpl:getIsPc() and 4 or 3

function cls.bind()
  return {
    txt_bld_lv = "",
    txt_bld_name = "",
    active_btnUpgrade = false,
    active_maxLvNode = false,
    grid_petEgg = {
      moduleName = "pages/pet/cellPetEggItem"
    },
    modulePetHatchEggInfo = {
      moduleName = "pages/pet/modulePetHatchEggInfo"
    },
    active_modulePetHatchEggInfo = false,
    modulePetHatchQueue = {
      moduleName = "pages/pet/modulePetHatchQueue"
    },
    active_modulePetHatchQueue = false,
    modulePetInfo = {
      moduleName = "pages/product/modulePetInfo"
    }
  }
end

function cls.methods()
  return {
    onClick_closeBtn = function(self)
      L_UI:close("pagePetHatch", nil, nil)
    end,
    onClick_switch = function(self)
      self:switchRightShow()
    end,
    onClick_upgrade = function(self)
      if L_HomeStore:checkHomeBuildingMaxLv(self.buildingGuid) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_home_manage_13"))
        return
      end
      L_UI:open("pageBuildingUpgrade", {
        guid = self.buildingGuid
      })
    end
  }
end

function cls:open(options)
  self.buildingGuid = options.buildingGuid
  self.buildType = options.buildType
  self.currentShowState = rightShowEnums.HatchEggInfo
  self:refreshHatchBuilding()
  L_HomeStore:listenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self.refreshHatchBuilding, self)
end

function cls:initPetWorker()
  self.modules.modulePetInfo:initModule(self.buildingGuid)
end

function cls:refreshHatchBuilding()
  self:refreshView()
  self:InitRightShow()
  self:initPetWorker()
end

function cls:refreshView()
  self.bind.txt_bld_name = L_HomeStore:getHomeBuildingName(self.buildingGuid)
  local isMaxLv = L_HomeStore:checkHomeBuildingMaxLv(self.buildingGuid)
  self.bind.active_btnUpgrade = not isMaxLv
  self.bind.active_maxLvNode = isMaxLv
  if not isMaxLv then
    local lv = L_HomeStore:getHomeBuildingLevel(self.buildingGuid)
    self.bind.txt_bld_lv = string.format("Lv.%s", lv)
  end
  
  local function onClick_select(cell)
    local guid = cell.bind.data.guid
    L_PetStore:setCurSelectedEggGuid(guid)
    for i = 1, #self.bind.grid_petEgg do
      if self.bind.grid_petEgg[i].data.guid == guid then
        self.bind.grid_petEgg:change(i, {activeSelect = true})
      else
        self.bind.grid_petEgg:change(i, {activeSelect = false})
      end
    end
    self:refreshRightShow()
  end
  
  local petEggsList = self:getSortPetEggList()
  self:insertArrayDataList(petEggsList)
  L_PetStore:setCurSelectedEggGuid(petEggsList[1] and petEggsList[1].guid or 0)
  local petEggItems = {}
  for _, v in ipairs(petEggsList) do
    table.insert(petEggItems, {
      data = v,
      callback = onClick_select,
      bEmtpy = not v.guid
    })
  end
  self.bind.grid_petEgg:clear()
  self.bind.grid_petEgg:insert_array(petEggItems)
end

function cls:getSortPetEggList()
  local petEggsDic = L_PetStore:getPetEggList()
  local petEggsList = {}
  for _, v in pairs(petEggsDic) do
    if L_PetStore:checkPetEggInHomeBuilding(v.guid, self.buildingGuid) then
      table.insert(petEggsList, v)
    end
  end
  table.sort(petEggsList, function(a, b)
    local petEggStateA = L_PetStore:getPetEggUnitState(a.guid)
    local petEggStateB = L_PetStore:getPetEggUnitState(b.guid)
    local eggHatchTimeA = L_PetStore:getEggIncubationTime(a.configId)
    local eggHatchTimeB = L_PetStore:getEggIncubationTime(b.configId)
    local weightA = petEggStateA * 10000000 - eggHatchTimeA * 100 - L_PetStore:getEggElementId(a.configId)
    local weightB = petEggStateB * 10000000 - eggHatchTimeB * 100 - L_PetStore:getEggElementId(b.configId)
    if weightA == weightB then
      return a.guid < b.guid
    end
    return weightA > weightB
  end)
  return petEggsList
end

function cls:insertArrayDataList(dataList)
  local lineNum = math.ceil(#dataList / columnNum)
  lineNum = math.max(minLineNum, lineNum)
  self.bindComponents.produceTargetList.disableScroll = lineNum <= minLineNum
  local dataListCount = #dataList
  if dataListCount >= lineNum * columnNum then
    return
  end
  for i = dataListCount + 1, lineNum * columnNum do
    table.insert(dataList, {})
  end
end

function cls:InitRightShow()
  self.bind.active_modulePetHatchEggInfo = self.currentShowState == rightShowEnums.HatchEggInfo
  self.bind.active_modulePetHatchQueue = self.currentShowState == rightShowEnums.HatchQueue
  if self.currentShowState == rightShowEnums.HatchEggInfo then
    self.bind.modulePetHatchEggInfo.module:InitModule(L_PetStore:getCurSelectedEggGuid(), self.buildingGuid)
  elseif self.currentShowState == rightShowEnums.HatchQueue then
    self.bind.modulePetHatchQueue.module:InitModule(self.buildingGuid)
  end
end

function cls:switchRightShow()
  self.currentShowState = math.fmod(self.currentShowState + 1, 2)
  self:InitRightShow()
end

function cls:refreshRightShow()
  if self.currentShowState == rightShowEnums.HatchQueue then
    self:switchRightShow()
  elseif self.currentShowState == rightShowEnums.HatchEggInfo then
    self.bind.modulePetHatchEggInfo.module:InitModule(L_PetStore:getCurSelectedEggGuid(), self.buildingGuid)
  end
end

function cls:show()
end

function cls:hide()
end

function cls:close(options)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self.refreshHatchBuilding, self)
end

return cls
