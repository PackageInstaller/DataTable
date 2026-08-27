local base = UIBaseNode
local UINRfCardSetSelectSetNode = class("UINRfCardSetSelectSetNode", base)
local UINRfCardSetSelectToggleItem = require("Game.Reinforce.UI.CardSet.Select.SetNode.UINRfCardSetSelectToggleItem")
local eReinforce = require("Game.Reinforce.Enum.eReinforce")
local UINRfCardSetSelectSetNodeSysNode = require("Game.Reinforce.UI.CardSet.Select.SetNode.SysNode.UINRfCardSetSelectSetNodeSysNode")
local UINRfCardSetSelectSetNodeFacNode = require("Game.Reinforce.UI.CardSet.Select.SetNode.FacNode.UINRfCardSetSelectSetNodeFacNode")
local cs_MessageCommon = CS.MessageCommon

function UINRfCardSetSelectSetNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SureEquip, self, self.OnClickBtnSure)
  self.sysNode = UINRfCardSetSelectSetNodeSysNode.New()
  self.sysNode:Init(self.ui.sysNode)
  self.facNode = UINRfCardSetSelectSetNodeFacNode.New()
  self.facNode:Init(self.ui.facNode)
  self.toggleCallback = BindCallback(self, self.OnToggleCallback)
  self.toggleItemPool = UIItemPool.New(UINRfCardSetSelectToggleItem, self.ui.togItem, false)
  self.sysToggleItem = self.toggleItemPool:GetOne()
  self.facToggleItem = self.toggleItemPool:GetOne()
  self.sysToggleItem:InitRfCardSetSelectToggleItem(eReinforce.eRfCardType.System, self.toggleCallback)
  self.facToggleItem:InitRfCardSetSelectToggleItem(eReinforce.eRfCardType.Factor, self.toggleCallback)
end

function UINRfCardSetSelectSetNode:InitSetNode(parentNode, dataAll, alSelectList, actLongId, facIndex, supportFacIndex)
  self.parentNode = parentNode
  self._resLoader = parentNode._resLoader
  self.dataAll = dataAll
  self.alSelectList = alSelectList
  self.actLongId = actLongId
  self.facIndex = facIndex
  self.supportFacIndex = supportFacIndex
  self.sysToggleItem:SetToggleOpen()
end

function UINRfCardSetSelectSetNode:OnToggleCallback(cardType, bool)
  if not bool then
    return
  end
  if self.nowCardType == cardType then
    return
  end
  local needPlayTween = true
  if self.nowCardType == nil then
    needPlayTween = false
  end
  self.nowCardType = cardType
  local isFactor = self.nowCardType == eReinforce.eRfCardType.Factor
  if isFactor then
    self.sysNode:Hide()
    self.facNode:Show()
    self.facNode:InitSetNodeFacPanel(self, self.dataAll, self.actLongId, self._resLoader)
  else
    self.facNode:Hide()
    self.sysNode:Show()
    self.sysNode:InitSetNodeSysPanel(self, self.dataAll, self.actLongId)
  end
end

function UINRfCardSetSelectSetNode:GetDataIsInAlSelectList(data)
  local index
  for id, alData in pairs(self.alSelectList) do
    if alData == data then
      index = id
      break
    end
  end
  return index
end

function UINRfCardSetSelectSetNode:SetCardEquip(cardData, cardItem)
  local maxNum = ConfigData.reinforce_exploration_main[self.actLongId].need_card
  local num = 0
  local installIndex = 0
  for i = 1, maxNum do
    if self.alSelectList[i] ~= nil then
      num = num + 1
    end
    if self.alSelectList[i] == nil and installIndex == 0 then
      installIndex = i
    end
  end
  local isReplace = false
  if cardData:GetRfCdType() == eReinforce.eRfCardType.Factor then
    if cardData:GetIsSupport() then
      if self.supportFacIndex ~= 0 then
        isReplace = true
      end
    elseif self.facIndex ~= 0 then
      isReplace = true
    end
  end
  if num == maxNum and not isReplace then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(59017))
    self:RefreshEquipNum(maxNum, maxNum)
    return
  end
  if cardData:GetRfCdType() == eReinforce.eRfCardType.Factor then
    if cardData:GetIsSupport() then
      if self.supportFacIndex ~= 0 then
        local oldinstallIndex = self.supportFacIndex
        self:RemoveCardEquip(self.alSelectList[self.supportFacIndex])
        installIndex = oldinstallIndex
      end
      self.supportFacIndex = installIndex
    else
      if self.facIndex ~= 0 then
        local oldinstallIndex = self.facIndex
        self:RemoveCardEquip(self.alSelectList[self.facIndex])
        installIndex = oldinstallIndex
      end
      self.facIndex = installIndex
    end
  end
  self.alSelectList[installIndex] = cardData
  local win = UIManager:GetWindow(UIWindowTypeID.UIReinforceCardSet)
  if win then
    win:SetCardItem(installIndex)
  end
  if cardItem ~= nil then
    cardItem:SetCardCallback(installIndex)
  end
  self:RefreshEquipNum()
end

function UINRfCardSetSelectSetNode:RemoveCardEquip(cardData, cardItem)
  if cardData == nil then
    return
  end
  if cardData:GetRfCdType() == eReinforce.eRfCardType.Factor then
    if cardData:GetIsSupport() then
      self.supportFacIndex = 0
    else
      self.facIndex = 0
    end
  end
  local index
  for list_index, list_cardData in pairs(self.alSelectList) do
    if list_cardData == cardData then
      index = list_index
      break
    end
  end
  self.alSelectList[index] = nil
  local win = UIManager:GetWindow(UIWindowTypeID.UIReinforceCardSet)
  if win then
    win:SetCardItem(index)
  end
  if cardItem ~= nil then
    cardItem:RemoveCardCallback()
  end
  self:RefreshEquipNum()
end

function UINRfCardSetSelectSetNode:RefreshEquipNum()
  local maxNum = ConfigData.reinforce_exploration_main[self.actLongId].need_card
  local num = 0
  for i = 1, maxNum do
    if self.alSelectList[i] ~= nil then
      num = num + 1
    end
  end
  self.ui.tex_Num:SetIndex(0, tostring(num), tostring(maxNum))
end

function UINRfCardSetSelectSetNode:GetCurrentInstallNumAndMaxNum()
  local maxNum = ConfigData.reinforce_exploration_main[self.actLongId].need_card
  local num = 0
  for i = 1, maxNum do
    if self.alSelectList[i] ~= nil then
      num = num + 1
    end
  end
  return num, maxNum
end

function UINRfCardSetSelectSetNode:OnClickBtnSure()
  UIUtil.OnClickBackByWinId(UIWindowTypeID.UIReinforceCardSetSelect)
end

function UINRfCardSetSelectSetNode:SetDetailWin(itemBase, win)
  self.parentNode:SetDetailWin(itemBase, win)
end

function UINRfCardSetSelectSetNode:OnDelete()
  self.sysNode:Delete()
  self.facNode:Delete()
end

return UINRfCardSetSelectSetNode
