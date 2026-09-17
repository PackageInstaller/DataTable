local this = class("pageHomeCenterPet", G_UIPageBase)
local _homeFreeWorkPositionTpl = L_GameTpl:getHomeFreeWorkPositionTpl()

function this.bind()
  return {
    active_closeBtn = true,
    list_cellPetStationed = {
      moduleName = "pages/home/homeCenter/pageHomeCenterPet/cellPetStationedInModuleHomeCenterPet"
    },
    active_petStationedManageBtnPart = true,
    text_petStationedNumInfo_petStationedManageBtnPart = ""
  }
end

function this.methods()
  return {
    onClick_btn_petStationedManage = function(self)
      self:onClickPetStationedManageBtn()
    end,
    onClick_btn_close = function(self)
      self:escHandle()
    end
  }
end

function this:preOpen()
  self.onHomeHubSyncHandler = handler(self, self.onHomeHubSync)
  L_HomeStore:getCsHomeStore():RegisterEvent(C_EHomeStoreEvent.HomeHubSync, self.onHomeHubSyncHandler)
  self.onRefreshPetHandler = handler(self, self.onRefreshPet)
  AzurWorld.petMgr:RegisterEvent(C_EPetEvent.refreshPet, self.onRefreshPetHandler)
  self:refreshData()
  self:refreshUI()
end

function this:open()
  self.isTop = true
  self.isOpen = true
end

function this:onTopChange(options)
  if not self.isOpen then
    return
  end
  local preIsTop = self.isTop
  local curPageName = L_UI:currentPage(L_UI.groupKeys.stack)
  self.isTop = self.pageName == curPageName
  if preIsTop and not self.isTop then
    self:pauseCellPetUpdate()
  elseif not preIsTop and self.isTop then
    self:refreshUI()
  end
end

function this:close()
  L_HomeStore:getCsHomeStore():UnregisterEvent(C_EHomeStoreEvent.HomeHubSync, self.onHomeHubSyncHandler)
  AzurWorld.petMgr:UnregisterEvent(C_EPetEvent.refreshPet, self.onRefreshPetHandler)
  self.isTop = false
  self.isOpen = false
end

function this:refreshData()
  self.parent = self.parent
  self.UIData = {}
  self.UIData.curPetStationedNum = self:getCurPetStationedNum()
  self.UIData.maxPetStationedNum = _homeFreeWorkPositionTpl:getMaxFreeWorkNum()
  self.UIData.unlockedPetStationedNum = self:getUnlockedPetStationedNum()
  self.UIData.petStationedDataList = self:getPetStationedDataList()
end

function this:refreshUI()
  self:refreshPetStionedPart()
  self:refreshPetStationedNumInfoOfStationedManageBtnPart()
end

function this:refreshPetStionedPart()
  local insertArrayTable = {}
  local maxItem = 25
  maxItem = maxItem < self.UIData.maxPetStationedNum and maxItem or self.UIData.maxPetStationedNum
  for _ = 1, maxItem do
    table.insert(insertArrayTable, {})
  end
  self.bind.list_cellPetStationed:clear()
  self.bind.list_cellPetStationed:insert_array(insertArrayTable)
  for i = 1, #self.bind.list_cellPetStationed do
    local cellPetStationed = self.bind.list_cellPetStationed:getItemCls(i)
    local petStationedData = self.UIData.petStationedDataList[i]
    if petStationedData then
      cellPetStationed:showSelf()
      cellPetStationed:refreshData(petStationedData)
      cellPetStationed:refreshUI()
    else
      cellPetStationed:hideSelf()
      cellPetStationed:clearTimer()
    end
  end
end

function this:pauseCellPetUpdate()
  for i = 1, #self.bind.list_cellPetStationed do
    local cellPetStationed = self.bind.list_cellPetStationed:getItemCls(i)
    cellPetStationed:clearTimer()
  end
end

function this:refreshPetStationedNumInfoOfStationedManageBtnPart()
  self.bind.text_petStationedNumInfo_petStationedManageBtnPart = string.format("%d/%d", self.UIData.curPetStationedNum, self.UIData.unlockedPetStationedNum)
end

function this:getCurPetStationedNum()
  return L_HomeStore:getCurPetStationedNum()
end

function this:getUnlockedPetStationedNum()
  local unlockedPetStationedNum = 0
  local freeWorkPosId2UnlockConditionList = _homeFreeWorkPositionTpl:getFreeWorkPosId2UnlockConditionList()
  for freeWorkPositionId, unlockConditionList in pairs(freeWorkPosId2UnlockConditionList) do
    if L_ConditionManager:isComplete(unlockConditionList) and freeWorkPositionId > unlockedPetStationedNum then
      unlockedPetStationedNum = freeWorkPositionId
    end
  end
  return unlockedPetStationedNum
end

function this:getPetStationedDataList()
  local petStationedDataList = {}
  local homeHubStationedPetGuidList = L_HomeStore:getHomeHubStationedPetGuidList()
  for _, petGuid in pairs(homeHubStationedPetGuidList) do
    local tmpPetStationedData = {}
    tmpPetStationedData.petGuid = petGuid
    local csPetData = L_PetStore:getCsPetData(petGuid)
    tmpPetStationedData.petId = L_PetStore:getPetConfigId(csPetData)
    table.insert(petStationedDataList, tmpPetStationedData)
  end
  return petStationedDataList
end

function this:onClickPetStationedManageBtn()
  L_UI:open("pageHomeCenterPetStationedManage", {
    onClickStationedPetCallback = function(petGuid)
      L_HomeStore:reqPetExitHomeHub(petGuid)
    end,
    onClickPetInPetBoxCallback = function(petGuid)
      if self.UIData.curPetStationedNum == self.UIData.unlockedPetStationedNum then
        L_FlyMsgManager:showNormalMsgByKey("notice_moduleHomeCenterPet")
        return
      end
      if type(petGuid) == "number" then
        local petItem = L_PetStore:getPetItem(petGuid)
        local isOnHero = petItem:isOnHero()
        if isOnHero then
          L_GameUtil.showCommonTip({
            txtContent = L_WordsTpl:getValue("residual_code_pagehomecenterpet_01"),
            confirmCallback = function()
              L_HomeStore:reqPetStationHomeHub(petGuid)
            end
          })
        else
          L_HomeStore:reqPetStationHomeHub(petGuid)
        end
      end
    end,
    closeCallback = function()
      self.bind.active_closeBtn = true
      self.bind.active_petStationedManageBtnPart = true
    end
  })
  self.bind.active_closeBtn = false
  self.bind.active_petStationedManageBtnPart = false
end

function this:onHomeHubSync()
  self:refreshData()
  if self.isTop then
    self:refreshUI()
  end
end

function this:onRefreshPet()
  self:refreshData()
  if self.isTop then
    self:refreshUI()
  end
end

function this:escHandle()
  L_UI:close(self.pageName)
end

function this:homeCenterEscHandleCallback()
  self.parent:changeToggleModule("moduleHomeCenterPetManage")
end

return this
