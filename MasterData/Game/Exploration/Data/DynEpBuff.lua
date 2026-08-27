local DynEpBuff = class("DynEpBuff")

function DynEpBuff:ctor(id)
  self.dataId = id
  local buffCfg = ConfigData.exploration_buff[self.dataId]
  if buffCfg == nil then
    error("exploration buff cfg is null,id:" .. tostring(self.dataId))
    return
  end
  self.epBuffCfg = buffCfg
end

function DynEpBuff:InitDynEpBuffInfo(buff)
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

function DynEpBuff:InitDynEpBuffItemId(itemId, level)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("Cant get item cfg, id = " .. tostring(itemId))
    return
  end
  self.itemCfg = itemCfg
  self._level = level or 1
end

function DynEpBuff:IsBuffNeedShowOnBuffList()
  return self.epBuffCfg.is_listshow
end

function DynEpBuff:GetEpBuffCfg()
  return self.epBuffCfg
end

function DynEpBuff:GetSpecificLogicPara(logic)
  if self.epBuffCfg.logic ~= logic then
    return false
  end
  return true, self.epBuffCfg.logic_num, self.epBuffCfg.logic_per
end

function DynEpBuff:GetEpBuffBuyPrice(epModuleId)
  local epTypeCfg = ConfigData.exploration_type[epModuleId]
  if epTypeCfg == nil then
    error("Cant get exploration_type cfg, epModuleId = " .. tostring(epModuleId))
    return 0
  end
  return epTypeCfg.chip_buff_price[self._level] or 0
end

function DynEpBuff:GetEpBuffName()
  return LanguageUtil.GetLocaleText(self.epBuffCfg.name)
end

function DynEpBuff:GetEpBuffIcon()
  return CRH:GetSprite(self.epBuffCfg.icon, CommonAtlasType.ExplorationIcon)
end

function DynEpBuff:GetEpBuffDescribe()
  return LanguageUtil.GetLocaleText(self.epBuffCfg.describe)
end

return DynEpBuff
