local UI_HBHeroRelation = class("UI_HBHeroRelation", UIBaseWindow)
local base = UIBaseWindow
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local cs_MessageCommon = CS.MessageCommon
local UIN_HBHeroRelationHeadItem = require("Game.HandBook.UI.Hero.UIN_HBHeroRelationHeadItem")
local UIN_HBHeroRelationPosItem = require("Game.HandBook.UI.Hero.UIN_HBHeroRelationPosItem")
local IndexAdjust = {
  [1] = 5,
  [2] = 2,
  [3] = 4,
  [4] = 6,
  [5] = 1,
  [6] = 3
}

function UI_HBHeroRelation:OnInit()
  self.handBookCtrl = ControllerManager:GetController(ControllerTypeId.HandBook, true)
  UIUtil.AddButtonListener(self.ui.btn_img_Check, self, self.__OnClickMainHeadItem)
  self.__onClickMainHeadItem = BindCallback(self, self.__OnClickMainHeadItem)
  self.__onClickAroundHeadItem = BindCallback(self, self.__OnClickAroundHeadItem)
  self.__aroundHeadPool = UIItemPool.New(UIN_HBHeroRelationHeadItem, self.ui.go_heroItem)
  self.mainHeadItem = UIN_HBHeroRelationHeadItem.New()
  self.mainHeadItem:Init(self.ui.go_heroItem)
  self.mainHeadItem:InitHBRelationHeroHeadItem(true, self.__onClickMainHeadItem)
  self.posItemDic = {}
  self.curPosItemList = {}
  self:InitAllPostItem()
end

function UI_HBHeroRelation:InitAllPostItem()
  for index, posObj in ipairs(self.ui.pos_array) do
    local posItem = UIN_HBHeroRelationPosItem.New()
    posItem:Init(posObj)
    posItem:InitHBRHHead(index)
    self.posItemDic[index] = posItem
  end
end

function UI_HBHeroRelation:InitHBHeroHeroRelation(heroId, resloader, backCallback)
  UIUtil.SetTopStatus(self, self.__OnClickBack)
  self.mainHeroId = heroId
  self.backCallback = backCallback
  local heroRelationDic = ConfigData.hero_relationship[heroId] or table.emptytable
  self.resloader = resloader
  local heroName, campname = self.mainHeadItem:RefreshHBRelationHeroHeadItem(heroId)
  local name = string.format(ConfigData:GetTipContent(8304), heroName)
  self.handBookCtrl:SetHBViewSetLayer(2, campname)
  self.handBookCtrl:SetHBViewSetLayer(3, name)
  self.__aroundHeadPool:HideAll()
  self.curPosItemList = {}
  for index, posItem in pairs(self.posItemDic) do
    local realIndex = IndexAdjust[index]
    local cfg = heroRelationDic[realIndex]
    if cfg ~= nil then
      local headItem = self.__aroundHeadPool:GetOne()
      headItem:InitHBRelationHeroHeadItem(false, self.__onClickAroundHeadItem)
      headItem:RefreshHBRelationHeroHeadItem(cfg.related_hero)
      posItem:SetHeroHead(headItem, cfg, heroId)
      table.insert(self.curPosItemList, posItem)
    else
      posItem:HideAll()
    end
  end
end

function UI_HBHeroRelation:__OnClickMainHeadItem()
  local heroData = PlayerDataCenter:GetHeroData(self.mainHeroId)
  if heroData == nil then
    return
  end
  UIManager:HideWindow(UIWindowTypeID.HandbookHeroRelation)
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfomation, function(window)
    if window ~= nil then
      window:InitHeroInformation(heroData, function()
        UIManager:ShowWindowOnly(UIWindowTypeID.HandbookHeroRelation)
      end)
    end
  end)
end

function UI_HBHeroRelation:__OnClickAroundHeadItem(mainHeroId, headItem)
  local heroRelationDic = ConfigData.hero_relationship[mainHeroId]
  if heroRelationDic == nil then
    return
  end
  AudioManager:PlayAudioById(1222)
  if not PlayerDataCenter:ContainsHeroData(mainHeroId) then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8301))
    return
  end
  self.mainHeroId = mainHeroId
  local heroName, campname = self.mainHeadItem:RefreshHBRelationHeroHeadItem(mainHeroId)
  local name = string.format(ConfigData:GetTipContent(8304), heroName)
  self.handBookCtrl:SetHBViewSetLayer(2, campname)
  self.handBookCtrl:SetHBViewSetLayer(3, name)
  local fromWorldPos = headItem.transform.position
  self.__aroundHeadPool:HideAll()
  self.curPosItemList = {}
  for index, posItem in pairs(self.posItemDic) do
    local realIndex = IndexAdjust[index]
    local cfg = heroRelationDic[realIndex]
    if cfg ~= nil then
      local headItem = self.__aroundHeadPool:GetOne()
      headItem:InitHBRelationHeroHeadItem(false, self.__onClickAroundHeadItem)
      headItem:RefreshHBRelationHeroHeadItem(cfg.related_hero)
      posItem:SetHeroHead(headItem, cfg, mainHeroId)
      table.insert(self.curPosItemList, posItem)
    else
      posItem:HideAll()
    end
  end
  self:PlayFromListTween(fromWorldPos)
end

function UI_HBHeroRelation:HBHROnHeroSkinChange(heroId)
  if self.mainHeroId == heroId then
    self.mainHeadItem:RefreshHBHeroHeadItem(heroId)
    return
  end
  for _, headItem in pairs(self.__aroundHeadPool.listItem) do
    if headItem.heroId == heroId then
      headItem:RefreshHBHeroHeadItem(heroId)
    end
  end
end

function UI_HBHeroRelation:PlayFromListTween(fromWorldPos)
  if self.__sequence ~= nil then
    self.__sequence:Complete()
    self.__sequence:Kill()
  end
  self.__sequence = cs_DoTween.Sequence():Append(self.mainHeadItem.ui.rect_head:DOMove(fromWorldPos, 0.3):From():SetEase(cs_Ease.OutQuart)):Join(self.mainHeadItem.ui.img_CampIcon:DOFade(0, 0.5):From():SetDelay(0.1)):Join(self.mainHeadItem.ui.img_CampIcon.transform:DOScale(1.5, 0.5):From():SetDelay(0.1))
  for index, posItem in ipairs(self.curPosItemList) do
    posItem:PlayLineScale()
    posItem.heroHeadItem:HBHRHeadPlayEnterTween(index / 10)
  end
end

function UI_HBHeroRelation:__OnClickBack()
  if self.backCallback ~= nil then
    self.backCallback()
  end
  self:Hide()
end

function UI_HBHeroRelation:OnDelete()
  self.mainHeadItem:Delete()
  self.__aroundHeadPool:DeleteAll()
  for key, posItem in pairs(self.posItemDic) do
    posItem:Delete()
  end
  if self.__sequence ~= nil then
    self.__sequence:Kill()
    self.__sequence = nil
  end
end

return UI_HBHeroRelation
