local UINSiftCondition = class("UINSiftCondition", UIBaseNode)
local base = UIBaseNode
local UINSortKindItem = require("Game.Hero.NewUI.SortList.UINSortKindItem")
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")

function UINSiftCondition:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnConfirmClick)
  UIUtil.AddButtonListener(self.ui.btn_Reset, self, self.__OnResetClick)
  if not IsNull(self.ui.btn_Close) then
    UIUtil.AddButtonListener(self.ui.btn_Close, self, self.Hide)
  end
  UIUtil.AddButtonListener(self.ui.btn_Background, self, self.Hide)
  self.sortKindData = {}
  self.ui.obj_labelItem:SetActive(false)
  self.ui.obj_kindItem:SetActive(false)
end

function UINSiftCondition:InitSiftCondition(eKindType, eKindMaxCount, onConfirmAction, itemSelectFunc)
  self.eKindType = eKindType
  self.eKindMaxCount = eKindMaxCount
  self.onConfirmAction = onConfirmAction
  local orderedTypes = {}
  for key, index in pairs(eKindType) do
    orderedTypes[index] = key
  end
  for index, key in ipairs(orderedTypes) do
    self.sortKindData[index] = {}
    self.sortKindData[index].kindItems = {}
    self.sortKindData[index].selectIndexs = {}
    self.sortKindData[index].nocondition = true
    local parentGo = self.ui.obj_labelItem:Instantiate()
    local tileName = parentGo:FindComponent("Tex_Type", eUnityComponentID.TextItemInfo)
    tileName:SetIndex(index)
    parentGo:SetActive(true)
    local temp = 0
    for i = 1, eKindMaxCount[index] do
      if index == HeroFilterEnum.eKindType.Rank then
        if i % 2 ~= 0 then
          goto lbl_102
        end
        temp = math.ceil(i / 2)
      elseif index == self.eKindType.Camp then
        if i <= ConfigData:GetCampCountWithOther() then
          temp = i
          goto lbl_77
        end
        goto lbl_102
      else
        temp = i
      end
      ::lbl_77::
      local go = self.ui.obj_kindItem:Instantiate(parentGo.transform)
      go:SetActive(true)
      local kindItem = UINSortKindItem.New()
      kindItem:Init(go.transform)
      kindItem:InitSortKindItem(index, temp, itemSelectFunc)
      table.insert(self.sortKindData[index].kindItems, kindItem)
      ::lbl_102::
    end
  end
end

function UINSiftCondition:__OnConfirmClick()
  local selectCount = 0
  for k, kindType in pairs(self.eKindType) do
    local noCondition = true
    local maxCount = 0
    if kindType == self.eKindType.Camp then
      maxCount = ConfigData:GetCampCountWithOther()
    else
      maxCount = self.eKindMaxCount[kindType]
    end
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
  if self.onConfirmAction ~= nil then
    self.onConfirmAction(self.sortKindData)
  end
  self:Hide()
end

function UINSiftCondition:__OnResetClick()
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

function UINSiftCondition:OnShow()
  UIUtil.HideTopStatus()
  AudioManager:PlayAudioById(1066)
end

function UINSiftCondition:OnHide()
  for _, sortKindData in pairs(self.sortKindData) do
    for i, kindItem in pairs(sortKindData.kindItems) do
      kindItem:SetSelectState(sortKindData.selectIndexs[i])
    end
  end
  UIUtil.ReShowTopStatus()
end

function UINSiftCondition:OnDelete()
  base.OnDelete(self)
end

return UINSiftCondition
