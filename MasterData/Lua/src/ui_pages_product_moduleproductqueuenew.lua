local this = class("moduleProductQueueNew", G_UIModuleBase)

function this.bind()
  return {
    list_queue = {
      moduleName = "pages/product/cellProductQueue"
    },
    active_focusRect = false
  }
end

function this.methods()
  return {
    list_queue = {
      onClickPageProductReward = function(self, bind)
        local viewIndex = bind.viewIndex
        local cellProductQueue = self.bind.list_queue:getItemCls(viewIndex)
        if cellProductQueue:checkIsPlayingAnimProductQueueGetOrCompleteOfNormalProduct() then
          return
        end
        self:onClickPageProductReward()
      end
    }
  }
end

function this:open()
  function self.onHomeBuildSyncHandler()
    self:refreshQueue()
  end
  
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeBuildSync, self.onHomeBuildSyncHandler)
  L_TimerManager:newOrResetTimer(self, "moduleProductQueueNewWaitForAnimEnd", function()
    if self.cachedRefreshQueueFlag == false then
      return
    end
    if self.waitForAnimProductQueueGetOfNormalProductFlag == true then
      return
    end
    self:refreshQueue()
    self.cachedRefreshQueueFlag = false
  end, 0.5, -1)
end

function this:close()
  if self.cacheShowRewardFunc ~= nil then
    self.cacheShowRewardFunc()
    self.cacheShowRewardFunc = nil
  end
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeBuildSync, self.onHomeBuildSyncHandler)
  self.onHomeBuildSyncHandler = nil
  L_TimerManager:clearTimer(self)
end

function this:initModule(guid)
  self._buildingGuid = guid
  self:refreshQueue()
end

function this:refreshQueue()
  if not self.isBind or not self._buildingGuid then
    return
  end
  if self.waitForAnimProductQueueGetOfNormalProductFlag then
    self.cachedRefreshQueueFlag = true
    return
  end
  local queueData = L_ProductManager:getProduceQueueForBuilding(self._buildingGuid)
  local tmp = {}
  for i = 1, #queueData do
    table.insert(tmp, {
      viewIndex = i,
      queueData = queueData[i]
    })
  end
  if not self.hasInsert then
    self.bind.list_queue:clear()
    self.bind.list_queue:insert_array(tmp)
    self.hasInsert = true
  else
    for i = 1, #self.bind.list_queue do
      self.bind.list_queue:change(i, tmp[i])
    end
  end
  if not self:hasItemInQueue() and self.parent.setGamepadFocusModule and self.parent.getProductListModule and self.parent._navMgr and self.parent.getProductListAreaName then
    self.parent:setGamepadFocusModule(self.parent:getProductListModule())
    self.parent._navMgr:SelectArea(self.parent:getProductListAreaName())
  end
end

function this:onClickPageProductReward()
  local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(self._buildingGuid)
  local reqNormalProductQueueList = {}
  for i = 1, #self.bind.list_queue do
    local cellProductQueue = self.bind.list_queue:getItemCls(i)
    local csHomeBuildProductData = cellProductQueue:getCsHomeBuildProductData()
    if csHomeBuildProductData then
      local finishCount = csHomeBuildProductData.finishCount
      if 0 < finishCount then
        if C_HomeUtil.GetBuildingType(self._buildingGuid) == L_Const.WorldMapBuildType.WMBT_HATCH then
          L_PetStore:onClickHatchOutPetEgg(self._buildingGuid, csHomeBuildProductData.specialGuid)
        else
          table.insert(reqNormalProductQueueList, cellProductQueue)
        end
      end
    end
  end
  if 0 < #reqNormalProductQueueList then
    local function animCallBack(onlyPart, sendGuidList)
      if not onlyPart then
        for _, cellProductQueue in pairs(reqNormalProductQueueList) do
          cellProductQueue:playAnimProductQueueGetOfNormalProduct()
        end
      else
        local sendGuidSet = {}
        for _, guid in pairs(sendGuidList) do
          sendGuidSet[guid] = true
        end
        for index, cellProductQueue in ipairs(reqNormalProductQueueList) do
          local csHomeBuildProductData = cellProductQueue:getCsHomeBuildProductData()
          if csHomeBuildProductData and csHomeBuildProductData.guid and sendGuidSet[csHomeBuildProductData.guid] then
            cellProductQueue:playAnimProductQueueGetOfNormalProduct()
          end
        end
      end
    end
    
    self.waitForAnimProductQueueGetOfNormalProductFlag = true
    local animStartTime = C_TimeUtility.NowServer
    L_ProductManager:reqCollectProduct(self._buildingGuid, function(rspData)
      function self.cacheShowRewardFunc()
        L_ProductManager:showProductFinishReward(rspData, true)
        
        self.waitForAnimProductQueueGetOfNormalProductFlag = false
      end
      
      local restTime = 0.55 - (C_TimeUtility.NowServer - animStartTime)
      L_TimerManager:newOrResetTimer(self, "showRewardWaitForAnimProductQueueGetOfNormalProduct", function()
        if self.cacheShowRewardFunc ~= nil then
          self.cacheShowRewardFunc()
          self.cacheShowRewardFunc = nil
        end
      end, restTime, 1)
    end, true, animCallBack)
  end
end

function this:getCellProductQueueList()
  return self.bind.list_queue
end

function this:hasItemInQueue()
  if self.bind.list_queue then
    for i = 1, #self.bind.list_queue do
      local item = self.bind.list_queue[i]
      if item.queueData.isEmpty == false then
        return true
      end
    end
  end
  return false
end

function this:setGamepadFocus(bFocus)
  self._gamepadFocus = bFocus
  self.bind.active_focusRect = self._gamepadFocus
  if self._gamepadFocus then
    self._inputActionBinding = self._inputActionBinding or self.gameObject:GetComponent(typeof(CS.Lens.Gameplay.UI.UIInputActionBinding))
    if self._inputActionBinding then
      local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
      args.isLuaEvent = true
      if C_HomeUtil.GetBuildingType(self._buildingGuid) == L_Const.WorldMapBuildType.WMBT_HATCH then
        args.luaTable = {
          moduleOrPageName = "moduleProductQueue",
          changeGroupName = "GroupEggCollect"
        }
      else
        args.luaTable = {
          moduleOrPageName = "moduleProductQueue",
          changeGroupName = "GroupCommonCollect"
        }
      end
      C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
    end
  end
end

function this:isGamepadFocus()
  if self._gamepadFocus ~= nil then
    return self._gamepadFocus
  end
  return false
end

return this
