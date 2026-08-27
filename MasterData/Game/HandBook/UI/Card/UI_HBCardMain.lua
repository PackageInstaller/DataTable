local UI_HBCardMain = class("UI_HBCardMain", UIBaseWindow)
local base = UIBaseWindow
local UINHandBookCardTag = require("Game.HandBook.UI.Card.UINHandBookCardTag")
local UINHandBookCardItem = require("Game.HandBook.UI.Card.UINHandBookCardItem")
local ReinforceCardDataSystem = require("Game.Reinforce.Data.ReinforceCardDataSystem")
local HandBookActReviewFunc = require("Game.HandBook.UI.Activity.HandBookActReviewFunc")
local HandBookActReviewOpenFunc = require("Game.HandBook.UI.Activity.HandBookActReviewOpenFunc")
local CS_Resloader = CS.ResLoader

function UI_HBCardMain:OnInit()
  self.handBookCtrl = ControllerManager:GetController(ControllerTypeId.HandBook, true)
  self._tagPool = UIItemPool.New(UINHandBookCardTag, self.ui.obj_tag)
  self.ui.obj_tag:SetActive(false)
  self._itemPool = UIItemPool.New(UINHandBookCardItem, self.ui.obj_item)
  self.ui.obj_item:SetActive(false)
  self.__OnSelectTagCallback = BindCallback(self, self.__OnSelectTag)
  self.__OnClickItemCallback = BindCallback(self, self.__OnClickItem)
  UIUtil.AddButtonListener(self.ui.btn_easterEggReview, self, self._OnClickEggReview)
  UIUtil.AddButtonListener(self.ui.btn_storyReview, self, self._OnClickStoryReview)
  self._resloder = CS_Resloader.Create()
end

function UI_HBCardMain:InitHBCardMain(callback)
  self._callback = callback
  UIUtil.SetTopStatus(self, self.__OnClickBack)
  self._tagPool:HideAll()
  local themCfgs = ConfigData.reinforce_collect_collect_theme[1]
  for _, cfg in pairs(themCfgs) do
    local tagId = cfg.theme_id
    local item = self._tagPool:GetOne()
    item:InitHandBookCardTag(tagId, cfg.theme_name, self.__OnSelectTagCallback)
  end
  self:__OnSelectTag(1)
end

function UI_HBCardMain:__OnSelectTag(tagId)
  if self._selectTag == tagId then
    return
  end
  for i, v in ipairs(self._tagPool.listItem) do
    v:RefreshCardTag(tagId)
  end
  self._selectTag = tagId
  self._itemPool:HideAll()
  local cardIdList = ConfigData.reinforce_card_card_main.packGroup[59001][tagId]
  local cardTable = self.handBookCtrl.cardHistoryData or {}
  for i, cardId in ipairs(cardIdList) do
    local item = self._itemPool:GetOne()
    local star = 2
    local msgCardData = cardTable[cardId]
    local isLock = true
    if msgCardData ~= nil then
      star = msgCardData.star
      isLock = false
    end
    item:InitHnadBoolCardItem(cardId, star, isLock, self.__OnClickItemCallback, self._resloder)
  end
end

function UI_HBCardMain:__OnClickItem(cardId, star)
  local reinforceCardData = ReinforceCardDataSystem.New()
  local star = star
  reinforceCardData:InitRfCardDataSys(cardId, nil, star)
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDetailSys, function(win)
    if win == nil then
      return
    end
    win:InitReinforceCardDetailSysForHandBook(reinforceCardData)
  end)
end

function UI_HBCardMain:__OnClickBack()
  self:Delete()
  UIUtil.SetTopStatusBtnShow(true, true)
  if self._callback ~= nil then
    self._callback()
  end
end

function UI_HBCardMain:_OnClickEggReview()
  if self.eggCRPData == nil then
    self.eggCRPData = HandBookActReviewFunc.CreateHandBookCardEggReview()
  end
  HandBookActReviewOpenFunc:OpenHandbookActReview(self.eggCRPData, function()
    UIManager:ShowWindowOnly(UIWindowTypeID.HandBookActBookFes)
  end, true)
end

function UI_HBCardMain:_OnClickStoryReview()
  if self.storyCRPData == nil then
    self.storyCRPData = HandBookActReviewFunc.CreateHandBookCardStoryReview()
  end
  HandBookActReviewOpenFunc:OpenHandbookActReview(self.storyCRPData, function()
    UIManager:ShowWindowOnly(UIWindowTypeID.HandBookActBookFes)
  end, true)
end

function UI_HBCardMain:OnDelete()
  self._tagPool:DeleteAll()
  self._itemPool:DeleteAll()
  base.OnDelete(self)
  if self._resloder ~= nil then
    self._resloder:Put2Pool()
    self._resloder = nil
  end
end

return UI_HBCardMain
