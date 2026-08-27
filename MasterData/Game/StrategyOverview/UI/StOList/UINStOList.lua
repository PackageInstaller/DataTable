local UINStioListBase = require("Game.StrategyOverview.UI.UINStioListBase")
local UINStOList = class("UINStOList", UINStioListBase)
local base = UINStioListBase
local UINStOSectorItem = require("Game.StrategyOverview.UI.StOList.UINStOSectorItem")
local UINStOTechItem = require("Game.StrategyOverview.UI.StOList.UINStOTechItem")
local UINStOTechLineItem = require("Game.StrategyOverview.UI.StOList.UINStOTechLineItem")

function UINStOList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.chessLayout.enabled = false
  self.ui.techTreeSectorItem:SetActive(false)
  self.sectorItemPool = UIItemPool.New(UINStOSectorItem, self.ui.techTreeSectorItem)
  self.techItemPool = UIItemPool.New(UINStOTechItem, self.prefabUITable.prefab_techItem)
  self.techLinePool = UIItemPool.New(UINStOTechLineItem, self.prefabUITable.prefab_obj_Line)
end

function UINStOList:InitStOList(resLoader, techDataList)
  self.isInit = true
  self.resLoader = resLoader
  if CS.ClientConsts.IsAudit then
    self.ui.lock:SetActive(false)
  end
  local lastSectorId = 0
  for k, sectorId in ipairs(ConfigData.sector.id_sort_list) do
    local sectorCfg = ConfigData.sector[sectorId]
    if sectorCfg ~= nil and 0 < #sectorCfg.building then
      lastSectorId = sectorId > lastSectorId and sectorId or lastSectorId
      local sectorItem = self.sectorItemPool:GetOne()
      sectorItem:InitStOSectorItem(sectorId, resLoader)
      sectorItem:SetBgImageColor(k % 2 ~= 0)
    end
  end
  self.ui.tex_SectorLock:SetIndex(0, tostring(lastSectorId + 1))
  self:ResetTechItemDic()
  self.lineDic = {}
  for k, techData in ipairs(techDataList) do
    local pos = self:_GetTechItemPos(techData, techData.buildingData.dynData.stcData.strategy_career)
    local buildingData = techData.buildingData
    local techItem = self.techItemPool:GetOne()
    techItem.transform:SetParent(self.ui.chessLayout.transform)
    techItem.gameObject.name = tostring(k)
    local edge = self:GetTechItemEdge(buildingData)
    techItem:InitStOTechItem(buildingData, resLoader, self, edge)
    techItem.transform.anchoredPosition = pos
    self:AddTechItem(buildingData.id, techItem)
    if techData.selected then
      self:SelectStOTechItem(techItem, techData.buildingData)
    end
    local preBuildingId = buildingData.dynData:GetPreBuildingId(1)[1]
    if preBuildingId ~= nil then
      local preTechItem = self:GetTechItem(preBuildingId)
      local startPos = techItem:GetStOTechItemUpPointPos()
      local endPos = preTechItem:GetStOTechItemDownPointPos()
      local lineItem = self.techLinePool:GetOne()
      lineItem:InitStOTechLineItem(startPos, endPos)
      self.lineDic[techItem] = lineItem
      lineItem.transform:SetParent(self.ui.lineObj.transform)
      lineItem.transform.anchoredPosition = Vector2.New(startPos.x, startPos.y)
      techItem:InitStOTechItemLine()
    end
  end
  self.ui.chessLayout.transform:SetAsLastSibling()
end

function UINStOList:_GetTechItemPos(techData, posIndex)
  if posIndex == 5 then
    posIndex = 1
  else
    posIndex = posIndex + 1
  end
  local padding = self.ui.chessLayout.padding
  local cellSize = self.ui.chessLayout.cellSize
  local spacing = self.ui.chessLayout.spacing
  local row = techData.buildingData.dynData.stcData.row
  local x = padding.left + (posIndex - 0.5) * cellSize.x + spacing.x * (posIndex - 1)
  local y = (padding.top + (row - 0.5) * cellSize.y + spacing.y * (row - 1)) * -1
  return Vector2.New(x, y)
end

function UINStOList:RefreshLine(techItem, valid)
  if self.lineDic[techItem] ~= nil then
    self.lineDic[techItem]:RefreshStOTechLineItem(valid)
  end
end

function UINStOList:OnDelete()
  self.sectorItemPool:DeleteAll()
  self.techItemPool:DeleteAll()
  self.techLinePool:DeleteAll()
  base.OnDelete(self)
end

return UINStOList
