local BuffChangeSanValueType = {
  Value = 1,
  MaxPercent = 2,
  CurPercent = 3,
  LostPercent = 4,
  NotifyEntityBuffLayer = 5,
  NotifyLayerOverflow = 6,
  NotifyLayerChange = 7
}
_enum("BuffChangeSanValueType", BuffChangeSanValueType)
_class("BuffLogicChangeSanValue", BuffLogicBase)
BuffLogicChangeSanValue = BuffLogicChangeSanValue

function BuffLogicChangeSanValue:Constructor(buffInstance, logicParam)
  self._modifyValue = logicParam.modifyValue or 0
  self._modifyType = logicParam.modifyType or 1
  self._modifyParam = logicParam.modifyParam
  self._forceRefresh = logicParam.forceRefresh
end

function BuffLogicChangeSanValue:DoLogic(notify)
  local lsvcFeature = self._world:GetService("FeatureLogic")
  local modifyValue = self._modifyValue
  if self._modifyType == BuffChangeSanValueType.Value then
    modifyValue = self._modifyValue
  elseif self._modifyType == BuffChangeSanValueType.MaxPercent then
    local sanMax = lsvcFeature:GetSanMaxValue()
    local oriModifyVal = self._modifyValue * sanMax
    local absModifyVal = math.abs(oriModifyVal)
    modifyValue = math.ceil(absModifyVal)
    if oriModifyVal < 0 then
      modifyValue = modifyValue * -1
    end
  elseif self._modifyType == BuffChangeSanValueType.CurPercent then
    local curSan = lsvcFeature:GetSanValue()
    local oriModifyVal = self._modifyValue * curSan
    local absModifyVal = math.abs(oriModifyVal)
    modifyValue = math.ceil(absModifyVal)
    if oriModifyVal < 0 then
      modifyValue = modifyValue * -1
    end
  elseif self._modifyType == BuffChangeSanValueType.LostPercent then
    local sanMax = lsvcFeature:GetSanMaxValue()
    local curSan = lsvcFeature:GetSanValue()
    local lostSan = sanMax - curSan
    local oriModifyVal = self._modifyValue * lostSan
    local absModifyVal = math.abs(oriModifyVal)
    modifyValue = math.ceil(absModifyVal)
    if oriModifyVal < 0 then
      modifyValue = modifyValue * -1
    end
  elseif self._modifyType == BuffChangeSanValueType.NotifyEntityBuffLayer then
    local sanMax = lsvcFeature:GetSanMaxValue()
    local curSan = lsvcFeature:GetSanValue()
    modifyValue = 0
    if notify then
      local notifyEntity = notify:GetNotifyEntity()
      if notifyEntity then
        local layerType = tonumber(self._modifyParam)
        local curLayer = self._buffLogicService:GetBuffLayer(notifyEntity, layerType)
        if curLayer and 0 < curLayer then
          local oriModifyVal = self._modifyValue * curLayer
          modifyValue = math.ceil(oriModifyVal)
        end
      end
    end
  elseif self._modifyType == BuffChangeSanValueType.NotifyLayerOverflow then
    modifyValue = 0
    local sanMax = lsvcFeature:GetSanMaxValue()
    local curSan = lsvcFeature:GetSanValue()
    if notify then
      local notifyType = notify:GetNotifyType()
      if notifyType == NotifyType.NotifyLayerChange then
        local overflowLayer = notify:GetOverflowLayer()
        if overflowLayer and 0 < overflowLayer then
          local oriModifyVal = self._modifyValue * overflowLayer
          modifyValue = math.ceil(oriModifyVal)
        end
      end
    end
  elseif self._modifyType == BuffChangeSanValueType.NotifyLayerChange then
    modifyValue = 0
    local sanMax = lsvcFeature:GetSanMaxValue()
    local curSan = lsvcFeature:GetSanValue()
    if notify then
      local notifyType = notify:GetNotifyType()
      if notifyType == NotifyType.NotifyLayerChange then
        local changeLayer = notify:GetChangeLayer()
        if changeLayer and changeLayer ~= 0 then
          local oriModifyVal = self._modifyValue * changeLayer
          modifyValue = math.ceil(oriModifyVal)
        end
      end
    end
  end
  if modifyValue == 0 and self._forceRefresh ~= 1 then
    return
  end
  local curSan, oldSan, realModifyValue, debtVal, modifyTimes = lsvcFeature:ModifySanValue(modifyValue)
  local nt = NTSanValueChange:New(curSan, oldSan, debtVal, modifyTimes)
  self._world:GetService("Trigger"):Notify(nt)
  local result = BuffResultChangeSanValue:New(curSan, oldSan, realModifyValue, debtVal, modifyTimes, self._forceRefresh)
  return result
end
