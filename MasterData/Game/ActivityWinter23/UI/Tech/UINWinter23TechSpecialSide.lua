local base = require("Game.ActivitySpring.UI.Tech.UINSpring23TechSpeicalSide")
local UINWinter23TechSpecialSide = class("UINWinter23TechSpecialSide", base)
local UINWinter23TechSpItem = require("Game.ActivityWinter23.UI.Tech.UINWinter23TechSpItem")
local UINChristmasBuffItem = require("Game.ActivityChristmas.UI.Tech.UINChristmasBuffItem")
local UINWinter23TechSpSidePageItem = require("Game.ActivityWinter23.UI.Tech.UINWinter23TechSpSidePageItem")

function UINWinter23TechSpecialSide:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._buffItemPool = UIItemPool.New(UINChristmasBuffItem, self.ui.infoItem)
  self.ui.infoItem:SetActive(false)
  self._pagePool = UIItemPool.New(UINWinter23TechSpSidePageItem, self.ui.item)
  self.ui.item:SetActive(false)
  self.ui.scroll.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__OnSpecialLvCallback = BindCallback(self, self.OnSpecialLv)
  self.__ClickSpItemCallback = BindCallback(self, self.__ClickSpItem)
  self._goItem = {}
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.OnClickReset)
  self._pagePool:HideAll()
  local sortList = {
    self.ePageEnum.strategyInfoNode,
    self.ePageEnum.buffList
  }
  local pageClickFunc = BindCallback(self, self.OnClickPage)
  for i, v in ipairs(sortList) do
    local item = self._pagePool:GetOne()
    item:InitWinter23TechSpSidePageItem(v, pageClickFunc)
  end
  self.ui.scroll.onValueChanged:AddListener(BindCallback(self, self.OnValueChange))
end

function UINWinter23TechSpecialSide:SetSpItemClick(func)
  self._spItemFunc = func
end

function UINWinter23TechSpecialSide:SetTechInfoHideFunc(func)
  self._hideTechFunc = func
end

function UINWinter23TechSpecialSide:__ClickSpItem(techItem, techData)
  if self._spItemFunc ~= nil then
    self._spItemFunc(techItem, techData)
  end
end

function UINWinter23TechSpecialSide:__SetUIPageState(pageEnumId)
  if self._curShowPage == self.ePageEnum.buffList then
    for i, v in ipairs(self._buffItemPool.listItem) do
      v:SetBuffItemNew(false)
    end
  end
  self._curShowPage = pageEnumId
  self.ui.buffList:SetActive(pageEnumId == self.ePageEnum.buffList)
  self.ui.strategyInfoNode:SetActive(pageEnumId == self.ePageEnum.strategyInfoNode)
  if pageEnumId == self.ePageEnum.buffList and self._needRefreshBuffNode then
    self:RefreshTechSpeicalSideBuffList()
  elseif self._needRefreshInfoNode then
    self:RefreshTechSpeicalSideInfoNode()
  end
  for i, v in ipairs(self._pagePool.listItem) do
    v:SetWinter23TechSpSidePageSelect(self._curShowPage)
  end
end

function UINWinter23TechSpecialSide:RefreshTechSpeicalSideBuffList()
  base.RefreshTechSpeicalSideBuffList(self)
  self.ui.empty:SetActive(self._buffItemPool.listItem[1] == nil)
end

function UINWinter23TechSpecialSide:RefreshTechSpeicalSideInfoNode()
  self._needRefreshInfoNode = false
  if self._techList == nil then
    local techDic = self._data:GetTechDataDic()[self._branchId]
    if techDic == nil then
      error("tech list error")
      return
    end
    local techList = {}
    for k, techData in pairs(techDic) do
      table.insert(techList, techData)
    end
    table.sort(techList, function(a, b)
      return a:GetTechId() < b:GetTechId()
    end)
    self._techList = techList
    self.ui.scroll.totalCount = #self._techList
    self.ui.scroll:RefillCells()
  else
    for k, v in pairs(self._goItem) do
      v:RefreshWin23TechSpItem()
    end
  end
  local targetIndex = 0
  for i, v in ipairs(self._techList) do
    if not v:GetIsUnlock() then
      break
    end
    targetIndex = i
  end
  if 0 < targetIndex then
    self.ui.scroll:SrollToCell(targetIndex - 1, 500)
  end
end

function UINWinter23TechSpecialSide:__OnInstantiateItem(go)
  local item = UINWinter23TechSpItem.New()
  item:Init(go)
  self._goItem[go] = item
end

function UINWinter23TechSpecialSide:__OnChangeItem(go, index)
  local item = self._goItem[go]
  local techData = self._techList[index + 1]
  item:SetWin23LogicDesType(self._desType)
  item:InitWin23TechSpItem(techData, self._resloader, self.__OnSpecialLvCallback, self.__ClickSpItemCallback)
end

function UINWinter23TechSpecialSide:OnSpecialLv(techData)
  if self._hideTechFunc ~= nil then
    self._hideTechFunc()
  end
  if self._lvCallback then
    self._lvCallback(techData)
  end
end

function UINWinter23TechSpecialSide:OnClickPage(index)
  self:__SetUIPageState(index)
  if self._hideTechFunc ~= nil then
    self._hideTechFunc()
  end
end

function UINWinter23TechSpecialSide:OnValueChange(vecPos)
  local vecPointY = vecPos.y
  if self._lastPointY ~= nil and math.abs(vecPointY - self._lastPointY) < 0.001 then
    self._lastPointY = vecPointY
    return
  end
  self._lastPointY = vecPointY
  if self._hideTechFunc ~= nil then
    self._hideTechFunc()
  end
end

return UINWinter23TechSpecialSide
