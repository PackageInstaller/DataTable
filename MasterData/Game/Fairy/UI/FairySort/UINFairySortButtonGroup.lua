local UINFairySortButtonGroup = class("UINFairySortButtonGroup", UIBaseNode)
local base = UIBaseNode
local FairySortEnum = require("Game.Fairy.UI.FairySort.FairySortEnum")

function UINFairySortButtonGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  for index, btn in ipairs(self.ui.sortBtnGroupList) do
    UIUtil.AddButtonListenerWithArg(btn, self, self.OnClickFairySortBtn, index)
  end
end

function UINFairySortButtonGroup:InitFairySortButtonGroup(switchFunc)
  self.sortType, self.isDesc = PlayerDataCenter.cacheSaveData:GetFairySortType()
  self.switchFunc = switchFunc
  self:SwitchSortFunc()
end

function UINFairySortButtonGroup:OnClickFairySortBtn(index)
  if self.sortType == index then
    self.isDesc = not self.isDesc
  else
    self.sortType = index
    self.isDesc = true
  end
  PlayerDataCenter.cacheSaveData:SetFairySortType(self.sortType, self.isDesc)
  self:SwitchSortFunc()
end

function UINFairySortButtonGroup:SwitchSortFunc()
  self:RefreshSortButtonGroupUI()
  if self.switchFunc then
    self.switchFunc(self:GetFairySortFunc())
  end
end

function UINFairySortButtonGroup:RefreshSortButtonGroupUI()
  for i, obj in pairs(self.ui.sortBtnUpStateList) do
    obj:SetActive(false)
  end
  for i, obj in pairs(self.ui.sortBtnDownStateList) do
    obj:SetActive(false)
  end
  if self.isDesc then
    self.ui.sortBtnDownStateList[self.sortType]:SetActive(true)
  else
    self.ui.sortBtnUpStateList[self.sortType]:SetActive(true)
  end
end

function UINFairySortButtonGroup:GetFairySortFunc()
  local funcTable = FairySortEnum.SortMannerDefine[self.sortType]
  if self.isDesc then
    return funcTable.descSort
  else
    return funcTable.asceSort
  end
end

function UINFairySortButtonGroup:Delete()
end

return UINFairySortButtonGroup
