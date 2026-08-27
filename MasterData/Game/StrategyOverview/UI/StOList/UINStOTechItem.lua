local UINStOTechItem = class("UINStOTechItem", UIBaseNode)
local base = UIBaseNode
local BuildingEnum = require("Game.Oasis.Data.BuildingEnum")

function UINStOTechItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  self.ui.obj_CanLevelUp:SetActive(false)
end

function UINStOTechItem:InitStOTechItem(buildingData, resLoader, stOList, edge)
  self.stOList = stOList
  self.edge = edge
  self.ui.img_Icon.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorBuilding"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, buildingData.icon_res)
    self.ui.img_Icon.enabled = true
  end)
  self:RefreshStOTechItemData(buildingData)
  self.edge:InitEdge(self)
  local isUseRedTip = self.edge ~= nil and self.edge:GetEdgeType() == BuildingEnum.TechItemEdgeType.RewardEdge
  self.ui.redDot:SetActive(isUseRedTip)
  self.ui.obj_TypeLevelUp:SetActive(not isUseRedTip)
end

function UINStOTechItem:InitStOTechItemLine()
  self:_RefreshLine()
end

function UINStOTechItem:_RefreshLine()
  local valid = self:IsBuildOrUnlock()
  self.stOList:RefreshLine(self, valid)
end

function UINStOTechItem:IsBuildOrUnlock()
  return self.buildingData.isBuild or self.buildingData.dynData:Unlock()
end

function UINStOTechItem:RefreshStOTechItemData(buildingData)
  self.buildingData = buildingData
  self:RefreshStOTechItem()
end

function UINStOTechItem:RefreshStOTechItem()
  local buildingData = self.buildingData
  self.ui.level:SetActive(true)
  self:_RefreshLine()
  self.ui.tex_Level:SetIndex(0, tostring(buildingData.level or 0), tostring(buildingData.maxLevel))
  local unlock = buildingData.dynData:Unlock()
  self:_RefreshLock(unlock)
  if buildingData.isBuild then
    self:_RefreshLevelUp(buildingData:CanUpgrade())
  elseif unlock then
    local canBuild = buildingData.dynData:CanBuild()
    self:_RefreshLevelUp(canBuild)
  else
    self.ui.level:SetActive(false)
  end
  if self.edge ~= nil then
    self.edge:SetState(buildingData.level or 0, unlock)
  end
end

function UINStOTechItem:_RefreshLock(unlock)
  if unlock then
    if self.lockGo ~= nil then
      local edgeType = self.edge ~= nil and self.edge:GetEdgeType() or nil
      self.stOList:ReturnStOTechLock(self.edge:GetEdgeType(), self.lockGo)
      self.lockGo = nil
    end
  elseif self.lockGo == nil then
    local edgeType = self.edge ~= nil and self.edge:GetEdgeType() or nil
    local lockGo = self.stOList:GetStOTechLock(edgeType)
    lockGo.transform:SetParent(self.ui.scaleGroup.transform)
    lockGo.transform.localPosition = Vector2.zero
    lockGo.transform.localScale = Vector3.one
    lockGo.transform:SetAsLastSibling()
    self.lockGo = lockGo
  end
end

function UINStOTechItem:_RefreshLevelUp(canLevelup)
  self.ui.obj_CanLevelUp:SetActive(canLevelup)
  self._canLevelup = canLevelup
  if canLevelup then
    if self._arrowTween == nil then
      self._arrowTween = self.ui.arrow:DOPunchPosition(Vector3.New(0, 6, 0), 1, 1):SetLoops(-1)
    end
  else
    self:_ClearArrowTween()
  end
end

function UINStOTechItem:_ClearArrowTween()
  if self._arrowTween ~= nil then
    self._arrowTween:Rewind()
    self._arrowTween:Kill()
    self._arrowTween = nil
  end
end

function UINStOTechItem:IsTethCanLevelup()
  return self._canLevelup
end

function UINStOTechItem:_OnClickRoot()
  self.stOList:SelectStOTechItem(self, self.buildingData)
end

function UINStOTechItem:GetStOTechItemUpPointPos()
  local pos
  if self.edge ~= nil then
    pos = self.transform.anchoredPosition + self.edge:GetUpPointPos()
  else
    pos = self.transform.anchoredPosition + self.ui.upPoint.anchoredPosition
  end
  return pos
end

function UINStOTechItem:GetStOTechItemDownPointPos()
  local pos
  if self.edge ~= nil then
    pos = self.transform.anchoredPosition + self.edge:GetDownPointPos()
  else
    pos = self.transform.anchoredPosition + self.ui.downPoint.anchoredPosition
  end
  return pos
end

function UINStOTechItem:GetSelectObjParent()
  local selectRoot
  if self.edge ~= nil then
    selectRoot = self.edge:TryGetFxRoot()
  end
  if selectRoot == nil then
    selectRoot = self.ui.scaleGroup.gameObject
  end
  return selectRoot
end

function UINStOTechItem:OnDelete()
  self:_ClearArrowTween()
  base.OnDelete(self)
end

return UINStOTechItem
