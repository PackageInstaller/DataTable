local PlayerHeadData = class("PlayerHeadData")

function PlayerHeadData:Init()
  self.tbHeadList = {}
  self:InitConfig()
end

function PlayerHeadData:UnInit()
end

function PlayerHeadData:InitConfig()
  local function foreachHead(mapData)
    self.tbHeadList[mapData.Id] = {mapCfg = mapData, bUnlock = false}
  end
  
  ForEachTableLine(DataTable.PlayerHead, foreachHead)
end

function PlayerHeadData:DelHeadId(nId)
  if self.tbHeadList[nId] ~= nil then
    self.tbHeadList[nId].bUnlock = false
  end
end

function PlayerHeadData:ChangePlayerHead(mapData)
  if not mapData then
    return
  end
  for _, v in pairs(mapData) do
    if self.tbHeadList[v.Tid] ~= nil then
      self.tbHeadList[v.Tid].bUnlock = true
    end
    RedDotManager.SetValid(RedDotDefine.Friend_Head_Item, v.Tid, true)
  end
end

function PlayerHeadData:GetPlayerHeadList()
  local tbHeadList = {}
  local nCurId = PlayerData.Base:GetPlayerHeadId()
  for nId, v in pairs(self.tbHeadList) do
    local mapData = {}
    if v.mapCfg.IsShow and (v.bUnlock or not v.bUnlock and v.mapCfg.IsLockShow) then
      mapData.nId = nId
      mapData.mapCfg = v.mapCfg
      mapData.nUnlock = v.bUnlock and 1 or 0
      if nId == nCurId then
        mapData.nSort = 1
      else
        mapData.nSort = 0
      end
      table.insert(tbHeadList, mapData)
    end
  end
  table.sort(tbHeadList, function(a, b)
    if a.nSort == b.nSort then
      if a.nUnlock == b.nUnlock then
        return a.nId < b.nId
      end
      return a.nUnlock > b.nUnlock
    end
    return a.nSort > b.nSort
  end)
  return tbHeadList
end

function PlayerHeadData:SendGetHeadListMsg(callback)
  local function netCallback(_, netMsgData)
    for nId, v in pairs(self.tbHeadList) do
      v.bUnlock = table.indexof(netMsgData.List, nId) > 0
      
      local bRedDot = RedDotManager.GetValid(RedDotDefine.Friend_Head_Item, nId)
      if bRedDot and not v.bUnlock then
        RedDotManager.SetValid(RedDotDefine.Friend_Head_Item, nId, false)
      end
    end
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_head_icon_info_req, {}, nil, netCallback)
end

function PlayerHeadData:SendPlayerHeadIconSetReq(nHeadIconId, callback)
  local msgData = {HeadIcon = nHeadIconId}
  
  local function successCallback(_, mapMainData)
    PlayerData.Base:ChangePlayerHeadId(nHeadIconId)
    if callback then
      callback(mapMainData)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_head_icon_set_req, msgData, nil, successCallback)
end

return PlayerHeadData
