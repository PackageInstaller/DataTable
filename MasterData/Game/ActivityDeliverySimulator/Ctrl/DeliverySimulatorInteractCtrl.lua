local base = require("Game.ActivityLobby.Ctrl.ActLobbyCtrlBase")
local DeliverySimulatorInteractCtrl = class("DeliverySimulatorInteractCtrl", base)
local DsInteractClassEnum = {
  Goods = 1,
  HandIn = 2,
  BornPoint = 3
}
local DsInteractClassTable = {
  [DsInteractClassEnum.Goods] = require("Game.ActivityDeliverySimulator.Entity.GoodsSpawnEntity"),
  [DsInteractClassEnum.HandIn] = require("Game.ActivityDeliverySimulator.Entity.HandInEntity"),
  [DsInteractClassEnum.BornPoint] = require("Game.ActivityDeliverySimulator.Entity.BornPointEnity")
}

function DeliverySimulatorInteractCtrl:ctor(dsCtrl)
end

function DeliverySimulatorInteractCtrl:InitDSInteractCtrl()
end

function DeliverySimulatorInteractCtrl:OnActLbSceneEnter(bind)
  base.OnActLbSceneEnter(self, bind)
  self._interactEntityList = {}
  self._curIntrctEntDic = {}
  self._interactcolliderDic = {}
  local interactObjRoot = bind.InteractRoot
  self:InitIntrctEntitys(interactObjRoot)
end

function DeliverySimulatorInteractCtrl:Reset()
  for index, entity in pairs(self._interactEntityList) do
    entity:Reset()
  end
  self._curIntrctEntDic = {}
end

function DeliverySimulatorInteractCtrl:InitIntrctEntitys(interactObjRoot)
  local interactObjCount = interactObjRoot.childCount
  for i = 0, interactObjCount - 1 do
    local interactObj = interactObjRoot:GetChild(i).gameObject
    local param = string.split(interactObj.name, "_")
    local dsInteractId = tonumber(param[2])
    self:_NewIntrctEntity(dsInteractId, interactObj)
  end
end

function DeliverySimulatorInteractCtrl:_NewIntrctEntity(dsInteractId, interactObj)
  local dsInteractCfg = ConfigData.delivery_interact_entity[dsInteractId]
  if IsNull(interactObj) then
    return
  end
  if dsInteractCfg == nil then
    error("dsInteractCfg == nil, dsInteractId:" .. tostring(dsInteractId))
    return
  end
  local entityClass = DsInteractClassTable[dsInteractCfg.interact_type]
  if entityClass == nil then
    error("Cant get DsInteractClass, interactType:" .. tostring(dsInteractCfg.interact_type))
    return
  end
  local entity = entityClass.New(dsInteractCfg.interact_param, interactObj, self.actLbCtrl)
  table.insert(self._interactEntityList, entity)
  self._interactcolliderDic[entity.interactRangeCollider] = entity
end

function DeliverySimulatorInteractCtrl:InitIntrctEntityUI(mainWindow)
  for index, entity in pairs(self._interactEntityList) do
    if entity ~= nil then
      entity:InitInteractEntityUI(mainWindow)
    end
  end
end

function DeliverySimulatorInteractCtrl:GetInteractEntityByCollider(collider)
  return self._interactcolliderDic[collider]
end

function DeliverySimulatorInteractCtrl:OnLbInteractChange(interactRangeGo, isEnter)
  local intrctEnt = self._intrctRangeGoDic[interactRangeGo]
  if IsNull(intrctEnt) then
    return
  end
  if isEnter then
    self._curIntrctEntDic[intrctEnt] = true
  else
    self._curIntrctEntDic[intrctEnt] = nil
  end
  self:UpdateGoodsPickUp(intrctEnt, isEnter)
end

function DeliverySimulatorInteractCtrl:UpdateGoodsPickUp(intrctEnt, isEnter)
  local isGoodsSpawnEntity = true
  if isGoodsSpawnEntity then
    local win = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
    win.actLbIntrctNode:UpdateBtnPickUp(intrctEnt, isEnter)
  end
end

function DeliverySimulatorInteractCtrl:OnUpdate()
  if self._interactEntityList ~= nil then
    for dsInteractId, dsInteractEntity in pairs(self._interactEntityList) do
      dsInteractEntity:OnUpDate()
    end
  end
end

return DeliverySimulatorInteractCtrl
