local WarChessBuffData = class("WarChessBuffData")

function WarChessBuffData.CrearteBuffByMsg(buffMsg)
  local uid = buffMsg.uid
  local id = buffMsg.configId
  local data = WarChessBuffData.New(uid, id)
  return data
end

function WarChessBuffData.CrearteBuffById(buffId)
  local uid = -1
  local id = buffId
  local data = WarChessBuffData.New(uid, id)
  if data.wcBuffCfg == nil then
    return nil
  end
  return data
end

function WarChessBuffData:ctor(uid, id)
  self.uid = uid
  self.id = id
  self.dataId = id
  self.wcBuffCfg = ConfigData.warchess_buff[id]
  if self.wcBuffCfg == nil then
    error("warches buff cfg not exist id:" .. tostring(id))
  end
end

function WarChessBuffData:UpdateWCBuff()
end

function WarChessBuffData:GetWCBuffIsNeedShow()
  return self.wcBuffCfg.is_show
end

function WarChessBuffData:GetWCBuffIcon()
  return self.wcBuffCfg.icon
end

function WarChessBuffData:GetWCBuffPrice()
  return self.wcBuffCfg.cost_num
end

function WarChessBuffData:GetWCBuffColorType()
  return self.wcBuffCfg.color_type
end

function WarChessBuffData:GetWcBuffDataCfg()
  return self.wcBuffCfg
end

function WarChessBuffData:GetWCBuffName()
  return LanguageUtil.GetLocaleText(self.wcBuffCfg.name)
end

function WarChessBuffData:GetWCBuffDes()
  return LanguageUtil.GetLocaleText(self.wcBuffCfg.description)
end

function WarChessBuffData:GetWCBuffShowType()
  return self.wcBuffCfg.show_type
end

function WarChessBuffData:GetWCBuffType()
  return self.wcBuffCfg.buff_type
end

local WCBuff2EpBuffColor = {
  [1] = 1,
  [2] = 0,
  [3] = 2
}

function WarChessBuffData:GetBuffCfg()
  if self._epBuffCfg == nil then
    local colorType = self:GetWCBuffColorType()
    self._epBuffCfg = {
      icon = self:GetWCBuffIcon(),
      buff_type = WCBuff2EpBuffColor[colorType] or 0,
      name = self.wcBuffCfg.name,
      describe = self.wcBuffCfg.description
    }
  end
  return self._epBuffCfg
end

return WarChessBuffData
