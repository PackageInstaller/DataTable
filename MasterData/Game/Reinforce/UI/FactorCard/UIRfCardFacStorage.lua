local base = UIBaseWindow
local UIRfCardFacStorage = class("UIRfCardFacStorage", base)
local UINRfCardFacBig = require("Game.Reinforce.UI.FactorCard.UINRfCardFacSupport")
local UINRfCdSaveEmptyCardItem = require("Game.Reinforce.UI.CardSave.UINRfCdSaveEmptyCardItem")
local CS_ResLoader = CS.ResLoader

function UIRfCardFacStorage:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction)
  self._cardItemPool = UIItemPool.New(UINRfCardFacBig, self.ui.Item, false)
  self._emptyCardPool = UIItemPool.New(UINRfCdSaveEmptyCardItem, self.ui.EmptyItem, false)
  self._OnFactorSupportCardChangeFunc = BindCallback(self, self.OnFactorSupportCardChange)
  MsgCenter:AddListener(eMsgEventId.ReinforceFactorSupportCardChange, self._OnFactorSupportCardChangeFunc)
  self._OnFactorCardSetFacCardChange = BindCallback(self, self.OnFactorCardSetFacCardChange)
  MsgCenter:AddListener(eMsgEventId.ReinforceFactorCardSetCardChange, self._OnFactorCardSetFacCardChange)
  self._resLoader = CS_ResLoader.Create()
  self._SelectFunc4Support = BindCallback(self, self.SelectFunc4Support)
  self._IsSelectFunc4Support = BindCallback(self, self.IsSelectFunc4Support)
  self._SelectFunc4Self = BindCallback(self, self.SelectFunc4Self)
  self._IsSelectFunc4Self = BindCallback(self, self.IsSelectFunc4Self)
end

function UIRfCardFacStorage:InitRfCardFacStorage(rfDataAll, closeCallback)
  self.ui.tex_setCount.gameObject:SetActive(true)
  self.rfDataAll = rfDataAll
  self.closeCallback = closeCallback
  local cardDataDic = rfDataAll:GetRfFactorCardDataDic()
  local factorNum = rfDataAll:GetRfEpMainCfg().factor_num
  self:RefreshFacrfCardDataList(cardDataDic, factorNum)
end

function UIRfCardFacStorage:InitRfCardFacStorage4Select(rfDataAll, selectCallback, isSelectCallback)
  self.ui.tex_setCount.gameObject:SetActive(false)
  self.isSelectMode = true
  self.rfDataAll = rfDataAll
  self.selectCallback = selectCallback
  self.isSelectCallback = isSelectCallback
  local cardDataDic = rfDataAll:GetRfFactorCardDataDic()
  local factorNum = rfDataAll:GetRfEpMainCfg().factor_num
  self:RefreshFacrfCardDataList(cardDataDic, factorNum)
  self:Roll2FirstSelectOne()
end

function UIRfCardFacStorage:RefreshFacrfCardDataList(cardDataDic, factorNum)
  self._cardItemPool:HideAll()
  if cardDataDic == nil then
    return
  end
  local count = 0
  local setCount = 0
  for i = 1, factorNum do
    local rfCardData = cardDataDic[i]
    if rfCardData == nil then
      local emptyIetm = self._emptyCardPool:GetOne()
      emptyIetm:InitRfCdSaveEmptyCardItem(i)
    else
      local cardItem = self._cardItemPool:GetOne()
      if self.isSelectMode then
        cardItem:InitNRfCardFacSupport(rfCardData, self._resLoader, self.ui, self._IsSelectFunc4Self, self._SelectFunc4Self, self.isSelectMode)
      else
        cardItem:InitNRfCardFacSupport(rfCardData, self._resLoader, self.ui, self._IsSelectFunc4Support, self._SelectFunc4Support)
      end
      count = count + 1
      if self:IsSelectFunc4Support(rfCardData) then
        setCount = setCount + 1
      end
    end
  end
  self:RefreshCardCount(count, factorNum)
  self:RefreshSetSupportCardCount(setCount, self.rfDataAll:GetFriendFactorMaxCount())
end

function UIRfCardFacStorage:Roll2FirstSelectOne()
  for _, cardItem in ipairs(self._cardItemPool.listItem) do
    if cardItem.isSelectedFunc(cardItem._rfCardData) then
      UIUtil.ScrollRectLocation(self.ui.List, cardItem.transform, true)
      return
    end
  end
end

function UIRfCardFacStorage:RefreshCardCount(count, sumCount)
  self.ui.tex_Num:SetIndex(0, tostring(count), tostring(sumCount))
end

function UIRfCardFacStorage:RefreshSetSupportCardCount(count, sumCount)
  self.ui.tex_setCount:SetIndex(0, tostring(count), tostring(sumCount))
end

function UIRfCardFacStorage:SelectFunc4Support(rfCardData, setSelect)
  local supportPos = self.rfDataAll:GetRfFactorCardAsSupportPosByCardOrderId(rfCardData:GetRfCdFactorOrder())
  local isSelect = -1 < supportPos
  if setSelect == isSelect then
    return
  end
  if setSelect then
    local newSupportPos = self.rfDataAll:GetAvailableRfFactorCardAsSupportPos()
    self.rfDataAll:SetRfFactorCardAsSupport(newSupportPos, rfCardData:GetRfCdFactorOrder())
  else
    self.rfDataAll:SetRfFactorCardAsSupport(supportPos, nil)
  end
end

function UIRfCardFacStorage:IsSelectFunc4Support(rfCardData)
  local supportPos = self.rfDataAll:GetRfFactorCardAsSupportPosByCardOrderId(rfCardData:GetRfCdFactorOrder())
  local isSelect = -1 < supportPos
  return isSelect
end

function UIRfCardFacStorage:SelectFunc4Self(rfCardData, setSelect)
  if self.selectCallback ~= nil then
    self.selectCallback(rfCardData, setSelect)
  end
end

function UIRfCardFacStorage:IsSelectFunc4Self(rfCardData)
  if self.isSelectCallback ~= nil then
    return self.isSelectCallback(rfCardData)
  end
  return false
end

function UIRfCardFacStorage:OnFactorSupportCardChange(factorCardSupportDic)
  if self.isSelectMode then
    return
  end
  for index, item in pairs(self._cardItemPool.listItem) do
    item:RefreshSelectState()
  end
  local setCount = 0
  local allCount = self.rfDataAll:GetFriendFactorMaxCount()
  for key, value in pairs(factorCardSupportDic) do
    if value ~= nil then
      setCount = setCount + 1
    end
  end
  self:RefreshSetSupportCardCount(setCount, allCount)
end

function UIRfCardFacStorage:OnFactorCardSetFacCardChange()
  if not self.isSelectMode then
    return
  end
  for index, item in pairs(self._cardItemPool.listItem) do
    item:RefreshSelectState()
  end
end

function UIRfCardFacStorage:BackAction()
  if self.isSelectMode then
    self:Delete(true)
    return
  end
  self.rfDataAll:SaveRfFactorCardAsSupport(function()
    if self.closeCallback ~= nil then
      self.closeCallback()
    end
    self:Delete(true)
  end)
end

function UIRfCardFacStorage:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.ReinforceFactorSupportCardChange, self._OnFactorSupportCardChangeFunc)
  MsgCenter:RemoveListener(eMsgEventId.ReinforceFactorCardSetCardChange, self._OnFactorCardSetFacCardChange)
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
end

return UIRfCardFacStorage
