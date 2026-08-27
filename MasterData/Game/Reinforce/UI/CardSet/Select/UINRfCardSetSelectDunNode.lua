local base = UIBaseNode
local UINRfCardSetSelectDunNode = class("UINRfCardSetSelectDunNode", base)
local UINRfCardSetFacItem = require("Game.Reinforce.UI.CardSet.Select.SetNode.SysNode.UINRfCardSetSelectFacItem")

function UINRfCardSetSelectDunNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Confirm, self, self.OnClickConfirm)
  self.facItemPool = UIItemPool.New(UINRfCardSetFacItem, self.ui.FacItem, false)
end

function UINRfCardSetSelectDunNode:InitNRFCardSetDunNode(parentNode, dataAll, selectData, onFactCardChangeFunc, isShowCurDetail)
  self.parentNode = parentNode
  self.selectData = selectData
  self.dataAll = dataAll
  self.onFactCardChangeFunc = onFactCardChangeFunc
  self._resLoader = parentNode._resLoader
  self:RefreshCards(isShowCurDetail)
end

function UINRfCardSetSelectDunNode:RefreshCards(isShowCurDetail)
  self.facItemPool:HideAll()
  local cardList = {}
  for id, data in pairs(self.dataAll:GetRfFactorCardDataDic()) do
    table.insert(cardList, data)
  end
  table.sort(cardList, function(a, b)
    return a:GetRfCdInfiniteCoe() > b:GetRfCdInfiniteCoe()
  end)
  for i, data in pairs(cardList) do
    local isEquip = self.selectData == data
    local item = self.facItemPool:GetOne()
    item:InitRfCardSetSelectFacItem(data, self._resLoader, isEquip, self, 0, true)
    item:SetIsDefaultFmt(true)
    if isShowCurDetail and isEquip then
      item:OnClickDetails()
    end
  end
  local num = 0
  if self.selectData ~= nil then
    num = 1
  end
  self:RefreshEquipNum(num)
end

function UINRfCardSetSelectDunNode:RefreshEquipNum(nowNum)
  self.ui.Tex_Num:SetIndex(0, tostring(nowNum), "1")
end

function UINRfCardSetSelectDunNode:SetCardEquip(cardData, cardItem)
  if self.selectData ~= nil then
    for key, cardItem in pairs(self.facItemPool.listItem) do
      if cardItem.cardData == self.selectData then
        cardItem:RemoveCardCallback()
      end
    end
  end
  self.selectData = cardData
  cardItem:SetCardCallback(0)
  self:RefreshEquipNum(1)
  if self.onFactCardChangeFunc ~= nil then
    self.onFactCardChangeFunc(self.selectData)
  end
end

function UINRfCardSetSelectDunNode:RemoveCardEquip(index, cardItem)
  self.selectData = nil
  cardItem:RemoveCardCallback()
  self:RefreshEquipNum(0)
  if self.onFactCardChangeFunc ~= nil then
    self.onFactCardChangeFunc()
  end
end

function UINRfCardSetSelectDunNode:SetDetailWin(itemBase, win)
  self.parentNode:SetDetailWin(itemBase, win)
end

function UINRfCardSetSelectDunNode:OnClickConfirm()
  local win = UIManager:GetWindow(UIWindowTypeID.UIReinforceCardDetailFac)
  if win then
    UIManager:DeleteWindow(UIWindowTypeID.UIReinforceCardDetailFac)
  end
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.UIReinforceCardDun)
end

function UINRfCardSetSelectDunNode:OnDelete()
  self.facItemPool:DeleteAll()
end

return UINRfCardSetSelectDunNode
