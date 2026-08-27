local AllTimingProduct = class("AllTimingProduct")
local TimingProductData = require("Game.PlayerData.TimingProduct.TimingProductData")

function AllTimingProduct:ctor()
  self.allTimingProduct = {}
  self.allTmProductItemIdMap = {}
  self._refreshEventDic = {}
end

function AllTimingProduct.TimingProductKeyConvert(k)
  return k >> 32, k & CommonUtil.UInt32Max
end

function AllTimingProduct:InitAllTimingProduct(timingProductBrief)
  for itemId, _ in pairs(timingProductBrief.itemIdMap) do
    self:_NewTmProductItemId(itemId, timingProductBrief.moduleId)
  end
  for k, v in pairs(timingProductBrief.data) do
    self:_NewTmProductData(v, timingProductBrief.moduleId)
  end
  self:_UpdDormResOutputRedDot()
end

function AllTimingProduct:_NewTmProductItemId(itemId, moduleId)
  self.allTmProductItemIdMap[moduleId] = self.allTmProductItemIdMap[moduleId] or {}
  self.allTmProductItemIdMap[moduleId][itemId] = true
end

function AllTimingProduct:_TryAddTimeUnlock(tmProductData, isNew)
  local moduleId = tmProductData.moduleId
  local refreshTm = tmProductData:GetTmProductRefreshTm()
  local curTimestamp = PlayerDataCenter.timestamp
  if isNew or refreshTm > curTimestamp then
    self._refreshEventDic[moduleId] = self._refreshEventDic[moduleId] or BindCallback(self, self._OnRefreshTimeUp, moduleId)
    local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
    timePassCtrl:AddEventTimer(refreshTm, self._refreshEventDic[moduleId])
  end
end

function AllTimingProduct:_NewTmProductData(timingProduct, moduleId)
  local moduleId = timingProduct.moduleId
  local tmProductData = TimingProductData.New(timingProduct)
  self:_NewTmProductItemId(timingProduct.itemId, moduleId)
  self.allTimingProduct[moduleId] = self.allTimingProduct[moduleId] or {}
  self.allTimingProduct[moduleId][timingProduct.id] = tmProductData
  self:_TryAddTimeUnlock(tmProductData, true)
  return tmProductData
end

function AllTimingProduct:UpdAllTimingProduct(msg)
  for k, v in pairs(msg.delete) do
    local moduleId, specifyId = AllTimingProduct.TimingProductKeyConvert(k)
    if self.allTimingProduct[moduleId] ~= nil and self.allTimingProduct[moduleId][specifyId] ~= nil then
      self.allTimingProduct[moduleId][specifyId] = nil
    end
  end
  for k, v in pairs(msg.update) do
    if v.realNum ~= nil and v.realNum ~= 0 then
      local moduleId, specifyId = AllTimingProduct.TimingProductKeyConvert(k)
      if self.allTimingProduct[moduleId] == nil or self.allTimingProduct[moduleId][specifyId] == nil then
        self:_NewTmProductData(v, moduleId)
      else
        local tmProductData = self.allTimingProduct[moduleId][specifyId]
        tmProductData:UpdTimingProductData(v)
        self:_NewTmProductItemId(v.itemId, moduleId)
        self:_TryAddTimeUnlock(tmProductData)
      end
    end
  end
  self:_UpdDormResOutputRedDot()
end

function AllTimingProduct:GetTimingProductData(moduleId)
  return self.allTimingProduct[moduleId] or table.emptytable
end

function AllTimingProduct:GetTimingProductDataGroupItemId(moduleId)
  local tmProductDic = self:GetTimingProductData(moduleId)
  local curTimestamp = PlayerDataCenter.timestamp
  local tmProductGroupDic = {}
  for k, tmProductData in pairs(tmProductDic) do
    if tmProductData:IsTmProductTimeUp(curTimestamp) then
      local groupDic = tmProductGroupDic[tmProductData.itemId] or {}
      if tmProductGroupDic[tmProductData.itemId] == nil then
        tmProductGroupDic[tmProductData.itemId] = groupDic
      end
      groupDic[k] = tmProductData
    end
  end
  return tmProductGroupDic
end

function AllTimingProduct:GetTmProductItemIdList(moduleId)
  local list = {}
  local dic = self.allTmProductItemIdMap[moduleId] or table.emptytable
  for itemId, v in pairs(dic) do
    table.insert(list, itemId)
  end
  return list
end

function AllTimingProduct:_OnRefreshTimeUp(moduleId)
  MsgCenter:Broadcast(eMsgEventId.TimingProductRefresh, moduleId)
end

function AllTimingProduct:CanPickTimingProduct(moduleId)
  local curTimestamp = PlayerDataCenter.timestamp
  local tmProductDataDic = self:GetTimingProductData(moduleId)
  for k, v in pairs(tmProductDataDic) do
    if v:IsTmProductTimeUp(curTimestamp) then
      return true
    end
  end
  return false
end

function AllTimingProduct:_UpdDormResOutputRedDot()
  local ok, comfortNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Dorm, RedDotStaticTypeId.DormResOutput)
  if self:CanPickTimingProduct(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm) then
    comfortNode:SetRedDotCount(1)
  else
    comfortNode:SetRedDotCount(0)
  end
end

return AllTimingProduct
