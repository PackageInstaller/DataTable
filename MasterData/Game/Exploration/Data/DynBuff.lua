local DynBuff = class("DynBuff")

function DynBuff.CreateByDungeonLevel(dunBuffId, buffCfg)
  local data = DynBuff.New()
  data.isDunBuff = true
  data.dataId = dunBuffId
  data.dunBuffCfg = buffCfg
  return data
end

function DynBuff.CreateByEpBuffId(id)
  local data = DynBuff.New()
  data.dataId = id
  local buffCfg = ConfigData.exploration_buff[data.dataId]
  if buffCfg == nil then
    error("exploration buff cfg is null,id:" .. tostring(data.dataId))
    return
  end
  data.epBuffCfg = buffCfg
  return data
end

function DynBuff:ctor()
  self.isDunBuff = false
end

function DynBuff:InitDynEpBuffInfo(buff)
  if buff.info ~= nil then
    self.expireTm = buff.info.expireTm
    self.cnt = buff.info.cnt
    self.durationLayer = buff.info.durationLayer
  else
    self.expireTm = -1
    self.cnt = -1
    self.durationLayer = -1
  end
end

function DynBuff:InitDynEpBuffItemId(itemId, level)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("Cant get item cfg, id = " .. tostring(itemId))
    return
  end
  self.itemCfg = itemCfg
  self._level = level or 1
end

function DynBuff:IsBuffNeedShowOnBuffList()
  if self.isDunBuff then
    return not self.dunBuffCfg.is_hide
  end
  return self.epBuffCfg.is_listshow
end

function DynBuff:GetBuffCfg()
  if self.isDunBuff then
    return self.dunBuffCfg
  end
  return self.epBuffCfg
end

function DynBuff:GetBuffDataId()
  return self.dataId
end

function DynBuff:GetSpecificLogicPara(logic)
  if self.isDunBuff then
    return false
  end
  if self.epBuffCfg.logic ~= logic then
    return false
  end
  return true, self.epBuffCfg.logic_num, self.epBuffCfg.logic_per
end

function DynBuff:GetEpBuffBuyPrice(epModuleId)
  local epTypeCfg = ConfigData.exploration_type[epModuleId]
  if epTypeCfg == nil then
    error("Cant get exploration_type cfg, epModuleId = " .. tostring(epModuleId))
    return 0
  end
  local resultPrice = epTypeCfg.chip_buff_price[self._level] or 0
  if ExplorationManager:IsInExploration() then
    local curStep = ExplorationManager.epCtrl.mapData:GetTotalStep()
    local refreshTime = 0
    local curRoomData = ExplorationManager.epCtrl:GetCurrentRoomData(true)
    if curRoomData ~= nil and curRoomData.storeRoomData ~= nil then
      refreshTime = curRoomData:GetEpStoreRoomRefreshTimes()
    end
    if 0 < curStep then
      local needAddPrice = 0
      local addPriceTable = epTypeCfg.step_add_function_price
      for k, v in pairs(addPriceTable) do
        if k <= curStep and v > needAddPrice then
          needAddPrice = v
        end
      end
      resultPrice = resultPrice + needAddPrice
    end
    if 0 < refreshTime then
      local needAddPrice = 0
      local addPriceTable = epTypeCfg.refresh_add_func_price
      for k, v in pairs(addPriceTable) do
        if k <= refreshTime and v > needAddPrice then
          needAddPrice = v
        end
      end
      resultPrice = resultPrice + needAddPrice
    end
  end
  return resultPrice
end

function DynBuff:GetEpBuffName()
  if self.isDunBuff then
    return LanguageUtil.GetLocaleText(self.dunBuffCfg.name)
  end
  return LanguageUtil.GetLocaleText(self.epBuffCfg.name)
end

function DynBuff:GetEpBuffIcon()
  if self.isDunBuff then
    return CRH:GetSprite(self.dunBuffCfg.icon, CommonAtlasType.ExplorationIcon)
  end
  return CRH:GetSprite(self.epBuffCfg.icon, CommonAtlasType.ExplorationIcon)
end

function DynBuff:GetEpBuffDescribe()
  if self.customDes ~= nil then
    return self.customDes
  end
  if self.isDunBuff then
    return LanguageUtil.GetLocaleText(self.dunBuffCfg.describe)
  end
  return LanguageUtil.GetLocaleText(self.epBuffCfg.describe)
end

return DynBuff
