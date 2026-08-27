local UIQuickPurchaseKey = class("UIQuickPurchaseKey", UIBaseWindow)
local base = UIBaseWindow
local HomeEnum = require("Game.Home.HomeEnum")
local UINQuickPrchaseKayItemNode = require("Game.QuickPurchaseBox.PurchaseKey.UINQuickPrchaseKayItemNode")
local UINQuickPrchaseKayMoneyNode = require("Game.QuickPurchaseBox.PurchaseKey.UINQuickPrchaseKayMoneyNode")
local cs_MessageCommon = CS.MessageCommon
local ShopEnum = require("Game.Shop.ShopEnum")
local quickBuyData = ShopEnum.eQuickBuy.stamina
UIQuickPurchaseKey.eBuyKeyTogType = {usePackage = 1, useMoney = 2}

function UIQuickPurchaseKey:OnInit()
  self.keyPackageList = nil
  self.selectedTogType = nil
  self.maxNeededKeyNum = nil
  self.itemNode = UINQuickPrchaseKayItemNode.New()
  self.itemNode:Init(self.ui.obj_useItem)
  self.itemNode:Hide()
  self.moneyNode = UINQuickPrchaseKayMoneyNode.New()
  self.moneyNode:Init(self.ui.obj_useMoney)
  self.moneyNode:Hide()
  self.togUIDic = {
    [UIQuickPurchaseKey.eBuyKeyTogType.usePackage] = {
      tog = self.ui.tog_useItem,
      selectObj = self.ui.obj_itemSelect,
      text = self.ui.tex_UseItem,
      page = self.itemNode,
      image = self.ui.img_tog_Item
    },
    [UIQuickPurchaseKey.eBuyKeyTogType.useMoney] = {
      tog = self.ui.tog_useMoney,
      selectObj = self.ui.obj_moneySelect,
      text = self.ui.tex_UseMoney,
      page = self.moneyNode,
      image = nil
    }
  }
  UIUtil.AddButtonListenerWithArg(self.ui.btn_Back, self, self.SlideOut, nil, true)
  UIUtil.AddValueChangedListener(self.ui.tog_useItem, self, self._OnClickTog, UIQuickPurchaseKey.eBuyKeyTogType.usePackage)
  UIUtil.AddValueChangedListener(self.ui.tog_useMoney, self, self._OnClickTog, UIQuickPurchaseKey.eBuyKeyTogType.useMoney)
  self.ui.tween_side.onComplete:AddListener(BindCallback(self, self.OnSlideInComplete))
  self.ui.tween_side.onRewind:AddListener(BindCallback(self, self.OnSlideInClose))
  self.__SlideOut = BindCallback(self, self.SlideOut, false, true)
end

function UIQuickPurchaseKey:InitQuickPurchaseKey(defaultTogType, maxNeededKeyNum, goodData, closeCallback)
  self.maxNeededKeyNum = maxNeededKeyNum
  self.goodData = goodData
  self.closeCallback = closeCallback
  self.itemNode:RefreshCouldUsePackList()
  local isHaveCouldUseItem = self.itemNode:GetIsHavePackageList()
  self.moneyNode:SetNodeData(self, goodData)
  self.itemNode:SetNodeData(self)
  local selectedTogType
  if defaultTogType ~= nil then
    selectedTogType = defaultTogType
  elseif isHaveCouldUseItem then
    selectedTogType = UIQuickPurchaseKey.eBuyKeyTogType.usePackage
  else
    selectedTogType = UIQuickPurchaseKey.eBuyKeyTogType.useMoney
  end
  self:SelectTog(selectedTogType)
end

function UIQuickPurchaseKey:SlideIn(isJumpIn, isHideLeftBtn)
  self.isJumpIn = isJumpIn
  self.__isHideLeftBtn = isHideLeftBtn
  self.ui.tween_side:DOPlayForward()
  AudioManager:PlayAudioById(1070)
  if not self.isJumpIn then
    UIUtil.SetTopStatus(self, self.SlideOut, {
      1001,
      1002,
      1007
    }, nil, nil, nil)
    UIUtil.SetCurButtonGroupActive(not isHideLeftBtn)
  else
    local backData = UIUtil.PeekBackStack()
    if backData ~= nil and not isHideLeftBtn then
      isHideLeftBtn = backData.hideTopStatus
    end
    if backData == nil or backData.backAction == nil then
      if ControllerManager:GetController(ControllerTypeId.HomeController).homeState == HomeEnum.eHomeState.Normal then
        UIUtil.SetTopStatus(self, self.SlideOut, nil, nil, nil, nil)
        UIUtil.SetCurButtonGroupActive(not isHideLeftBtn)
      else
        UIUtil.SetTopStatus(self, self.SlideOut, {
          1001,
          1002,
          1007
        }, nil, nil, nil)
        UIUtil.SetCurButtonGroupActive(not isHideLeftBtn)
      end
    else
      UIUtil.SetTopStatus(self, self.SlideOut, {
        1001,
        1002,
        1007
      }, nil, nil, nil)
      UIUtil.SetCurButtonGroupActive(not isHideLeftBtn)
    end
  end
  self.slideInOver = false
  self.isSlideOuting = false
end

function UIQuickPurchaseKey:OnSlideInComplete()
  self.slideInOver = true
end

function UIQuickPurchaseKey:SlideOut(isHome, popBackStack)
  if not self.slideInOver then
    self:OnSlideInClose()
    if popBackStack then
      UIUtil.PopFromBackStackByUiTab(self)
    end
    if self.closeCallback ~= nil then
      self.closeCallback()
    end
    return
  elseif self.isSlideOuting then
    return
  end
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self.isSlideOuting = true
  AudioManager:PlayAudioById(1071)
  self.ui.tween_side:DOPlayBackwards()
  if popBackStack then
    if not self.isJumpIn then
      UIUtil.PopFromBackStackByUiTab(self)
      self.isJumpIn = nil
    else
      UIUtil.PopFromBackStackByUiTab(self)
    end
  end
end

function UIQuickPurchaseKey:_OnClickTog(type, bool)
  local togUIDic = self.togUIDic[type]
  togUIDic.selectObj:SetActive(not bool)
  if bool then
    self.selectedTogType = type
    togUIDic.text.color = self.ui.color_black
    togUIDic.page:Show()
    togUIDic.page:InitQPKNode(self.maxNeededKeyNum, self.__SlideOut)
    if type == UIQuickPurchaseKey.eBuyKeyTogType.usePackage then
      togUIDic.image.color = Color.black
    end
  else
    togUIDic.text.color = self.ui.color_white
    togUIDic.page:Hide()
    if type == UIQuickPurchaseKey.eBuyKeyTogType.usePackage then
      togUIDic.image.color = Color.white
    end
  end
end

function UIQuickPurchaseKey:SelectTog(selectedTogType)
  for _, type in pairs(UIQuickPurchaseKey.eBuyKeyTogType) do
    local isSelected = type == selectedTogType
    self:_OnClickTog(type, isSelected)
    self.togUIDic[type].tog.isOn = isSelected
  end
end

local waitRecorverNUM = 0

function UIQuickPurchaseKey:GenCoverJumpReturnCallback()
  local dataTable = {}
  for key, value in pairs(self) do
    dataTable[key] = value
  end
  waitRecorverNUM = waitRecorverNUM + 1
  self:SlideOut(nil, true)
  return function()
    waitRecorverNUM = waitRecorverNUM - 1
    for key, value in pairs(dataTable) do
      self[key] = value
    end
    self:SlideIn(self.isJumpIn, self.__isHideLeftBtn)
    self:InitQuickPurchaseKey(self.selectedTogType, self.maxNeededKeyNum, self.goodData, self.closeCallback)
  end
end

function UIQuickPurchaseKey:OnSlideInClose()
  self.isSlideOuting = false
  if waitRecorverNUM <= 0 then
    self:Delete()
  else
    self:Hide()
  end
end

function UIQuickPurchaseKey:OnDelete()
  self.itemNode:Delete()
  self.moneyNode:Delete()
  base.OnDelete(self)
end

return UIQuickPurchaseKey
