local PlayerCoinData = class("PlayerCoinData")

function PlayerCoinData:Init()
  self._mapCoin = nil
end

function PlayerCoinData:CacheCoin(mapData)
  if self._mapCoin == nil then
    self._mapCoin = {}
  end
  for _, mapCoinInfo in ipairs(mapData) do
    self._mapCoin[mapCoinInfo.Tid] = mapCoinInfo.Qty
  end
end

function PlayerCoinData:GetCoinCount(nCoinItemId)
  if type(self._mapCoin) == "table" then
    local nCoinCount = self._mapCoin[nCoinItemId]
    if type(nCoinCount) == "number" then
      return nCoinCount
    else
      self._mapCoin[nCoinItemId] = 0
      return 0
    end
  else
    self._mapCoin = {}
    self._mapCoin[nCoinItemId] = 0
    return 0
  end
end

function PlayerCoinData:ChangeCoin(mapCoinChange)
  if type(mapCoinChange) == "table" then
    for i, v in ipairs(mapCoinChange) do
      local nCoinItemId = v.Tid
      local nChangeCount = v.Qty
      local nCurCount = self:GetCoinCount(nCoinItemId)
      self._mapCoin[nCoinItemId] = nCurCount + nChangeCount
      EventManager.Hit(EventId.CoinResChange, nCoinItemId, nCurCount, nChangeCount)
      if nCoinItemId == AllEnum.CoinItemId.STONE then
        EventManager.Hit(EventId.CoinResChange, AllEnum.CoinItemId.FREESTONE)
      end
    end
  end
end

function PlayerCoinData:ExchangeFurnitureCoin(nAllNeedFurniture, funcOpenBuyGem)
  local nHasFurniture = self:GetCoinCount(AllEnum.CoinItemId.Furniture)
  if nAllNeedFurniture <= nHasFurniture then
    return
  end
  local nHasJade = self:GetCoinCount(AllEnum.CoinItemId.Jade)
  local nHasStone = self:GetCoinCount(AllEnum.CoinItemId.FREESTONE) + self:GetCoinCount(AllEnum.CoinItemId.STONE)
  local nFurnitureConvertProp = ConfigTable.GetConfigNumber("DormBlocksConvertProp")
  local nJadeConvertCount = nHasJade * nFurnitureConvertProp
  local nStoneConvertCount = nHasStone * nFurnitureConvertProp
  local nNeedFurniture = nAllNeedFurniture - nHasFurniture
  local nAllNeedJade = math.ceil(nNeedFurniture / nFurnitureConvertProp)
  local nNeedJade = nAllNeedJade - nHasJade
  local nAllNeedStone = nNeedJade
  
  local function stone_warn()
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = orderedFormat(ConfigTable.GetUIText("Recruit_Charge"), AllEnum.CoinItemId.STONE),
      callbackConfirm = funcOpenBuyGem,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  local function jade_warn(callbackConfirm)
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = orderedFormat(ConfigTable.GetUIText("Coin_Exchange"), AllEnum.CoinItemId.Jade, nAllNeedStone, AllEnum.CoinItemId.STONE, nNeedJade, AllEnum.CoinItemId.Jade),
      callbackConfirm = callbackConfirm,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  local function furniture_warn(callbackConfirm)
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = orderedFormat(ConfigTable.GetUIText("Coin_Exchange"), AllEnum.CoinItemId.Furniture, nAllNeedJade, AllEnum.CoinItemId.Jade, nNeedFurniture, AllEnum.CoinItemId.Furniture),
      callbackConfirm = callbackConfirm,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  local function convert_furniture()
    self:SendDormBlocksConvertReq(nAllNeedJade)
  end
  
  local function convert_jade()
    self:SendGemConvertReqReq(nAllNeedStone)
  end
  
  if nJadeConvertCount >= nNeedFurniture then
    furniture_warn(convert_furniture)
  elseif nNeedFurniture <= nJadeConvertCount + nStoneConvertCount then
    furniture_warn(function()
      jade_warn(convert_jade)
    end)
  else
    furniture_warn(function()
      jade_warn(stone_warn)
    end)
  end
end

function PlayerCoinData:SendGemConvertReqReq(nCount, callback)
  local mapMsg = {Value = nCount}
  
  local function successCallback(_, mapData)
    if callback then
      callback(mapData)
    end
    UTILS.OpenReceiveByChangeInfo(mapData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.gem_convert_req, mapMsg, nil, successCallback)
end

function PlayerCoinData:SendDormBlocksConvertReq(nCount, callback)
  local mapMsg = {Value = nCount}
  
  local function successCallback(_, mapData)
    if callback then
      callback(mapData)
    end
    UTILS.OpenReceiveByChangeInfo(mapData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.dorm_blocks_convert_req, mapMsg, nil, successCallback)
end

return PlayerCoinData
