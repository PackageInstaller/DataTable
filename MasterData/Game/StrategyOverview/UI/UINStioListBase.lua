local UINStioListBase = class("UINStioListBase", UIBaseNode)
local base = UIBaseNode

function UINStioListBase:ctor(uiStO, prefabUITable)
  self.uiStO = uiStO
  self.prefabUITable = prefabUITable
  self.techItemDic = {}
end

function UINStioListBase:AddTechItem(id, techItem)
  self.techItemDic[id] = techItem
end

function UINStioListBase:GetTechItem(id)
  return self.techItemDic[id]
end

function UINStioListBase:ResetTechItemDic()
  self.techItemDic = {}
end

function UINStioListBase:GetStOTechLock(edgeType)
  return self.uiStO:GetStOTechLock(edgeType)
end

function UINStioListBase:ReturnStOTechLock(edgeType, lockGo)
  self.uiStO:ReturnStOTechLock(edgeType, lockGo)
end

function UINStioListBase:SelectStOTechItem(techItem, buildingData)
  self.lastSelectTech = techItem
  self.lastSelectTechId = buildingData.id
  self.uiStO:SelectStOTechItem(techItem:GetSelectObjParent(), buildingData)
end

function UINStioListBase:GetTechItemEdge(buildingData)
  local buildCfg = ConfigData.building[buildingData.id]
  return self.uiStO:GetTechItemEdge(buildCfg.nodeType)
end

function UINStioListBase:OnBuildUpgradeStOList(buildingData)
  self:RefreshAllStOListTech(buildingData)
  local techItem = self.techItemDic[buildingData.id]
  if techItem ~= nil then
    local fX_LevelUp = self.uiStO:GetFX_LevelUp()
    fX_LevelUp.transform:SetParent(techItem.gameObject.transform)
    fX_LevelUp.transform.localPosition = Vector3.zero
    fX_LevelUp:SetActive(false)
    fX_LevelUp:SetActive(true)
  end
end

function UINStioListBase:RefreshAllStOListTech(buildingData)
  for k, techItem in pairs(self.techItemDic) do
    if buildingData ~= nil and techItem.buildingData.id == buildingData.id then
      techItem:RefreshStOTechItemData(buildingData)
    else
      techItem:RefreshStOTechItem()
    end
  end
end

function UINStioListBase:EnterStOList()
  self:RefreshAllStOListTech()
  local selectItem = self.lastSelectTech
  if selectItem == nil then
    local tempPos
    for k, techItem in pairs(self.techItemDic) do
      local comparePos = techItem.gameObject.transform.localPosition
      if tempPos == nil or tempPos.x > comparePos.x and tempPos.y < comparePos.y then
        tempPos = comparePos
        selectItem = techItem
      end
    end
  end
  self:SelectStOTechItem(selectItem, selectItem.buildingData)
end

function UINStioListBase:RefreshLine(techItem, valid)
end

return UINStioListBase
