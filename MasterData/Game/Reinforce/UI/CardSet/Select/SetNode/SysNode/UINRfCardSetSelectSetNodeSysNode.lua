local base = UIBaseNode
local UINRfCardSetSelectSetNodeSysNode = class("UINRfCardSetSelectSetNodeSysNode", base)
local UINRfCardSetSelectSetNodeSysNodeItem = require("Game.Reinforce.UI.CardSet.Select.SetNode.SysNode.UINRfCardSetSelectSetNodeSysNodeItem")
local UINRfCardSetSelectSiftItem = require("Game.Reinforce.UI.CardSet.Select.SetNode.SysNode.UINRfCardSetSelectSiftItem")

function UINRfCardSetSelectSetNodeSysNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Shift, self, self.OnClickShift)
  UIUtil.AddButtonListener(self.ui.btn_CloseGroup, self, self.OnClickShiftClose)
  self.siftCallback = BindCallback(self, self.OnSiftCallback)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.siftItemPool = UIItemPool.New(UINRfCardSetSelectSiftItem, self.ui.siftItem, false)
  self.siftDic = {}
  self.cardItemDic = {}
  self.sysCardList = nil
  self.totalCount = nil
  self.ui.btn_CloseGroup.gameObject:SetActive(false)
  self.ui.shiftDropDownList.gameObject:SetActive(false)
  self:InitSiftItem()
  self._onSysCardChange = BindCallback(self, self._OnSysCardChange)
  MsgCenter:AddListener(eMsgEventId.ReinforceCardSysChange, self._onSysCardChange)
end

function UINRfCardSetSelectSetNodeSysNode:InitSetNodeSysPanel(setNode, dataAll, actLongId)
  self.setNode = setNode
  self.dataAll = dataAll
  self.actLongId = actLongId
  self:RefreshList()
end

function UINRfCardSetSelectSetNodeSysNode:InitSiftItem()
  self.siftItemPool:HideAll()
  for id, cfg in ipairs(ConfigData.reinforce_card_label) do
    local item = self.siftItemPool:GetOne()
    item:InitRfCardSetSelectSiftItem(id, self.siftCallback)
  end
end

function UINRfCardSetSelectSetNodeSysNode:OnClickShift(isActive)
  if isActive == nil then
    isActive = not self.ui.shiftDropDownList.activeSelf
  end
  self.ui.shiftDropDownList:SetActive(isActive)
  self.ui.btn_CloseGroup.gameObject:SetActive(isActive)
end

function UINRfCardSetSelectSetNodeSysNode:OnClickShiftClose()
  self:OnClickShift(false)
end

function UINRfCardSetSelectSetNodeSysNode:__OnInstantiateItem(go)
  local cardItem = UINRfCardSetSelectSetNodeSysNodeItem.New()
  cardItem:Init(go)
  self.cardItemDic[go] = cardItem
end

function UINRfCardSetSelectSetNodeSysNode:__OnChangeItem(go, index)
  local cardItem = self.cardItemDic[go]
  if cardItem == nil then
    return
  end
  local cardIndex = index + 1
  local data = self.sysCardList[cardIndex]
  local curInstallIndex = self.setNode:GetDataIsInAlSelectList(data)
  local isEquip = curInstallIndex ~= nil
  cardItem:InitCardSetSelectTotalItem(self.setNode.nowCardType, data, self.setNode._resLoader, isEquip, self.setNode, curInstallIndex, cardIndex)
end

function UINRfCardSetSelectSetNodeSysNode:OnSiftCallback(index, item)
  if self.siftDic[index] then
    self.siftDic[index] = nil
  else
    self.siftDic[index] = true
  end
  item:SetSiftItemOpen(self.siftDic[index])
  self:RefreshList()
end

function UINRfCardSetSelectSetNodeSysNode:RefreshList()
  self:RefreshSysStateData()
  self.ui.rect.offsetMax = Vector2.zero
  self.ui.scrollRect.totalCount = self.totalCount or 0
  self.ui.scrollRect:RefillCells()
end

function UINRfCardSetSelectSetNodeSysNode:_OnSysCardChange()
  self.ui.scrollRect:RefreshCells()
end

function UINRfCardSetSelectSetNodeSysNode:CheckIsNeedSift()
  for id, bool in pairs(self.siftDic) do
    if bool then
      return true
    end
  end
  return false
end

function UINRfCardSetSelectSetNodeSysNode:RefreshSysStateData()
  local cardList = {}
  local isNeedSift = self:CheckIsNeedSift()
  for id, data in pairs(self.dataAll:GetRfCardSysDataDic()) do
    if isNeedSift then
      local isLabelHit = false
      local curInstallIndex = self.setNode:GetDataIsInAlSelectList(data)
      local labelList = data:GetRfCardLabelIdList()
      for _, labelId in ipairs(labelList) do
        if self.siftDic[labelId] then
          isLabelHit = true
          break
        end
      end
      if isLabelHit or curInstallIndex ~= nil then
        table.insert(cardList, data)
      end
    else
      table.insert(cardList, data)
    end
  end
  table.sort(cardList, function(a, b)
    local indexA = self.setNode:GetDataIsInAlSelectList(a) or 0
    local indexB = self.setNode:GetDataIsInAlSelectList(b) or 0
    if indexA ~= 0 or indexB ~= 0 then
      if indexA == 0 then
        return false
      end
      if indexB == 0 then
        return true
      end
      return indexA < indexB
    end
    local aStar = a:GetRfCardStar()
    local bStar = b:GetRfCardStar()
    if aStar ~= bStar then
      return aStar > bStar
    end
    return a:GetRfCdInfiniteCoe() > b:GetRfCdInfiniteCoe()
  end)
  self.sysCardList = cardList
  self.totalCount = #cardList
  self.setNode:RefreshEquipNum()
end

function UINRfCardSetSelectSetNodeSysNode:PlaySelectSetNodeDoTween()
  for i, item in pairs(self.cardItemDic) do
    if not IsNull(item) then
      local cardIndex = item.cardIndex
      local delayTime = cardIndex < 2 and 0 or (cardIndex - 2) * self.ui.constTime + self.ui.delayTime
      item:PlayTotalItemTween(delayTime, self.ui.constTime)
    end
  end
end

function UINRfCardSetSelectSetNodeSysNode:OnDelete()
  self.siftItemPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.ReinforceCardSysChange, self._onSysCardChange)
end

return UINRfCardSetSelectSetNodeSysNode
