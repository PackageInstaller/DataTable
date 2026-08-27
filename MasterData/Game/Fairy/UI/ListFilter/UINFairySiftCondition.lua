local UINFairySiftCondition = class("UINFairySiftCondition", UIBaseNode)
local base = UIBaseNode
local UINFairySortKindItem = require("Game.Fairy.UI.ListFilter.UINFairySortKindItem")
local FairyFilterEnum = require("Game.Fairy.UI.ListFilter.FairyFilterEnum")
local cs_MessageCommon = CS.MessageCommon

function UINFairySiftCondition:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnConfirmClick)
  UIUtil.AddButtonListener(self.ui.btn_Reset, self, self.__OnResetClick)
  if not IsNull(self.ui.btn_Close) then
    UIUtil.AddButtonListener(self.ui.btn_Close, self, self.Hide)
  end
  UIUtil.AddButtonListener(self.ui.btn_Background, self, self.Hide)
  self.ui.obj_labelItem:SetActive(false)
  self.ui.obj_kindItem:SetActive(false)
end

function UINFairySiftCondition:SetSortKindData(sortKindData)
  self:ShowSortKindData(false)
  self.sortKindData = sortKindData
  if self.sortKindData == nil then
    self.sortKindData = {}
    self:_GenFairySiftCondition()
    return
  end
  self:ShowSortKindData(true)
end

function UINFairySiftCondition:ShowSortKindData(isShow)
  if self.sortKindData == nil then
    return
  end
  for k, v in pairs(self.eKindType) do
    local kindItem = self.sortKindData[v].kindParent
    kindItem:SetActive(isShow)
  end
end

function UINFairySiftCondition:_GenFairySiftCondition()
  local orderedTypes = {}
  for key, index in pairs(self.eKindType) do
    orderedTypes[index] = key
  end
  for index, key in ipairs(orderedTypes) do
    self.sortKindData[index] = {}
    self.sortKindData[index].kindItems = {}
    self.sortKindData[index].selectIndexs = {}
    self.sortKindData[index].nocondition = true
    local parentGo = self.ui.obj_labelItem:Instantiate()
    local tileName = parentGo:FindComponent("Tex_Type", eUnityComponentID.TextItemInfo)
    tileName:SetIndex(index - 1)
    parentGo:SetActive(true)
    self.sortKindData[index].kindParent = parentGo
    local temp = 0
    for i = 1, self.eKindMaxCount[index] do
      if index == self.eKindType.Rank then
        temp = i
      elseif index == self.eKindType.Quality then
        temp = i
      else
        temp = i
      end
      local go = self.ui.obj_kindItem:Instantiate(parentGo.transform)
      go:SetActive(true)
      local kindItem = UINFairySortKindItem.New()
      kindItem:Init(go.transform)
      kindItem:InitFairySortKindItem(index, temp, self.itemSelectFunc)
      table.insert(self.sortKindData[index].kindItems, kindItem)
    end
  end
end

function UINFairySiftCondition:InitFairySiftCondition(eKindType, eKindMaxCount, onConfirmAction, itemSelectFunc, checkCanConfirmFunc, sortKindData)
  self.eKindType = eKindType
  self.eKindMaxCount = eKindMaxCount
  self.onConfirmAction = onConfirmAction
  self.checkCanConfirmFunc = checkCanConfirmFunc
  self.itemSelectFunc = itemSelectFunc
end

function UINFairySiftCondition:__OnConfirmClick()
  local selectCount = 0
  for k, kindType in pairs(self.eKindType) do
    local noCondition = true
    local maxCount = 0
    maxCount = self.eKindMaxCount[kindType]
    for i = 1, maxCount do
      local kindItem = self.sortKindData[kindType].kindItems[i]
      if kindItem ~= nil then
        local isSelect = kindItem.select
        if isSelect then
          noCondition = false
          selectCount = selectCount + 1
        end
        self.sortKindData[kindType].selectIndexs[i] = isSelect
      end
    end
    self.sortKindData[kindType].nocondition = noCondition
  end
  if self.checkCanConfirmFunc and not self.checkCanConfirmFunc(self.sortKindData) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22006))
    return
  end
  if self.onConfirmAction ~= nil then
    self.onConfirmAction(self.sortKindData)
  end
  self:Hide()
end

function UINFairySiftCondition:__OnResetClick()
  for k, v in pairs(self.eKindType) do
    for i = 1, self.eKindMaxCount[v] do
      local kindItem = self.sortKindData[v].kindItems[i]
      if kindItem ~= nil then
        kindItem.select = false
        kindItem:SetSelectUIActive()
        self.sortKindData[v].selectIndexs[i] = false
      end
    end
    self.sortKindData[v].nocondition = true
  end
end

function UINFairySiftCondition:OnShow()
  UIUtil.HideTopStatus()
  AudioManager:PlayAudioById(1066)
end

function UINFairySiftCondition:OnHide()
  for _, sortKindData in pairs(self.sortKindData) do
    for i, kindItem in pairs(sortKindData.kindItems) do
      kindItem:SetSelectState(sortKindData.selectIndexs[i])
    end
  end
  UIUtil.ReShowTopStatus()
end

function UINFairySiftCondition:OnDelete()
  base.OnDelete(self)
end

return UINFairySiftCondition
