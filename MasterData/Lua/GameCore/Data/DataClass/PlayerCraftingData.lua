local PlayerCraftingData = class("PlayerCraftingData")

function PlayerCraftingData:Init()
  self:InitCfgData()
end

function PlayerCraftingData:InitCfgData()
  local function foreachProduction(line)
    local lineData = line
    
    local tbMaterialList = {}
    for i = 1, 4 do
      local nMtId = line["RawMaterialId" .. i]
      local nMtCount = line["RawMaterialCount" .. i]
      if 0 < nMtId then
        local tbMtInfo = {nItemId = nMtId, nCount = nMtCount}
        table.insert(tbMaterialList, tbMtInfo)
      end
    end
    line.MaterialList = tbMaterialList
    CacheTable.InsertData("_ProductionPage", line.Tag, lineData)
    CacheTable.InsertData("_ProductionGroup", line.Group, lineData)
    CacheTable.SetData("_Production", line.Id, lineData)
  end
  
  ForEachTableLine(DataTable.Production, foreachProduction)
end

function PlayerCraftingData:GetProductionListByPage(nPageType)
  local productionList = {}
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local tbList = CacheTable.GetData("_ProductionPage", nPageType)
  if nil ~= tbList then
    for _, v in ipairs(tbList) do
      if v.IsActivated and nWorldClass >= v.IsShowWorldLevel then
        table.insert(productionList, v)
      end
    end
  end
  table.sort(productionList, function(a, b)
    if a.SortId == b.SortId then
      return a.Id < b.Id
    end
    return a.SotId < b.SortId
  end)
  return productionList
end

function PlayerCraftingData:GetProductionPageList()
  local tbPageList = {}
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local _ProductionPage = CacheTable.Get("_ProductionPage") or {}
  for type, list in pairs(_ProductionPage) do
    if nil ~= list and nil ~= next(list) then
      local tbList = {}
      for _, v in ipairs(list) do
        if v.IsActived and nWorldClass >= v.IsShowWorldLevel then
          table.insert(tbList, v)
        end
      end
      table.sort(tbList, function(a, b)
        if a.SortId == b.SortId then
          return a.Id > b.Id
        end
        return a.SortId < b.SortId
      end)
      if nil ~= next(tbList) then
        local tbPage = {}
        tbPage.nType = type
        local typeCfg = ConfigTable.GetData("ProductionType", type)
        tbPage.nSortId = typeCfg.SortId
        tbPage.tbList = tbList
        table.insert(tbPageList, tbPage)
      end
    end
  end
  table.sort(tbPageList, function(a, b)
    if a.nSortId == b.nSortId then
      return a.nType < b.nType
    end
    return a.nSortId < b.nSortId
  end)
  return tbPageList
end

function PlayerCraftingData:GetProductionById(nId)
  return CacheTable.GetData("_Production", nId)
end

function PlayerCraftingData:CheckProductionUnlock(nProductionId)
  local bUnlock = false
  local tbCfg = ConfigTable.GetData("Production", nProductionId)
  if nil ~= tbCfg and tbCfg.IsActived then
    local nWorldClass = PlayerData.Base:GetWorldClass()
    bUnlock = nWorldClass >= tbCfg.IsShowWorldLevel and nWorldClass >= tbCfg.UnlockWorldLevel
  end
  return bUnlock
end

function PlayerCraftingData:GetProductionListByGroup(nGroupId)
  local tbGroupList = {}
  local tbList = CacheTable.GetData("_ProductionGroup", nGroupId)
  if nil ~= tbList then
    local nWorldClass = PlayerData.Base:GetWorldClass()
    for _, v in ipairs(tbList) do
      if v.IsActived and nWorldClass >= v.IsShowWorldLevel then
        table.insert(tbGroupList, v)
      end
    end
  end
  table.sort(tbGroupList, function(a, b)
    if a.SortId == b.SortId then
      return a.Id > b.Id
    end
    return a.SortId < b.SortId
  end)
  return tbGroupList
end

function PlayerCraftingData:SendMaterialCrafting(nProductionId, nCount, callback)
  local function successCallback(MsgSend, mapMsgData)
    UTILS.OpenReceiveByChangeInfo(mapMsgData)
    
    if nil ~= callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.item_product_req, {Id = nProductionId, Num = nCount}, nil, successCallback)
end

function PlayerCraftingData:SendPresentsCrafting(nProductionId, tbMatList, callback)
  local function successCallback(MsgSend, mapMsgData)
    UTILS.OpenReceiveByChangeInfo(mapMsgData)
    
    if nil ~= callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.presents_crafting_req, {Id = nProductionId, PresentsIds = tbMatList}, nil, successCallback)
end

return PlayerCraftingData
