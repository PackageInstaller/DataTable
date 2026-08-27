local UIDormSortCondition = class("UIDormSortCondition", UIBaseNode)
local eSortKindType, eSortKindTypeMax = table.unpack(require("Game.Dorm.UI.SortList.DormSortKindHelper"))
local UIDormSortKindItem = require("Game.Dorm.UI.SortList.UIDormSortKindItem")

function UIDormSortCondition:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_sift, self, self.OnShowSiftClick)
  UIUtil.AddValueChangedListener(self.ui.tog_direction, self, self.__RefreshAscendBtn)
  UIUtil.AddButtonListener(self.ui.btn_siftConfirm, self, self.OnSiftConfirmClick)
  UIUtil.AddButtonListener(self.ui.btn_siftReset, self, self.OnSiftResetClick)
  self.ui.fliterItem:SetActive(false)
  self.ui.kindItem:SetActive(false)
  self:__InitDormSortKindItem()
  self:__InitDormSortMannerData()
end

function UIDormSortCondition:InitDormSortCondition(onSortSwiteAction)
  self.ui.furnitureNode:SetActive(false)
  self.ui.siftNode:SetActive(false)
  self.ui.sortNode:SetActive(false)
  self:__RefreshAscendBtn(false)
  self.onSortSwiteAction = onSortSwiteAction
end

function UIDormSortCondition:__InitDormSortKindItem()
  self.sortKindData = {
    [eSortKindType.Star] = {
      kindItem = {},
      selectIndex = {},
      nocondition = true
    },
    [eSortKindType.KindType] = {
      kindItem = {},
      selectIndex = {},
      nocondition = true
    },
    [eSortKindType.Interact] = {
      kindItem = {},
      selectIndex = {},
      nocondition = true
    },
    [eSortKindType.Binding] = {
      kindItem = {},
      selectIndex = {},
      nocondition = true
    }
  }
  local selectFunc = BindCallback(self.self.__OnSortKindItemClick)
  local go, child
  local count = 0
  local kindItem
  for k, value in pairs(eSortKindType) do
    go = self.ui.fliterItem:Instantiate()
    go:SetActive(true)
    local tileName = go:FindComponent("Tex_FliterName", eUnityComponentID.TextItemInfo)
    tileName:SetIndex(value)
    for i = 1, eSortKindTypeMax[value] do
      child = self.ui.kindItem:Instantiate(go)
      child:SetActive(true)
      kindItem = UIDormSortKindItem.New()
      kindItem:Init(child.transform)
      kindItem:InitDormSortKindItem(value, i, selectFunc)
      table.insert(self.sortKindData[value].kindItem, kindItem)
    end
  end
end

function UIDormSortCondition:__InitDormSortMannerData()
  self.sortMannerData = {
    AscendFun = function(a, b)
      return a.comfort < b.comfort
    end,
    DeclineFun = function(a, b)
      return a.comfort < b.comfort
    end
  }
end

function UIDormSortCondition:__RefreshAscendBtn(value)
  self.ui.img_Up:SetActive(not value)
  self.ui.img_Down:SetActive(value)
  self.isAscend = value
  self.curFuncSort = not value and self.sortMannerData.AscendFun or self.sortMannerData.DeclineFun
  if self.onSortSwiteAction ~= nil then
    self.onSortSwiteAction(self.curFuncSort, self.__FuncSift)
  end
end

function UIDormSortCondition:OnShowSiftClick()
  local activeSelf = self.ui.furnitureNode.activeSelf
  self.ui.siftNode:SetActive(not activeSelf)
  if activeSelf then
    self:OnSiftConfirmClick()
  end
end

function UIDormSortCondition:OnSiftConfirmClick()
  for k, value in pairs(eSortKindType) do
    local sortKindData = self.sortKindData[value]
    for k, item in ipairs(eSortKindTypeMax[value].kindItem) do
      local isSelect = item.isSelect
      if isSelect then
        sortKindData.selectIndex[k] = isSelect
      end
    end
    if table.count(sortKindData.selectIndex) > 0 then
      sortKindData[value].nocondition = false
    end
  end
  if self.onSortSwiteAction ~= nil then
    self.onSortSwiteAction(self.curFuncSort, self.__FuncSift)
  end
end

function UIDormSortCondition:__FuncSift(dormData)
  local starCfg = self.sortKindData[eSortKindType.Star]
  local starOk = starCfg.nocondition or starCfg.selectIndexs[dormData.star]
  local typeCfg = eSortKindTypeMax[eSortKindType.KindType]
  local typeOk = typeCfg.nocondition or typeCfg.selectIndexs[dormData.type]
  local interactCfg = eSortKindTypeMax[eSortKindType.Interact]
  local interactOk = interactCfg.nocondition or interactCfg.selectIndexs[dormData.interact]
  local bindCfg = eSortKindTypeMax[eSortKindType.Binding]
  local bindOk = bindCfg.nocondition or bindCfg.selectIndexs[dormData.binding]
  if starOk and typeOk and interactOk and bindOk then
    return true
  else
    return false
  end
end

function UIDormSortCondition:OnSiftResetClick()
  for k, value in pairs(eSortKindType) do
    local sortKindData = self.sortKindData[value]
    for k, item in ipairs(eSortKindTypeMax[value].kindItem) do
      if item.isSelect then
        sortKindData.selectIndex[k] = nil
        item.isSelect = false
      end
    end
    sortKindData.nocondition = true
  end
  if self.onSortSwiteAction ~= nil then
    self.onSortSwiteAction(self.curFuncSort, self.__FuncSift)
  end
end

function UIDormSortCondition:RefreshFurnitureCount(num, total)
  self.ui.furnitureNode:SetActive(true)
  self.ui.tex_FurnitureNum:SetIndex(0, tostring(num), tostring(total))
end

function UIDormSortCondition:OnDelete()
end
