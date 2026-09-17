local this = class("pagePetDecryptEditRoulette", G_UIPageBase)
local _petTpl = L_GameTpl:getPetTpl()
local _homeBlockTpl = L_GameTpl:getHomeBlockTpl()

function this.bind()
  return {
    scrollList_pet = {
      moduleName = "pages/petDecryptRoulette/cellEditDecrypt"
    },
    module_sortFilter = L_Const.ModuleInfo.SortFilterModule,
    module_petDecryptRoulette = {
      moduleName = "pages/petDecryptRoulette/modulePetDecryptRoulette"
    },
    active_petContent = false,
    active_emptyTips = false
  }
end

function this.methods()
  return {
    onClick_autoEquip = function(self)
      self:onBtnAutoSet()
    end,
    onClick_close = function(self)
      self:playAnimation(false)
    end
  }
end

function this:preOpen(options)
  options = options or {}
  self._callback = options.callback
end

function this:open(options)
  L_QuickRouletteStore:listenCallFunc(L_QuickRouletteStore.event.refreshPetPuzzleRouletteInfo, self.onEvent_refreshPetPuzzleRouletteInfo, self)
  self.onEvent_homeHubRefreshSync = self.onEvent_homeHubRefreshSync or handler(self, self.homeHubRefresh)
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeHubRefresh, self.onEvent_homeHubRefreshSync)
  self:initPage()
end

function this:initPage()
  self.selectIndex = self:getDefaultRouletteSelectIndex()
  self:initSortFilterModule()
  self:updatePetList()
  self:refreshPetRouletteInfo()
  self:playAnimation(true)
end

function this:initSortFilterModule()
  local function callback()
    self:updatePetList()
  end
  
  self._petSortFilter = self._petSortFilter or L_SortFilterManager:createSortFilter(L_SystemConst.enum.petPuzzleRoulette, nil, callback)
  self._petSortFilter:bindModule(self.modules.module_sortFilter)
end

function this:updatePetList()
  self:getPetData()
  self:insertArrayDataList()
end

function this:getPetData()
  self._dataList = self:getPetDataList()
  self:sortData()
end

function this:getPetDataList()
  local tmp = {}
  local pet = L_PetStore:getPetList()
  for _, v in pairs(pet) do
    local cell = {
      guid = v.guid,
      itemType = L_Const.resType.pet,
      itemId = v:petCfgId()
    }
    table.insert(tmp, cell)
  end
  self._petSortFilter:sortFilterList(tmp)
  return tmp
end

function this:sortData()
  table.sort(self._dataList, function(a, b)
    local indexA = L_QuickRouletteStore:checkInRoulette(L_Const.quickRouletteType.petPuzzle, a.guid)
    local indexB = L_QuickRouletteStore:checkInRoulette(L_Const.quickRouletteType.petPuzzle, b.guid)
    local PetCfgA = _petTpl:getTplById(a.itemId)
    local petCfgB = _petTpl:getTplById(b.itemId)
    local weightA = 10000 * (0 < indexA and 1 or 0) + (10 - indexA) * 100 + (10 - _petTpl:getFirstElement(PetCfgA))
    local weightB = 10000 * (0 < indexB and 1 or 0) + (10 - indexB) * 100 + (10 - _petTpl:getFirstElement(petCfgB))
    if weightA == weightB then
      if a.itemId == b.itemId then
        return a.guid < b.guid
      end
      return a.itemId < b.itemId
    end
    return weightA > weightB
  end)
end

function this:insertArrayDataList()
  local tmp = {}
  
  local function onClick_select(cell)
    if self.selectIndex <= 0 then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_puzzla_roulette02"))
      return
    end
    local gameplayStatus = L_Const.PetState.PET_NORMAL
    local pet = L_PetStore:getPetItem(cell.bind.guid)
    if pet then
      gameplayStatus = pet:getGameplayStatus()
    end
    if gameplayStatus == L_Const.PetState.PET_WORKING or gameplayStatus == L_Const.PetState.PET_RESTING or gameplayStatus == L_Const.PetState.PET_HUB then
      L_GameUtil.showCommonTip({
        txtContent = L_WordsTpl:getValue("notice_pet_puzzla_roulette03"),
        confirmCallback = function()
          if gameplayStatus == L_Const.PetState.PET_RESTING and pet.work_status == L_Const.PetStationedWorkStatusType.PSWST_RANCH_WORK then
            local defaultBlockId = _homeBlockTpl:getId(_homeBlockTpl:getBlockTypeList(L_HomeConst.blockType.RANCH)[1])
            local ranchData = C_HomeManager:GetHomeStore():GetRanchData(defaultBlockId)
            local slot = ranchData:GetSlotByGuid(cell.bind.guid)
            if slot then
              C_HomeManager:GetHomeStore():ReqSetProductPet(defaultBlockId, slot, cell.bind.guid, function(rspData, errorCode)
                if errorCode ~= 0 then
                  return
                end
                self:refreshLeaveInfo(self.selectIndex, cell.bind.guid)
              end)
            else
              L_HomeStore:reqPetExitHomeHub(cell.bind.guid, function(errorCode)
                if errorCode ~= 0 then
                  return
                end
                self:refreshLeaveInfo(self.selectIndex, cell.bind.guid)
              end)
            end
            return
          else
            L_HomeStore:reqPetExitHomeHub(cell.bind.guid, function(errorCode)
              if errorCode ~= 0 then
                return
              end
              self:refreshLeaveInfo(self.selectIndex, cell.bind.guid)
            end)
          end
        end
      })
      return
    end
    local rouletteInfo = L_QuickRouletteStore:getRouletteInfoByType(L_Const.quickRouletteType.petPuzzle)
    local nowIndex = L_QuickRouletteStore:checkInRoulette(L_Const.quickRouletteType.petPuzzle, cell.bind.guid)
    if 0 < nowIndex then
      rouletteInfo[nowIndex] = 0
    end
    rouletteInfo[self.selectIndex] = cell.bind.guid
    L_QuickRouletteStore:req_SaveRouletteInfo(L_Const.quickRouletteType.petPuzzle, rouletteInfo)
  end
  
  for index, v in ipairs(self._dataList or {}) do
    table.insert(tmp, {
      guid = v.guid,
      index = index,
      cbk = onClick_select,
      selected = L_QuickRouletteStore:checkInRoulette(L_Const.quickRouletteType.petPuzzle, v.guid) > 0
    })
  end
  self.bind.scrollList_pet:clear()
  self.bind.scrollList_pet:insert_array(tmp)
  self.bind.active_emptyTips = #tmp <= 0
  self.bind.active_petContent = 0 < #tmp
end

function this:refreshLeaveInfo(selectIndex, leaveGuid)
  local rouletteInfo = L_QuickRouletteStore:getRouletteInfoByType(L_Const.quickRouletteType.petPuzzle)
  local nowIndex = L_QuickRouletteStore:checkInRoulette(L_Const.quickRouletteType.petPuzzle, leaveGuid)
  if 0 < nowIndex then
    rouletteInfo[nowIndex] = 0
  end
  rouletteInfo[selectIndex] = leaveGuid
  L_QuickRouletteStore:req_SaveRouletteInfo(L_Const.quickRouletteType.petPuzzle, rouletteInfo)
end

function this:getDefaultRouletteSelectIndex()
  local index = self.selectIndex and self.selectIndex > 0 and self.selectIndex or 1
  local bFind = false
  local rouletteInfo = L_QuickRouletteStore:getRouletteInfoByType(L_Const.quickRouletteType.petPuzzle)
  for i = index, #rouletteInfo do
    if rouletteInfo[i] <= 0 then
      index = i
      bFind = true
      break
    end
  end
  if not bFind then
    for i = 1, index - 1 do
      if rouletteInfo[i] <= 0 then
        index = i
        break
      end
    end
  end
  if 0 < rouletteInfo[index] then
    return -1
  end
  return index
end

function this:homeHubRefresh(eventId, leave)
  if leave then
    local leavePets = leave:GetObject(0)
    for i, guid in pairs(leavePets) do
      local rouletteInfo = L_QuickRouletteStore:getRouletteInfoByType(L_Const.quickRouletteType.petPuzzle)
      local nowIndex = L_QuickRouletteStore:checkInRoulette(L_Const.quickRouletteType.petPuzzle, guid)
      if 0 < nowIndex then
        rouletteInfo[nowIndex] = 0
      end
      rouletteInfo[self.selectIndex] = guid
      L_QuickRouletteStore:req_SaveRouletteInfo(L_Const.quickRouletteType.petPuzzle, rouletteInfo)
    end
  end
end

function this:refreshPetRouletteInfo()
  local rouletteInfo = L_QuickRouletteStore:getRouletteInfoByType(L_Const.quickRouletteType.petPuzzle)
  local data = {}
  
  local function onClick_select(cell)
    if cell.bind.guid > 0 then
      rouletteInfo[cell.bind.index] = 0
      self.selectIndex = cell.bind.index
      L_QuickRouletteStore:req_SaveRouletteInfo(L_Const.quickRouletteType.petPuzzle, rouletteInfo)
      return
    end
    self.selectIndex = cell.bind.index
    self:setPetRouletteListActive(self.selectIndex)
  end
  
  for index, guid in ipairs(rouletteInfo) do
    table.insert(data, {
      guid = guid,
      index = index,
      cbk = onClick_select
    })
  end
  local modulePetDecryptRoulette = self.modules.module_petDecryptRoulette
  modulePetDecryptRoulette:refreshPetData(data)
  self:setPetRouletteListActive(self.selectIndex)
end

function this:setPetRouletteListActive(selectIndex)
  local modulePetDecryptRoulette = self.modules.module_petDecryptRoulette
  modulePetDecryptRoulette:setPetRouletteActive(selectIndex)
end

function this:onEvent_refreshPetPuzzleRouletteInfo()
  self.selectIndex = self:getDefaultRouletteSelectIndex()
  self:updatePetList()
  self:refreshPetRouletteInfo()
end

function this:checkPetBusy(pet)
  local gameplayStatus = L_Const.PetState.PET_NORMAL
  gameplayStatus = pet:getGameplayStatus()
  return gameplayStatus == L_Const.PetState.PET_WORKING or gameplayStatus == L_Const.PetState.PET_RESTING or gameplayStatus == L_Const.PetState.PET_HUB
end

function this:getAutoSetData()
  local tmp = {}
  local result = {}
  for i = 1, 9 do
    table.insert(tmp, 0)
  end
  local mainTmp = {}
  local viceTmp = {}
  local pet = L_PetStore:getPetList()
  for _, v in pairs(pet) do
    if not self:checkPetBusy(v) then
      local element = _petTpl:getElement(_petTpl:getTplById(v:petCfgId()))
      if not mainTmp[element[1]] then
        mainTmp[element[1]] = {}
      end
      table.insert(mainTmp[element[1]], {
        guid = v.guid,
        lv = v:petLv(),
        score = v:getPetGrade()
      })
      for i = 2, #element do
        if not viceTmp[element[i]] then
          viceTmp[element[i]] = {}
        end
        table.insert(viceTmp[element[i]], {
          guid = v.guid,
          lv = v:petLv(),
          score = v:getPetGrade()
        })
      end
    end
  end
  for elementId, v in pairs(mainTmp) do
    table.sort(v, function(a, b)
      local weightA = a.lv * 1000000 + a.score
      local weightB = b.lv * 1000000 + b.score
      if weightA == weightB then
        return a.guid < b.guid
      end
      return weightA > weightB
    end)
  end
  for elementId, v in pairs(viceTmp) do
    table.sort(v, function(a, b)
      local weightA = a.lv * 1000000 + a.score
      local weightB = b.lv * 1000000 + b.score
      if weightA == weightB then
        return a.guid < b.guid
      end
      return weightA > weightB
    end)
  end
  for i = 1, 9 do
    if mainTmp[i] and tmp[i] == 0 then
      for _, v in ipairs(mainTmp[i]) do
        tmp[i] = v.guid
        table.insert(result, v.guid)
        break
      end
    end
  end
  for i = 1, 9 do
    if tmp[i] == 0 and viceTmp[i] then
      for _, v in ipairs(viceTmp[i]) do
        local bUsed = false
        for i = 1, 9 do
          if tmp[i] == v.guid then
            bUsed = true
            break
          end
        end
        if not bUsed then
          tmp[i] = v.guid
          table.insert(result, v.guid)
          break
        end
      end
    end
  end
  for i = 1, 9 do
    if tmp[i] == 0 and mainTmp[i] then
      for _, v in ipairs(mainTmp[i]) do
        local bUsed = false
        for i = 1, 9 do
          if tmp[i] == v.guid then
            bUsed = true
            break
          end
        end
        if not bUsed then
          tmp[i] = v.guid
          table.insert(result, v.guid)
          break
        end
      end
    end
  end
  for i = 1, 9 do
    if tmp[i] == 0 and viceTmp[i] then
      for _, v in ipairs(viceTmp[i]) do
        local bUsed = false
        for i = 1, 9 do
          if tmp[i] == v.guid then
            bUsed = true
            break
          end
        end
        if not bUsed then
          tmp[i] = v.guid
          table.insert(result, v.guid)
          break
        end
      end
    end
  end
  for i = 1, 9 do
    result[i] = result[i] or 0
  end
  return result
end

function this:onBtnAutoSet()
  local tmp = self:getAutoSetData()
  L_QuickRouletteStore:req_SaveRouletteInfo(L_Const.quickRouletteType.petPuzzle, tmp, nil, function()
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_puzzla_roulette04"))
  end)
end

function this:close()
  L_QuickRouletteStore:unListenCallFunc(L_QuickRouletteStore.event.refreshPetPuzzleRouletteInfo, self.onEvent_refreshPetPuzzleRouletteInfo, self)
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeHubRefresh, self.onEvent_homeHubRefreshSync)
  if self._callback then
    self._callback()
    self._callback = nil
  end
end

function this:playAnimation(isIn)
  if not self.isBind or not self.bindComponents.anim_commonEditRoulette then
    return
  end
  local inStr = "in"
  if not isIn then
    inStr = "out"
    L_TimerManager:newOrResetTimer(self, "editroulette_out", function()
      L_UI:close("pagePetDecryptEditRoulette")
    end, 0.15)
  end
  local mobileStr = ""
  self.bindComponents.anim_commonEditRoulette:Play(string.format("anim_common_editroulette_%s", inStr .. mobileStr))
end

return this
