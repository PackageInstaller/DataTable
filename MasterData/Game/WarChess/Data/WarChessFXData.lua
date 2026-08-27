local WarChessFXData = class("WarChessFXData")

function WarChessFXData:ctor(isGrid, fxId, isOnce, isBind, data)
  self.__fxId = fxId
  self.__isOnce = isOnce
  self.__isBind = isBind
  self.__isGrid = isGrid
  if isGrid then
    self.__gridData = data
  else
    self.__entityData = data
  end
  self.__fxCfg = ConfigData.warchess_fx_res[fxId]
  if self.__fxCfg == nil then
    error("can't get warchess fx res cfg fxId:" .. tostring(fxId) .. serpent.block(data))
  end
end

function WarChessFXData:GetWCFxResName()
  if self.__fxCfg == nil then
    return nil
  end
  return self.__fxCfg.prefab_res
end

function WarChessFXData:GetWCFxAudioId()
  if self.__fxCfg == nil then
    return nil
  end
  return self.__fxCfg.audio_id
end

function WarChessFXData:GetWCFxLogicPos()
  if self.__isGrid then
    return self.__gridData:GetGridLogicPos()
  else
    return self.__entityData:GetEntityLogicPos()
  end
end

function WarChessFXData:GetWCFXIsNotOnce()
  return not self.__isOnce
end

function WarChessFXData:GetWCFXIsBound()
  return self.__isBind
end

function WarChessFXData:GetWCFXIsNeedFillCount()
  return self.__fxCfg.need_count
end

function WarChessFXData:GetWCFXCoutNum()
  if self.__isGrid then
    return self.__gridData:GetFxCount()
  else
    return self.__entityData:GetFxCount()
  end
end

return WarChessFXData
