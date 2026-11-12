local CustomersCtrl = class("CustomersCtrl", BaseCtrl)
CustomersCtrl._mapNodeConfig = {
  customerItem_ = {
    nCount = 6,
    sCtrlName = "Game.UI.Play_IceCreamTruck.Play.CustomerItemCtrl"
  },
  IceCreamBuffs = {
    sCtrlName = "Game.UI.Play_IceCreamTruck.Play.IceCreamBuffsCtrl"
  },
  Point_Recycle = {}
}
CustomersCtrl._mapEventConfig = {
  Event_ReturnCustomer = "Event_ReturnCustomer",
  Event_InitCharPool = "InitCharPool"
}

function CustomersCtrl:Awake()
  self.maxSize = 6
  self.nCustomerCount = 0
  self.tbCurrentCharPool = {}
  self._nInstSeq = 0
  self.ActiveRoles = {}
  self:Init()
  self.tbCustomersId = ConfigTable.GetConfigNumberArray("IceCreamSpecialCustomerId")
  self.SpecialCustomerNum = ConfigTable.GetConfigNumber("IceCreamSpecialCustomerOrderNum")
  self.SpecialProbability = ConfigTable.GetConfigNumber("IceCreamSpecialCustomerProbability")
  self.PatienceGroup = ConfigTable.GetConfigNumber("IceCreamPatienceGroup")
  self.PatienceLowerVal = ConfigTable.GetConfigNumber("IceCreamPatienceLowerValue")
  self.PatiencePerReduce = ConfigTable.GetConfigNumber("IceCreamPatiencePerReduce")
end

function CustomersCtrl:OnEnable()
end

function CustomersCtrl:Init()
  if self.UnActive == nil then
    self.UnActive = {}
  end
  if self.InActive == nil then
    self.InActive = {}
  end
end

function CustomersCtrl:OnDestroy()
  if self._mapNode and self._mapNode.customerItem_ then
    for i = 1, self.maxSize do
      local customerItem = self._mapNode.customerItem_[i]
      if customerItem and customerItem.ClearSpine then
        customerItem:ClearSpine()
      end
    end
  end
  self:ClearAllTable()
  self.tbCurrentCharPool = {}
end

function CustomersCtrl:ClearAllTable()
  if self.UnActive ~= nil then
    self.UnActive = {}
  end
  if self.InActive ~= nil then
    self.InActive = {}
  end
end

function CustomersCtrl:_NextInstId()
  self._nInstSeq = self._nInstSeq + 1
  return self._nInstSeq
end

function CustomersCtrl:InitCharPool(LevelData)
  if LevelData == nil then
    printError("初始角色池--LevelData 为空")
    return
  end
  self.LevelData = LevelData
  self.nMaxPatienceValue = self.LevelData.PatienceValue
  local nPoolId = self.LevelData.CharPoolId
  local CurrentCharPool = {}
  
  local function forEachLine_CharPool(mapLineData)
    if mapLineData.PoolId == nPoolId then
      local nCharType = ConfigTable.GetData("IceCreamChar", mapLineData.CharId).CharType
      table.insert(CurrentCharPool, {
        charId = mapLineData.CharId,
        weight = mapLineData.Weight,
        charType = nCharType
      })
    end
  end
  
  ForEachTableLine(DataTable.IceCreamCharPool, forEachLine_CharPool)
  self.tbCurrentCharPool = CurrentCharPool
  self:CreatNewCustomers()
end

function CustomersCtrl:CreatNewCustomers()
  self:ClearAllTable()
  for i = 1, self.maxSize do
    self._mapNode.customerItem_[i]:SetBlankData(self._mapNode.Point_Recycle.gameObject:GetComponent("RectTransform"), self.nMaxPatienceValue)
    table.insert(self.UnActive, self._mapNode.customerItem_[i])
  end
end

function CustomersCtrl:GetCustomerNew(CurrentLevelData)
  if CurrentLevelData == nil then
    printError("当前的关卡数据为空")
    return
  end
  local AllCustomerCount = CurrentLevelData.CustomerCount
  if 0 < AllCustomerCount and AllCustomerCount <= self.nCustomerCount then
    printLog(string.format("[IceCream] 已达本关顾客上限：nCustomerCount=%d / CustomerCount=%d", self.nCustomerCount, AllCustomerCount))
    return nil
  end
  if #self.UnActive == 0 then
    printLog("[IceCream] 当前没有空缺角色对象，等待回收")
    return nil
  end
  local customerItem = self.UnActive[1]
  customerItem = self:SetInActiveCustomer(customerItem)
  if customerItem == nil then
    return nil
  end
  table.remove(self.UnActive, 1)
  self.InActive[customerItem.nCharacterId] = customerItem
  return customerItem.nCharacterId
end

function CustomersCtrl:SetInActiveCustomer(customerItem)
  if not self.LevelData then
    printError("关卡信息为空")
    return nil
  end
  local nTryCount = self.nCustomerCount + 1
  local bIsSpecial = false
  if self.LevelData.LevelType ~= GameEnum.ActivityIceCreamLevelType.Teaching and nTryCount % self.SpecialCustomerNum == 0 then
    bIsSpecial = math.random() <= self.SpecialProbability
    if bIsSpecial == true then
      self.SpecialProbability = ConfigTable.GetConfigNumber("IceCreamSpecialCustomerProbability")
    else
      self.SpecialProbability = math.min(self.SpecialProbability + 0.1, 1)
    end
  end
  if self.LevelData.LevelType == GameEnum.ActivityIceCreamLevelType.Infinite and nTryCount % 10 == 0 then
    EventManager.Hit("Event_ShowOctopus")
  end
  local nItemID = 0
  if bIsSpecial then
    if not self.tbCustomersId or #self.tbCustomersId == 0 then
      bIsSpecial = false
      printError("特殊角色池数据为空")
    else
      local nBuffId = self._mapNode.IceCreamBuffs:GetBuffItemID()
      if nBuffId == nil or nBuffId == 0 then
        bIsSpecial = false
      else
        nItemID = nBuffId
      end
    end
  end
  local nSelectedRoleId
  local bSpecialFromPool = false
  if bIsSpecial then
    nSelectedRoleId = self.tbCustomersId[math.random(1, #self.tbCustomersId)]
    bSpecialFromPool = true
  else
    local tbCandidates = {}
    local nTotalWeight = 0
    for _, mapCfg in pairs(self.tbCurrentCharPool) do
      local bAllowRepeat = mapCfg.charType == GameEnum.iceChar.Low
      if bAllowRepeat or (self.ActiveRoles[mapCfg.charId] or 0) == 0 then
        table.insert(tbCandidates, {
          nId = mapCfg.charId,
          nWeight = mapCfg.weight
        })
        nTotalWeight = nTotalWeight + mapCfg.weight
      end
    end
    if #tbCandidates == 0 or nTotalWeight <= 0 then
      printError("没有可用的候选角色")
      return nil
    end
    local nRand = math.random(1, nTotalWeight)
    local nCumWeight = 0
    nSelectedRoleId = tbCandidates[1].nId
    for _, item in ipairs(tbCandidates) do
      nCumWeight = nCumWeight + item.nWeight
      if nRand <= nCumWeight then
        nSelectedRoleId = item.nId
        break
      end
    end
  end
  self.nCustomerCount = nTryCount
  if not bSpecialFromPool then
    self.ActiveRoles[nSelectedRoleId] = (self.ActiveRoles[nSelectedRoleId] or 0) + 1
  end
  if bIsSpecial then
    self.nMaxPatienceValue = ConfigTable.GetConfigNumber("IceCreamPatienceShylock")
  elseif self.LevelData.LevelType == GameEnum.ActivityIceCreamLevelType.Infinite and self.nCustomerCount % self.PatienceGroup == 0 then
    self.nMaxPatienceValue = math.max(self.PatienceLowerVal, self.nMaxPatienceValue - self.PatiencePerReduce)
  end
  local nMaxScoop = self.LevelData.IceCreamBallLimit or 1
  local nInstId = self:_NextInstId()
  local tbUnlockSlot = self.LevelData.UnlockSlot
  customerItem:SetActiveData(nInstId, nSelectedRoleId, bIsSpecial, nItemID, self.nMaxPatienceValue, nMaxScoop, tbUnlockSlot)
  return customerItem
end

function CustomersCtrl:Event_ReturnCustomer(customerInstId)
  local customerItem = self.InActive[customerInstId]
  if not customerItem then
    printError("要销毁的是未激活的错误实例ID:" .. tostring(customerInstId))
    return
  end
  local roleId = customerItem.nRoleId
  if roleId and self.ActiveRoles[roleId] then
    self.ActiveRoles[roleId] = self.ActiveRoles[roleId] - 1
    if self.ActiveRoles[roleId] <= 0 then
      self.ActiveRoles[roleId] = nil
    end
  end
  self.InActive[customerInstId] = nil
  customerItem:ResetData()
  table.insert(self.UnActive, customerItem)
end

function CustomersCtrl:GetAllCustomerCount()
  return self.nCustomerCount
end

function CustomersCtrl:GetCustomerById(nInstId)
  if nInstId == nil then
    return nil
  end
  return self.InActive and self.InActive[nInstId] or nil
end

function CustomersCtrl:Restart()
  for i = 1, self.maxSize do
    local customerItem = self._mapNode.customerItem_[i]
    if customerItem then
      if customerItem._mapNode and customerItem._mapNode.IceCreamOrder then
        customerItem._mapNode.IceCreamOrder:Clear()
      end
      customerItem:ResetData()
    end
  end
  self.nCustomerCount = 0
  self._nInstSeq = 0
  self.ActiveRoles = {}
  self.tbCurrentCharPool = {}
  self.nMaxPatienceValue = nil
  self:ClearAllTable()
  self:CreatNewCustomers()
end

return CustomersCtrl
