local CustomerQueueCtrl = class("CustomerQueueCtrl", BaseCtrl)
local IceCreamUtils = require("Game.UI.Play_IceCreamTruck.Play.IceCreamUtils")
local IceCreamTruckGameCtrl = require("Game.UI.Play_IceCreamTruck.Play.IceCreamTruckGameCtrl")
local enumQueueType = IceCreamUtils.EnumQueueType
CustomerQueueCtrl._mapNodeConfig = {
  Customers = {
    sCtrlName = "Game.UI.Play_IceCreamTruck.Play.CustomersCtrl"
  },
  obj_Point = {nCount = 4}
}
CustomerQueueCtrl._mapEventConfig = {
  Event_FirstCustomerLeave = "Event_FirstCustomerLeave",
  Event_FirstCustomerStartLeaving = "Event_FirstCustomerStartLeaving",
  Event_StartBusiness = "Event_StartBusiness"
}

function CustomerQueueCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.nLevelId = param[2]
  end
  self.nPendingCount = 0
  self.tbQueuePoints = {}
  self.MaxQueueLine = 4
  self.LevelData = ConfigTable.GetData("ActivityIceCreamLevel", self.nLevelId)
end

function CustomerQueueCtrl:OnEnable()
  if self.LevelData == nil then
    printError("LevelData是空的")
  end
  self._bOpened = false
end

function CustomerQueueCtrl:Event_StartBusiness()
  if self._bOpened then
    return
  end
  self:StartOpen()
end

function CustomerQueueCtrl:StartOpen()
  self._bOpened = true
  EventManager.Hit("Event_InitCharPool", self.LevelData)
  EventManager.Hit("Event_InitBuffPool", self.LevelData)
  self:InitQueuePoints()
  self._mapNode.Customers:Init()
  local fInitInterval = 1.5
  for i = 1, self.MaxQueueLine do
    self:CreatWaitCustomers((i - 1) * fInitInterval)
  end
end

function CustomerQueueCtrl:CreatWaitCustomers(nDelay)
  local nMax = self.LevelData.CustomerCount
  if nMax and 0 < nMax and nMax <= self._mapNode.Customers:GetAllCustomerCount() then
    return
  end
  self.nPendingCount = self.nPendingCount + 1
  self:TryFillQueuePoints(nDelay or 0)
end

function CustomerQueueCtrl:InitQueuePoints()
  for i, point in ipairs(self._mapNode.obj_Point) do
    local rectTransform = point.gameObject:GetComponent("RectTransform")
    if i == 1 then
      self.tbQueuePoints[i] = {
        Point = rectTransform,
        bIsFree = true,
        enumQueueTyp = enumQueueType.InMake,
        currentCustomerId = nil
      }
    else
      self.tbQueuePoints[i] = {
        Point = rectTransform,
        bIsFree = true,
        enumQueueTyp = enumQueueType.InQueue,
        currentCustomerId = nil
      }
    end
  end
end

function CustomerQueueCtrl:TryFillQueuePoints(nDelay)
  local maxNum = self.LevelData.CustomerCount < 0 and self.MaxQueueLine or math.min(self.MaxQueueLine, self.LevelData.CustomerCount)
  for i = 1, maxNum do
    if self.tbQueuePoints[i].bIsFree and 0 < self.nPendingCount then
      self.nPendingCount = self.nPendingCount - 1
      local customerId = self._mapNode.Customers:GetCustomerNew(self.LevelData)
      if customerId then
        self.tbQueuePoints[i].currentCustomerId = customerId
        self.tbQueuePoints[i].bIsFree = false
        EventManager.Hit("Event_CustomerTeleportTo", customerId, self:GetSpawnPoint())
        self:CustomerMove(self.tbQueuePoints[i], nDelay)
      end
    end
  end
end

function CustomerQueueCtrl:CompactQueue()
  local nDelay = 0
  local fInterval = 0.4
  for i = 1, #self.tbQueuePoints - 1 do
    local currentPoint = self.tbQueuePoints[i]
    local nextPoint = self.tbQueuePoints[i + 1]
    if currentPoint.bIsFree and not nextPoint.bIsFree then
      local customerId = nextPoint.currentCustomerId
      currentPoint.bIsFree = false
      currentPoint.currentCustomerId = customerId
      nextPoint.bIsFree = true
      nextPoint.currentCustomerId = nil
      self:CustomerMove(currentPoint, nDelay)
      nDelay = nDelay + fInterval
    end
  end
end

function CustomerQueueCtrl:Event_FirstCustomerLeave(customerId, bSucceed)
  EventManager.Hit("Event_CustomerLeaveQueue", customerId, bSucceed)
  local nIdx
  for i = 1, self.MaxQueueLine do
    if not self.tbQueuePoints[i].bIsFree and self.tbQueuePoints[i].currentCustomerId == customerId then
      nIdx = i
      break
    end
  end
  if nIdx == nil then
    printLog("[IceCream] FirstCustomerLeave: 找不到 id=" .. tostring(customerId) .. " 的队列槽位（可能已处理）")
    return
  end
  if nIdx ~= 1 then
  end
  self._bPendingCompact = customerId
end

function CustomerQueueCtrl:Event_FirstCustomerStartLeaving(customerId)
  if self._bPendingCompact == nil then
    return
  end
  if self._bPendingCompact ~= customerId then
    printLog(string.format("[IceCream] StartLeaving id 不匹配: pending=%s incoming=%s", tostring(self._bPendingCompact), tostring(customerId)))
    return
  end
  self._bPendingCompact = nil
  self.tbQueuePoints[1].currentCustomerId = nil
  self.tbQueuePoints[1].bIsFree = true
  self:CompactQueue()
  self:CreatWaitCustomers()
end

function CustomerQueueCtrl:CustomerMove(QueuePoints, nDelay)
  local nGen = IceCreamTruckGameCtrl.GetRestartGen()
  local nExpectId = QueuePoints.currentCustomerId
  if nExpectId == nil then
    return
  end
  if 0 < nDelay then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(nDelay))
      
      if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
        return
      end
      if QueuePoints.currentCustomerId ~= nExpectId then
        return
      end
      EventManager.Hit("Event_CustomerMoveTo", QueuePoints)
    end
    
    cs_coroutine.start(wait)
  else
    cs_coroutine.start(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
        return
      end
      if QueuePoints.currentCustomerId ~= nExpectId then
        return
      end
      EventManager.Hit("Event_CustomerMoveTo", QueuePoints)
    end)
  end
end

function CustomerQueueCtrl:ClearQueue()
  self.nPendingCount = 0
  if self.tbQueuePoints ~= nil then
    self.tbQueuePoints = {}
  end
  self._bPendingCompact = nil
  self._bOpened = false
end

function CustomerQueueCtrl:GetSpawnPoint()
  return self.tbQueuePoints[self.MaxQueueLine].Point
end

function CustomerQueueCtrl:GetServingCustomer()
  local slot = self.tbQueuePoints and self.tbQueuePoints[1]
  if slot == nil or slot.bIsFree or slot.currentCustomerId == nil then
    return nil
  end
  if self._mapNode.Customers == nil then
    return nil
  end
  return self._mapNode.Customers:GetCustomerById(slot.currentCustomerId)
end

function CustomerQueueCtrl:Restart()
  if self._mapNode.Customers and self._mapNode.Customers.Restart then
    self._mapNode.Customers:Restart()
  end
  self.nPendingCount = 0
  self.tbQueuePoints = {}
  self._bPendingCompact = nil
  self.LevelData = ConfigTable.GetData("ActivityIceCreamLevel", self.nLevelId)
  if self.LevelData == nil then
    printError("[IceCream] CustomerQueueCtrl:Restart LevelData 为空")
    return
  end
  self._bOpened = false
end

return CustomerQueueCtrl
