local base = UIBaseNode
local UINActCommonMonsterCardSiftingNode = class("UINActCommonMonsterCardSiftingNode", base)
local eActMonsterCardEnum = require("Game.ActivityFrame.ActivityMonsterCard.eActMonsterCardEnum")
local UINSiftingKindItem = require("Game.ActivityFrame.ActivityMonsterCard.UI.UINActCommonMonsterCardSiftingKindItem")

function UINActCommonMonsterCardSiftingNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnConfirmClick)
  UIUtil.AddButtonListener(self.ui.btn_Reset, self, self.__OnResetClick)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.Hide)
  UIUtil.AddButtonListener(self.ui.btn_Background, self, self.Hide)
  self.__onItemSelectChange = BindCallback(self, self.__OnItemSelectChange)
  self.ui.obj_labelItem:SetActive(false)
  self.ui.obj_kindItem:SetActive(false)
end

function UINActCommonMonsterCardSiftingNode:InitMCSiftCondition(lableList, cardQualityList, onConfirmAction)
  self.lableList = lableList
  self.cardQualityList = cardQualityList
  self.onConfirmAction = onConfirmAction
  self.siftingDataDic = {}
  self.itemDicTypeDic = {}
  for _, siftingTypeId in ipairs(eActMonsterCardEnum.siftingTypeOrder) do
    self.siftingDataDic[siftingTypeId] = {}
    self.siftingDataDic[siftingTypeId].selectIdDic = {}
    local itemDic = {}
    local parentGo = self.ui.obj_labelItem:Instantiate()
    local tileName = parentGo:FindComponent("Tex_Type", eUnityComponentID.TextItemInfo)
    tileName:SetIndex(siftingTypeId - 1)
    parentGo:SetActive(true)
    
    local function GetOneKindItem()
      local go = self.ui.obj_kindItem:Instantiate(parentGo.transform)
      go:SetActive(true)
      local kindItem = UINSiftingKindItem.New()
      kindItem:Init(go.transform)
      return kindItem
    end
    
    if siftingTypeId == eActMonsterCardEnum.siftingType.quality then
      for _, quality in ipairs(self.cardQualityList) do
        local item = GetOneKindItem()
        item:InitSiftingKindItem(siftingTypeId, quality, self.__onItemSelectChange)
        itemDic[quality] = item
      end
    elseif siftingTypeId == eActMonsterCardEnum.siftingType.label then
      for _, labelId in ipairs(self.lableList) do
        local item = GetOneKindItem()
        item:InitSiftingKindItem(siftingTypeId, labelId, self.__onItemSelectChange)
        itemDic[labelId] = item
      end
    end
    self.itemDicTypeDic[siftingTypeId] = itemDic
  end
end

function UINActCommonMonsterCardSiftingNode:__RefreshItemBySiftingDataDic()
  for siftingTypeId, data in pairs(self.siftingDataDic) do
    local itemDic = self.itemDicTypeDic[siftingTypeId]
    for id, item in pairs(itemDic) do
      local isSelected = data.selectIdDic[id]
      item:SetSelectState(isSelected)
    end
  end
end

function UINActCommonMonsterCardSiftingNode:__OnItemSelectChange(kindType, id, isSelect)
  local data = self.siftingDataDic[kindType]
  if isSelect then
    data.selectIdDic[id] = isSelect
  else
    data.selectIdDic[id] = nil
  end
end

function UINActCommonMonsterCardSiftingNode:__OnConfirmClick()
  if self.onConfirmAction ~= nil then
    self.onConfirmAction(self.siftingDataDic)
  end
  self:Hide()
end

function UINActCommonMonsterCardSiftingNode:__OnResetClick()
  for siftingTypeId, data in pairs(self.siftingDataDic) do
    data.selectIdDic = {}
  end
  self:__RefreshItemBySiftingDataDic()
end

function UINActCommonMonsterCardSiftingNode:OnShow()
  UIUtil.HideTopStatus()
  AudioManager:PlayAudioById(1066)
end

function UINActCommonMonsterCardSiftingNode:OnHide()
  UIUtil.ReShowTopStatus()
end

function UINActCommonMonsterCardSiftingNode:OnDelete()
  base.OnDelete(self)
end

return UINActCommonMonsterCardSiftingNode
