local UI_HBHeroHeroList = class("UI_HBHeroHeroList", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local cs_DoTweenLoopType = CS.DG.Tweening.LoopType
local UIN_HBHeroHeroListHeroItem = require("Game.HandBook.UI.Hero.UIN_HBHeroHeroListHeroItem")

function UI_HBHeroHeroList:OnInit()
  self.resloader = cs_ResLoader.Create()
  self.handBookCtrl = ControllerManager:GetController(ControllerTypeId.HandBook, true)
  self.ui.heroLoopList.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.heroLoopList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__heroItemDic = {}
  self.__onClickHeroItem = BindCallback(self, self.__OnClickHeroItem)
  self.__reshow = BindCallback(self, self.__ReshowTween)
  UIUtil.AddButtonListener(self.ui.btn_ToInfo, self, self.__OnClickCampInfo)
end

function UI_HBHeroHeroList:InitHBHeroHeroList(campId)
  UIUtil.SetTopStatus(self, self.__OnClickBack)
  self.campId = campId
  self:__RefreshCampInfo()
  self:RefreshHeroCollect()
  self:__RefreshHeroHeads()
  self:__EnterTween()
end

function UI_HBHeroHeroList:__RefreshCampInfo()
  if self.__showingCampId == self.campId then
    self.handBookCtrl:SetHBViewSetLayer(2, self.ui.tex_Camp.text)
    return
  end
  self.__showingCampId = self.campId
  local campCfg = ConfigData.camp[self.campId]
  self.ui.img_CampIcon.gameObject:SetActive(false)
  self.resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campCfg.icon), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_CampIcon.gameObject:SetActive(true)
    self.ui.img_CampIcon.texture = texture
  end)
  local name = LanguageUtil.GetLocaleText(campCfg.name)
  self.ui.tex_Camp.text = name
  self.handBookCtrl:SetHBViewSetLayer(2, name)
end

function UI_HBHeroHeroList:RefreshHeroCollect()
  local collectRate, totalNum = self.handBookCtrl:GetCampHeroCollectNum(self.campId)
  self.ui.tex_Count:SetIndex(0, tostring(collectRate), tostring(totalNum))
end

function UI_HBHeroHeroList:__RefreshHeroHeads()
  self.__heroList = ConfigData.camp.camp2HeroListDic[self.campId] or {}
  self.ui.heroLoopList.totalCount = #self.__heroList
  self.ui.heroLoopList:RefillCells()
end

function UI_HBHeroHeroList:__OnNewItem(go)
  local heroHeadItem = UIN_HBHeroHeroListHeroItem.New()
  heroHeadItem:Init(go)
  heroHeadItem:InitHBHeroHeadItem(self.__onClickHeroItem)
  self.__heroItemDic[go] = heroHeadItem
end

function UI_HBHeroHeroList:__OnChangeItem(go, index)
  local heroHeadItem = self.__heroItemDic[go]
  if heroHeadItem == nil then
    error("Can't find heroHeadItem by gameObject")
    return
  end
  local heroId = self.__heroList[index + 1]
  if heroId == nil then
    error("Can't find heroId by index, index = " .. tostring(index))
    return
  end
  heroHeadItem:RefreshHBHeroHeadItem(heroId)
end

function UI_HBHeroHeroList:__GetItemGoByIndex(index)
  local go = self.ui.heroLoopList:GetCellByIndex(index - 1)
  if go ~= nil then
    return self.__heroItemDic[go]
  end
  return nil
end

function UI_HBHeroHeroList:__GetItemByHeroId(theHeroId)
  for index, heroId in ipairs(self.__heroList) do
    if heroId == theHeroId then
      return self:__GetItemGoByIndex(index)
    end
  end
end

function UI_HBHeroHeroList:__OnClickHeroItem(heroId)
  if not PlayerDataCenter:ContainsHeroData(heroId) then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8301))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HandbookHeroRelation, function(win)
    self.ui.layoutGroup_rect.enabled = false
    local headItem = self:__GetItemByHeroId(heroId)
    headItem.gameObject:SetActive(false)
    win:InitHBHeroHeroRelation(heroId, self.resloader, self.__reshow)
    win:PlayFromListTween(headItem.transform.position)
    self:__PlayOutTween(function()
      self:Hide()
      headItem.gameObject:SetActive(true)
      self.ui.layoutGroup_rect.enabled = true
    end)
  end)
end

function UI_HBHeroHeroList:__OnClickCampInfo()
  local campCfg = ConfigData.camp[self.campId]
  AudioManager:PlayAudioById(campCfg.camp_info_audio)
  self:__PlayOutTween(function()
    UIManager:ShowWindowAsync(UIWindowTypeID.HandBookCampInfo, function(win)
      win:InitHBCampInfo(self.campId, self.resloader, self.__reshow)
      self:Hide()
    end)
  end)
end

function UI_HBHeroHeroList:HBHLOnHeroSkinChange(changeHeroId)
  for _, heroId in pairs(self.__heroList) do
    if changeHeroId == heroId then
      local headItem = self:__GetItemByHeroId(heroId)
      if headItem ~= nil then
        headItem:RefreshHBHeroHeadItem(heroId)
      end
    end
  end
end

function UI_HBHeroHeroList:__PlayOutTween(callback, isBackwards)
  self.__outTweenOverCallback = callback
  self.__outTweenOverisBackwards = isBackwards
  if self.__sequence == nil then
    local sequence = cs_DoTween.Sequence()
    sequence:AppendCallback(function()
      if self.__outTweenOverisBackwards then
        UIUtil.CloseOneCover("UI_HBHeroHeroList")
      else
        UIUtil.AddOneCover("UI_HBHeroHeroList")
      end
    end)
    sequence:Append(self.ui.cg_main:DOFade(0, 0.2):SetEase(cs_Ease.OutQuart))
    sequence:Join(self.ui.rect_main:DOScale(0.8, 0.2):SetEase(cs_Ease.OutQuart))
    sequence:AppendCallback(function()
      if self.__outTweenOverCallback ~= nil then
        self.__outTweenOverCallback()
      end
      if self.__outTweenOverisBackwards then
        UIUtil.AddOneCover("UI_HBHeroHeroList")
      else
        UIUtil.CloseOneCover("UI_HBHeroHeroList")
      end
    end)
    sequence:SetAutoKill(false)
    sequence:Pause()
    self.__sequence = sequence
  end
  if isBackwards then
    self.__sequence:PlayBackwards()
  else
    self.__sequence:Restart()
  end
end

function UI_HBHeroHeroList:__ReshowTween()
  self:Show()
  self.handBookCtrl:SetHBViewSetLayer(2, self.ui.tex_Camp.text)
  self:__PlayOutTween(nil, true)
end

function UI_HBHeroHeroList:__EnterTween()
  local order = 0
  for index, value in ipairs(self.__heroList) do
    local headItem = self:__GetItemGoByIndex(index)
    if headItem ~= nil then
      order = order + 1
      headItem:HBHeroHeadPlayBlinkTween(order)
    end
  end
end

function UI_HBHeroHeroList:__OnClickBack()
  UIManager:ShowWindow(UIWindowTypeID.HandBookHeroCampIndex):HBCIPlayEnterTween()
  self.handBookCtrl:SetHBViewSetLayer(1)
  self:Hide()
end

function UI_HBHeroHeroList:OnShow()
end

function UI_HBHeroHeroList:OnDelete()
  for index, value in ipairs(self.__heroList) do
    local headItem = self:__GetItemGoByIndex(index)
    if headItem ~= nil then
      headItem:Delete()
    end
  end
  if self.__sequence ~= nil then
    self.__sequence:Kill()
    self.__sequence = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
  end
end

return UI_HBHeroHeroList
