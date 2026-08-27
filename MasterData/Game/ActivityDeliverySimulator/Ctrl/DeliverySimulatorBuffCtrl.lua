local base = require("Game.ActivityLobby.Ctrl.ActLobbyCtrlBase")
local DeliverySimulatorBuffCtrl = class("DeliverySimulatorBuffCtrl", base)
local Stack = require("Framework.Lib.Stack")
local CommonPool = require("Common.CommonPool")
local DSBuff = require("Game.ActivityDeliverySimulator.DeliverySimulatorBuff.DSBuff")

function DeliverySimulatorBuffCtrl:ctor()
  self.DSBuffTable = {}
  self.DSBuffPool = CommonPool.New(function()
    return DSBuff.New()
  end, function(dsBuff)
    dsBuff:Reset()
  end)
end

function DeliverySimulatorBuffCtrl:Reset()
  for buffId, buff in pairs(self.DSBuffTable) do
    buff:Reset()
  end
  self.DSBuffTable = {}
  self.DSBuffPool:PoolClear()
end

function DeliverySimulatorBuffCtrl:GetDsEntity()
  if self.dsEntity ~= nil then
    return self.dsEntity
  end
  return self.actLbCtrl.dsPlayerEntity
end

function DeliverySimulatorBuffCtrl:AddBuff(buffId, dsEntity)
  if dsEntity == nil then
    dsEntity = self:GetDsEntity()
  end
  if dsEntity == nil then
    return
  end
  self.dsEntity = dsEntity
  if self:IsExistBuff(buffId) then
    self:GetBuff(buffId):OverlayBuff(dsEntity)
    return
  end
  local buff = self.DSBuffPool:PoolGet()
  buff:InitDSBuff(buffId)
  buff:AddBuff(dsEntity)
  self.DSBuffTable[buffId] = buff
  if self.actLbCtrl.mainWindow ~= nil then
    self.actLbCtrl.mainWindow:AddBuff(buff)
  end
  return buff
end

function DeliverySimulatorBuffCtrl:RemoveBuff(buff)
  buff:RemoveBuff()
  self.DSBuffTable[buff.DSbuffId] = nil
  if self.actLbCtrl.mainWindow ~= nil then
    self.actLbCtrl.mainWindow:RemoveBuff(buff)
  end
  self.DSBuffPool:PoolPut(buff)
end

function DeliverySimulatorBuffCtrl:GetBuff(buffId)
  return self.DSBuffTable[buffId]
end

function DeliverySimulatorBuffCtrl:IsExistBuff(buffId)
  return self.DSBuffTable[buffId] ~= nil
end

function DeliverySimulatorBuffCtrl:UpdateBuff()
  local time = Time.time
  for index, buff in pairs(self.DSBuffTable) do
    if buff:IsEnd(time) then
      self:RemoveBuff(buff)
    end
  end
end

return DeliverySimulatorBuffCtrl
