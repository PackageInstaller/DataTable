local UINAthListArea = class("UINAthListArea", UIBaseNode)
local base = UIBaseNode
local UINAthScrollList = require("Game.Arithmetic.AthList.Area.UINAthScrollList")
local AthSortEnum = require("Game.Arithmetic.AthList.Sort.AthSortEnum")

function UINAthListArea:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.selectCount:SetActive(false)
  self.athScrollList = UINAthScrollList.New()
  self.athScrollList:Init(self.ui.scroll)
  self.athScrollList:SetAthScrollListRefillFunc(BindCallback(self, self.__RefreshAthCount))
end

function UINAthListArea:InitAthListArea(heroData, areaId, quality, clickItemFunc, itemStartDragFunc, resLoader, withMat, changeAreaFunc, ignoreInstalled)
  self.athScrollList:InitAthScrollList(heroData, areaId, quality, clickItemFunc, itemStartDragFunc, resLoader, withMat, ignoreInstalled)
end

function UINAthListArea:ShowAthListAreaSuitPartTog(show, suitId)
  self.ui.suitTogGroup.gameObject:SetActive(show)
  if not show then
    return
  end
  if self.suitPartTogPool == nil then
    self._OnSuitPartSelectFunc = BindCallback(self, self._OnSuitPartSelect)
    self.ui.tog_SuitPartItem:SetActive(false)
    local UINAthListSuitPartTog = require("Game.Arithmetic.AthList.Area.UINAthListSuitPartTog")
    self.suitPartTogPool = UIItemPool.New(UINAthListSuitPartTog, self.ui.tog_SuitPartItem)
  end
  self.suitPartTogPool:HideAll()
  local suitPartList = ConfigData.arithmetic.suitDic[suitId]
  for partId = 0, #suitPartList do
    local suitPartTogItem = self.suitPartTogPool:GetOne()
    suitPartTogItem:InitAthListSuitPartTog(partId, self._OnSuitPartSelectFunc)
  end
  self.suitId = suitId
  self.ui.suitTogGroup.allowSwitchOff = true
  self.ui.suitTogGroup:SetAllTogglesOff()
  self.ui.suitTogGroup.allowSwitchOff = false
  self.suitPartTogPool.listItem[1]:SetAthListSuitPartTogIsOn()
end

function UINAthListArea:SetAthListAreaMultSeletedUidDic(dic)
  self.athScrollList:SetAthScrollListMultSeletedUidDic(dic)
  self.ui.selectCount:SetActive(true)
  self.ui.tex_SelectCount:SetIndex(0, tostring(table.count(dic)))
end

function UINAthListArea:_OnSuitPartSelect(suitPartId)
  if suitPartId == 0 then
    suitPartId = nil
  end
  self.athScrollList:SetAthScrollListSuitId(self.suitId, suitPartId)
  self.athScrollList:RefreshAthScrollListData()
  self.athScrollList:SetAthScrollListSiftFunc(nil)
  self.athScrollList:RefillAthScrollList(nil, nil, true)
end

function UINAthListArea:__RefreshAthCount()
  self.ui.tex_AthCount:SetIndex(0, tostring(#PlayerDataCenter.allAthData:GetAllAthList()), ConfigData.game_config.athMaxNum)
end

function UINAthListArea:SetAthListAreaScrollTop(value)
  local offsetMax = self.ui.scroll.transform.offsetMax
  offsetMax.y = value
  self.ui.scroll.transform.offsetMax = offsetMax
end

function UINAthListArea:OnDelete()
  self.athScrollList:Delete()
  base.OnDelete(self)
end

return UINAthListArea
